package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface InterAdminDAO {

	// 카테고리 목록 보여주기
	public List<Map<String, String>> getCategoryList(HttpServletRequest request) throws SQLException;

	// 제품 번호 채번해오기
	public int getPnumOfProduct() throws SQLException;

	// tbl_product 테이블에 제품정보 insert 하기
	public int productInsert(ProductVO pvo) throws SQLException;

	
	// tbl_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 
	public int product_imagefile_Insert(ProductVO pvo, String attachFileName)throws SQLException;

	// 검색 제품의 전체개수 알아오기
	public int totalProdCount(Map<String, String> paraMap)throws SQLException;

	// 검색 제품 알아오기
	public List<ProductVO> selectSearchProduct(Map<String, String> paraMap)throws SQLException;

	// tbl_imagefile 테이블에 제품의 크기 이미지 파일명 insert 해주기 
	public int product_lastimg_Insert(ProductVO pvo, String lastimg)throws SQLException;
	
	
	
}
