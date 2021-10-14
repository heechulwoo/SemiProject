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
						 " where p.pnum = ? ";
			
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
			
			String sql = " select pnum, fk_cnum, pname, price, color, pinpupdate, pqty, psummary, pcontent " + 
						 " from tbl_product " + 
						 " where pnum = ? ";
			
			pstmt = conn.prepareCall(sql);
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pvo = new ProductVO_kgh();
				pvo.setPnum(rs.getString(1));
				pvo.setFk_cnum(rs.getString(2));
				pvo.setPname(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setColor(rs.getString(5));
				pvo.setPinpupdate(rs.getString(6));
				pvo.setPqty(rs.getInt(7));
				pvo.setPsummary(rs.getString(8));
				pvo.setPcontent(rs.getString(9));
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
		}  finally {
			close();
		}
		
		return orderList;
	}
}
