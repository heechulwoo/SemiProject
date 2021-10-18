package contact.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class ConsultWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null ) {
			// 로그인을 한 경우
			
		//  super.setRedirect(false); // 생략가능
			super.setViewPage("/WEB-INF/contact/consultWrite.jsp");
			
			
		}
		else {
			// 로그인을 안한 경우
	         String message = "로그인한 사용자만 접근이 가능합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         // super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
			
			
			
			
		}
		
		
		
	}

}
