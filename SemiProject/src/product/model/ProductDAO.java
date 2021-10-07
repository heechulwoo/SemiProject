package product.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO() {
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

    // 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드
	@Override
	public List<ProductVO> newProduct() throws SQLException {
		List<ProductVO> newproductList = new ArrayList<>();
		try {
			
			conn = ds.getConnection();
			
			String sql = " select pnum,fk_cnum,pname,price,color, pinupdate ,pqty,psummary,pcontent,cname, prodimage " + 
						 " from " + 
						 "     ( " + 
						 "     select pnum,fk_cnum,pname,price,color,to_char(pinpupdate,'yyyy-mm-dd') as pinupdate ,pqty,psummary,pcontent, prodimage " + 
						 "     from " + 
						 "     ( " + 
						 "         select pnum,fk_cnum,pname,price,color,pinpupdate,pqty,psummary,pcontent,ROW_NUMBER() over(order by pinpupdate desc) as new, prodimage " + 
						 "         from " + 
						 "         ( " + 
						 "             select pnum,fk_cnum,pname,price,color,pinpupdate,pqty,psummary,pcontent,ROW_NUMBER() over(partition by pname order by pinpupdate) as updatedate, prodimage " + 
						 "             from tbl_product " + 
						 "         ) " + 
						 "         where updatedate = 1 " + 
						 "     ) " + 
						 "     where new < 5 " + 
						 " )P join tbl_category C " + 
						 " on P.fk_cnum = c.cnum ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				ProductVO pvo = new ProductVO();
				
				pvo.setPnum(rs.getString(1));
				pvo.setFk_cnum(rs.getString(2));
				pvo.setPname(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setColor(rs.getString(5));
				pvo.setPinpupdate(rs.getString(6));
				pvo.setPqty(rs.getInt(7));
				pvo.setPsummary(rs.getString(8));
				pvo.setPcontent(rs.getString(9));
				pvo.setCname(rs.getString(10));
				pvo.setProdimage(rs.getNString(11));
				
				newproductList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return newproductList;
	}// end of public List<ProductVO> newProduct()-----------------------------

	// 모든 제품에서 보여줄 카테고리와 해당 카테고리 의자 이미지 1개 얻어오는 메소드
	@Override
	public List<Map<String, String>> selectCategoryImage() throws SQLException {
		
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select cnum, cname, prodimage " + 
						 " from " + 
						 " ( " + 
						 " select cnum, cname, prodimage, ROW_NUMBER() over(partition by cname order by prodimage) as images " + 
						 " from tbl_category C join tbl_product P " + 
						 " on c.cnum = p.fk_cnum " + 
						 " ) " + 
						 " where images = 1 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				Map<String,String> paraMap= new HashMap<>();
				paraMap.put("cnum", rs.getString(1));
				paraMap.put("cname", rs.getString(2));
				paraMap.put("prodimage", rs.getString(3));
				
				categoryList.add(paraMap);
				
			}
			
		} finally {
			close();
		}
		
		return categoryList;
	}
    // end of public List<Map<String, String>> selectCategoryImage()----------------------
    
    
    
}
