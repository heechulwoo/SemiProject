package product.model;

import member.model.MemberVO;

public class ProductOrderVO_kgh {
	private String odrcode;		// 주문번호
	private String fk_userid;	// 유저 아이디
	private int odrtotalprice;	// 주문 총액
	private String odrdate;		// 주문일자
	
	private MemberVO mvo;		// 회원VO
	
	public ProductOrderVO_kgh() {}
	
	public ProductOrderVO_kgh(String odrcode, String fk_userid, 
							   int odrtotalprice, String odrdate) {
		
		this.odrcode = odrcode;
		this.fk_userid = fk_userid;
		this.odrtotalprice = odrtotalprice;
		this.odrdate = odrdate;
		
	}

	
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

	
	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	
	
	
}
