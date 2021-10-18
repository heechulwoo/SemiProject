package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import product.model.ProductOrderDetailVO_kgh;
import product.model.ProductOrderVO_kgh;
import product.model.ProductVO;
import product.model.ProductVO_kgh;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO_jy implements InterMemberDAO_jy {
	
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public MemberDAO_jy() {
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
		
	}// public MemberVO selectOneMember(Map<String, String> paraMap)---------

	
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	   @Override
	   public boolean idDuplicateCheck(String userid) throws SQLException {
	      
	      boolean isExists = false;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select userid "
	                  + " from tbl_member "
	                  + " where userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);   
	         
	         rs = pstmt.executeQuery();
	         
	         isExists = rs.next(); // 행이 있으면 (중복된 userid) true,
	                          // 행이 없으면 (중복된 userid) false,
	         
	         
	      } finally {
	         close();
	         
	      }

	      return isExists;
	   }// end of public boolean idDuplicateCheck(String userid)-------------
	   
	   
	  
	    // email 중복검사 (tbl_member 테이블에서 email이  존재하면 true를 리턴해주고, email이 존재하지 않으면 false를 리턴한다) (추상메소드)
	   @Override
	   public boolean emailDuplicateCheck(String email) throws SQLException {
	      
	      boolean isExists = false;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select email "
	                  + " from tbl_member "
	                  + " where email = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, aes.encrypt(email)); // "seokj@gmail.com" ==> aes.encrypt("seokj@gmail.com") ==> ZcP4DfL7Voac4wwe6pNyRA==
	         
	         rs = pstmt.executeQuery();
	         
	         isExists = rs.next(); // 행이 있으면 (중복된 email) true,
	                          // 행이 없으면 (사용가능한 email) false
	   
	      } catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } finally {
	            close();
	      }
	   
	      return isExists;
	         
	   }// end of public boolean emailDuplicateCheck(String email)-----------------


	   // 회원가입을 해주는 메소드(tbl_member 테이블에 insert)(추상메소드)
	   @Override
	   public int registerMember(MemberVO member) throws SQLException {
	      
	      int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) "     
	                  + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) "; 
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, member.getUserid());
	         pstmt.setString(2, Sha256.encrypt(member.getPwd()) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. (복호화 불가)
	         pstmt.setString(3, member.getName());
	         pstmt.setString(4, aes.encrypt(member.getEmail()));  // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
	         pstmt.setString(5, aes.encrypt(member.getMobile())); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
	         pstmt.setString(6, member.getPostcode());
	         pstmt.setString(7, member.getAddress());
	         pstmt.setString(8, member.getDetailaddress());
	         pstmt.setString(9, member.getExtraaddress());
	         pstmt.setString(10, member.getGender());
	         pstmt.setString(11, member.getBirthday());
	         
	         n = pstmt.executeUpdate();
	         
	      } catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      

	      return n;
	   }// end of public int registerMember(MemberVO member)-------------------

	   
	   
	   
	// 페이징 처리를 한 회원목록의 조회를 해주는 메소드
	@Override
	public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
		
		List<MemberVO> memberList = new ArrayList<>();
			
		try {
			
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, gender " + 
					     " from " + 
				 	     " ( " + 
					     "    select rownum AS rno, userid, name, email, gender " + 
					     "    from " + 
					     "    ( " + 
					     "     select userid, name, email, gender " + 
				 	     "     from tbl_member " + 
					     "     where userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
		
			
			if("email".equals(colname)) {
				searchWord = aes.encrypt(searchWord);
			}
		
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				sql += " and " + colname + " like '%'|| ? || '%' ";
				
			}
			
			sql +=  "     order by registerday desc " + 
					"    )V " + 
					" ) T " + 
					" where rno between ? and ? ";
	
			
			pstmt = conn.prepareStatement(sql);

			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			
			
			if( searchWord != null && !searchWord.trim().isEmpty()) {
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));  // 공식
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));  // 공식
				pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식
			}

			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setEmail(aes.decrypt(rs.getString(3))); // 복호화
				mvo.setGender(rs.getString(4));
				
				memberList.add(mvo);
				
			}// end of while-----------------------

			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
			
		return memberList;
	}



	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기  
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ceil(count(*)/?) " + 
	                      " from tbl_member " + 
	                      " where userid != 'admin' ";
	         
	         String colname = paraMap.get("searchType");
	         String searchWord = paraMap.get("searchWord");
	         
	         if( "email".equals(colname) ) {
	            // 검색대상이 email 인 경우
	            searchWord = aes.encrypt(searchWord);
	         }
	         
	         if( searchWord != null && !searchWord.trim().isEmpty() ) {
	            sql += " and "+colname+" like '%'|| ? ||'%' ";
	         }
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, paraMap.get("sizePerPage"));
	         
	         if( searchWord != null && !searchWord.trim().isEmpty() ) {
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
	
	}

	
	
	// userid 값을 입력을받아서 회원 1명에 대한 상세정보를 알아오기 (select)
	@Override
	public MemberVO memberOneDetail(String userid) throws SQLException {
		
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender "+
					 	 "      , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
						 "      , to_char(registerday, 'yyyy-mm-dd') AS registerday "+
						 " from tbl_member  "+
						 " where userid = ? ";
		
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userid);
	                  
	        rs = pstmt.executeQuery();
	         
	        if(rs.next()) {  
	               
	            mvo = new MemberVO();
	            mvo.setUserid(rs.getString(1));
	            mvo.setName(rs.getString(2));
	            mvo.setEmail(aes.decrypt(rs.getString(3))); // 복호화 
	            mvo.setMobile( aes.decrypt(rs.getString(4)) ); // 복호화 
	            mvo.setPostcode(rs.getString(5));
	            mvo.setAddress(rs.getString(6));
	            mvo.setDetailaddress(rs.getString(7));
	            mvo.setExtraaddress(rs.getString(8));
	            mvo.setGender(rs.getString(9));
	            mvo.setBirthday(rs.getString(10) + rs.getString(11) + rs.getString(12));
	            mvo.setRegisterday(rs.getString(13));
	         }			
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {   
	         e.printStackTrace();
	    } finally {
			close();
		}
		
		return mvo;
	}// end of public MemberVO memberOneDetail(String userid)------------------

	
	// 휴면 해제전 인증하는 메소드 (아이디, 비밀번호, 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려준다)
	@Override
	public boolean isUserRestart(Map<String, String> paraMap) throws SQLException {
		
		boolean isUserRestart = false; 

		
		try {
			conn = ds.getConnection();
			
			String sql = " select email "
					   + " from tbl_member "
					   + " where idle = 1 and userid = ? and pwd = ? and email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) );
			pstmt.setString(3, aes.encrypt(paraMap.get("email")) ); 
			
			rs = pstmt.executeQuery();
			
			
			isUserRestart = rs.next();
			
			
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {   
	         e.printStackTrace();
	    } finally {
			close();
		}
		

		return isUserRestart;

		
	}// end of public boolean isUserRestart(Map<String, String> paraMap)--------------

	
	
	// 마지막 로그인 값을 업데이트 해주는 메소드 (마지막 로그인 값을 업데이트 해주는 메소드)
	@Override
	public int loginUpdate(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_loginhistory set logindate = sysdate "+
						 " where FK_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			n = pstmt.executeUpdate();
			
	    } finally {
			close();
		}
		
		
		return n;
	}

	
	// idle(휴면상태)를 활동중으로 바꿔주는 메소드
	@Override
	public int idleUdate(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set idle = '0' "+
						 " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			n = pstmt.executeUpdate();
			
	    } finally {
			close();
		}
		
		return n;
	}

	
	// 로그인된 회원의 주문목록을 띄워주는 메소드
	@Override
	public List<ProductOrderVO_kgh> selectMyPageOderList(String userid) throws SQLException {
		
		List<ProductOrderVO_kgh> productList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select odrcode, odrdate ,odrtotalprice " + 
						 " from tbl_order " + 
					     " where fk_userid = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				ProductOrderVO_kgh pvo = new ProductOrderVO_kgh();
				pvo.setOdrcode(rs.getString(1));
				pvo.setOdrdate(rs.getString(2));
				pvo.setOdrtotalprice(rs.getInt(3));
				
				productList.add(pvo);
				
			}// end of while-----------------------
			
		
		} finally {
			close();
		}
			
		return productList;
		
	} // end of public List<ProductVO> selectMyPageOderList(String userid)-------------

	
	// 클릭한 주문번호를 가지고 주문상세정보를 띄워주는 메소드
	@Override
	public List<ProductOrderDetailVO_kgh> selectBySpecName(String odrcode) throws SQLException {
		
		List<ProductOrderDetailVO_kgh> odrDetail = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pname, price, oqty, odrprice, deliverstatus, fk_odrcode, deliverdate, odrtotalprice " + 
						 " from tbl_order_detail O join tbl_product P " + 
						 " on P.pnum = O.fk_pnum " + 
						 " join tbl_order R " + 
						 " on O.fk_odrcode = R.odrcode " + 
						 " where fk_odrcode = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, odrcode);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				// ProductOrderVO_kgh (tbl_order) --주문
				
				// ProductOrderDetailVO_kgh (tbl_order_detail) --주문상세
				// private ProductVO_kgh pvo;				// 제품 VO 주문상세에 포함
				// private ProductOrderVO_kgh povo;		    // 주문 VO	 주문상세에 포함
				
				// ProductVO_kgh (tbl_product) -- 제품
				
				
				String pname = rs.getString(1); // 제품명
				int price = rs.getInt(2); // 제품금액
				int oqty = rs.getInt(3); // 주문개수
				int odrprice = rs.getInt(4); // 상품금액
				int deliverstatus = rs.getInt(5); // 배송상태 
				String fk_odrcode = rs.getString(6); // 주문코드
				String deliverdate = rs.getString(7); // 배송일자
				int odrtotalprice = rs.getInt(8);
				
				
				ProductVO_kgh pvo = new ProductVO_kgh();
				 // pname, price
				
				pvo.setPname(pname);
				pvo.setPrice(price);
				
				
				
				ProductOrderDetailVO_kgh pdvo = new ProductOrderDetailVO_kgh();  // 기본값
				
				pdvo.setPvo(pvo);// 다른 테이블값을 넣어준다
				
				// oqty, odrprice, deliverstatus, fk_odrcode, deliverdate
				pdvo.setOqty(oqty);
				pdvo.setOdrprice(odrprice);
				pdvo.setDeliverstatus(deliverstatus);
				pdvo.setFk_odrcode(fk_odrcode);
				pdvo.setDeliverdate(deliverdate);
				
				
				ProductOrderVO_kgh povo = new ProductOrderVO_kgh();
				// odrtotalprice
				povo.setOdrtotalprice(odrtotalprice);
				
				pdvo.setPovo(povo);// 다른 테이블의 값을 넣어준다 22
				
				odrDetail.add(pdvo);

				
			}// end of while-------------
			
		} finally {
			close();
		}
		
		
		return odrDetail;
		
	}// end of public List<ProductOrderDetailVO_kgh> selectBySpecName(String odrcode)---------
	
}
	

