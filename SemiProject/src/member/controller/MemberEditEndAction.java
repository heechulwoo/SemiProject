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
		
		String message = "";
        String loc = "";
		
		
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
	         
	         InterMemberDAO_sj mdao = new MemberDAO_sj();
	         
	         
	         boolean c = mdao.checkPwd(member); // 비밀번호가 기존의 비밀번호인지 체크 해주는 메소드 (기존의 비밀번호라면 true, 아니면 false)
	         

	         if(c) { // 비밀번호가 기존의 비밀번호라면
	        	
	        	 int n = mdao.updateMemberNotPwd(member); // 회원정보를 업데이트 시켜주는 메소드 (

		         if(n == 1) { // 업데이트가 성공했다면
		        	 
		        	 // !!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다. !!! //
		        	 HttpSession session = request.getSession();
		        	 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		        	 
		        	 loginuser.setName(name);
		        	 loginuser.setPwd(pwd);
		        	 loginuser.setEmail(email);
		        	 loginuser.setMobile(mobile);
		        	 loginuser.setAddress(address);
		        	 loginuser.setDetailaddress(detailAddress);
		        	 loginuser.setExtraaddress(extraAddress);
		        	  
		        	 message = "회원정보 수정 성공!!";	
		        	 loc = request.getContextPath() + "/index.one";

		         }
	         }     
		     else if(!c) {
		        	 
		        	 int n = mdao.updateMember(member); // 회원정보를 업데이트 시켜주는 메소드 (비밀번호가 기존것과 다르다)

			         if(n == 1) { // 업데이트가 성공했다면
			        	 
			        	 // !!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다. !!! //
			        	 HttpSession session = request.getSession();
			        	 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			        	 
			        	 loginuser.setName(name);
			        	 loginuser.setPwd(pwd);
			        	 loginuser.setEmail(email);
			        	 loginuser.setMobile(mobile);
			        	 loginuser.setAddress(address);
			        	 loginuser.setDetailaddress(detailAddress);
			        	 loginuser.setExtraaddress(extraAddress);
			        	 
			        	 
			        	 message = "회원정보 수정 성공!!";	
			        	 loc = request.getContextPath() + "/index.one";
			         }
		     }
	         else { // 기존의 비밀번호와 새 비밀번호가 같은데 뭔가 잘못되어서 업데이트가 안된 경우
	        	 message = "회원정보 수정 실패!!";
	        	 loc = "javascript:history.back()";
	         }
	         
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
		else {
			// **** POST 방식으로 넘어온 것이 아니라면  **** //
			
			 message = "비정상적인 경로를 통해 들어왔습니다.!!";
	         loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setViewPage("/WEB-INF/msg.jsp");
		
		}

	
		}//if("POST".contentEquals(method))
		

		
		
	}

	

