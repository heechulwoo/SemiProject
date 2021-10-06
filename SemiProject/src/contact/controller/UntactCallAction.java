package contact.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class UntactCallAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			//  super.setRedirect(false); // 생략가능
				super.setViewPage("/WEB-INF/contact/untactCall.jsp");
		
	}

}
