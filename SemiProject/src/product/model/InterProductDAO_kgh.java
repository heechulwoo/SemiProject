package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductDAO_kgh {

	// 상품의 이미지 가져오는 메서드
	List<ProductImageVO_kgh> selectProductImage(String pnum) throws SQLException;


	// 상품의 정보를 가져오는 메서드
	ProductVO_kgh selectProductDetail(String pnum) throws SQLException;
}
