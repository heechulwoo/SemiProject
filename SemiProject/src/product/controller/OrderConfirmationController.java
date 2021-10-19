package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class OrderConfirmationController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String shippingNo = request.getParameter("shippingNo");
			String shippingEmail = request.getParameter("shippingEmail");
			
			InterProductDAO_kgh pdao = new ProductDAO_kgh();
			
			List<ProductOrderDetailVO_kgh> orderList = pdao.selectOrderConfirmation(shippingNo, shippingEmail);
/*			
			for(ProductOrderDetailVO_kgh odrDetailVO : orderList) {
				System.out.println("확인용 odrDetailVO.getPovo().getOdrdate() : " + odrDetailVO.getPovo().getOdrdate());
			}
*/			
			request.setAttribute("orderList", orderList);
			request.setAttribute("cnt", orderList.size());
			
			super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");

			
		/*	JSONArray jsonArr = new JSONArray();
			
			if(orderList.size() > 0) {
				for(ProductOrderDetailVO_kgh podvo : orderList) {
					
					JSONObject jsonObj = new JSONObject();
					
					jsonObj.put("cnum", podvo.getPcvo().getCnum());
					jsonObj.put("cname", podvo.getPcvo().getCname());
					
					jsonObj.put("pnum", podvo.getPvo().getPnum());
					jsonObj.put("pname", podvo.getPvo().getPname());
					jsonObj.put("prodimage", podvo.getPvo().getProdimage());
					jsonObj.put("price", podvo.getPvo().getPrice());
					
					jsonObj.put("odrcode", podvo.getPovo().getOdrcode());
					jsonObj.put("odrtotalprice", podvo.getPovo().getOdrtotalprice());
					jsonObj.put("odrdate", podvo.getPovo().getOdrdate());
					
					jsonObj.put("oqty", podvo.getOqty());
					jsonObj.put("odrprice", podvo.getOdrprice());
					
					jsonArr.put(jsonObj);
					
				}
				
				String json = jsonArr.toString();
				
				request.setAttribute("json", json);
			
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/orderConfirmation.jsp");
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
			else {
				String json = jsonArr.toString();
				
				request.setAttribute("json", json);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
		*/		
		}
		else {
			System.out.println("get방식 접속");
		}
		
	}

}
