package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class ProductAllController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
        super.goBackURL(request);
        
		// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해 제품의 전체개수 알아오기 //
		
		int totalCount = pdao.totalCount();
		request.setAttribute("totalCount", totalCount);
		
		super.setViewPage("/WEB-INF/product/productAll.jsp");
		
	}

}
