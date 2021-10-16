package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class DeleteOneCartJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "잘못된 접근입니다.!";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	    //  super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			HttpSession session =  request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser == null) { // 로그인을 안했으면
				String message = "로그인이 필요합니다!";
		        String loc = "javascript:history.back()";
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		    //  super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
		        
			} else { // 로그인을 했으면
				
				String userid = loginuser.getUserid();
				
				String id = request.getParameter("userid");
				String pnum = request.getParameter("pnum");
				
				if( !userid.equals(id) ) {
					String message = "다른회원정보에 접근은 불가합니다!";
			        String loc = "javascript:history.back()";
			         
			        request.setAttribute("message", message);
			        request.setAttribute("loc", loc);
			         
			    //  super.setRedirect(false);
			        super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				else {
					InterProductDAO pdao = new ProductDAO();
					
					// 장바구니 delete
					pdao.deleteOneCart(userid,pnum);
					
				}
				
				
			}
		}
		
	}

}
