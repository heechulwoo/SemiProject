package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO_jy;
import member.model.MemberDAO_jy;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
//			super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		else {
			
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
			String gender = request.getParameter("gender");
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd");
			
			String mobile = hp1+hp2+hp3;
			String birthday = birthyyyy+"-"+birthmm+"-"+birthdd;
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, gender, birthday);
	        // VO는 DTO처럼 계층간 데이터 교환을 위한 자바객체를 뜻하지만 읽기만 가능한 read only 속성을 가진다.
		
			
			
			String message = "";
	        String loc = "";
	         
	         try {
	            InterMemberDAO_jy mdao = new MemberDAO_jy();
	            int n = mdao.registerMember(member);
	            
	            if(n==1) { // 등록되었다면
	               message = "회원가입 성공";
	               loc = request.getContextPath()+"/index.one"; // 시작페이지로 이동한다.
	            }
	         } catch(SQLException e) {
	            message = "SQL구문 에러발생"; // msg.jsp
	            loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
	         }
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      // super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	
	}

}
