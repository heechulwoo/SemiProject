package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO_jy {
	
	// 로그인 처리를 해주는 메소드 
	MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다) (추상메소드)
	boolean idDuplicateCheck(String userid) throws SQLException;
	   
	// email 중복검사 (tbl_member 테이블에서 email이  존재하면 true를 리턴해주고, email이 존재하지 않으면 false를 리턴한다) (추상메소드)
	boolean emailDuplicateCheck(String email) throws SQLException;
	   
	// 회원가입을 해주는 메소드(tbl_member 테이블에 insert)(추상메소드)
	int registerMember(MemberVO member) throws SQLException;
	
	// 페이징 처리를 한 회원목록의 조회를 해주는 메소드 
	List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// userid 값을 입력을받아서 회원 1명에 대한 상세정보를 알아오기 (select)
	MemberVO memberOneDetail(String userid) throws SQLException;
	
	// 휴면 해제전 인증하는 메소드 (아이디, 비밀번호, 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려준다)
	boolean isUserRestart(Map<String, String> paraMap) throws SQLException;
	
	// 마지막 로그인값을 업데이트 해주는 메소드
	int loginUpdate(Map<String, String> paraMap) throws SQLException;
	
	// idle(휴면) 상태를 업데이트 해주는 메소드
	int idleUdate(Map<String, String> paraMap) throws SQLException ;
	
	
	
	
	
}
