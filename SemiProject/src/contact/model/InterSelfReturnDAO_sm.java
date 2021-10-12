package contact.model;

import java.sql.SQLException;
import java.util.List;

public interface InterSelfReturnDAO_sm {
	
	// 로그인 한 사용자의 주문 번호 가져오는 메소드
	List<String> getOdrcode(String userid) throws SQLException;
	
	// 셀프 반품 확인 이메일 보내주는 메소드
	int sendReturnEmail(SelfReturnVO selfReturn) throws SQLException;
	
	
	
	
}
