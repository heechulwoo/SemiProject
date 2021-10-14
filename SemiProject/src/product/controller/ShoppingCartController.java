package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class ShoppingCartController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session =  request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String ctxPath = request.getContextPath();
		if(loginuser == null) { // 로그인을 안했으면
			String message = "장바구니 기능은 로그인이 필요합니다!";
	        String loc = ctxPath+"/login/login.one";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	    //  super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	        
		} else { // 로그인을 했으면
			
			String userid = loginuser.getUserid();
			
			InterProductDAO pdao = new ProductDAO();
			
			// 회원이 장바구니에 저장한 제품 select 하기
			List<ProductVO> prodList = pdao.selectCartList(userid);
			
			request.setAttribute("prodList", prodList);
			
			super.setViewPage("/WEB-INF/product/shoppingCart.jsp");
		}
		
		
		
	}

}
