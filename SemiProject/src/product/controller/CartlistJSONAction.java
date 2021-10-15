package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class CartlistJSONAction extends AbstractController {

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
				String message = "장바구니 기능은 로그인이 필요합니다!";
		        String loc = "javascript:history.back()";
		         
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		    //  super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
		        
			} else { // 로그인을 했으면
				
				String userid = loginuser.getUserid();
				
				InterProductDAO pdao = new ProductDAO();
				List<ProductVO> prodList = pdao.selectCartList(userid);
				
				JSONArray jsonArr = new JSONArray();  // []
			    
			    if( prodList.size() > 0 ) {
			       
			       for(ProductVO pvo : prodList) {
			          
			          JSONObject jsonObj = new JSONObject();  // {}  {}
			          
			          jsonObj.put("pnum", pvo.getPnum());    
			          jsonObj.put("pname", pvo.getPname());
			          jsonObj.put("color", pvo.getColor());
			          jsonObj.put("price", pvo.getPrice());
			          jsonObj.put("pqty", pvo.getPqty());
			          jsonObj.put("prodimage", pvo.getProdimage());
			          jsonObj.put("cnum", pvo.getCategvo().getCnum());
			          jsonObj.put("cname", pvo.getCategvo().getCname());
			          jsonObj.put("pinpupdate", pvo.getPinpupdate());
			          jsonObj.put("cartno", pvo.getCartvo().getCartno());
			          jsonObj.put("oqty", pvo.getCartvo().getOqty());
			          
			          jsonArr.put(jsonObj);
			          
			       }// end of for---------------------------------
			   
			       String json = jsonArr.toString();  // 문자열로 변환
			       
			        //  System.out.println("~~~~ 확인용 json => " + json);
			          
			          
			          request.setAttribute("json", json);
			          super.setViewPage("/WEB-INF/jsonview.jsp");
			          
			       }
			       else {
			          // DB에서 조회된 것이 없다라면
			          
			    	   String json = jsonArr.toString();  // 문자열로 변환
			           
			       //  System.out.println("~~~~ 확인용 json => " + json);
			           //~~~~ 확인용 json => []
			    	   
			    	   request.setAttribute("json", json);
			    	   
			           super.setViewPage("/WEB-INF/jsonview.jsp");
			       }
			}
		}
	}

}
