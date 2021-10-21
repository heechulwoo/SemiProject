package product.model;

import member.model.MemberVO;

public class ProductReviewVO {

	private int review_seq;			// 리뷰번호 시퀀스
	private String fk_userid;		// 유저 아이디
	private String fk_pnum;			// 상품 번호
	private String title;			// 글제목
	private String content;			// 글내용
	private String registerdate;	// 글 작성일
	
	private MemberVO mvo;			// 멤버 VO 참조
	private ProductVO_kgh pvo;		// 제품 VO 참조
	
	public ProductReviewVO() { }
	
	public ProductReviewVO(int review_seq, String fk_userid, String fk_pnum, String title, String content,
							String registerdate, MemberVO mvo, ProductVO_kgh pvo) {
		
		this.review_seq = review_seq;
		this.fk_userid = fk_userid;
		this.fk_pnum = fk_pnum;
		this.title = title;
		this.content = content;
		this.registerdate = registerdate;
		this.mvo = mvo;
		this.pvo = pvo;
		
	}

	public int getReview_seq() {
		return review_seq;
	}

	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegisterdate() {
		return registerdate;
	}

	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public ProductVO_kgh getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO_kgh pvo) {
		this.pvo = pvo;
	}
	
	
	
}
