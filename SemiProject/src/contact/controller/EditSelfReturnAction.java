package contact.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterSelfReturnDAO_sm;
import contact.model.SelfReturnDAO_sm;
import member.model.MemberVO;

public class EditSelfReturnAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/index.jsp"); // 인덱스로 가자
		}
		
		else {
			// POST 방식
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null) {
				// 로그인 한 경우
				
				
				
				Map<String, String> paraMap = new HashMap<>(); // map만들어서 조건을 담아서 method로 갈 것
				
				String fk_userid = request.getParameter("fk_userid");
				String returnno = request.getParameter("returnno");
				
				System.out.println("확인용 fk_userid: "+fk_userid);
				
				
				if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
					// 관리자(admin) 로 로그인했을 때만 상태 변경 가능
					
					// DB에 보내주기 //
					// paraMap.put("fk_userid", fk_userid);
					// paraMap.put("returnno", returnno);
					
					String fk_odrcode = request.getParameter("fk_odrcode");
					String name = request.getParameter("name");
					String email = request.getParameter("email"); 
					String mobile = request.getParameter("mobile"); 
					String whyreturn = request.getParameter("whyreturn");
					String wherebuy = request.getParameter("wherebuy");
				//	String plusreason = request.getParameter("plusreason"); // 시큐어 처리
					String returndate = request.getParameter("returndate");
					String status = request.getParameter("status");
				
					
					// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
					String plusreason = request.getParameter("plusreason");
					plusreason = plusreason.replaceAll("<", "&lt;");
					plusreason = plusreason.replaceAll(">", "&gt;");
					
					
					
				//  입력한 내용에서 엔터는 <br>로 변환시키기
					plusreason = plusreason.replaceAll("\r\n", "<br>");	
					
					
					
					// DB에 보내주기 //
					paraMap.put("returnno", returnno);
					paraMap.put("fk_userid", fk_userid);
					paraMap.put("fk_odrcode", fk_odrcode);
					paraMap.put("name", name);
					paraMap.put("email", email);
					paraMap.put("mobile", mobile);
					paraMap.put("whyreturn", whyreturn);
					paraMap.put("wherebuy", wherebuy);
					paraMap.put("plusreason", plusreason);
					paraMap.put("returndate", returndate);
					paraMap.put("status", status);
					
					
					// ###### 반품 상태 수정이 성공되면 셀프 반품 리스트로 넘어감 ###### //
					try {
						
						InterSelfReturnDAO_sm rdao = new SelfReturnDAO_sm();
						int n = rdao.updateSelfReturn(paraMap);
						
						if(n==1) {
							
							 String message = "셀프 반품 상태 수정이 완료되었습니다! 셀프 반품 리스트에서 확인해주세요 :-)";
					         String loc = request.getContextPath()+"/contact/selfReturnList.one";
					         
					         request.setAttribute("message", message);
					         request.setAttribute("loc", loc);
					         
					         // super.setRedirect(false);
					         super.setViewPage("/WEB-INF/msg.jsp");
							
							
						//	super.setRedirect(false);
						//	super.setViewPage("/WEB-INF/contact/consultList.jsp");
							
						}
					} catch(SQLException e) {
						String message = "SQL구문 에러발생";
						String loc = "/WEB-INF/index.jsp"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
					
					
					
				}// end of if( loginuser != null && "admin".equals(loginuser.getUserid()) )--------------------------------
				
				
				else {
					// 관리자가 아닌 사람이 정보를 수정하려고 시도하는 경우 
					
					String message = "관리자 이외의 접속자가 반품 상태를 변경 할 수 없습니다. 관리자만 수정이 가능합니다.";
					String loc = request.getContextPath()+"/contact/consultList.one";
					
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
