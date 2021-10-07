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

public class MemberDAO implements InterMemberDAO {
	
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public MemberDAO() {
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

   
	// 로그인 처리를 해주는 메소드    
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		
		MemberVO member = null;

		
		try {
			
			conn = ds.getConnection();
			
			String sql = " SELECT userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
						 "    , birthyyyy, birthmm, birthdd, registerday, pwdchangegap "+
						 "    , NVL(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap "+
				 		 " FROM "+
						 " ( "+
						 "    select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
						 "         , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
						 "         , to_char(registerday, 'yyyy-mm-dd') AS registerday "+
						 "         , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap "+
						 "    from tbl_member "+
						 "    where status = 0 and userid = ? and pwd = ? "+
						 " )  "+
						 " CROSS JOIN  "+
						 " ( "+
						 "    select  trunc( months_between(sysdate,max(logindate) ) ) AS lastlogingap  "+
						 "    from tbl_loginhistory "+
						 "    where fk_userid = ? "+
						 " ) H ";
				
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid") );
		//	pstmt.setString(2, paraMap.get("pwd") );
		    pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) );  
			pstmt.setString(3, paraMap.get("userid") );
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				member = new MemberVO();
				
				member.setUserid(rs.getString(1));
				member.setName(rs.getString(2));
			//	member.setEmail(rs.getString(3));   
			//	member.setMobile(rs.getString(4));
				member.setEmail( aes.decrypt(rs.getString(3)));   
				member.setMobile( aes.decrypt(rs.getString(4)) ); 
	            member.setPostcode(rs.getString(5));
	            member.setAddress(rs.getString(6));
	            member.setDetailaddress(rs.getString(7));
	            member.setExtraaddress(rs.getString(8));
	            member.setGender(rs.getString(9));
	            member.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
	            member.setRegisterday(rs.getString(13));
				
	            
				if(rs.getInt(14) >= 3) { // 마지막으로 암호를 변경한 날짜가 지금으로부터 3개월이 지났다면 true
					
					member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다.
					
				}
	            
				if( rs.getInt(15) >= 12 ) {
	            	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정
	            	member.setIdle(1);  // 0이 활동중, 1이 휴면
	            	
	            	// === tbl_member 테이블의 idle 컬럼의 값을 0 로 변경 하기 === //
	            	
	            	sql = " update tbl_member set idle = 1 "
	            		+ " where userid = ? ";
	            	
	            	pstmt = conn.prepareStatement(sql);
	            	pstmt.setString(1, paraMap.get("userid"));
	            	
	            	pstmt.executeUpdate();
	            	
	            }
				
				// === tbl_loginhistory(로그인기록) 테이블에 insert 하기 === //
	            
	            if(member.getIdle() != 1) { // 휴면상태가 아니라면 (1이 휴면상태)
	            	
	            	sql = " insert into tbl_loginhistory(fk_userid,clientip) "
	            		+ " values(?, ?) ";
	            	
	            	pstmt = conn.prepareStatement(sql);
	            	pstmt.setString(1, paraMap.get("userid"));
	            	pstmt.setString(2, paraMap.get("clientip"));
	            	
	            	pstmt.executeUpdate();
	            
	         
	            	
	            }
 
			}// end of if ---------------------------
			
		
		}catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return member;
	}

}
