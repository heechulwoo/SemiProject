package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class PwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		// "GET" or "POST" 
		
		if("POST".equalsIgnoreCase(method)) {
			// 비밀번호 찾기 네비게이션에서 찾기 버튼을 클릭했을 경우
			
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			InterMemberDAO_sj mdao = new MemberDAO_sj();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			
			boolean isUserExist = mdao.isUserExist(paraMap);
			
			boolean sendMailSuccess = false;
			// 메일이 정상적으로 전송되었는지 알아보기
			
			if(isUserExist) {
				// 회원이 맞는 경우
				
				Random rnd = new Random();
				
				String certificationCode = "";
				
				char randchar = ' ';
				for(int i=0; i<5; i++) {
					
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certificationCode += randchar;
				}// end of for------------------------------------
				
				int randnum = 0;
				for(int i=0; i<7; i++) {
					randnum = rnd.nextInt(9 - 0 + 1) + 0;
					certificationCode += randnum;
				}// end of for-----------------------------
				
				GoogleMail mail = new GoogleMail();
				
				try {
					mail.sendmail(email, certificationCode);
					sendMailSuccess = true; // 메일 전송을 성공하면 기록
					
					HttpSession session = request.getSession();
					session.setAttribute("certificationCode", certificationCode);
					// 인증코드를 세션에 저장시킨다.		
				
				} catch (Exception e) { // 메일 전송이 실패라면
					e.printStackTrace();
					sendMailSuccess = false;
				}
			}// end of if(isUserExist) {}---------------
			
			request.setAttribute("isUserExist", isUserExist);
			request.setAttribute("userid", userid);
			request.setAttribute("email", email);
			request.setAttribute("sendMailSuccess", sendMailSuccess);
	
		} // end of if("POST".equalsIgnoreCase(method))--------------------------------- 	
		
		request.setAttribute("method", method);
		
		super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		
	}

}
