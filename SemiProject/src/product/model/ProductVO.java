package product.model;

public class ProductVO {
	private String pnum;	   // 상품고유번호
	private String fk_cnum;    // 카테고리 번호
	private String pname;      // 상품명
	private int price;         // 제품가격
	private String color;      // 제품색상
	private String pinpupdate; // 제품입고일자
	private int pqty;          // 제품재고량
	private String psummary;   // 제품요약
	private String pcontent;   // 제품설명
	private String prodimage;
	
	private String cname;	   // 카테고리명
	private CategoryVOwhc categvo;
	private CartVO cartvo;
	
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

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public CategoryVOwhc getCategvo() {
		return categvo;
	}

	public void setCategvo(CategoryVOwhc categvo) {
		this.categvo = categvo;
	}

	public CartVO getCartvo() {
		return cartvo;
	}

	public void setCartvo(CartVO cartvo) {
		this.cartvo = cartvo;
	}

	
}
