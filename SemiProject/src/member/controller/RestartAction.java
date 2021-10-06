package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class RestartAction extends AbstractController {
	
	// 휴면상태를 풀어주는 페이지이다.
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setViewPage("/WEB-INF/login/restart.jsp");
		
		
	}

}
