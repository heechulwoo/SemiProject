package contact.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.*;

public class SelfReturnSendAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// *** POST 방식으로 넘어온 것이라면 *** => 정상 //
			
			String fk_userid = request.getParameter("userid");
			String fk_odrcode = request.getParameter("odrcode");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String whyreturn = request.getParameter("whyreturn");
			String wherebuy = request.getParameter("wherebuy");
			String plusReason = request.getParameter("plusReason");
			
			String mobile = hp1+hp2+hp3;
			
			// form 에서 받아온 값을 SelfReturnVO 에 넣어주기 (SelfReturnVO 에 셀프반품 전용 만들기)
			SelfReturnVO selfReturn = new SelfReturnVO(fk_userid, fk_odrcode, name, email, mobile, whyreturn, wherebuy, plusReason);
			
			InterSelfReturnDAO_sm rdao = new SelfReturnDAO_sm();
			int n = rdao.sendReturnEmail(selfReturn); // 메소드 // 여기서 returnno.nextval 처리해주기
			
			String message = "";
			String loc = "javascript:history.back()";
			
			
			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
			
			
			if(n == 1) {
				
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("fk_odrcode", fk_odrcode);  // 제품번호
				paraMap.put("whyreturn", whyreturn);  	// 반품사유
				paraMap.put("fk_userid", fk_userid);  	// 아이디
				paraMap.put("name", name);  		  	// 성명
				paraMap.put("email", email);  		  	// 이메일
				paraMap.put("mobile", mobile);  	  	// 휴대전화
				paraMap.put("wherebuy", wherebuy);    	// 구입처
				paraMap.put("plusReason", plusReason);  // 추가내용
				
				
				// 위의 정보를 바탕으로 사용자에게 셀프 반품 이메일을 전송시킨다.
				GoogleMail_sm mail = new GoogleMail_sm();
				
				try {
					mail.sendmail(email, paraMap);
					sendMailSuccess = true; // 메일 전송 성공했음을 기록함.
					
					// 세션불러오기
					// HttpSession session = request.getSession();
					// session.setAttribute("certificationCode", certificationCode);
					// 발급한 인증코드를 세션에 저장시킴.
					
				
					message = "[신청 완료] 셀프 반품 이메일이 전송되었습니다. 이메일을 제품, 영수증과 함께 매장의 교환환불코너에서 제시해 주세요.";
					loc = "javascript:self.close()";
		        	
				
					
				} catch(Exception e) { // 메일 전송이 실패한 경우
					e.printStackTrace();
					sendMailSuccess = false; // 메일 전송 실패했음을 기록함.
				}
				
			}// end of if(n == 1) {}-----------------------------------------------------
			
			else {
				message = "셀프 반품 신청 insert 에 실패했습니다.";
				loc = "javascript:self.close()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false); // 생략 가능
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}// end of if("POST".equalsIgnoreCase(method)) {} --------------------------------
	
		
	//	request.setAttribute("method", method);
	
	//	super.setRedirect(false);
	//	super.setViewPage("/WEB-INF/index.jsp");
		
		
		
		else {
			// *** GET 방식으로 넘어온 것이 아라면 *** => 비정상 //
			String message = "비정상적인 경로를 통해 들어왔습니다.";
	        String loc = "javascript:self.close()"; 
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
