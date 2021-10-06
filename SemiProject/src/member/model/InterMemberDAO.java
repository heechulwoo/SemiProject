package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO {
	
	// 로그인 처리를 해주는 메소드 
	MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;
	
	
	
	
	
	
	
}
