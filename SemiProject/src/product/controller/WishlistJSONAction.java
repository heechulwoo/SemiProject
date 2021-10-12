package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class WishlistJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String localWishList = request.getParameter("localWishList");
		int lastindex = localWishList.length() -1;
		localWishList = localWishList.substring(1, lastindex);
		localWishList = localWishList.replaceAll("\"","");
	//	System.out.println(localWishList);
		
		InterProductDAO pdao = new ProductDAO();
		
		// 위시리스트에 있는 pnum 을 통해 제품 select 하기
		List<ProductVO> prodList = pdao.selectProductbyPnum(localWishList);
		
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
