package member.controller;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO_sj;
import member.model.MemberDAO_sj;
import member.model.MemberVO;

public class MemberDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession(); // 세션에서 loginuser 가져오기
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		String method = request.getMethod();
		// "GET" or "POST"
	
		if("GET".equalsIgnoreCase(method)) {
//			super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
			super.setViewPage("/WEB-INF/member/memberDelete.jsp");
		}
		else {
			// POST방식이라면
			String message = "";
	        String loc = "";
	         
	         try {
	        	 Map<String,String> paraMap = new HashMap<>();
	 			 paraMap.put("userid", userid);
	 	
	 			 InterMemberDAO_sj mdao = new MemberDAO_sj();
	 			 int n = mdao.deleteMember(paraMap);
	            
	 			 if(n==1) { // 탈퇴되었다면
	               message = "IKEA 계정 탈퇴를 하셨습니다.";
	               request.setAttribute("userid", userid);
	               //loc = request.getContextPath()+"/index.one"; // 시작페이지로 이동한다.
	               super.setViewPage("/WEB-INF/member/memberDelete.jsp");
	 			 }
	 			 
	         } catch(SQLException e) {
	            message = "SQL구문 에러발생"; // msg.jsp
	            loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
	         }
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      // super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		}
		
		
	}

