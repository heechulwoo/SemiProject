package contact.model;

public class ProductAddressVO_sm {
	
	private int addrno; 	   	  // 배송지번호
	private String fk_odrcode; 	  // 주문번호
	private String name; 	   	  // 성명
	private String mobile; 	   	  // 연락처
	private String postcode;   	  // 우편번호
	private String address;    	  // 주소
	private String detailaddress; // 상세주소        
	private String extraaddress;  // 주소참고항목
	
	
	
	
	// === getter setter === //
	
	public int getAddrno() {
		return addrno;
	}
	public void setAddrno(int addrno) {
		this.addrno = addrno;
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
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
	
	
}
