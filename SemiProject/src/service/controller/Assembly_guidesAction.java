package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class Assembly_guidesAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// super.setRedirect(false); 
		super.setViewPage("/WEB-INF/service/assembly_guides.jsp");
	}

}
