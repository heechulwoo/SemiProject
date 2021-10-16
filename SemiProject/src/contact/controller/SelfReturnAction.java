package contact.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterSelfReturnDAO_sm;
import contact.model.SelfReturnDAO_sm;
import member.model.MemberVO;

public class SelfReturnAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	
		
		
	 	HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		
		// 전제조건 : 선 로그인
		if( loginuser != null ) { //  로그인 유무 확인
			// 로그인을 한 경우
			
			// === 로그인 유저와 주소에 장난친 것 구분하기 === //
			String inputUserid = request.getParameter("userid"); 
			String userid = loginuser.getUserid();				// 실제 로그인 유저 아이디
			InterSelfReturnDAO_sm rdao = new SelfReturnDAO_sm();
			
			List<String> odrcode = rdao.getOdrcode(userid); // 주문번호 가져오기
			// 주문을 한번만 하는게 아니기 때문에 리턴타입은 리스트로 받는다.
			
			
			
			if( loginuser.getUserid().equals(inputUserid) ) {
				// 로그인한 사용자가 자신의 셀프 반품을 신청하는 경우
				
				
				if(odrcode.isEmpty()){ 
				// 주문내역이 없는 경우
				String message = "주문내역이 존재하지 않습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
       			request.setAttribute("loc", loc);  
       
			 // super.setRedirect(false);
		     	super.setViewPage("/WEB-INF/msg.jsp");
		     	
				}
				
				else { 
					// 주문내역이 있는 경우
					request.setAttribute("odrcode",odrcode);
					
				//  super.setRedirect(false); // 생략가능
					super.setViewPage("/WEB-INF/contact/selfReturn.jsp");
					
				}
					
					
			}
			
			else {
				// 로그인한 사용자가 다른 사용자의 셀프 반품을 신청하려고 하는 경우
				String message = "다른 사용자의 셀프 반품은 신청할 수 없습니다.";
				String loc = request.getContextPath()+"/index.one"; // 인덱스 페이지로 이동
				
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
			String loc = request.getContextPath()+"/login/login.one"; // 로그인 페이지로 이동
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);  // 생략 가능
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		
			
	}

}
