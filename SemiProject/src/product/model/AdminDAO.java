package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

public class AdminDAO implements InterAdminDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public AdminDAO() {
		
		try {
		
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    
		}catch(NamingException e) {
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

	   
	// 카테고리 목록 보여주기
	@Override
	public List<Map<String, String>> getCategoryList(HttpServletRequest request) throws SQLException {
	
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cnum, cname " + 
						" from tbl_category " + 
						" order by cnum asc ";
			
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> map = new HashMap<>();
				map.put("cnum", rs.getString(1));
				map.put("cname", rs.getString(2));
				
				categoryList.add(map);
				
			}// end of while --------------------------------
			
		} finally {
			close();
			
		}
		return categoryList;
	}

	
	// 제품 번호 채번해오기
	@Override
	public int getPnumOfProduct() throws SQLException {
		
		int pnum = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select seq_pnum.nextval AS PNUM " +
	                     " from dual ";
	                  
	          pstmt = conn.prepareStatement(sql);
	          rs = pstmt.executeQuery();
	                    
	          rs.next();
	          pnum = rs.getInt(1);
	      
	      } finally {
	         close();
	      }
	      
	      return pnum;
	}

	
	// tbl_product 테이블에 제품정보 insert 하기 
	@Override
	public int productInsert(ProductVO pvo)throws SQLException {
		
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_product(pnum, fk_cnum, pname, prodimage, price, color, pinpupdate, pqty, psummary, pcontent) " +  
	                    " values(?,?,?,?,?,?,?,?,?,?)";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, pvo.getPnum());
	         pstmt.setString(2, pvo.getFk_cnum());    
	         pstmt.setString(3, pvo.getPname());    
	         pstmt.setString(4, pvo.getProdimage());
	         pstmt.setInt(5, pvo.getPrice());   
	         pstmt.setString(6, pvo.getColor());
	         pstmt.setString(7, pvo.getPinpupdate());
	         pstmt.setInt(8, pvo.getPqty()); 
	         pstmt.setString(9, pvo.getPsummary());
	         pstmt.setString(10, pvo.getPcontent());
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;  
		
	}// end of public void productInsert(ProductVO pvo)------------

	
	// tbl_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 
	@Override
	public int product_imagefile_Insert(int pnum, String attachFileName) throws SQLException {
		
		 int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_imagefile(imgfileno, fk_pnum, imgfilename) "+ 
	                    " values(seq_img.nextval, ?, ?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, pnum);
	         pstmt.setString(2, attachFileName);
	         
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;       
		
	}// end of public int product_imagefile_Insert(int pnum, String attachFileName)------

	
	
	 
	
	   

}
