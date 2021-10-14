package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class ProductAllController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		
		// 모든 제품에서 보여줄 카테고리와 해당 카테고리 의자 이미지 1개 얻어오는 메소드 
		List<Map<String,String>> categoryList = pdao.selectCategoryImage();
		request.setAttribute("categoryList", categoryList);
		
		// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해 제품의 전체개수 알아오기 //
		
		int totalCount = pdao.totalCount();
		request.setAttribute("totalCount", totalCount);
		
		super.setViewPage("/WEB-INF/product/productAll.jsp");
		
	}

}
