package contact.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterAnswerDAO_sm {
	
	// 댓글 등록하는 메소드(tbl_answer 테이블에 insert)
	int registerAnswer(Map<String, String> paraMap) throws SQLException;
	
	// 댓글 목록 보여주는 메소드(tbl_answer 테이블에 select)
	List<AnswerVO> viewAnswer(Map<String, String> paraMap) throws SQLException;
	
	// 댓글 삭제하는 메소드(tbl_answer 테이블에 delete)
	int deleteAnswer(String answerno) throws SQLException;
	
	
	
	
	
	
}
