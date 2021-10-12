package contact.model;

public class SelfReturnVO {
	
	
	
	private int returnno;           // 반품번호
	private String fk_userid;       // 회원아이디
	private String fk_odrcode;      // 제품번호
	private String name;            // 이름
	private String email;           // 이메일
	private String mobile;          // 휴대전화
	private String whyreturn;       // 반품사유
	private String wherebuy;        // 구입처
	private String plusreason;      // 추가 반품 사유
	private String returndate;      // 반품신청일
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	// 셀프 반품 신청서 등록용
	public SelfReturnVO(String fk_userid, String fk_odrcode, String name, String email, String mobile,
			String whyreturn, String wherebuy, String plusReason) {
		
		this.fk_userid = fk_userid;
		this.fk_odrcode = fk_odrcode;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.whyreturn = whyreturn;
		this.wherebuy = wherebuy;
		this.plusreason = plusReason;
		
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	// === getter setter === //
	
	public int getReturnno() {
		return returnno;
	}
	public void setReturnno(int returnno) {
		this.returnno = returnno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getFk_odrcode() {
		return fk_odrcode;
	}
	public void setFk_odrcode(String fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
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
	public String getWhyreturn() {
		return whyreturn;
	}
	public void setWhyreturn(String whyreturn) {
		this.whyreturn = whyreturn;
	}
	public String getWherebuy() {
		return wherebuy;
	}
	public void setWherebuy(String wherebuy) {
		this.wherebuy = wherebuy;
	}
	public String getPlusreason() {
		return plusreason;
	}
	public void setPlusreason(String plusreason) {
		this.plusreason = plusreason;
	}
	public String getReturndate() {
		return returndate;
	}
	public void setReturndate(String returndate) {
		this.returndate = returndate;
	}

	
	
}
