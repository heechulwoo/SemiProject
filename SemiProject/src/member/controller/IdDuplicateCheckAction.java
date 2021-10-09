package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class IdDuplicateCheckAction extends AbstractController { // extends 부모클래스

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			
			InterMemberDAO_jy mdao = new MemberDAO_jy();
			boolean isExists = mdao.idDuplicateCheck(userid);
			
			JSONObject jsonObj = new JSONObject();// {} jsonObject는 하나 이상의 key:value쌍이 {}를 이용하여 담고있는 객체구조
			jsonObj.put("isExists", isExists);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}

}
