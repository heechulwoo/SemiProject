package contact.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import product.model.ProductImageVO_kgh;
import util.security.AES256;
import util.security.SecretMyKey;

public class ProductOrderDAO_sm implements InterProductOrderDAO_sm {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public ProductOrderDAO_sm() {
		try {
			
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");
			
			aes = new AES256(SecretMyKey.KEY);
			
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
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
	
	
	
	
	
	// 주문 리스트  페이징 처리를 한 목록 보여주기
	@Override
	public List<ProductOrderVO_sm> selectPagingOrder(Map<String, String> paraMap) throws SQLException {
		
		List<ProductOrderVO_sm> orderList = new ArrayList<>();
		
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select odrcode, fk_userid, odrtotalprice, to_char(odrdate, 'yyyy-mm-dd') AS odrdate " + 
						 " from " + 
						 " ( " + 
						 "    select rownum AS rno, odrcode, fk_userid, odrtotalprice, odrdate " + 
						 "    from " + 
						 "    ( " + 
						 "    select odrcode, fk_userid, odrtotalprice, odrdate " + 
						 "    from tbl_order " + 
						 "    where fk_userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	if( "odrcode".equals(colname) ) {
				// 검색대상 선택을 email로 했을 경우 
				// searchWord 에 email 이 올 것이므로 DB와 맞춰줘야만한다(--> 암호화 필요)
				// searchWord = aes.encrypt(searchWord);
		//	}
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				// searchWord가 널값이 아니며, 공백도 아닌 경우
				
				sql += "  and "+colname+" like '%'|| ? ||'%' ";
				// column 명과 테이블명에는 위치홀더 절대 안돼 !!!!! 
				// 검색어만 위치홀더 가능 (그래서 컬럼명에는 위에서 설정해준 변수 colname을 넣어주자)
			}
			
			
				sql +=	 "    order by odrdate desc " + 
						 "    ) V " + 
						 " ) T " + 
						 " where rno between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				
				// === 위치 홀더 처리 === //
				
				int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") ); 
				// return 타입이 스트링 ==> 그러나 DB에서 곱셈, 나눗셈해야하므로 int로 바꾸자
				
				int sizePerPage = Integer.parseInt( paraMap.get("sizePerPage") ) ;
				// return 타입이 스트링 ==> 그러나 DB에서 곱셈, 나눗셈해야하므로 int로 바꾸자
				
				
				if( searchWord != null && !searchWord.trim().isEmpty() ) {
					// 검색어가 있는 경우 (위치홀더 3개)
					pstmt.setString(1, searchWord);
					pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 페이징처리 공식 넣어주기
					pstmt.setInt(3, (currentShowPageNo * sizePerPage) ); // 페이징처리 공식 넣어주기
					
				}
				else {
					// 검색어가 없는 경우 (위치홀더 2개)
					pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 페이징처리 공식 넣어주기
					pstmt.setInt(2, (currentShowPageNo * sizePerPage) ); // 페이징처리 공식 넣어주기
				}
			
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					// 존재한다면
					
					ProductOrderVO_sm ovo = new ProductOrderVO_sm();
					
					ovo.setOdrcode(rs.getString(1));
					ovo.setFk_userid(rs.getString(2));
					ovo.setOdrtotalprice(rs.getInt(3));
					ovo.setOdrdate(rs.getString(4));
					
				    orderList.add(ovo); // cvo 값을 List에 담아서 보내주기
					
					
				}// end of while------------------------------------------------	
			
		
		} finally {
			close();
		}
		
