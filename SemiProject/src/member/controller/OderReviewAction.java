package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OderReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
	      super.getCategoryList(request);
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		
			String pnum = request.getParameter("pnum");
			
			request.setAttribute("pnum", pnum);
			
	     // super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/review.jsp");
		
		}// end of if
	}

}
