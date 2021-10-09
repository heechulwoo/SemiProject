package contact.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class SelfReturnAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	/*
		
		// 전제조건 : 선 로그인
		if( super.checklogin(request) ) { //  로그인 유무 확인하는 메소드 AbstractController 에서 생성하기
			
			// 로그인을 한 경우
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( loginuser.getUserid().equals(userid) ) {
				// 로그인한 사용자가 자신의 셀프 반품을 신청하는 경우
				
			//  super.setRedirect(false); // 생략가능
				super.setViewPage("/WEB-INF/contact/selfReturn.jsp");
				
			}
			else {
				// 로그인한 사용자가 다른 사용자의 셀프 반품을 신청하려고 하는 경우
				String message = "다른 사용자의 셀프 반품은 신청할 수 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			
		}
		else {
			
			// 로그인을 안한 경우
			String message = "셀프 반품을 신청하기 전에 로그인을 해주세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);  // 생략 가능
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		
	*/
		
		//  super.setRedirect(false); // 생략가능
			super.setViewPage("/WEB-INF/contact/selfReturn.jsp");
			
	}

}
