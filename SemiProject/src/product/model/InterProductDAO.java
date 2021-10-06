package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductDAO {

	List<ProductVO> newProduct() throws SQLException; // 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드
	
}
