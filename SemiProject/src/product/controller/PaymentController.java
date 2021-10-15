package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class PaymentController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null) {
				
				String pnum = request.getParameter("pnum");
				String pqty = request.getParameter("pqty");

			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/payment.jsp");
			}
			else {
				// 로그인을 안했으면
				String message = "상품 구매를 하기 위해서는 먼저 로그인을 하세요!!";
		        String loc = "javascript:history.back()";
				
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
//		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		
		}
		else {
			// 로그인한 사용자가 다른 사용자의 정보를 통해 구매할 경우
			String message = "비정상적인 접근은 불가합니다.!!";
            String loc = "javascript:history.back()";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
       //   super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
            return;
		}
		
	}

	
	
}
