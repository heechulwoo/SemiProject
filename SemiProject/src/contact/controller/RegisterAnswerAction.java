package contact.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.AnswerDAO_sm;
import contact.model.InterAnswerDAO_sm;
import member.model.MemberVO;

public class RegisterAnswerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		String method = request.getMethod();
		
		
		if("GET".equalsIgnoreCase(method)) {
			// GET방식으로 들어온 경우
	        String message = "올바른 방식으로 접근해주세요";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        // super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			// POST 방식
			
			// === 관리자(admin) 로 로그인했을 때만 조회가 가능하도록 한다 === //
			HttpSession session = request.getSession();

			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			
			if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
				// 로그인 했을 경우
				
				Map<String, String> paraMap = new HashMap<>();
				
				String fk_askno = request.getParameter("fk_askno");
				String fk_userid = request.getParameter("fk_userid");
			//	String answertitle = request.getParameter("answertitle");     // 시큐어 코드 처리
			//	String answercontent = request.getParameter("answercontent"); // 시큐어 코드 처리
				
				// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
				String answertitle = request.getParameter("answertitle");
				answertitle = answertitle.replaceAll("<", "&lt;");
				answertitle = answertitle.replaceAll(">", "&gt;");
				
				String answercontent = request.getParameter("answercontent");
				answercontent = answercontent.replaceAll("<", "&lt;");
				answercontent = answercontent.replaceAll(">", "&gt;");
				
		        // 입력한 내용에서 엔터는 <br>로 변환시키기
				answertitle = answertitle.replaceAll("\r\n", "<br>");
				answercontent = answercontent.replaceAll("\r\n", "<br>");	
				
				
				System.out.println("댓글 데이터 넘어오는지 확인 : " + fk_askno + "," +answertitle);
				
				
				// DB에 보내주기 //
				paraMap.put("fk_askno", fk_askno);
				paraMap.put("fk_userid", fk_userid);
				paraMap.put("answertitle", answertitle);
				paraMap.put("answercontent", answercontent);
				
				
				// ###### 댓글 등록이 성공되면 문의게시글 리스트로 넘어감 ###### //
				try {
					
					InterAnswerDAO_sm adao = new AnswerDAO_sm();
					int n = adao.registerAnswer(paraMap);
					
					if(n==1) {
						
						 String message = "댓글 등록이 완료되었습니다! 게시판에서 확인해주세요 :-)";
				         String loc = request.getContextPath()+"/contact/consultList.one";
				         
				         request.setAttribute("message", message);
				         request.setAttribute("loc", loc);
				         
				         // super.setRedirect(false);
				         super.setViewPage("/WEB-INF/msg.jsp");
					
						
					}
				} catch(SQLException e) {
					String message = "SQL구문 에러발생";
					String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				
			}
			else {
				
				 // 로그인을 안한 경우
		         String message = "로그인한 사용자만 접근이 가능합니다.";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         // super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
			
		}
		
		
		
	}

}
