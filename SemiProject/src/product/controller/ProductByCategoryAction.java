package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class ProductByCategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
        super.goBackURL(request);
		
		InterProductDAO pdao = new ProductDAO();
		
		// 카테고리에 해당하는 제품수 얻어오기
		String cnum = request.getParameter("cnum");
		int totalCount = pdao.totalCount(cnum);
		
		// 카테고리번호에 해당하는 카테고리 이름 얻어오기
		String cname = pdao.selectCname(cnum);
		
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("cnum", cnum);
		request.setAttribute("cname", cname);
		
		super.setViewPage("/WEB-INF/product/productByCategory.jsp");
		
	}

}
