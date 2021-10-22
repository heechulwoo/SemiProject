package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO_jy;
import member.model.MemberDAO_jy;
import member.model.MemberVO;

public class LoginStartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
	      super.getCategoryList(request);
	      
	      // 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
	    //    super.goBackURL(request);
		
		
		String method = request.getMethod();
		
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식으로 넘어온 것이 아니라면 (확인완료)
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; // execute(HttpServletRequest request, HttpServletResponse response) 메소드 종료함
		}
	
		
		// POST 방식으로 넘어온 것이 맞다면
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		
		// ===> 로그인 기록 업데이트를 위해 IP 주소를 알아오자 ==
		String clientip = request.getRemoteAddr();
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd);
		paraMap.put("clientip", clientip);

		InterMemberDAO_jy mdao = new MemberDAO_jy();
		
		MemberVO loginuser = mdao.selectOneMember(paraMap);
		
		if(loginuser != null) {
			
			if(loginuser.getIdle() == 1) { // 휴면 상태라면 (1 휴면, 0활동)
				
				 String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다. 휴면해제 페이지로 이동합니다.";
		         String loc = request.getContextPath()+"/login/restart.one";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
				
		         return; // 메소드 종료
			}
			
			
			if(loginuser.getStatus() == 1) { // 휴면 상태라면 (1 휴면, 0활동)
				
				 String message = "탈퇴한 회원입니다! 새로 회원가입을 해주세요!";
		         String loc = request.getContextPath()+"/index.one";
		         // 원래는 위와 같이 index.up 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다. (이건 세미할때 해보자!)
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
				
		         return; // 메소드 종료
			}
			
			
			
			//////////// 세션에 로그인 된 값들 업데이트 //////////////
			HttpSession session = request.getSession();
			
			session.setAttribute("loginuser", loginuser);			
			
			if( loginuser.isRequirePwdChange() == true ) {
				
				String message = "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!!";
		        String loc = request.getContextPath()+"/member/mypage.one";
		        // 원래는 위와같이 index.up이 아니라 사용자의 암호를 변경해주는 페이지로 잡아주어야한다.
		          
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
		         
			}
			else {// 로그인 성공
				// 비밀번호를 변경한지 3개월 이내인 경우
				// 페이지 이동을 시킨다.
				super.setRedirect(true);
				
				// 로그인을 하면 시작페이지(index.up)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 가기 위한 것이다.
				String goBackURL = (String)session.getAttribute("goBackURL");
				
				if(goBackURL == null) {
					super.setViewPage(request.getContextPath()+"/index.one");
				}
				else {
					super.setViewPage(request.getContextPath()+goBackURL);
					
				}
		        
			}
			

		}// end of if(loginuser != null)------------------
		

		else {
			 System.out.println(">>> 확인용 로그인 실패!!! <<<");
	         String message = "로그인 실패";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");

		}

		
	}

}
