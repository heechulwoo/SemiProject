package contact.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.*;
import member.model.MemberVO;

public class ConsultOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

			
			// == 로그인 했을 때만 조회가 가능하도록 한다. == //
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if( loginuser != null ) {
				// 로그인 한 경우
				
				Map<String, String> paraMap = new HashMap<>(); // map만들어서 조건을 담아서 method로 갈 것
				
				String fk_userid = request.getParameter("fk_userid");
				String askno = request.getParameter("askno"); // 글 번호
				
				// System.out.println("확인용 askno => "+askno);
				
				// DB에 보내주기 //
				paraMap.put("fk_userid", fk_userid);
				paraMap.put("askno", askno);
				
				
				// 회원 상세 정보 보여주는 메소드
				InterConsultWriteDAO_sm cdao = new ConsultWriteDAO_sm();
				ConsultWriteVO_sm cvo = cdao.consultOneDetail(paraMap);
				
				// 댓글 목록 보여주는 메소드
				InterAnswerDAO_sm adao = new AnswerDAO_sm();
				List<AnswerVO> answerList = adao.viewAnswer(paraMap); // 댓글이 여러 개일 수도 있으므로 리스트로 받기
				
				
				if(cvo != null) {
					
					
					if(answerList != null) {
						// 댓글목록이 있을 경우
						
						request.setAttribute("cvo", cvo); // 메소드에서 얻어온 값을 담아주기
						request.setAttribute("answerList", answerList);
						
						// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
							String goBackURL = request.getParameter("goBackURL");
						//	System.out.println("~~~ 확인용 goBackURL => " + goBackURL);
						//	~~~ 확인용 goBackURL => /member/memberList.up?currentShowPageNo=5
						//  ~~~ 확인용 goBackURL => /member/memberList.up?currentShowPageNo=5	
							
							request.setAttribute("goBackURL", goBackURL);
							
							
							// === 뷰 단 === //
							super.setRedirect(false); // 생략가능
							super.setViewPage("/WEB-INF/contact/consultOneDetail.jsp");
						
						
					}
					else {
						// 댓글목록이 없을 경우
						
						request.setAttribute("cvo", cvo); // 메소드에서 얻어온 값을 담아주기
						
						// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
							String goBackURL = request.getParameter("goBackURL");
						//	System.out.println("~~~ 확인용 goBackURL => " + goBackURL);
						//	~~~ 확인용 goBackURL => /member/memberList.up?currentShowPageNo=5
						//  ~~~ 확인용 goBackURL => /member/memberList.up?currentShowPageNo=5	
							
							request.setAttribute("goBackURL", goBackURL);
							
							
							// === 뷰 단 === //
							super.setRedirect(false); // 생략가능
							super.setViewPage("/WEB-INF/contact/consultOneDetail.jsp");
						
					}
					
				}
				
				else {
					
					// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
			         String message = "검색하신 제품은 존재하지 않습니다.";
			         String loc = request.getContextPath()+"/contact/consultList.one";
			         
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
