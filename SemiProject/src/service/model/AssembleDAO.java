package service.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class AssembleDAO implements InterServiceDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public AssembleDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
			aes = new AES256(SecretMyKey.KEY); // 기본 생성자가 없고, 파라미터 생성자만 있다. 
		    
		}catch(NamingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
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
	public List<String> takeOdrcode(String userid) throws SQLException {
	   
	   List<String> odrcodeList = new ArrayList<>();
	   
	   try {
			
			conn = ds.getConnection();
	   
			String sql = " select odrcode "+
						" from tbl_order "+
						" where fk_userid = ? "+
						" order by odrdate ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			// System.out.println(userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				odrcodeList.add(rs.getString(1));				
			}
			
		} finally {
			close();
		}
		
		return odrcodeList;
	}   	   
   

	   
	// 조립 신청서를 제출하는 메소드(tbl_assemble 테이블에 insert)
	@Override
	public int applyAssemble(AssembleVO member) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_assemble(assembleno, fk_userid, fk_odrcode, name, email, mobile, hopedate, "
						+ " hopehour, postcode, address, detailaddress, extraaddress, demand, assembledate, progress) "
						+ " values(seq_assemble.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getFk_userid());
			pstmt.setString(2, member.getFk_odrcode());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail())); // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(5, aes.encrypt(member.getMobile())); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(6, member.getHopedate());
			pstmt.setString(7, member.getHopehour());
			pstmt.setString(8, member.getPostcode());
			pstmt.setString(9, member.getAddress());
			pstmt.setString(10, member.getDetailaddress());
			pstmt.setString(11, member.getExtraaddress());
			pstmt.setString(12, member.getDemand());
			pstmt.setInt(13, member.getProgress());
			
			n = pstmt.executeUpdate();
						
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}finally {
			close();
		}
				
		return n;
	}// end of public int applyAssemble(AssembleVO member) throws SQLException------

	
	// 페이징 처리를 한 조립 신청 목록 보여주기
	@Override
	public List<AssembleVO> assembleApplyMember(Map<String, String> paraMap) throws SQLException {
		
		List<AssembleVO> assembleList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select assembledate, assembleno, fk_odrcode, fk_userid, name, mobile, progress "
						+ " from "
						+ " ( "
						+ "   select rownum as rno, to_char(assembledate, 'yyyy-mm-dd') as assembledate, assembleno, fk_odrcode, fk_userid, name, mobile, progress "
						+ "   from "
						+ " 	( "
						+ "		select assembledate, assembleno, fk_odrcode, fk_userid, name, mobile, progress "
						+ "		from tbl_assemble "
						+ "     where fk_userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
						
			if("mobile".equals(colname)) {
				// 검색대상이 전화번호인 경우
				searchWord = aes.encrypt(searchWord); // 암호화해서 테이블 속 검색
			}
			
			if(searchWord != null && !searchWord.trim().isEmpty()) { // 검색어가 있는 경우
				
				sql += " and " + colname + " like '%'|| ? ||'%' ";
			}
			// 컬럼명과 테이블명은 위치홀더 불가하다!!! 변수처리
			
			sql +=	"    order by assembledate desc "+
					"    ) V "+
					" ) T "+
					" where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo")); 
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage")); 
			// 스트링 타입으로 받아온 '보고있는 페이지 번호', '페이지 내용물 개수'를 정수로 형변환 후 변수처리 
			
			if(searchWord != null && !searchWord.trim().isEmpty()) {
				// 검색어가 있는 경우
				pstmt.setString(1, searchWord);
				pstmt.setInt(2,  (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
				
			}
			else {
				// 검색어가 없는 경우 like 연산 sql문이 붙지 않는다.
				pstmt.setInt(1,  (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); 
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
				
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AssembleVO avo = new AssembleVO();
				avo.setAssembledate(rs.getString(1));
				avo.setAssembleno(rs.getInt(2));
				avo.setFk_odrcode(rs.getString(3));
				avo.setFk_userid(rs.getString(4));
				avo.setName(rs.getString(5));
				avo.setMobile(aes.decrypt(rs.getString(6)) ); // 복호화
				avo.setProgress(rs.getInt(7));

				assembleList.add(avo); 
				
			}// end of while-------------------------
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) { // | : 또는
			e.printStackTrace();		
		} finally {
			close();
		}
		
		return assembleList;
	}

	
	// 검색과 상관 없이 조립 신청에 대한 전체 페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "+
						 " from tbl_assemble " +
						 " where fk_userid != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if("mobile".equals(colname)) {
				// 검색대상이 mobile인 경우
				searchWord = aes.encrypt(searchWord); // 암호화한 값으로 검색
			}
			
			// 검색어가 있는 경우
			if(searchWord != null && !searchWord.trim().isEmpty()) {
				sql += " and "+colname+" like '%' || ? || '%' ";
				
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("sizePerPage"));
		
			if(searchWord != null && !searchWord.trim().isEmpty()) {
				
				pstmt.setString(2, searchWord);
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) { // | : 또는
			e.printStackTrace();	
		} finally {
			close();
		}
		
		return totalPage;
	}// end of public int getTotalPage(Map<String, String> paraMap)-----

	
	
	// 조립 신청 상세 알아와서 보여주기
	@Override
	public AssembleVO memberOneDetail(String assembleno) throws SQLException {
		
		AssembleVO avo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select assembleno, fk_userid, fk_odrcode, name, email, mobile, to_char(hopedate, 'yyyy-mm-dd'), "
					+ " hopehour, postcode, address, detailaddress, extraaddress, demand, assembledate, progress "
					+ " from tbl_assemble "
					+ " where assembleno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, assembleno);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				
				avo = new AssembleVO();
				avo.setAssembleno(rs.getInt(1));
				avo.setFk_userid(rs.getString(2));
				avo.setFk_odrcode(rs.getString(3));
				avo.setName(rs.getNString(4));
				avo.setEmail(aes.decrypt(rs.getString(5)));
				avo.setMobile(aes.decrypt(rs.getString(6)));
				avo.setHopedate(rs.getString(7));
				avo.setHopehour(rs.getString(8));
				avo.setPostcode(rs.getString(9));
				avo.setAddress(rs.getString(10));
				avo.setDetailaddress(rs.getString(11));
				avo.setExtraaddress(rs.getString(12));
				avo.setDemand(rs.getString(13));
				avo.setAssembledate(rs.getString(14));
				avo.setProgress(rs.getInt(15));
			
			}
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) { // | : 또는
			e.printStackTrace();	
		} finally {
			close();
			
			
		}
		
		return avo;
		
	}// end of 	public AssembleVO memberOneDetail(String odrcode)-----

	
	// 조립 신청 상태 바꾸기
	@Override
	public int updateProgress(String assembleno, String progress) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql= " update tbl_assemble set progress= ? where assembleno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, progress);
			pstmt.setString(2, assembleno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return n;
	}

	
	
	
}
