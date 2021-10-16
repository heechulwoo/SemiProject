package contact.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterSelfReturnDAO_sm {
	
	// 로그인 한 사용자의 주문 번호 가져오는 메소드
	List<String> getOdrcode(String userid) throws SQLException;
	
	// 셀프 반품 확인 이메일 보내주는 메소드
	int sendReturnEmail(SelfReturnVO selfReturn) throws SQLException;
	
	// 셀프 반품 페이징 처리를 한 목록 보여주기
	List<SelfReturnVO> selectPagingReturn(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 셀프 반품에 대한 총 페이지 수 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// fk_userid & returnno 값을 받아서 셀프 반품 1개에 대한 상세정보를 알아오기(select) 
	SelfReturnVO SelfReturnOneDetail(Map<String, String> paraMap) throws SQLException;
	
	// 셀프 반품 상태 변경해주기
	int updateSelfReturn(Map<String, String> paraMap) throws SQLException;
	
	
	
	
}
