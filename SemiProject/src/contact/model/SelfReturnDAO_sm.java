package contact.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

import util.security.AES256;
import util.security.SecretMyKey;

public class SelfReturnDAO_sm implements InterSelfReturnDAO_sm {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public SelfReturnDAO_sm() {
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
	   
	
	
	// 로그인 한 사용자의 주문 번호 가져오는 메소드
	@Override
	public List<String> getOdrcode(String userid) throws SQLException {

		List<String> getOdrcodeList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
	   
			String sql = " select odrcode " + 
						 " from tbl_order " + 
						 " where fk_userid = ? " + 
						 " order by odrdate ";
	   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				getOdrcodeList.add(rs.getString(1));				
			}
			
		} finally {
			close();
		}
		
		return getOdrcodeList;
		
	}// end of public List<String> getOdrcode(String userid)---------------------------------------
	
	
	
	// 셀프 반품 확인 이메일 보내주는 메소드
	@Override
	public int sendReturnEmail(SelfReturnVO selfReturn) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_return(returnno, fk_userid, fk_odrcode, name, email, mobile, whyreturn, wherebuy, plusreason, returndate ) "     
					   + " values(returnno.nextval, ?, ?, ?, ?, ?, ?, ?, ?, sysdate) "; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, selfReturn.getFk_userid());
			pstmt.setString(2, selfReturn.getFk_odrcode());
			pstmt.setString(3, selfReturn.getName());
			pstmt.setString(4, aes.encrypt(selfReturn.getEmail()));
			pstmt.setString(5, aes.encrypt(selfReturn.getMobile()));
			pstmt.setString(6, selfReturn.getWhyreturn());
			pstmt.setString(7, selfReturn.getWherebuy());
			pstmt.setString(8, selfReturn.getPlusreason());
			
			n = pstmt.executeUpdate();
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int sendReturnEmail(SelfReturnVO selfReturn)--------------------------------
	
	
}
