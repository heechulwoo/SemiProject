package contact.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ShippingTrackingAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	
		
		
		//  super.setRedirect(false); // 생략가능
			super.setViewPage("/WEB-INF/contact/shippingTracking.jsp");
			
	}

}
