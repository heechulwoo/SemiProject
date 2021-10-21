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
	      
		
//		super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
			super.setViewPage("/WEB-INF/login/login.jsp");
		
	
	}

}
