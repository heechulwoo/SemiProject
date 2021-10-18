package contact.model;

public class ConsultWriteVO_sm {
	
	
	
	private int askno; 		   // 문의글번호
	private String fk_userid;  // 작성자ID
	private String category;   // 카테고리
	private String name;       // 성명
	private String email;      // 이메일
	private String mobile;     // 휴대전화
	private String asktitle;   // 글제목
	private String askcontent; // 글내용
	private String askdate;    // 작성일자
	private String ask_systemFileName; // 
	private String ask_orginFileName;  // 
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////
	
	
	public ConsultWriteVO_sm() { }
	
	
	///////////////////////////////////////////////////////////////////////////////
	
	// 문의 게시판 등록용(안쓴다)
/*
	public ConsultWriteVO_sm(String fk_userid, String category, String name, String email, String mobile,
			String asktitle, String askcontent) {
		
		this.fk_userid = fk_userid;
		this.category = category;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.asktitle = asktitle;
		this.askcontent = askcontent;
		
	}
*/
	
	

	// 문의 게시판 등록용
	public ConsultWriteVO_sm(String fk_userid, String category, String name, String email, String mobile,
			String asktitle, String askcontent, String ask_systemFileName, String ask_orginFileName) {
		
		this.fk_userid = fk_userid;
		this.category = category;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.asktitle = asktitle;
		this.askcontent = askcontent;
		this.ask_systemFileName = ask_systemFileName;
		this.ask_orginFileName = ask_orginFileName;
		
	}
	
	
	
	///////////////////////////////////////////////////////////////////////////////
	
	
	// === getter setter === //
	
	
	
	public int getAskno() {
		return askno;
	}
	public void setAskno(int askno) {
		this.askno = askno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAsktitle() {
		return asktitle;
	}
	public void setAsktitle(String asktitle) {
		this.asktitle = asktitle;
	}
	public String getAskcontent() {
		return askcontent;
	}
	public void setAskcontent(String askcontent) {
		this.askcontent = askcontent;
	}
	
	public String getAskdate() {
		return askdate;
	}
	public void setAskdate(String askdate) {
		this.askdate = askdate;
	}
	
	public String getAsk_systemFileName() {
		return ask_systemFileName;
	}

	public void setAsk_systemFileName(String ask_systemFileName) {
		this.ask_systemFileName = ask_systemFileName;
	}

	public String getAsk_orginFileName() {
		return ask_orginFileName;
	}

	public void setAsk_orginFileName(String ask_orginFileName) {
		this.ask_orginFileName = ask_orginFileName;
	}
	
	
	
	/*	
	public String getAskfile() {
		return askfile;
	}
	public void setAskfile(String askfile) {
		this.askfile = askfile;
	}
	
	public int getAskcount() {
		return askcount;
	}
	public void setAskcount(int askcount) {
		this.askcount = askcount;
	}
	
*/
	
}
