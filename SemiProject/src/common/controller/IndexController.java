package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class IndexController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// IndexController 클래스의 인스턴스 메소드
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);
		
		InterProductDAO pdao = new ProductDAO();
		
		// 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드
		List<ProductVO> newproductList = pdao.newProduct();
		
		request.setAttribute("newproductList", newproductList);
		
		// 메인페이지에 보여줄 인기제품 4종을 판매량순으로 select 해주는 메소드
		List<ProductVO> hotproductList = pdao.hotProduct();
		request.setAttribute("hotproductList", hotproductList);
		
	//	super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
		super.setViewPage("/WEB-INF/index.jsp");
		
	}

}
