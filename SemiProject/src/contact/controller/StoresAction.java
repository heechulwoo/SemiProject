package contact.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import contact.model.InterProductOrderDAO_sm;
import contact.model.ProductOrderDAO_sm;
import contact.model.ShoppingmapVO_sm;

public class StoresAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	
		
		
		
		InterProductOrderDAO_sm odao = new ProductOrderDAO_sm();
		
		// 매장 정보를 불러오는 메소드
		List<ShoppingmapVO_sm> storeList = odao.selectStoresInfo();
		
		
		if(storeList == null) {
			
			// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
	        String message = "검색하신 매장은 존재하지 않습니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	    //  super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
			
	        return;
		}
		
		else {
			request.setAttribute("storeList", storeList);
			
		//	List<ShoppingmapVO_sm> sameProductList = odao.SameCategoryProduct();
			
		//	request.setAttribute("sameProductList", sameProductList);
			
		//  super.setRedirect(false); // 생략가능
			super.setViewPage("/WEB-INF/contact/stores.jsp");
			
		}
		
		
	}

}
