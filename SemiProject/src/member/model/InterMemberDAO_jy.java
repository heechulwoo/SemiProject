package member.model;

import java.sql.SQLException;
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
	
	
	
	
	
}
