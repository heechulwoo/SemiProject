package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class MallDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String range = request.getParameter("range");
		String start = request.getParameter("start");
	    String len = request.getParameter("len");
	    String cnum = request.getParameter("cnum");
	    
	    InterProductDAO pdao = new ProductDAO();
	    
	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("range", range);
	    paraMap.put("start", start);  // start "1"  "9"   "17"  "25"  "33"
	    paraMap.put("cnum", cnum);
	    
	    String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1); 
	                                   
	    paraMap.put("end", end);      //  end ==> start + len - 1;
	                                  //  end   "8"  "16"  "24"  "32"  "40" 
	    
	    List<ProductVO> prodList = pdao.selectAllproduct(paraMap);
	    
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
