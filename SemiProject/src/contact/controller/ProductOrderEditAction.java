package contact.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterProductOrderDAO_sm;
import contact.model.InterSelfReturnDAO_sm;
import contact.model.ProductOrderDAO_sm;
import contact.model.SelfReturnDAO_sm;
import member.model.MemberVO;

public class ProductOrderEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	
		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/index.jsp"); // 인덱스로 가기
		}
		
		else {
			// POST 방식
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null) {
				// 로그인 한 경우
				
				
				
				Map<String, String> paraMap = new HashMap<>(); // map만들어서 조건을 담아서 method로 갈 것
				
				String odrseqnum = request.getParameter("odrseqnum");
				
				// System.out.println("확인용 odrseqnum: "+odrseqnum);
				
				
				if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
					// 관리자(admin) 로 로그인했을 때만 상태 변경 가능
					
					
					String deliverstatus = request.getParameter("deliverstatus");
					// System.out.println("확인용 deliverstatus: "+deliverstatus);
					
					
					
					// DB에 보내주기 //
					paraMap.put("odrseqnum", odrseqnum);
					paraMap.put("deliverstatus", deliverstatus);
					
					
					// ###### 배송 상태 수정이 성공되면 주문 내역 리스트로 넘어감 ###### //
					try {
						
						
						if("1".equals(deliverstatus) || "3".equals(deliverstatus)) {
							InterProductOrderDAO_sm rdao = new ProductOrderDAO_sm();
							int n = rdao.updateDeliverStatus1(paraMap);
							
							
							if(n==1) {
								
								 String message = "배송 상태가 수정이 완료되었습니다! 주문 내역 리스트에서 확인해주세요 :-)";
						         String loc = request.getContextPath()+"/contact/productOrderList.one";
						         
						         request.setAttribute("message", message);
						         request.setAttribute("loc", loc);
						         
						         // super.setRedirect(false);
						         super.setViewPage("/WEB-INF/msg.jsp");
							
							}
						}
						
						else if("2".equals(deliverstatus)) {
							// 배송중이라면 날짜 수정(도착예정일 : sysdate+7)
							
							InterProductOrderDAO_sm rdao = new ProductOrderDAO_sm();
							int n = rdao.updateDeliverStatus2(paraMap);
							
							if(n==1) {
								
								 String message = "배송 상태가 수정이 완료되었습니다! 주문 내역 리스트에서 확인해주세요 :-)";
						         String loc = request.getContextPath()+"/contact/productOrderList.one";
						         
						         request.setAttribute("message", message);
						         request.setAttribute("loc", loc);
						         
						         // super.setRedirect(false);
						         super.setViewPage("/WEB-INF/msg.jsp");
							
							}
						}
						
						
						
						
						
					} catch(SQLException e) {
						String message = "SQL구문 에러발생";
						String loc = "/WEB-INF/index.jsp";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
					
					
					
				}// end of if( loginuser != null && "admin".equals(loginuser.getUserid()) )--------------------------------
				
				
				else {
					// 관리자가 아닌 사람이 상태를 수정하려고 시도하는 경우 
					
					String message = "관리자 이외의 접속자가 배송 상태를 변경 할 수 없습니다. 관리자만 수정이 가능합니다.";
					String loc = request.getContextPath()+"/contact/productOrderList.one";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
					
				}
				
		    }// end of if(loginuser != null)----------------------------------------
			
			else {
				
				// 로그인을 안한 경우
		         String message = "로그인한 관리자만 접근이 가능합니다. 로그인을 해주세요!";
		         String loc = request.getContextPath()+"/login/login.one";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         // super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
	 		}
			
			
		}// end of else (// POST 방식) ------------------------------------------
		
		
		
		
		
	}

}
