package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class EachProductColorController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.getParameter("pname");
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/eachProductColor.jsp");
	}

}