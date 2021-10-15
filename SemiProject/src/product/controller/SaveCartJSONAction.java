package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class SaveCartJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { //get 방식으로 접근한 경우
			String message = "비정상적인 접근입니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//   super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		else { // post 방식인 경우
			
			String pqty = request.getParameter("pqty");
			String pnum = request.getParameter("pnum");
			
			HttpSession session =  request.getSession();
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser != null ) { // 로그인을 한 경우
				String userid = loginuser.getUserid();
				
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("pqty", pqty);
				paraMap.put("pnum", pnum);
				paraMap.put("userid", userid);
				
				InterProductDAO pdao = new ProductDAO();
				
				// 장바구니에 같은 제품일경우에는 update 신규 제품은 insert 하는 메소드
				pdao.saveCart(paraMap);
				
				
			}
			
			
		}
		
	}
}
