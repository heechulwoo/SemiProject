package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class EachProductController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
//		InterProductDAO_kgh pdao = new ProductDAO_kgh();
//		
//		
//		String pnum = request.getParameter("pnum");
//		
//		// 상품의 이미지를 가져오는 메서드
//		List<ProductImageVO_kgh> pimgList = pdao.selectProductImage(pnum);
//		
//		request.setAttribute("pimgList", pimgList);
//		
//		
//		// 제품의 정보를 불러오는 메서드
//		ProductVO_kgh pvo = pdao.selectProductDetail(pnum);
//		
//		request.setAttribute("pvo", pvo);
//		request.setAttribute("pnum", pvo.getPnum());
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/eachProduct.jsp");
	}

}
