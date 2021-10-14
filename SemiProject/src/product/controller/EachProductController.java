package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class EachProductController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pnum = request.getParameter("pnum");
		
		String cnum = request.getParameter("pnum").substring(0, 4);
		// System.out.println("확인용 cnum => " + cnum);
		
		InterProductDAO_kgh pdao = new ProductDAO_kgh();
		
		// 상품의 이미지를 가져오는 메서드
		List<ProductImageVO_kgh> pimgList = pdao.selectProductImage(pnum);
		
		request.setAttribute("pimgList", pimgList);
		
		// 제품의 정보를 불러오는 메서드
		ProductVO_kgh pvo = pdao.selectProductDetail(pnum);
		
		request.setAttribute("pvo", pvo);
		
		// 제품의 카테고리와 일치하는 유사한 제품을 불러오는 메서드 
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pnum", pnum);
		paraMap.put("cnum", cnum);
		
		List<ProductVO_kgh> sameProductList = pdao.SameCategoryProduct(paraMap);
		
		request.setAttribute("sameProductList", sameProductList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/eachProduct.jsp");
	}

}
