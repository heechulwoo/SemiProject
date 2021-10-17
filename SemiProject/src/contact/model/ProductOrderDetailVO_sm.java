package contact.model;

public class ProductOrderDetailVO_sm {

	private int odrseqnum; 			// 주문상세번호
	private String fk_odrcode;		// 주문번호(주문 테이블 Foreign KEY)
	private String fk_pnum;			// 제품코드(제품 테이블 Foreign KEY)
	private int oqty;				// 주문수량
	private int odrprice;			// 주문총액
	private int deliverstatus;		// 배송상태
	private String deliverdate;		// 배송일자
	
	
	
	// === getter setter === // 
	
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
	
	
	
	
}
