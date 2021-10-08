package product.model;

public class ProductCategoryVO_kgh {
	private String cnum;	// 카테고리 번호
	private String cname;	// 카테고리 명
	
	public ProductCategoryVO_kgh() { }
	
	public ProductCategoryVO_kgh(String cnum, String cname) {
		this.cnum = cnum;
		this.cname = cname;
	}
	
	public String getCnum() {
		return cnum;
	}
	public void setCnum(String cnum) {
		this.cnum = cnum;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	
	
}
