package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class ProductByCategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

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
