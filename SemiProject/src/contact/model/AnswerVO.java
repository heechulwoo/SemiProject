package contact.model;

public class AnswerVO {
	
	private int answerno; 			// 댓글 글번호
	private int fk_askno; 			// 문의게시글 글번호
	private String fk_userid; 		// 작성자ID
	private String answertitle; 	// 댓글 제목
	private String answercontent;   // 댓글 내용
	private String answerdate; 		// 댓글 작성일
	
	
	
	
	// === getter setter === //
	
	
	public int getAnswerno() {
		return answerno;
	}
	public void setAnswerno(int answerno) {
		this.answerno = answerno;
	}
	public int getFk_askno() {
		return fk_askno;
	}
	public void setFk_askno(int fk_askno) {
		this.fk_askno = fk_askno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getAnswertitle() {
		return answertitle;
	}
	public void setAnswertitle(String answertitle) {
		this.answertitle = answertitle;
	}
	public String getAnswercontent() {
		return answercontent;
	}
	public void setAnswercontent(String answercontent) {
		this.answercontent = answercontent;
	}
	public String getAnswerdate() {
		return answerdate;
	}
	public void setAnswerdate(String answerdate) {
		this.answerdate = answerdate;
	}
	
	
	
}
