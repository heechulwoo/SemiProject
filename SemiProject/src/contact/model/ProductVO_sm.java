package contact.model;

public class ProductVO_sm {
	
	private String pnum;		// 상품 고유번호
	private String fk_cnum;		// 카테고리코드(Foreign Key) 참조
	private String pname;		// 상품명
	private int price;			// 제품가격
	private String color;		// 색상
	private String pinpupdate;	// 제품 입고일자
	private int pqty;			// 제품 재고량
	private String psummary;	// 제품 요약
	private String pcontent;	// 제품 설명
	private String prodimage;	// 제품 대표 이미지
	
	
	// === getter setter === //
	
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public String getFk_cnum() {
		return fk_cnum;
	}
	public void setFk_cnum(String fk_cnum) {
		this.fk_cnum = fk_cnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getPinpupdate() {
		return pinpupdate;
	}
	public void setPinpupdate(String pinpupdate) {
		this.pinpupdate = pinpupdate;
	}
	public int getPqty() {
		return pqty;
	}
	public void setPqty(int pqty) {
		this.pqty = pqty;
	}
	public String getPsummary() {
		return psummary;
	}
	public void setPsummary(String psummary) {
		this.psummary = psummary;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getProdimage() {
		return prodimage;
	}
	public void setProdimage(String prodimage) {
		this.prodimage = prodimage;
	}
	
	
	
	
	
	
	
}
