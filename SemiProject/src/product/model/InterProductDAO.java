package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	List<ProductVO> newProduct() throws SQLException; // 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드

	List<Map<String, String>> selectCategoryImage() throws SQLException; // 모든 제품에서 보여줄 카테고리와 해당 카테고리 의자 이미지 1개 얻어오는 메소드
	
}
