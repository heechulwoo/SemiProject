package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	List<ProductVO> newProduct() throws SQLException; // 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드

	List<Map<String, String>> selectCategoryImage() throws SQLException; // 모든 제품에서 보여줄 카테고리와 해당 카테고리 의자 이미지 1개 얻어오는 메소드
	
	int totalCount() throws SQLException; // Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해 제품의 전체개수 알아오기 // 
	
	List<ProductVO> selectAllproduct(Map<String, String> paraMap) throws SQLException; // Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라서(start ~ end) 조회해오기 
 
	List<ProductVO> selectProductbyPnum(String localWishList) throws SQLException; // 위시리스트에 있는 pnum 을 통해 제품 select 하기

	int saveCart(Map<String, String> paraMap) throws SQLException; // 장바구니에 같은 제품일경우에는 update 신규 제품은 insert 하는 메소드

	List<ProductVO> selectCartList(String userid) throws SQLException;	// 회원이 장바구니에 저장한 제품 select 하기

	int deleteOneCart(String userid, String pnum) throws SQLException; // 장바구니 delete
	
}
