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

}
