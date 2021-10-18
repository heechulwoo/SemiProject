package contact.model;

public class ProductOrderVO_sm {
	
	private String odrcode;		// 주문번호
	private String fk_userid;	// 유저 아이디
	private int odrtotalprice;	// 주문 총액
	private String odrdate;		// 주문일자
	
	
	// === getter setter === //
	
	public String getOdrcode() {
		return odrcode;
	}
	public void setOdrcode(String odrcode) {
		this.odrcode = odrcode;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getOdrtotalprice() {
		return odrtotalprice;
	}
	public void setOdrtotalprice(int odrtotalprice) {
		this.odrtotalprice = odrtotalprice;
	}
	public String getOdrdate() {
		return odrdate;
	}
	public void setOdrdate(String odrdate) {
		this.odrdate = odrdate;
	}
	
	
	
}
