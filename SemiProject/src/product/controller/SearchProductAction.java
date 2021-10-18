package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.AdminDAO;
import product.model.InterAdminDAO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class SearchProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		super.goBackURL(request);
		
		Map<String,String> paraMap = new HashMap<>();
		
		String searchWord = request.getParameter("searchWord"); // 검색어 얻어오기
		// System.out.println(searchWord);
		
		paraMap.put("searchWord", searchWord); // dao에 보낼 검색어 
		
       
        // === Ajax(JSON)를 사용하여 상품목록을 스크롤 방식으로 페이징처리 === // 
        
	      InterAdminDAO adao = new AdminDAO();
	      // 충돌 날 수 있으니 만들어 놓은 admin dao 사용
	      
	      int totalProdCount = adao.totalProdCount(paraMap);  // 검색상품의 전체개수를 알아온다.
		
	      // System.out.println(totalProdCount);
	      
	      request.setAttribute("totalProdCount", totalProdCount);
	      
	      // 검색어가 없을 경우 get방식 url주소에 null이 넣어지고 'null'이 검색되는 경우를 방지
	      if(searchWord == null) {
				searchWord="";	
			}
		
	      request.setAttribute("searchWord", searchWord);
	      
	      InterProductDAO pdao = new ProductDAO();
			
	      // 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드
		  List<ProductVO> newproductList = pdao.newProduct();
			
		  request.setAttribute("newproductList", newproductList);
	      
	      super.setViewPage("/WEB-INF/product/admin/searchResult.jsp");
		
	}

}
