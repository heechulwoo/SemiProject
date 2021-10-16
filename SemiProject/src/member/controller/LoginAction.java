package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
	      super.getCategoryList(request);
	      
	    // 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
	  //   super.goBackURL(request);
		
		
//		super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
			super.setViewPage("/WEB-INF/login/login.jsp");
		
	
	}

}
