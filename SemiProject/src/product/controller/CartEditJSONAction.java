package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class CartEditJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "잘못된 접근입니다!";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	    //  super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			HttpSession session =  request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if(loginuser == null) { // 로그인을 안했으면
				String message = "로그인이 필요합니다!";
		        String loc = "javascript:history.back()";
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		    //  super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
		        
			} else { // 로그인을 했으면
				
				String cartno = request.getParameter("cartno");
				String oqty = request.getParameter("oqty");
				
				InterProductDAO pdao = new ProductDAO();
				
				// 장바구니 수정
				int n =pdao.editCart(cartno,oqty);
				JSONArray jsonArr = new JSONArray();
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("n",n);
				jsonArr.put(jsonObj);
				String json = jsonArr.toString();
				request.setAttribute("json", json);
			//	System.out.println("~~~~ 확인용 json => " + json);
		        super.setViewPage("/WEB-INF/jsonview.jsp");
			}
		}
		
	}

}
