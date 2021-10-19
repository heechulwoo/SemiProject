package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class OrderConfirmationController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
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
		else if (loginuser != null) {
			String odrcode = request.getParameter("odrcode");
			String email = request.getParameter("email");
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(odrcode, email);
/*			
			for(ProductOrderDetailVO_kgh odrDetailVO : orderList) {
				System.out.println("확인용 odrDetailVO.getPovo().getOdrdate() : " + odrDetailVO.getPovo().getOdrdate());
			}
*/			
			request.setAttribute("orderList", orderList);
			request.setAttribute("cnt", orderList.size());
			
			super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");
		}
		
		
	}

}
