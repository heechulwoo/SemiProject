package service.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;

public interface InterServiceDAO {

	// 로그인 한 사용자의 주문 번호 가져오는 메소드
	List<String> takeOdrcode(String userid) throws SQLException;
	
	// 조립 신청서를 제출하는 메소드(tbl_assemble 테이블에 insert)
	int applyAssemble(AssembleVO member) throws SQLException;

	// 페이징 처리를 한 조립 신청 목록 보여주기
	List<AssembleVO> assembleApplyMember(Map<String, String> paraMap)throws SQLException;

	// 검색과 상관 없이 조립 신청에 대한 전체 페이지 알아오기
	int getTotalPage(Map<String, String> paraMap)throws SQLException;

	// 조립 신청 상세 보여주기
	AssembleVO memberOneDetail(String assembleno)throws SQLException;

	// 조립 신청 상태 바꾸기
	int updateProgress(String assembleno, String progress)throws SQLException;



	
	

}
