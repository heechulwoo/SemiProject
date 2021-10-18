package contact.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductOrderDAO_sm {
	
	// 주문 리스트  페이징 처리를 한 목록 보여주기
	List<ProductOrderVO_sm> selectPagingOrder(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체주문내역에 대한 총 페이지 수 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 주문 상세 정보를 리스트로 보여주는 메소드(tbl_order_detail 테이블에 select)
	List<ProductOrderDetailVO_sm> viewDetailOrder(String odrcode) throws SQLException;
	
	// odrseqnum값을 받아서 주문 세부 내역 1개 보여주기 (select)
	ProductOrderDetailVO_sm viewOrderDetail(String odrseqnum) throws SQLException;
	
	// 배송상태 변경해주기(deliverstatus == 1 또는 3 인 경우)
	int updateDeliverStatus1(Map<String, String> paraMap) throws SQLException;
	
	// 배송상태 변경해주기(deliverstatus == 2 인 경우)
	int updateDeliverStatus2(Map<String, String> paraMap) throws SQLException;

	
	
	
	
	
}
