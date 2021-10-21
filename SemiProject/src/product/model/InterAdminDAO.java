package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import contact.model.SelfReturnVO;
import service.model.AssembleVO;
import service.model.StoreVO;

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

	// 내 문의내역 목록 가져오기(마이페이지)
	public List<HashMap<String, String>> selectmyask(Map<String, String> paraMap)throws SQLException;

	// 내 환불신청 목록 가져오기(마이페이지)
	public List<SelfReturnVO> myReturnList(Map<String, String> paraMap)throws SQLException;

	// 내 조립신청 목록 가져오기(마이페이지)
	public List<AssembleVO> myAssembleList(Map<String, String> paraMap)throws SQLException;

	// 내 문의내역 총페이지 알아오기
	public int getTotalPage1(String userid, String sizePerPage1)throws SQLException;

	// 내 환불신청 총페이지 알아오기
	public int getTotalPage2(String userid, String sizePerPage2)throws SQLException;

	// 내 조립신청 총페이지 알아오기
	public int getTotalPage3(String userid, String sizePerPage3)throws SQLException;

	// 매장테이블에 새로운 매장 정보 insert해주기
	public int storeInsert(StoreVO svo)throws SQLException;
	
	
	
}
