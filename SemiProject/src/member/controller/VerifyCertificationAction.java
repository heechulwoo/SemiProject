package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String userCertificationCode = request.getParameter("userCertificationCode");
				
		HttpSession session = request.getSession(); // 세션불러오기 (세션에 저장된 것은 모든 class와 jsp에서 쓸 수 있다)
		String certificationCode = (String)session.getAttribute("certificationCode");
		
		String message = "";
		String loc = "";
		
		
		if( certificationCode.equals(userCertificationCode) ) {
			message = "인증되었습니다!";
			loc = request.getContextPath()+"/login/pwdUpdateEnd.one?userid="+userid;
		}
		else {
			message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
			loc = request.getContextPath()+"/login/pwdFind.one";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
		
		// !!!! 세션에 저장된 인증코드 삭제하기 !!!! //
		session.removeAttribute("certificationCode");
		
		
		
	}

}
