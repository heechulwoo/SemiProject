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
		
		String userid = request.getParameter("userid");
		
		if("POST".equalsIgnoreCase(method) && loginuser != null) {
			
			String shippingNo = request.getParameter("shippingNo");
			String shippingEmail = request.getParameter("shippingEmail");
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(shippingNo, shippingEmail);

			for(ProductOrderDetailVO_kgh odrDetailVO : orderList) {
				System.out.println("확인용 odrDetailVO.getMvo().getName() : " + odrDetailVO.getMvo().getName());
			}
			
			request.setAttribute("orderList", orderList);
			request.setAttribute("cnt", orderList.size());
			
			super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");
			
		}
		else if (loginuser != null && userid.equals(loginuser.getUserid())) {
			String odrcode = request.getParameter("odrcode");
			String email = loginuser.getEmail();
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(odrcode, email);
			
			for(ProductOrderDetailVO_kgh odrDetailVO : orderList) {
				System.out.println("확인용 odrDetailVO.getMvo().getName() : " + odrDetailVO.getMvo().getName());
			}
	 		
			request.setAttribute("orderList", orderList);
			request.setAttribute("cnt", orderList.size());
			
			super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");
		}
		else {
			// 로그인을 하지 않았을 때
			String message = "로그인을 정상적으로 한 후 이용하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//   super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
