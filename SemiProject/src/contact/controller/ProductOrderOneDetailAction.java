package contact.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterProductOrderDAO_sm;
import contact.model.ProductOrderDAO_sm;
import contact.model.ProductOrderDetailVO_sm;
import member.model.MemberVO;

public class ProductOrderOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

			
			// == 관리자로 로그인 했을 경우에만 조회가 가능하도록 한다 == //
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
				// 관리자로 로그인 했을 경우
				
				
				String odrcode = request.getParameter("odrcode"); // 주문번호
				
				System.out.println("확인용 odrcode => "+odrcode);
				
				
				
				// 주문 상세 정보 보여주는 메소드
				InterProductOrderDAO_sm odao = new ProductOrderDAO_sm();
				List<ProductOrderDetailVO_sm> orderDetailList = odao.viewDetailOrder(odrcode); // 댓글이 여러 개일 수도 있으므로 리스트로 받기
				
				
					
				if(orderDetailList != null) {
					// 주문 상세 정보가 있을 경우
					
					request.setAttribute("orderDetailList", orderDetailList);
					request.setAttribute("odrcode", odrcode);
					
					// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
						String goBackURL = request.getParameter("goBackURL");
					//	System.out.println("~~~ 확인용 goBackURL => " + goBackURL);
						
						request.setAttribute("goBackURL", goBackURL);
						
						
						// === 뷰 단 === //
						super.setRedirect(false); // 생략가능
						super.setViewPage("/WEB-INF/contact/ProductOrderOneDetail.jsp");
					
					
				}
					
				
				
				else {
					
					// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 주문번호를 입력한 경우
			         String message = "검색하신 제품은 존재하지 않습니다.";
			         String loc = request.getContextPath()+"/contact/productOrderList.one";
			         
			         request.setAttribute("message", message);
			         request.setAttribute("loc", loc);
			         
			      //   super.setRedirect(false);
			         super.setViewPage("/WEB-INF/msg.jsp");
			         
			         return;
					
				}
				
				
			} 
			else {
				// 장난쳐서 들어온 경우 또는 로그인을 안한 경우
		         String message = "로그인 후 접근이 가능합니다. 로그인을 먼저 해주세요!";
		         String loc = request.getContextPath()+"/login/login.one";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      //   super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");   
			}
		
		
		
		
		
		
		
	}

}
