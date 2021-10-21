package contact.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class ConsultWriteDAO_sm implements InterConsultWriteDAO_sm {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public ConsultWriteDAO_sm() {
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
	
	
	
	// 문의게시판 글 업로드 해주는 메소드( tbl_ask 테이블에 insert )
	@Override
	public int uploadConsult(ConsultWriteVO_sm cWrite) throws SQLException {
		
		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_ask(askno, fk_userid, category, name, email, mobile, asktitle, askcontent, askdate, ask_systemFileName, ask_orginFileName) "     
	                   + " values(askno.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate, ?, ?) "; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cWrite.getFk_userid());
			pstmt.setString(2, cWrite.getCategory());
			pstmt.setString(3, cWrite.getName());
			pstmt.setString(4, aes.encrypt(cWrite.getEmail()));   // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(5, aes.encrypt(cWrite.getMobile()));  // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(6, cWrite.getAsktitle());
			pstmt.setString(7, cWrite.getAskcontent());
			pstmt.setString(8, cWrite.getAsk_systemFileName());  // ask_systemFileName
			pstmt.setString(9, cWrite.getAsk_orginFileName());   // ask_orginFileName
			
			n = pstmt.executeUpdate();
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
		} finally {
			close();
		}
		
		
		return n;
		
	}// end of public int uploadConsult(ConsultWriteVO_sm cWrite)--------------------

	
	
	// 문의게시판 페이징 처리를 한 글 목록 보여주기
	@Override
	public List<ConsultWriteVO_sm> selectPagingConsult(Map<String, String> paraMap) throws SQLException {
		
		List<ConsultWriteVO_sm> consultList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select askno, fk_userid, asktitle, name, to_char(askdate, 'yyyy-mm-dd') AS askdate , ask_systemFileName" + 
						 " from " + 
						 " ( " + 
						 "    select rownum AS rno, askno, fk_userid, asktitle, name, askdate, ask_systemFileName " + 
						 "    from " + 
						 "    ( " + 
						 "    select askno, fk_userid, asktitle, name, askdate, ask_systemFileName " + 
						 "    from tbl_ask " + 
						 "    where fk_userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if( "email".equals(colname) ) {
				// 검색대상 선택을 email로 했을 경우 
				// searchWord 에 email 이 올 것이므로 DB와 맞춰줘야만한다(--> 암호화 필요)
				searchWord = aes.encrypt(searchWord);
			}
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				// searchWord가 널값이 아니며, 공백도 아닌 경우
				
				sql += "  and "+colname+" like '%'|| ? ||'%' ";
				// column 명과 테이블명에는 위치홀더 절대 안돼 !!!!! 
				// 검색어만 위치홀더 가능 (그래서 컬럼명에는 위에서 설정해준 변수 colname을 넣어주자)
			}
			
			
				sql +=	 "    order by askno desc " + 
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
					
					ConsultWriteVO_sm cvo = new ConsultWriteVO_sm();
					
					cvo.setAskno(rs.getInt(1));
					cvo.setFk_userid(rs.getString(2));
					cvo.setAsktitle(rs.getString(3));
					cvo.setName(rs.getString(4));
					cvo.setAskdate(rs.getString(5));
					cvo.setAsk_systemFileName(rs.getString(6));
					
					consultList.add(cvo); // cvo 값을 List에 담아서 보내주기
					
					
				}// end of while------------------------------------------------	
			
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
			e.printStackTrace();	
		} finally {
			close();
		}
		
		return consultList;
	}// end of public List<ConsultWriteVO_sm> selectPagingConsult(Map<String, String> paraMap)------------------------------
	
	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 문의게시판 글에 대한 총 페이지 수 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) " + 
						 " from tbl_ask " + 
						 " where fk_userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if( "email".equals(colname) ) {
				// 검색대상 선택을 email로 했을 경우 
				// searchWord 에 email 이 올 것이므로 DB와 맞춰줘야만한다(--> 암호화 필요)
				searchWord = aes.encrypt(searchWord);
			}
			
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
			
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getTotalPage(Map<String, String> paraMap)----------------------------------------------
	
	
	
	// fk_userid 값을 받아서 문의글 1개에 대한 상세정보를 알아오기(select) 
	@Override
	public ConsultWriteVO_sm consultOneDetail(Map<String, String> paraMap) throws SQLException {
		
		ConsultWriteVO_sm cvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select askno, fk_userid, category, name, email, mobile, asktitle, askcontent "+
					 	 "         , to_char(askdate, 'yyyy-mm-dd') AS askdate, ask_systemFileName, nvl(ask_orginFileName, '없음') AS ask_orginFileName "+
					 	 " from tbl_ask "+
					 	 " where fk_userid = ? and askno = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, paraMap.get("fk_userid"));
	        pstmt.setString(2, paraMap.get("askno"));
	        
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	        	
	        	cvo = new ConsultWriteVO_sm();
	        	cvo.setAskno(rs.getInt(1));
	        	cvo.setFk_userid(rs.getString(2)); 			   // fk_userid
	        	cvo.setCategory(rs.getString(3));  			   // category
	        	cvo.setName(rs.getString(4));				   // name
	        	cvo.setEmail( aes.decrypt(rs.getString(5)) );  // email(복호화 필수)
	        	cvo.setMobile( aes.decrypt(rs.getString(6)) ); // mobile(복호화 필수)
	        	cvo.setAsktitle(rs.getString(7));			   // asktitle
	        	cvo.setAskcontent(rs.getString(8));            // askcontent
	        	cvo.setAskdate(rs.getString(9));               // askdate
	        	cvo.setAsk_systemFileName(rs.getString(10));   // ask_systemFileName 
	        	cvo.setAsk_orginFileName(rs.getString(11));    // ask_orginFileName  
	        	
	        }
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
			e.printStackTrace();	
		} finally {
			close();
		}
		
		return cvo;
		
	}// end of public ConsultWriteVO_sm consultOneDetail(Map<String, String> paraMap)-------------------------
	
	
	
	// 문의글 수정해주기
	@Override
	public int updateConsult(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_ask set askno = ? "
	                   + "                  , fk_userid = ? "
	                   + "                  , category = ? "
	                   + "                  , name = ? "
	                   + "                  , email = ? "
	                   + "                  , mobile = ? "
	                   + "                  , asktitle = ? "
	                   + "                  , askcontent = ? "
	                   + "                  , askdate = sysdate "
	                   + "                  , ask_systemFileName = ? "
	                   + "                  , ask_orginFileName = ? "
	                   + " where askno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("askno"));
			pstmt.setString(2, paraMap.get("fk_userid"));
			pstmt.setString(3, paraMap.get("category"));
			pstmt.setString(4, paraMap.get("name"));
			pstmt.setString(5, aes.encrypt(paraMap.get("email")) );
			pstmt.setString(6, aes.encrypt(paraMap.get("mobile")) );
			pstmt.setString(7, paraMap.get("asktitle"));
			pstmt.setString(8, paraMap.get("askcontent"));
			pstmt.setString(9, paraMap.get("ask_systemFileName"));
			pstmt.setString(10, paraMap.get("ask_orginFileName"));
			pstmt.setString(11, paraMap.get("askno"));
			
			n = pstmt.executeUpdate();
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
			e.printStackTrace();	
		} finally {
			close();
		}
		
		
		return n;
	}// end of public int updateConsult(Map<String, String> paraMap)-------------------------------
	
	
	
	// 글번호를 가지고서 해당 글의 첨부파일의 서버에 업로드된 파일명과 오리지널 파일명을 조회해오기
	@Override
	public Map<String, String> getAskFileName(String askno) throws SQLException {
		
		
		Map<String, String> map = new HashMap<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ask_systemFileName, ask_orginFileName "
	                  	+ " from tbl_ask "
	                  	+ " where askno = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, askno);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            map.put("ask_systemFileName", rs.getString(1)); 
	            // 파일서버에 업로드되어지는 실제 파일명
	            
	            map.put("ask_orginFileName", rs.getString(2)); 
	            // 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 파일명
	         }
	         
	      } finally {
	         close();
	      }
	      
	      return map;
		
		
	}// end of public Map<String, String> getAskFileName(String askno)-------------------
	
	
	
	// fk_userid 값, 글번호값을 받아서 문의글 1개 삭제
	@Override
	public int consultOneDelete(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			
			 conn = ds.getConnection();
			 
			 String sql = " delete from tbl_ask " + 
					      " where fk_userid = ? and askno = ? ";
			 
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, paraMap.get("fk_userid"));
			 pstmt.setString(2, paraMap.get("askno"));
			 
			 n = pstmt.executeUpdate();
			 
		} finally {
			close();
		}
		
		return n;
		
	}// end of public int consultOneDelete(Map<String, String> paraMap)-------------------------
	
	
	
	
	
	
	
	
	
	
	

}
