package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class Ikea_servicesAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
	// super.setRedirect(false); 
	super.setViewPage("/WEB-INF/service/ikea_services.jsp");	
		
	}

}