		return orderList;
		
	}// end of public List<ProductOrderVO_sm> selectPagingOrder(Map<String, String> paraMap)-----------------------
	
	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체주문내역에 대한 총 페이지 수 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) " + 
						 " from tbl_order " + 
						 " where fk_userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
		//	if( "odrcode".equals(colname) ) {
				// 검색대상 선택을 odrcode로 했을 경우 
				// searchWord 에 email 이 올 것이므로 DB와 맞춰줘야만한다(--> 암호화 필요)
				// searchWord = aes.encrypt(searchWord);
		//	 }
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				// 검색어가 있는 경우 기존 sql문에서 추가해야한다.
				
				sql += " and "+colname+" like '%'|| ? ||'%' ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				// 검색어가 있는 경우 기존 sql문에서 추가했으므로 , 위치 홀더 처리
				pstmt.setString(2, searchWord);
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
			
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getTotalPage(Map<String, String> paraMap)------------------------------------------------
	
	
	
	// 주문 상세 정보 보여주는 메소드(tbl_order_detail 테이블에 select)
	@Override
	public List<ProductOrderDetailVO_sm> viewDetailOrder(String odrcode) throws SQLException {
		
		List<ProductOrderDetailVO_sm> orderDetailList = new ArrayList<>();
		
		
		try {
			
			conn = ds.getConnection();
			
			
			String sql = " select odrseqnum, fk_odrcode, fk_pnum, oqty, odrprice, deliverstatus, to_char(deliverdate, 'yyyy-mm-dd') AS deliverdate "+
					 	 " from tbl_order_detail "+
					 	 " where fk_odrcode = ? "+
					 	 " order by odrseqnum ";
		
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode); // paraMap key값 주의 !
	        
	        rs = pstmt.executeQuery();
	        
	        
	        while(rs.next()) {
				// 존재한다면
				
	        	ProductOrderDetailVO_sm dvo = new ProductOrderDetailVO_sm();
				
	        	dvo.setOdrseqnum(rs.getInt(1));
	        	dvo.setFk_odrcode(rs.getString(2));
	        	dvo.setFk_pnum(rs.getString(3));
	        	dvo.setOqty(rs.getInt(4));
	        	dvo.setOdrprice(rs.getInt(5));
	        	dvo.setDeliverstatus(rs.getInt(6));
	        	dvo.setDeliverdate(rs.getString(7));
				
				
	        	orderDetailList.add(dvo); // dvo 값을 List에 담아서 보내주기
				
				
			}// end of while------------------------------------------------	
		
	        
			
		} finally {
			close();
		}
		
		
		return orderDetailList;
		
	}// end of public List<ProductOrderVO_sm> viewDetailOrder(String odrcode)------------------
	
	
	
	// odrseqnum값을 받아서 주문 세부 내역 1개 보여주기 (select)
	@Override
	public ProductOrderDetailVO_sm viewOrderDetail(String odrseqnum) throws SQLException {
		
		ProductOrderDetailVO_sm dvo = null;
		
		try {
			
			
			conn = ds.getConnection();
			
			String sql = "select odrseqnum, fk_odrcode, fk_pnum, oqty, odrprice, deliverstatus, deliverdate, pname "+
						 " from "+
						 " ( "+
						 " select odrseqnum, fk_odrcode, fk_pnum, oqty, odrprice, deliverstatus, to_char(deliverdate, 'yyyy-mm-dd') AS deliverdate , P.pname AS pname "+
						 " from tbl_order_detail D "+
						 " JOIN tbl_product P "+
						 " ON D.fk_pnum = P.pnum "+
						 " ) "+
						 " where odrseqnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, odrseqnum);
	        
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	        	
	        	dvo = new ProductOrderDetailVO_sm();
	        	ProductVO_sm pvosm = new ProductVO_sm();
	        	
	        	dvo.setOdrseqnum(rs.getInt(1));
	        	dvo.setFk_odrcode(rs.getString(2));
	        	dvo.setFk_pnum(rs.getString(3));
	        	dvo.setOqty(rs.getInt(4));
	        	dvo.setOdrprice(rs.getInt(5));
	        	dvo.setDeliverstatus(rs.getInt(6));
	        	dvo.setDeliverdate(rs.getString(7));
	        	
	        	pvosm.setPname(rs.getString(8));
	        	dvo.setPvosm(pvosm);
	        	
	        }
			
		} finally {
			close();
		}
		
		return dvo;
		
	}// end of public ProductOrderDetailVO_sm viewOrderDetail(String odrseqnum)-------------------------
	
	
	
	// 배송상태 변경해주기(deliverstatus == 1 또는 2 인 경우)
	@Override
	public int updateDeliverStatus1(Map<String, String> paraMap) throws SQLException {

		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_order_detail set deliverstatus = ? "
	                   + " where odrseqnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("deliverstatus"));
			pstmt.setString(2, paraMap.get("odrseqnum"));
			
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		
		return n;
		
	}// end of public int updateDeliverStatus1(Map<String, String> paraMap)--------------------------
	
	
	
	// 배송상태 변경해주기(deliverstatus == 3 인 경우)
	@Override
	public int updateDeliverStatus2(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_order_detail set deliverstatus = ? , deliverdate = to_char(sysdate , 'yyyy-mm-dd') "
	                   + " where odrseqnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("deliverstatus"));
			pstmt.setString(2, paraMap.get("odrseqnum"));
			
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		
		return n;
		
	}// end of public int updateDeliverStatus2(Map<String, String> paraMap)-----------------------------
	
	
	
	// 배송지 상세 정보를 리스트로 보여주는 메소드(tbl_address 테이블에 select)
	@Override
	public ProductAddressVO_sm viewOrderAddress(String odrcode) throws SQLException {
		
		
		
		ProductAddressVO_sm addressOneDetail = null;
		
		
		try {
			
			conn = ds.getConnection();
			
			
			String sql = " select addrno, fk_odrcode, name, mobile, postcode, address, detailaddress, extraaddress "+
					 	 " from tbl_address "+
					 	 " where fk_odrcode = ? ";
		
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode); // paraMap key값 주의 !
	        
	        rs = pstmt.executeQuery();
	        
	        
	        if(rs.next()) {
				// 존재한다면
				
	        	addressOneDetail = new ProductAddressVO_sm();
				
	        	addressOneDetail.setAddrno(rs.getInt(1));					// 배송지번호
	        	addressOneDetail.setFk_odrcode(rs.getString(2)); 			// 주문번호
	        	addressOneDetail.setName(rs.getString(3));					// 성명
	        	addressOneDetail.setMobile( aes.decrypt(rs.getString(4)) );	// 연락처(복호화 필수)
	        	addressOneDetail.setPostcode(rs.getString(5));				// 우편번호
	        	addressOneDetail.setAddress(rs.getString(6));				// 주소
	        	addressOneDetail.setDetailaddress(rs.getString(7));  		// 상세주소
	        	addressOneDetail.setExtraaddress(rs.getString(8));			// 주소참고항목
	        	
				
			}// end of if------------------------------------------------	
		
	        
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
			e.printStackTrace();	
		} finally {
			close();
		}
		
		return addressOneDetail;
		
		
	}// end of public List<ProductAddressVO_sm> viewOrderAddress(String odrcode)------------------------
	
	
	
	// 매장 정보를 불러오는 메소드
	@Override
	public List<ShoppingmapVO_sm> selectStoresInfo() throws SQLException {
		
		List<ShoppingmapVO_sm> storeList = new ArrayList<>();
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select storeid, storename, postcode, address, detailaddress, extraaddress, openinghour, restaurant, storeimg "+
					 	 " from tbl_shoppingmap ";
			
			pstmt = conn.prepareStatement(sql);
			
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ShoppingmapVO_sm svo = new ShoppingmapVO_sm();
				
				svo.setStoreid(rs.getInt(1));
				svo.setStorename(rs.getString(2));
				svo.setPostcode(rs.getString(3));
				svo.setAddress(rs.getString(4));
				svo.setDetailaddress(rs.getString(5));
				svo.setExtraaddress(rs.getString(6));
				svo.setOpeninghour(rs.getString(7));
				svo.setRestaurant(rs.getString(8));
				svo.setStoreimg(rs.getString(9));
				
				storeList.add(svo);
			}
			
			
		} finally {
			close();
		}
		
		
		return storeList;
		
	}// end of public List<ShoppingmapVO_sm> selectStoresInfo()-----------------------------------------
	
	
	
	
	   
	   
	   
	
	
	
}
