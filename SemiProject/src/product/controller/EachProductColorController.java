package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class EachProductColorController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pname = request.getParameter("pname");
		
		InterProductDAO_kgh pdao = new ProductDAO_kgh();
		
		// 해당하는 제품 이름과 일치하는 상품의 색상 이미지 가져오기
		List<ProductVO_kgh> productColorList = pdao.selectProductColor(pname);
		
		if(productColorList.size() > 0) {
			request.setAttribute("productColorList", productColorList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/eachProductColor.jsp");
		}
		else {
			// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
	        String message = "검색하신 제품의 색상은 존재하지 않습니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	    //  super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	         
	        return;
		}
		
	}

}
