package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.AdminDAO;
import product.model.InterAdminDAO;

import product.model.ProductVO;

public class SearchResultJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String range = request.getParameter("range");
		String start = request.getParameter("start");
	    String len = request.getParameter("len");
	    String searchWord = request.getParameter("searchWord");
	    
	    // System.out.println(searchWord);
	    
		InterAdminDAO adao = new AdminDAO();
		
		Map<String, String> paraMap = new HashMap<>();

		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1); 
	   
		// dao에서 불러올 키-값
		paraMap.put("searchWord", searchWord);
		paraMap.put("start", start);
		paraMap.put("end", end);
		paraMap.put("range", range);

	    List<ProductVO> searchList = adao.selectSearchProduct(paraMap);
	    
	    JSONArray jsonArr = new JSONArray();  // []
	    
	    if( searchList.size() > 0 ) {
		    
	       for(ProductVO pvo : searchList) {
	          
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
	       
	       request.setAttribute("json", json); // 뷰단에 뿌려주기 위해
	       
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
