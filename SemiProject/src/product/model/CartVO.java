package product.model;

public class CartVO {
	
	private String cartno;
	private String fk_userid;
	private String fk_pnum;
	private int oqty;
	
	public String getCartno() {
		return cartno;
	}
	public void setCartno(String cartno) {
		this.cartno = cartno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
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
	
}
