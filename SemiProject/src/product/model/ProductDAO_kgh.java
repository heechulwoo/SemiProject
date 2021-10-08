package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO_kgh implements InterProductDAO_kgh {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO_kgh() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");		// import javax.sql.DataSource;
			
		} catch (NamingException e) {
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
}
