package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class ProductDAO_kgh implements InterProductDAO_kgh {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public ProductDAO_kgh() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");		// import javax.sql.DataSource;
			
			aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 는 우리가 만든 비밀키이다. 
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
    private void close() {
	  	try {
	  		if(rs != null)    {rs.close();    rs=null;}
		    if(pstmt != null) {pstmt.close(); pstmt=null;}
		    if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
		    e.printStackTrace();
		}
    }

    
    // 상품의 이미지를 가져오는 메서드
	@Override
	public List<ProductImageVO_kgh> selectProductImage(String pnum) throws SQLException {
		List<ProductImageVO_kgh> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgfileno, pnum, imgfilename " + 
						 " from tbl_product P " + 
						 " JOIN tbl_imagefile F " + 
						 " ON P.pnum = F.fk_pnum " + 
						 " where p.pnum = ? " + 
						 " order by imgfileno ";
			
			pstmt = conn.prepareCall(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductImageVO_kgh pimgvo = new ProductImageVO_kgh();
				pimgvo.setImgfileno(rs.getInt(1));
				pimgvo.setFk_pnum(rs.getString(2));
				pimgvo.setImgfilename(rs.getString(3));
				
				imgList.add(pimgvo);
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}

	
	// 상품의 정보를 가져오는 메서드
	@Override
	public ProductVO_kgh selectProductDetail(String pnum) throws SQLException {
		ProductVO_kgh pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cname, pnum, fk_cnum, pname, price, color, pinpupdate, pqty, psummary, pcontent, prodimage " + 
						 " from tbl_product P " + 
						 " JOIN tbl_category G " + 
						 " ON P.fk_cnum = G.cnum " + 
						 " where pnum = ? ";
			
			pstmt = conn.prepareCall(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pvo = new ProductVO_kgh();
				
				ProductCategoryVO_kgh pcvo = new ProductCategoryVO_kgh();
				pcvo.setCname(rs.getString(1));
				pvo.setCategvo(pcvo);
				
				pvo.setPnum(rs.getString(2));
				pvo.setFk_cnum(rs.getString(3));
				pvo.setPname(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setColor(rs.getString(6));
				pvo.setPinpupdate(rs.getString(6));
				pvo.setPqty(rs.getInt(8));
				pvo.setPsummary(rs.getString(9));
				pvo.setPcontent(rs.getString(10));
				pvo.setProdimage(rs.getString(11));
			}
			
		} finally {
			close();
		}
		
		return pvo;
	}

	
	// 주문번호 확인하는 메서드
	@Override
	public boolean shippingNoCheck(String shippingNo, String shippingEmail) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select odrcode, M.userid, email " + 
						 " from " + 
						 " ( " + 
						 "     select odrcode, fk_userid " + 
						 "     from tbl_order " + 
						 " ) V " + 
						 " JOIN tbl_member M " + 
						 " ON V.fk_userid = M.userid " + 
						 " where odrcode = ? and M.email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, shippingNo);
			pstmt.setString(2, aes.encrypt(shippingEmail));
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}  finally {
			close();
		}
		
		return isExists;
	}

	
	// 주문번호와 이메일을 통해 주문과 주문 상세를 select 하는 메서드
	@Override
	public List<ProductOrderDetailVO_kgh> selectOrderConfirmation(String shippingNo, String shippingEmail) throws SQLException {
		List<ProductOrderDetailVO_kgh> orderList = new ArrayList<>();;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cnum, cname, pnum, pname, prodimage, price, odrcode, " + 
						 "        oqty, odrprice, odrtotalprice, to_char(odrdate, 'yyyy.mm.dd') AS odrdate, deliverstatus " + 
						 " from " + 
						 " ( " + 
						 "     select cnum , cname, pnum, pname, prodimage, price, fk_odrcode AS odrcode, " + 
						 "            oqty, odrprice, fk_userid, odrtotalprice, odrdate, deliverstatus " + 
						 "     from " + 
						 "     ( " + 
						 "         select cnum , cname, pnum, pname, prodimage, price, fk_odrcode, oqty, odrprice, deliverstatus " + 
						 "         from " + 
						 "         ( " + 
						 "             select cnum , cname, pnum, pname, prodimage, price " + 
						 "             from tbl_category G " + 
						 "             JOIN tbl_product P " + 
						 "             ON G.cnum = P.fk_cnum " + 
						 "         ) A " + 
						 "         JOIN tbl_order_detail D " + 
						 "         ON A.pnum = D.fk_pnum " + 
						 "     ) B " + 
						 "     JOIN tbl_order O " + 
						 "     ON O.odrcode = B.fk_odrcode " + 
						 " ) C " + 
						 " JOIN tbl_member M " + 
						 " ON C.fk_userid = M.userid " + 
						 " where odrcode = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, shippingNo);
			pstmt.setString(2, aes.encrypt(shippingEmail));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductOrderDetailVO_kgh podvo = new ProductOrderDetailVO_kgh();
				
				ProductCategoryVO_kgh pcvo = new ProductCategoryVO_kgh();	//카테고리
				pcvo.setCnum(rs.getString("cnum"));
				pcvo.setCname(rs.getString("cname"));
				podvo.setPcvo(pcvo);
				
				ProductVO_kgh pdvo = new ProductVO_kgh();	// 제품 정보
				pdvo.setPnum(rs.getString("pnum"));
				pdvo.setPname(rs.getString("pname"));
				pdvo.setProdimage(rs.getString("prodimage"));
				pdvo.setPrice(rs.getInt("price"));
				podvo.setPvo(pdvo);
				
				ProductOrderVO_kgh povo = new ProductOrderVO_kgh();	// 주문
				povo.setOdrcode(rs.getString("odrcode"));
				povo.setOdrtotalprice(rs.getInt("odrtotalprice"));
				povo.setOdrdate(rs.getString("odrdate"));
				podvo.setPovo(povo);
					
				podvo.setOqty(rs.getInt("oqty"));				// 주문상세
				podvo.setOdrprice(rs.getInt("odrprice"));
				podvo.setDeliverstatus(rs.getInt("deliverstatus"));
				
				
				orderList.add(podvo);
				
			}
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return orderList;
	}

	// 제품의 카테고리와 일치하는 유사한 제품을 불러오는 메서드
	@Override
	public List<ProductVO_kgh> SameCategoryProduct(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO_kgh> sameProductList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, price, prodimage " + 
						 " from  (select * " + 
						 "        from tbl_product " + 
						 "        order by dbms_random.value) " + 
						 " where pnum != ? and fk_cnum = ? and rownum <= 4 ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("pnum"));
			pstmt.setString(2, paraMap.get("cnum"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO_kgh pvo = new ProductVO_kgh();
				pvo.setPnum(rs.getString(1));
				pvo.setPname(rs.getString(2));
				pvo.setPrice(rs.getInt(3));
				pvo.setProdimage(rs.getString(4));
				
				sameProductList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return sameProductList;
	}

	
	// 해당하는 제품 이름과 일치하는 상품의 색상 이미지 가져오기
	@Override
	public List<ProductVO_kgh> selectProductColor(String pname) throws SQLException {
		
		List<ProductVO_kgh> productColorList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, color, pqty, prodimage " + 
						 " from tbl_product " + 
						 " where pname like '%'|| ? ||'%' ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO_kgh pvo = new ProductVO_kgh();
				pvo.setPnum(rs.getString(1));
				pvo.setPname(rs.getString(2));
				pvo.setColor(rs.getString(3));
				pvo.setPqty(rs.getInt(4));
				pvo.setProdimage(rs.getString(5));
				
				productColorList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return productColorList;
	}

	
	// 주문하려는 상품의 대표 이미지 가져오는 메소드 생성
	@Override
	public ProductImageVO_kgh getProdImage(String odpnum) throws SQLException {
		ProductImageVO_kgh pimgVO = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select prodimage " + 
						 " from tbl_product " + 
						 " where pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odpnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				pimgVO = new ProductImageVO_kgh();
				pimgVO.setImgfilename(rs.getString(1));
				
			}
			
		} finally {
			close();
		}
		
		return pimgVO;
	}

	
	// 주문 테이블에 주문내역 insert 하고 주문번호 select하기
	@Override
	public String insertOrder(String userid, String sumTotalPrice) throws SQLException {
		String odrCode = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalprice) " + 
						 " values(to_char(sysdate, 'YYMMDD')||seq_order.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, Integer.parseInt(sumTotalPrice));
			
			int n = pstmt.executeUpdate();
			
			if(n == 1) {
				sql = " select odrcode " + 
					  " from tbl_order " + 
					  " where rownum = 1 and fk_userid = ? and odrtotalprice = ? " + 
					  " order by odrdate ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setInt(2, Integer.parseInt(sumTotalPrice));
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					odrCode = rs.getString(1);
				}
			}
		} finally {
			close();
		}
		
		return odrCode;
	}

	
	// ===== Transaction 처리하기 ===== // 
    // 1. 주문 테이블에 입력한 주문전표로 주문 정보 insert하기 
    // 2. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 3. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
    
	// 4. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
	
    // 5. 배송지 테이블에서  사용자의 주소 정보 더하기(insert)(수동커밋처리) 
    // 6. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
    // 7. **** SQL 장애 발생시 rollback 하기(rollback) ****
	@Override
	public int orderAdd(HashMap<String, Object> paraMap) throws SQLException {
		int isSuccess = 0;
		int n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0;
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false);	// 수동 커밋
			
			// 1. 주문 테이블에 입력한 주문전표로 주문 정보 insert하기 
			String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalprice) " + 
						 " values(?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String)paraMap.get("odrcode"));
			pstmt.setString(2, (String)paraMap.get("userid"));
			pstmt.setInt(3, Integer.parseInt((String)paraMap.get("sumtotalprice")));
			
			n1 = pstmt.executeUpdate();
			System.out.println("~~~ 확인용 n1 : " + n1);
			

			// 2. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
			if(n1 == 1) {
				String[] pnumArr = (String[])paraMap.get("pnumArr");
				String[] oqtyArr = (String[])paraMap.get("oqtyArr");
				String[] totalPriceArr = (String[])paraMap.get("totalPriceArr");
				
				int cnt = 0;

				for (int i = 0; i < pnumArr.length; i++) {
					
					sql = " insert into tbl_order_detail(odrseqnum, fk_odrcode, fk_pnum, oqty, odrprice)" + 
						  " values(seq_order_detail.nextval, ?, ?, ?, ?) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, (String)paraMap.get("odrcode"));
					pstmt.setString(2, pnumArr[i]);
					pstmt.setString(3, oqtyArr[i]);
					pstmt.setString(4, totalPriceArr[i]);
					
					pstmt.executeUpdate();
					cnt++;
				}// end of for
				
				if(cnt == pnumArr.length) {
					n2 = 1;
				}

				System.out.println("~~~ 확인용 n2 : " + n2);
			
			}// end of if
			
			// 3. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
			if(n2 == 1) {
				String[] pnumArr = (String[]) paraMap.get("pnumArr");
				String[] oqtyArr = (String[]) paraMap.get("oqtyArr");
				
				int cnt = 0;
				for (int i = 0; i < pnumArr.length; i++) {
					sql = " update tbl_product set pqty = pqty - ? "
			            + " where pnum = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(oqtyArr[i]));
					pstmt.setString(2, pnumArr[i]);
					
					pstmt.executeUpdate();
					
					cnt++;
				}// end of for
				
				if(cnt == pnumArr.length) {
					n3 = 1;
				}
				
				System.out.println("~~~ 확인용 n3 : " + n3);
				
			}// end of if
			
			// 4. 장바구니 테이블에서 odcartno 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
		    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
			if(paraMap.get("odcartno") != null && n3 == 1) {
				
				sql = " delete from tbl_cart " + 
					  " where cartno in(" + (String)paraMap.get("odcartno") + ") ";
				
				//  !!! in 절은 위와 같이 직접 변수로 처리해야 함. !!! 
		        //  in 절에 사용되는 것들은 컬럼의 타입을 웬만하면 number 로 사용하는 것이 좋다. 
		        //  왜냐하면 varchar2 타입으로 되어지면 데이터 값에 앞뒤로 홑따옴표 ' 를 붙여주어야 하는데 이것을 만들수는 있지만 귀찮기 때문이다.
				
				pstmt = conn.prepareStatement(sql);
				
				n4 = pstmt.executeUpdate();
				
				System.out.println("~~~ 확인용 n3 : " + n3);
			
			}// end of if
			
			if(paraMap.get("odcartno") == null && n3 == 1) {
				// "제품 상세 정보" 페이지에서 "바로주문하기" 를 한 경우 
				// 장바구니 번호인 cartnojoin 이 없는 것이다.
				n4 = 1;
				
				System.out.println("~~~ 확인용 n4 : " + n4);
			}
			
			// 5. 배송지 테이블에서  사용자의 주소 정보 더하기(insert)(수동커밋처리) 
			if(n4 > 0) {
				sql = " insert into tbl_address(addrno, fk_odrcode, name, mobile, postcode, address, detailaddress, extraaddress) " + 
					  " values(seq_address.nextval, ?, ?,  ?, ?, ?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, (String)paraMap.get("odrcode"));
				pstmt.setString(2, (String)paraMap.get("name"));
				pstmt.setString(3, aes.encrypt((String)paraMap.get("mobile")));
				pstmt.setString(4, (String)paraMap.get("postcode"));
				pstmt.setString(5, (String)paraMap.get("address"));
				pstmt.setString(6, (String)paraMap.get("detailAddress"));
				pstmt.setString(7, (String)paraMap.get("extraAddress"));
			
				n5 = pstmt.executeUpdate();
				
				System.out.println("~~~ 확인용 n5 : " + n5);
			}// end of if
			
			// 6. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
			if(n1 * n2 * n3 * n4 * n5 > 0) {
				conn.commit();
				
				conn.setAutoCommit(true);
				// 자동 커밋으로 전환
				
				System.out.println("~~ 확인용 n1 * n2 * n3 * n4 * n5 : " + n1 * n2 * n3 * n4 * n5);
			
				isSuccess = 1;
			}
			
		} catch (SQLException e) {
			
			// 7. **** SQL 장애 발생시 rollback 하기(rollback) ****
			conn.rollback();
			
			conn.setAutoCommit(true);
			// 자동 커밋으로 전환
			
			isSuccess = 0;
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return isSuccess;
	}

	
	// 주문 일자 가져오기
	@Override
	public String selectOrderDate(String odrcode) throws SQLException {
		
		String orderDate = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select to_char(odrdate, 'yyyy-mm-dd') AS odrdate " + 
						 " from tbl_order " + 
						 " where odrcode = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				orderDate = rs.getString(1);
			}
			
		} finally {
			close();
		}
		
		return orderDate;
	}

	
	// 주문정보 지우기
	@Override
	public void deleteOrder(String odrcode) throws SQLException {
		try {
			conn = ds.getConnection();
			
			String sql = " delete tbl_order " + 
						 " where odrcode = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode);
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
	}

	
	// 주문번호 생성하는 메서드
	@Override
	public String getodrCode() throws SQLException {
		
		String odrcode = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select to_char(sysdate, 'YYMMDD')||seq_order.nextval AS odrcode " + 
						 " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			odrcode = rs.getString(1);
			
		} finally {
			close();
		}
		
		return odrcode;
	}

	
	// 제품 번호에 해당하는 제품의 리뷰 글 select 하기
	@Override
	public List<ProductReviewVO> reviewList(String fk_pnum) throws SQLException {
		
		List<ProductReviewVO> reviewList = new ArrayList<>();	
		
		try {
			conn = ds.getConnection();
			
			String sql = " select rownum, fk_userid, title, content, to_char(registerdate, 'yyyy-mm-dd') AS registerdate " + 
						 " from tbl_review R " +
						 " where R.fk_pnum = ? " + 
						 " order by rownum desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_pnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductReviewVO reviewvo = new ProductReviewVO();
				reviewvo.setReview_seq(rs.getInt(1));
				reviewvo.setFk_userid(rs.getString(2));
				reviewvo.setTitle(rs.getString(3));
				reviewvo.setContent(rs.getString(4));
				reviewvo.setRegisterdate(rs.getString(5));
			
				reviewList.add(reviewvo);
			}
			
		} finally {
			close();
		}

		return reviewList;
		
	}// end of public List<ProductReviewVO> reviewList(String fk_pnum)

	

	
}
