package product.model;

import member.model.MemberVO;

public class ProductOrderDetailVO_kgh {
	
	private int odrseqnum; 			// 주문상세번호
	private String fk_odrcode;		// 주문번호(주문 테이블 Foreign KEY)
	private String fk_pnum;			// 제품코드(제품 테이블 Foreign KEY)
	private int oqty;				// 주문수량
	private int odrprice;			// 주문총액
	private int deliverstatus;		// 배송상태
	private String deliverdate;		// 배송일자
	
	private ProductVO_kgh pvo;				// 제품 VO
	private ProductOrderVO_kgh povo;		// 주문 VO	
	private ProductCategoryVO_kgh pcvo;		// 카테고리 VO
	private MemberVO mvo;					// 회원 VO


	public ProductOrderDetailVO_kgh() {}
	
	public ProductOrderDetailVO_kgh(int odrseqnum, String fk_odrcode, String fk_pnum, int oqty,
									 int odrprice, int deliverstatus, String deliverdate) {
		this.odrseqnum = odrseqnum;
		this.fk_odrcode = fk_odrcode;
		this.fk_pnum = fk_pnum;
		this.oqty = oqty;
		this.odrprice = odrprice;
		this.deliverstatus = deliverstatus;
		this.deliverdate = deliverdate;
	}

	
	public int getOdrseqnum() {
		return odrseqnum;
	}

	public void setOdrseqnum(int odrseqnum) {
		this.odrseqnum = odrseqnum;
	}

	
	public String getFk_odrcode() {
		return fk_odrcode;
	}

	public void setFk_odrcode(String fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}

	
	public String getFk_pnum() {
		return fk_pnum;
	}

	public void setFk_pnum(String fk_pnum) {
		this.fk_pnum = fk_pnum;
	}

	
	public int getOqty() {
		return oqty;
	}

	public void setOqty(int oqty) {
		this.oqty = oqty;
	}

	
	public int getOdrprice() {
		return odrprice;
	}

	public void setOdrprice(int odrprice) {
		this.odrprice = odrprice;
	}

	
	public int getDeliverstatus() {
		return deliverstatus;
	}

	public void setDeliverstatus(int deliverstatus) {
		this.deliverstatus = deliverstatus;
	}

	
	public String getDeliverdate() {
		return deliverdate;
	}

	public void setDeliverdate(String deliverdate) {
		this.deliverdate = deliverdate;
	}

	
	public ProductVO_kgh getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO_kgh pvo) {
		this.pvo = pvo;
	}

	
	public ProductOrderVO_kgh getPovo() {
		return povo;
	}

	public void setPovo(ProductOrderVO_kgh povo) {
		this.povo = povo;
	}
	
	
	public ProductCategoryVO_kgh getPcvo() {
		return pcvo;
	}

	public void setPcvo(ProductCategoryVO_kgh pcvo) {
		this.pcvo = pcvo;
	}
	
	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
}
