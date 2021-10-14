package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO_jy;
import member.model.MemberDAO_jy;

public class VerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String userid = request.getParameter("userid");
		String userCertificationCode = request.getParameter("userCertificationCode"); // 유저가 입력한 코드

		HttpSession session = request.getSession(); // 세션불러오기
		String certificationCode = (String)session.getAttribute("certificationCode"); // 발급된 코드(세션)
		
		String message = "";
		String loc = "";	
		
		if( certificationCode.equals(userCertificationCode) ) { // 유저가 보내온 인증코드와, 발송된 인증코드가 같다면
				
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			
			InterMemberDAO_jy mdao = new MemberDAO_jy();
			int n = mdao.loginUpdate(paraMap); // 유저가 보내온 인증코드가 맞다면, 로그인 기록을 수정해준다

			if(n == 1) {
				n = 0;
				n = mdao.idleUdate(paraMap); // 로그인 기록 수정이 성공하면, idle 상태를 변환시켜준다
			}
					
			message = "휴면 해제되었습니다 . 정상 이용 가능합니다.";
			loc = request.getContextPath()+"/login/login.one";

		}
		
		
		else { // 유저가 보내온 인증코드와, 발송된 인증코드가 같지않다면
			
			message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
			loc = request.getContextPath()+"/login/restart.one";
			
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
		
		
		// !!!! 중요 !!!!
		// !!!! 세션에 저장된 인증코드 삭제하기!!!! //
		session.removeAttribute("certificationCode");
		
		
	}

}
