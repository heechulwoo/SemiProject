package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class ProductPayController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = request.getParameter("userid");
		
			if(super.checkLogin(request) && userid.equals(loginuser.getUserid())) {
				
				String totalPay = request.getParameter("totalPay");

//				System.out.println(sumTotalPrice);
				
				request.setAttribute("totalPay", totalPay);
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				request.setAttribute("userid", loginuser.getUserid());
				
//				super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/paymentGateway.jsp");
				
			}
			else {
				// 로그인을 하지 않았을 때
				String message = "결제를 하기 위해서는 먼저 로그인을 하세요!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//   super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
		
		
		
	}

}
