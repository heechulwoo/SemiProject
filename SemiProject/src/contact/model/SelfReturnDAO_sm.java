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
	
	
	
	// 셀프 반품 페이징 처리를 한 목록 보여주기
	@Override
	public List<SelfReturnVO> selectPagingReturn(Map<String, String> paraMap) throws SQLException {

		List<SelfReturnVO> selfReturnList = new ArrayList<>();
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select returnno, fk_userid, fk_odrcode, name, email, to_char(returndate, 'yyyy-mm-dd') AS returndate, status " + 
						 " from " + 
						 " ( " + 
						 "    select rownum AS rno, returnno, fk_userid, fk_odrcode, name, email, returndate, status " + 
						 "    from " + 
						 "    ( " + 
						 "    select returnno, fk_userid, fk_odrcode, name, email, returndate, status " + 
						 "    from tbl_return " + 
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
			
			
				sql +=	 "    order by returnno desc " + 
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
					
					SelfReturnVO rvo = new SelfReturnVO();
					
					rvo.setReturnno(rs.getInt(1));
					rvo.setFk_userid(rs.getString(2));
					rvo.setFk_odrcode(rs.getString(3));
					rvo.setName(rs.getString(4));
					rvo.setEmail( aes.decrypt(rs.getString(5)) ); // email 복호화
					rvo.setReturndate(rs.getString(6));
				    rvo.setStatus(rs.getInt(7));
					
					selfReturnList.add(rvo); // cvo 값을 List에 담아서 보내주기
					
					
				}// end of while------------------------------------------------	
			
			
			
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {	
			e.printStackTrace();	
		} finally {
			close();
		}
		
		
		return selfReturnList;
		
	}// end of public List<SelfReturnVO> selectPagingReturn(Map<String, String> paraMap)--------------
	
	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 셀프 반품에 대한 총 페이지 수 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) " + 
						 " from tbl_return " + 
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
		
		
		
	}// end of public int getTotalPage(Map<String, String> paraMap)------------------------------------
	
	
	
	// fk_userid & returnno 값을 받아서 셀프 반품 1개에 대한 상세정보를 알아오기(select) 
	@Override
	public SelfReturnVO SelfReturnOneDetail(Map<String, String> paraMap) throws SQLException {
		
		SelfReturnVO rvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select returnno, fk_userid, fk_odrcode, name, email, mobile, whyreturn, wherebuy, plusreason "+
					 	 "         , to_char(returndate, 'yyyy-mm-dd') AS returndate, status "+
					 	 " from tbl_return "+
					 	 " where fk_userid = ? and returnno = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, paraMap.get("fk_userid"));
	        pstmt.setString(2, paraMap.get("returnno"));
	        
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	        	
	        	rvo = new SelfReturnVO();
	        	
	        	rvo.setReturnno(rs.getInt(1));
	        	rvo.setFk_userid(rs.getString(2));
	        	rvo.setFk_odrcode(rs.getString(3));
	        	rvo.setName(rs.getString(4));
	        	rvo.setEmail( aes.decrypt(rs.getString(5)) );  // email(복호화 필수)
	        	rvo.setMobile( aes.decrypt(rs.getString(6)) ); // mobile(복호화 필수)
	        	rvo.setWhyreturn(rs.getString(7));
	        	rvo.setWherebuy(rs.getString(8));
	        	rvo.setPlusreason(rs.getString(9));
	        	rvo.setReturndate(rs.getString(10));
	         	rvo.setStatus(rs.getInt(11));
	        	
	        }
			
	    } catch(GeneralSecurityException | UnsupportedEncodingException e) {	
				e.printStackTrace();
		} finally {
			close();
		}
		
		return rvo;
		
	}// end of public SelfReturnVO SelfReturnOneDetail(Map<String, String> paraMap)---------------------
	
	
	
	// 셀프 반품 상태 변경해주기
	@Override
	public int updateSelfReturn(Map<String, String> paraMap) throws SQLException {
		
		
		int n = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update tbl_return set status = ? "
	                   + " where returnno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("status"));
			pstmt.setString(2, paraMap.get("returnno"));
			
			n = pstmt.executeUpdate();
			
			
		} finally {
			close();
		}
		
		
		return n;
		
	}// end of public int updateSelfReturn(Map<String, String> paraMap)--------------------------
	
	
}
