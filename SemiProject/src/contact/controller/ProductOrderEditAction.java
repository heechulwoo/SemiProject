package contact.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterProductOrderDAO_sm;
import contact.model.ProductOrderDAO_sm;
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
				
				String odrseqnum = request.getParameter("odrseqnum"); 	// 주문상세번호
				String email = request.getParameter("email");		  	// 이메일
				String fk_odrcode = request.getParameter("fk_odrcode"); // 주문번호
				String pname = request.getParameter("pname");			// 상품명
				String oqty = request.getParameter("oqty");				// 주문수량
				
				
			 // System.out.println("확인용 email: "+email);
				
				
				if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
					// 관리자(admin) 로 로그인했을 때만 상태 변경 가능
					
					
					String deliverstatus = request.getParameter("deliverstatus");
					// System.out.println("확인용 deliverstatus: "+deliverstatus);
					
					
					
					// DB에 보내주기 //
					paraMap.put("odrseqnum", odrseqnum);
					paraMap.put("deliverstatus", deliverstatus);
					paraMap.put("email", email);
					paraMap.put("fk_odrcode", fk_odrcode);
					paraMap.put("pname", pname);
					paraMap.put("oqty", oqty);
					
					
					// ###### 배송 상태 수정이 성공되면 주문 내역 리스트로 넘어감 ###### //
					try {
						
						
						if("1".equals(deliverstatus) || "2".equals(deliverstatus)) {
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
						
						else if("3".equals(deliverstatus)) {
							// 배송완료라면 날짜 수정(도착일 : sysdate)
							
							// 배송이 완료되었다는 이메일 발송
							InterProductOrderDAO_sm rdao = new ProductOrderDAO_sm();
							int n = rdao.updateDeliverStatus2(paraMap);
							
							
							boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
							
							
							if(n==1) {
								
								// 위의 정보를 바탕으로 사용자에게 이메일을 전송시킨다.
								GoogleMail_sm mail = new GoogleMail_sm();
								
								try {
									mail.sendShipmail(email, paraMap);
									sendMailSuccess = true; // 메일 전송 성공했음을 기록함.
									
									
								} catch(Exception e) { // 메일 전송이 실패한 경우
									e.printStackTrace();
									sendMailSuccess = false; // 메일 전송 실패했음을 기록함.
								}
								
								
								 String message = "배송 상태가 배송완료로 변경되었습니다! 주문 내역 리스트에서 확인해주세요 :-)";
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
