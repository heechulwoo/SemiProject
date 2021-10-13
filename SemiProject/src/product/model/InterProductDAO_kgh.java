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
}
