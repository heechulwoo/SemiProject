package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class OrderConfirmationController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String shippingNo = request.getParameter("shippingNo");
			String shippingEmail = request.getParameter("shippingEmail");
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(shippingNo, shippingEmail);
/*			
			for(ProductOrderDetailVO_kgh odrDetailVO : orderList) {
				System.out.println("확인용 odrDetailVO.getPovo().getOdrdate() : " + odrDetailVO.getPovo().getOdrdate());
			}
*/			
			request.setAttribute("orderList", orderList);
			request.setAttribute("cnt", orderList.size());

			
			
			super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");
			
		}
		else {
			System.out.println("get방식 접속");
		}
		
	}

}
