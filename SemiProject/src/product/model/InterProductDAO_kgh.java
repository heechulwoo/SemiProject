package product.model;

import java.sql.SQLException;
import java.util.*;

public interface InterProductDAO_kgh {

	// 상품의 이미지 가져오는 메서드
	List<ProductImageVO_kgh> selectProductImage(String pnum) throws SQLException;


	// 상품의 정보를 가져오는 메서드
	ProductVO_kgh selectProductDetail(String pnum) throws SQLException;

	// 주문번호 확인하는 메서드
	boolean shippingNoCheck(String shippingNo, String shippingEmail) throws SQLException;

	// 주문번호와 이메일을 통해 주문과 주문 상세를 select 하는 메서드
	List<ProductOrderDetailVO_kgh> selectOrderConfirmation(String shippingNo, String shippingEmail) throws SQLException;

	// 제품의 카테고리와 일치하는 유사한 제품을 불러오는 메서드 
	List<ProductVO_kgh> SameCategoryProduct(Map<String, String> paraMap) throws SQLException;

	// 해당하는 제품 이름과 일치하는 상품의 색상 이미지 가져오기
	List<ProductVO_kgh> selectProductColor(String pname) throws SQLException;

	// 주문하려는 상품의 대표 이미지 가져오는 메소드 생성
	ProductImageVO_kgh getProdImage(String odpnum) throws SQLException;

	// 주문 테이블에 주문내역 insert하기
	String insertOrder(String userid, String sumTotalPrice) throws SQLException;


	// ===== Transaction 처리하기 ===== // 
    // >> 앞에서 미리 했음 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
    // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
    
	// 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
	
    // 6. 배송지 테이블에서  사용자의 주소 정보 더하기(insert)(수동커밋처리) 
    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
    // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
	int orderAdd(HashMap<String, Object> paraMap) throws SQLException;

	// 주문 일자 가져오기
	String selectOrderDate(String odrcode) throws SQLException;

	// 주문 정보 지우기
	void deleteOrder(String odrcode) throws SQLException;

	// 주문번호 가져오는 메서드
	String getodrCode() throws SQLException;

	// 제품 번호에 해당하는 제품의 리뷰 글 select 하기
	List<ProductReviewVO> reviewList(String fk_pnum) throws SQLException;


}
