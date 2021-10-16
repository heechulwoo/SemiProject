package contact.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.AnswerDAO_sm;
import contact.model.InterAnswerDAO_sm;
import member.model.MemberVO;

public class DeleteAnswerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		// === 관리자(admin) 로 로그인했을 때만 조회가 가능하도록 한다 === //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			// 관리자로 로그인 했을 경우
			
			String answerno = request.getParameter("answerno");
			
			System.out.println("확인용 answerno" + answerno);
			
			// DB에 보내주고 해당 댓글 삭제 //
			InterAnswerDAO_sm adao = new AnswerDAO_sm();
			int n = adao.deleteAnswer(answerno); // 댓글 삭제 메소드
			
			
			if(n == 1) {
				
				//////////////////////////////////////////////////////////
								
				String message = "댓글 삭제가 완료되었습니다! 게시판에서 확인해주세요 :-)";
				String loc = request.getContextPath()+"/contact/consultList.one";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			else {
				
				String message = "댓글 삭제 실패!";
				String loc = request.getContextPath()+"/contact/consultList.one";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
		}
		
		else {
			// 로그인을 안했거나, 관리자 계정이 아닌 경우
			
			String message = "댓글을 삭제 하기 전에 먼저 로그인을 해주세요!";
			String loc = request.getContextPath()+"/login/login.one";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
			
		
	}

}
