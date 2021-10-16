package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class MemberEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".contentEquals(method)) {
			// **** POST 방식으로 넘어온 것이라면  **** //
			 
			 String userid = request.getParameter("userid"); 
			 String pwd = request.getParameter("pwd");
			 String name = request.getParameter("name"); 
	         String email = request.getParameter("email"); 
	         String hp1 = request.getParameter("hp1"); 
	         String hp2 = request.getParameter("hp2"); 
	         String hp3 = request.getParameter("hp3"); 
	         String postcode = request.getParameter("postcode");
	         String address = request.getParameter("address"); 
	         String detailAddress = request.getParameter("detailAddress"); 
	         String extraAddress = request.getParameter("extraAddress"); 
	        
	         String mobile = hp1+hp2+hp3;
	         
	         
	         MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress );
	 		
	         String message = "";
	         String loc = "javascript:historyback()";
	         
	         InterMemberDAO_sj mdao = new MemberDAO_sj();
				
			// !!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다. !!! //
       	 	HttpSession session = request.getSession();
       	 	MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
       	 
       	 	System.out.println("~~~ 확인용 userpwd ==> " + loginuser.getPwd() );
       	 	System.out.println("확인용 pwd " + pwd );
			if("pwd".equals(loginuser.getPwd())) {
				// 마이페이지에 입력한 암호와 기존의 암호가 일치한다면
				// '최근비밀번호변경일'을 업데이트에서 제외시킨다.
				
					int m = mdao.updateMember_2(member);
					// 메소드 만들러 가야 함
				
					if(m==1) {	// 암호를 제외한 업데이트가 성공이라면
						loginuser.setName(name);
						loginuser.setPwd(pwd);
						loginuser.setEmail(email);
						loginuser.setMobile(mobile);
						loginuser.setAddress(address);
						loginuser.setDetailaddress(detailAddress);
						loginuser.setExtraaddress(extraAddress);
						
						message = "회원정보가 수정되었습니다!";
						loc = request.getContextPath()+"/index.one";
						
					}
					else { // 암호를 제외한 업데이트가 실패라면
						message = "회원정보 수정 실패!!";	
					}
				
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
					
			}
			else { 
				// 마이페이지에 입력한 암호와 기존의 암호가 일치하지 않는다면
				// '최근비밀번호변경일'도 함께 업데이트시킨다.
					int n = mdao.updateMember(member);
					// 메소드 만들러 가야 함
				
					if(n==1) {	// 암호를 제외한 업데이트가 성공이라면
						loginuser.setName(name);
						loginuser.setPwd(pwd);
						loginuser.setEmail(email);
						loginuser.setMobile(mobile);
						loginuser.setAddress(address);
						loginuser.setDetailaddress(detailAddress);
						loginuser.setExtraaddress(extraAddress);
						
						message = "회원정보가 수정되었습니다!";
						loc = request.getContextPath()+"/index.one";
						
					}
					else { // 암호를 제외한 업데이트가 실패라면
						message = "회원정보 수정 실패!!";	
					}
				
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setViewPage("/WEB-INF/msg.jsp");
				}
			
		}
		else {
			// **** POST 방식으로 넘어온 것이 아니라면  **** //
			
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}
}
