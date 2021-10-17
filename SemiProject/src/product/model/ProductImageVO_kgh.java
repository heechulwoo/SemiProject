package product.model;

public class ProductImageVO_kgh {

	private int imgfileno;		// 이미지 파일 고유번호
	private String fk_pnum;		// 제품 고유번호(Foreign Key)
	private String imgfilename;	// 이미지 파일명
	
	private ProductVO_kgh pvo;	// 제품 VO
	
    public ProductImageVO_kgh() {}
	
    public ProductImageVO_kgh(int imgfileno, String fk_pnum, String imgfilename) {
		this.imgfileno = imgfileno;
		this.fk_pnum = fk_pnum;
		this.imgfilename = imgfilename;
	}

	public int getImgfileno() {
		return imgfileno;
	}

	public void setImgfileno(int imgfileno) {
		this.imgfileno = imgfileno;
	}

	public String getFk_pnum() {
		return fk_pnum;
	}

	public void setFk_pnum(String fk_pnum) {
		this.fk_pnum = fk_pnum;
	}

	public String getImgfilename() {
		return imgfilename;
	}

	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}

	public ProductVO_kgh getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO_kgh pvo) {
		this.pvo = pvo;
	}
	
}
