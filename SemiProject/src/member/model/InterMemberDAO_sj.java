package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO_sj {

	// 마이페이지에서 개인정보 수정하기(기존의 암호와 동일한 경우 최근암호변경일은 업데이트 하지 않는다.)
	int updateMember(MemberVO member) throws SQLException;

	// 마이페이지에서 개인정보 수정하기(기존의 암호와 동일한 경우 최근암호변경일은 업데이트 하지 않는다.)
	int updateMember_2(MemberVO member) throws SQLException;
	 
	// 아이디 찾기(성명, 이메일을 입력 받아서 해당 사용자의 아이디를 알려준다)
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// 비밀번호 찾기(아이디, 이메일을 입력 받아서 해당 사용자가 존재하는지 유무를 알려준다)
	boolean isUserExist(Map<String, String> paraMap) throws SQLException;

	// 이메일을 통해 인증번호를 받은 후 비밀번호 변경
	int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	

	

	
}
