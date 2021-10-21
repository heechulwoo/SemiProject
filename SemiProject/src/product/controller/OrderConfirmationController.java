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
		String email = request.getParameter("shippingEmail");
		
		if("POST".equalsIgnoreCase(method) && loginuser != null && email.equals(loginuser.getEmail())) {
			
			String shippingNo = request.getParameter("shippingNo");
			String shippingEmail = request.getParameter("shippingEmail");
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(shippingNo, shippingEmail);

			request.setAttribute("orderList", orderList);
			request.setAttribute("cnt", orderList.size());
			
			super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");
			
		}
		else if ("GET".equalsIgnoreCase(method) && loginuser != null && userid.equals(loginuser.getUserid())) {
			String odrcode = request.getParameter("odrcode");
			email = loginuser.getEmail();
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(odrcode, email);
			
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
