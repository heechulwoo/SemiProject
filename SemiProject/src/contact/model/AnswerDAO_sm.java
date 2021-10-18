package contact.model;

import java.io.UnsupportedEncodingException;
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

import util.security.AES256;
import util.security.SecretMyKey;

public class AnswerDAO_sm implements InterAnswerDAO_sm{
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public AnswerDAO_sm() {
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
	
	
	
	// 댓글 등록하는 메소드(tbl_answer 테이블에 insert)
	@Override
	public int registerAnswer(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			
			String sql = " insert into tbl_answer(answerno, fk_askno, fk_userid, answertitle, answercontent, answerdate) "     
	                   + " values(answerno.nextval, ?, ?, ?, ?, sysdate) "; 
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("fk_askno"));
			pstmt.setString(2, paraMap.get("fk_userid"));
			pstmt.setString(3, paraMap.get("answertitle"));
			pstmt.setString(4, paraMap.get("answercontent"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return n;
		
	}// end of public int registerAnswer(Map<String, String> paraMap)---------------------------------
	
	
	
	// 댓글 목록 보여주는 메소드(tbl_answer 테이블에 select)
	@Override
	public List<AnswerVO> viewAnswer(Map<String, String> paraMap) throws SQLException {
		
		List<AnswerVO> answerList = new ArrayList<>();
		
		
		try {
			
			conn = ds.getConnection();
			
			
			String sql = " select answerno, fk_askno, fk_userid, answertitle, answercontent, to_char(answerdate, 'yyyy-mm-dd') AS answerdate "+
					 	 " from tbl_answer "+
					 	 " where fk_userid = ? and fk_askno = ? "+
					 	 " order by answerno ";
		
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_userid"));
	        pstmt.setString(2, paraMap.get("askno"));		// paraMap key값 주의 !
	        
	        rs = pstmt.executeQuery();
	        
	        
	        while(rs.next()) {
				// 존재한다면
				
	        	AnswerVO avo = new AnswerVO();
				
	        	avo.setAnswerno(rs.getInt(1));
	        	avo.setFk_askno(rs.getInt(2));
	        	avo.setFk_userid(rs.getString(3));
	        	avo.setAnswertitle(rs.getString(4));
	        	avo.setAnswercontent(rs.getString(5));
	        	avo.setAnswerdate(rs.getString(6));
				
				
				answerList.add(avo); // cvo 값을 List에 담아서 보내주기
				
				
			}// end of while------------------------------------------------	
		
	        
			
		} finally {
			close();
		}
		
		return answerList;
		
	}// end of public List<AnswerVO> viewAnswer(Map<String, String> paraMap)--------------------------
	
	
	
	// 댓글 삭제하는 메소드(tbl_answer 테이블에 delete)
	@Override
	public int deleteAnswer(String answerno) throws SQLException {
		
		int n = 0;
		
		try {
			
			 conn = ds.getConnection();
			 
			 String sql = " delete from tbl_answer " + 
					      " where answerno = ? ";
			 
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, answerno);
			 
			 n = pstmt.executeUpdate();
			 
		} finally {
			close();
		}
		
		return n;
		
	}// end of public int deleteAnswer(String answerno)---------------------------------------------
	   
	
	
	
	
	
	
	
	
}
