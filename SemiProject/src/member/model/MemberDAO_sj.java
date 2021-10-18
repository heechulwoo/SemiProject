package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO_sj implements InterMemberDAO_sj { 
	// DAO는 DB를 사용하여 데이터의 조회 및 조작하는 기능을 전담하는 오브젝트
	// "implemets" 키워드를 통해 InterMemberDAO 인터페이스를 구현한다.

	private DataSource ds; 
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public MemberDAO_sj() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    aes = new AES256(SecretMyKey.KEY);
		   // SecretMyKey.KEY 우리가 만든 비밀키이다.
		    
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

	
	// 마이페이지에서 개인정보 수정하기
	@Override
	public int updateMember(MemberVO member) throws SQLException {
		
		int n = 0;
		
		try {		
			conn = ds.getConnection();
			
			String sql = " update tbl_member set name = ? "
					   + "                     , pwd = ? "
					   + "                     , email = ? "
					   + "                     , mobile = ? "
					   + "                     , postcode = ? "
					   + "                     , address = ? "
					   + "                     , detailaddress = ? "
					   + "                     , extraaddress = ? " 
					   + "                     , lastpwdchangedate = sysdate "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getName()); 
	        pstmt.setString(2, Sha256.encrypt(member.getPwd()) );
	        pstmt.setString(3, aes.encrypt(member.getEmail()) );
	        pstmt.setString(4, aes.encrypt(member.getMobile()) );
	        pstmt.setString(5, member.getPostcode() );
	        pstmt.setString(6, member.getAddress() );
	        pstmt.setString(7, member.getDetailaddress() );
	        pstmt.setString(8, member.getExtraaddress() );
	        pstmt.setString(9, member.getUserid() );
			
			n = pstmt.executeUpdate();
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {   
	         e.printStackTrace();
	    } finally {
			close();
		}
		
		
		return n;
	}// end of public int updateMember(MemberVO member) throws SQLException {})--------------------

	
	// 아이디 찾기(성명, 이메일을 입력 받아서 해당 사용자의 아이디를 알려준다)
	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {
		
		String userid = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid "
					   + " from tbl_member "
					   + " where status = 0 and name = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("name"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email")) );
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userid = rs.getString(1);	
			}
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return userid;
	}// end of public String findUserid(Map<String, String> paraMap)------------

	
	// 비밀번호 찾기(아이디, 이메일을 입력 받아서 해당 사용자가 존재하는지 유무를 알려준다)
	@Override
	public boolean isUserExist(Map<String, String> paraMap) throws SQLException {
		
		boolean isUserExist = false;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select userid "
	                    + " from tbl_member "
	                    + " where status = 0 and userid = ? and email = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, paraMap.get("userid") );
	         pstmt.setString(2, aes.encrypt(paraMap.get("email")) );
	         
	         rs = pstmt.executeQuery();

	         isUserExist = rs.next();
	         
	      } catch(GeneralSecurityException | UnsupportedEncodingException e) {   
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
	      return isUserExist;
	}// end of public boolean isUserExist(Map<String, String> paraMap)------------

	
	// 이메일을 통해 인증번호 받은 후 비밀번호 변경
	@Override
	public int pwdUpdate(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set pwd = ? "
					   + "                     , lastpwdchagedate = sysdate "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, Sha256.encrypt(paraMap.get("pwd")));
			pstmt.setString(2, paraMap.get("userid"));
			
			n = pstmt.executeUpdate();
				
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int pwdUpdate(Map<String, String> paraMap)-----------
	
	
	// 비밀번호가 기존의 비밀번호인지 체크 해주는 메소드
	@Override
	public boolean checkPwd(MemberVO member) throws SQLException {
			
		 boolean c = false; // 비밀번호가 기존의 비밀번호면 true, 아니면 false
		
		  try {
		         conn = ds.getConnection();
		         
		         String sql = " select userid "
		                    + " from tbl_member "
		                    + " where status = 0 and userid = ? and pwd = ? ";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, member.getUserid() );
		         pstmt.setString(2, Sha256.encrypt(member.getPwd()) );
		       
		         
		         rs = pstmt.executeQuery();

		         c = rs.next();
		         
		      } finally {
		         close();
		      }
		

		return c;
	}
	
	
	// 마이페이지에서 개인정보 수정하기(비밀번호가 기존의 비밀번호인 경우, 마지막 비밀번호날짜 업데이트 x)
	@Override
	public int updateMemberNotPwd(MemberVO member) throws SQLException {
		
		int n = 0;
		
		try {		
			conn = ds.getConnection();
			
			String sql = " update tbl_member set name = ? "
					   + "                     , pwd = ? "
					   + "                     , email = ? "
					   + "                     , mobile = ? "
					   + "                     , postcode = ? "
					   + "                     , address = ? "
					   + "                     , detailaddress = ? "
					   + "                     , extraaddress = ? " 
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getName()); 
	        pstmt.setString(2, Sha256.encrypt(member.getPwd()) );
	        pstmt.setString(3, aes.encrypt(member.getEmail()) );
	        pstmt.setString(4, aes.encrypt(member.getMobile()) );
	        pstmt.setString(5, member.getPostcode() );
	        pstmt.setString(6, member.getAddress() );
	        pstmt.setString(7, member.getDetailaddress() );
	        pstmt.setString(8, member.getExtraaddress() );
	        pstmt.setString(9, member.getUserid() );
			
			n = pstmt.executeUpdate();
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {   
	         e.printStackTrace();
	    } finally {
			close();
		}
		
		
		return n;
	}// end of public int updateMemberNotPwd(MemberVO member)--------------

	
	// 마이페이지에서 계정 탈퇴 (status를 1로 업데이트한다)
	@Override
	public int deleteMember(Map<String, String> paraMap) throws SQLException {
	
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set status = 1 "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			n = pstmt.executeUpdate();
				
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int deleteMember(Map<String, String> paraMap)----------------


}