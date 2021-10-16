package service.model;

public class AssembleVO {

	// 필드 
	private int assembleno;			   // 조립 신청 글번호
	private String fk_userid;		   // 로그인 되어 있는 아이디
	private String fk_odrcode;		   // 주문번호
	private String name;               // 회원명
	private String email;              // 이메일 (AES-256 암호화/복호화 대상)
	private String mobile;             // 연락처 (AES-256 암호화/복호화 대상)
	private String hopedate;		   // 희망일자
	private String hopehour;		   // 희망시간
	private String postcode;           // 우편번호
	private String address;            // 주소
	private String detailaddress;      // 상세주소
	private String extraaddress;       // 참고항목
	private String demand; 			   // 요청사항
	private String assembledate;	   // 신청일자
	
	private int progress;			   // 신청 진행상황
	
//////////////////////////////////////////////////////////////
	
	
	public AssembleVO() {} // 기본 생성자
	
	// 신청 양식에서 받아오는 값만
	public AssembleVO(String fk_userid, String fk_odrcode, String name, String email, String mobile, String hopedate,
			String hopehour, String postcode, String address, String detailaddress, String extraaddress,
			String demand) {
		this.fk_userid = fk_userid;
		this.fk_odrcode = fk_odrcode;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.hopedate = hopedate;
		this.hopehour = hopehour;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.demand = demand;
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
	public String getHopedate() {
		return hopedate;
	}
	public void setHopedate(String hopedate) {
		this.hopedate = hopedate;
	}
	public String getHopehour() {
		return hopehour;
	}
	public void setHopehour(String hopehour) {
		this.hopehour = hopehour;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	public String getExtraaddress() {
		return extraaddress;
	}
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	public String getDemand() {
		return demand;
	}
	public void setDemand(String demand) {
		this.demand = demand;
	}
	public String getAssembledate() {
		return assembledate;
	}
	public void setAssembledate(String assembledate) {
		this.assembledate = assembledate;
	}

	public int getAssembleno() {
		return assembleno;
	}

	public void setAssembleno(int assembleno) {
		this.assembleno = assembleno;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}
	
	
	
	
	
	
}
