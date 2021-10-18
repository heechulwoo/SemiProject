package contact.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterConsultWriteDAO_sm {
	
	// 문의게시판 글 업로드 해주는 메소드( tbl_ask 테이블에 insert )
	int uploadConsult(ConsultWriteVO_sm cWrite) throws SQLException;
	
	// 문의게시판 페이징 처리를 한 글 목록 보여주기
	List<ConsultWriteVO_sm> selectPagingConsult(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 문의게시판 글에 대한 총 페이지 수 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// fk_userid 값을 받아서 문의글 1개에 대한 상세정보를 알아오기(select) 
	ConsultWriteVO_sm consultOneDetail(Map<String, String> paraMap) throws SQLException;
	
	// 문의글 수정해주기
	int updateConsult(Map<String, String> paraMap) throws SQLException;
	
	
	
	
	
	// 글번호를 가지고서 해당 글의 첨부파일의 서버에 업로드된 파일명과 오리지널 파일명을 조회해오기
	Map<String, String> getAskFileName(String askno) throws SQLException;
	
	// fk_userid 값, 글번호값을 받아서 문의글 1개 삭제
	int consultOneDelete(Map<String, String> paraMap) throws SQLException;

}
