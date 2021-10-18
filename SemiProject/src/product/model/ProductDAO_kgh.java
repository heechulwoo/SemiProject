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
						 " order by imgfilename ";
			
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
			
			String sql = " select cname, pnum, fk_cnum, pname, price, color, pinpupdate, pqty, psummary, pcontent " + 
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
						 "        oqty, odrprice, odrtotalprice, to_char(odrdate, 'yyyy.mm.dd') AS odrdate " + 
						 " from " + 
						 " ( " + 
						 "     select cnum , cname, pnum, pname, prodimage, price, fk_odrcode AS odrcode, " + 
						 "            oqty, odrprice, fk_userid, odrtotalprice, odrdate " + 
						 "     from " + 
						 "     ( " + 
						 "         select cnum , cname, pnum, pname, prodimage, price, fk_odrcode, oqty, odrprice " + 
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

	
	// 해당 주문번호를 통해 배송지 insert하기
	@Override
	public void insertAddress(Map<String, String> paraMap) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_address(addrno, fk_odrcode, name, mobile, postcode, address, detailaddress, extraaddress) " + 
						 " values(seq_address.nextval, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("odrCode"));
			pstmt.setString(2, paraMap.get("odrName"));
			pstmt.setString(3, aes.encrypt(paraMap.get("odrMobile")));
			pstmt.setString(4, paraMap.get("odrPostcode"));
			pstmt.setString(5, paraMap.get("odrAddress"));
			pstmt.setString(6, paraMap.get("odrDetailAddress"));
			pstmt.setString(7, paraMap.get("odrExtraAddress"));
			
			pstmt.executeUpdate();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
	}

	
	// 주문상세 테이블에 주문 상세내역 insert 하기
	@Override
	public int insertOrderDetail(Map<String, String> odrparaMap) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_order_detail(Odrseqnum, fk_odrcode, fk_pnum, oqty, odrprice, deliverstatus) " + 
						 " values(seq_order_detail.nextval, ?, ?, ?, ?, 1) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrparaMap.get("odrCode"));
			pstmt.setString(2, odrparaMap.get("odpnumIndex"));
			pstmt.setString(3, odrparaMap.get("odoqtyIndex"));
			pstmt.setString(4, odrparaMap.get("odcartnoIndex"));
			
			n = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return n;
	}

	
	// 제품 테이블의 재고 수량 update 하기
	@Override
	public void updatePqty(String odpnumIndex, String odoqtyIndex) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_product set pqty = pqty - ? " + 
						 " where pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(odoqtyIndex));
			pstmt.setString(2, odpnumIndex);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			close();
		}
	}

	
	// 장바구니에 해당 하는 상품 목록 delete 하기
	@Override
	public void deleteCartno(String odcartnoIndex) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart " + 
						 " where cartno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odcartnoIndex);
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
	}


	
}
