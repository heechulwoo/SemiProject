package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO_kgh;
import product.model.ProductDAO_kgh;

public class ShippingNoCheckController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String shippingNo = request.getParameter("shippingNo");
			String shippingEmail = request.getParameter("shippingEmail");
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			boolean isExists = pdao.shippingNoCheck(shippingNo, shippingEmail);
			
			JSONObject jsonObj = new JSONObject();	// {}
			jsonObj.put("isExists", isExists);		// {"isExists": true}
			
			String json = jsonObj.toString();		// "{"isExists": true}"
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
