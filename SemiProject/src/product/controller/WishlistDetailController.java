package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class WishlistDetailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
        super.goBackURL(request);
        
		super.setViewPage("/WEB-INF/product/wishlistDetail.jsp");
		
	}

}
