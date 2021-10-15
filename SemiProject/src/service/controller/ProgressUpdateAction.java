package service.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import service.model.*;

public class ProgressUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 한다. == //
	HttpSession session = request.getSession();
	
	MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	
	if(loginuser != null && "admin".equals(loginuser.getUserid())) {
	
	
		String progress = request.getParameter("progress");
		String assembleno = request.getParameter("assembleno");
		
		try {
		InterServiceDAO sdao = new AssembleDAO();
		
		int n  = sdao.updateProgress(assembleno, progress); // db에 상태 업데이트 잘 되었으면 1
		
		if(n==1) {
			String message = "신청 상태 변경이 완료되었습니다.";
	        String loc = "javascript:location.replace(document.referrer)";
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        // super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp"); 
			
		}
		}catch(SQLException e) {
			
			 String message = "sql구문 에러발생";
	    	 String loc = "javascript:history.back()"; // 자바스크립트를 이용한  이전페이지로 이동하는 것.
	    	   
	    	 request.setAttribute("message", message);  // requestScope로 가는 json객체(키값, value)
		     request.setAttribute("loc", loc);  
		       
		     // super.setRedirect(false);
		     super.setViewPage("/WEB-INF/msg.jsp");
	   
		}
	}	
	else {	
		// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우 
        String message = "관리자만 접근이 가능합니다.";
        String loc = "javascript:history.back()";
        request.setAttribute("message", message);
        request.setAttribute("loc", loc);
        
     //   super.setRedirect(false);
        super.setViewPage("/WEB-INF/msg.jsp"); 

	}

	}
}
