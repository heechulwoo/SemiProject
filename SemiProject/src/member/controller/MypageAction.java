package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MypageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	//		super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
			// 카테고리 목록 얻어오기 
		    super.getCategoryList(request);
			super.setViewPage("/WEB-INF/member/mypage.jsp");
		
			
			
	}

}
