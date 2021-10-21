package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO_jy;
import member.model.MemberDAO_jy;

public class OderReviewEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			
			InterMemberDAO_jy mdao = new MemberDAO_jy();
				
			Map<String, String> paraMap = new HashMap<>();
			
			String fk_pnum = request.getParameter("fk_pnum");
			String fk_userid = request.getParameter("fk_userid");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			paraMap.put("fk_pnum", fk_pnum);
			paraMap.put("fk_userid", fk_userid);
			paraMap.put("title", title);
			paraMap.put("content", content);
			
			int n = mdao.updateReview(paraMap);
			
			if(n==1) {
				String message = "리뷰 등록이 완료되었습니다!"; // msg.jsp
				String loc = request.getContextPath()+"/member/memberOderList.one";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			}
			else {
				String message = "리뷰 등록실패!"; // msg.jsp
				String loc = "javascript:history.back()";// 자바스크립트를 이용하여 이전 페이지로 돌아간다.
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
			}

			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}

}
