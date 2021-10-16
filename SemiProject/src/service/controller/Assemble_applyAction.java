package service.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import common.controller.AbstractController;

import member.model.MemberVO;
import service.model.*;

public class Assemble_applyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		String ctxPath = request.getContextPath();
		String method  = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		 if("get".equalsIgnoreCase(method)) {
			 super.setViewPage("/WEB-INF/service/assemble_apply.jsp");
			
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);
			 
		 // 조립 서비스를 신청하려면 로그인 먼저 해야 함
			if(loginuser != null) {
				// 로그인을 한 경우

				String userid = loginuser.getUserid(); // 혹은 로그인 아이디를 받아 숨겨둔 인풋태그에서 getparameter해도 된다.
				InterServiceDAO sdao = new AssembleDAO();
				
				List<String> odrcodeList = sdao.takeOdrcode(userid); // 로그인 한 사용자의 주문번호 가져오는 메소드
				// 주문을 한번만 하는게 아니기 때문에 리턴타입은 리스트로 받는다.
				
				if(odrcodeList.isEmpty()){ // 주문내역이 없는 경우
					 String message = "⛔ 조립 서비스는 제품을 구매한 후 이용 가능합니다.";
		        	 String loc = request.getContextPath()+"/index.one"; // 인덱스페이지로 이동한다.
					
					 request.setAttribute("message", message);
	       			 request.setAttribute("loc", loc);  
	       
				  // super.setRedirect(false);
			     	 super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				else { // 주문내역이 있는 경우
				request.setAttribute("odrcodeList",odrcodeList);
				// 뷰단에서 get해서 리스트니까 foreach써서 옵션값에 뿌려준다.
				
				super.setViewPage("/WEB-INF/service/assemble_apply.jsp");
				}				
				
			} // end of if(loginuser != null)-----------
			else {
				// 로그인을 안한 경우
				String loc = ctxPath+"/login/login.one"; // 로그인 페이지로 이동
				
				request.setAttribute("loc", loc);
		   
			    //  super.setRedirect(false);
			        super.setViewPage("/WEB-INF/loc.jsp");
				
	 		}

		
		 }else { // post 방식 : 신청서를 낸 경우
	
	 		String fk_userid = loginuser.getUserid();
	        String fk_odrcode = request.getParameter("fk_odrcode"); 
			String name = request.getParameter("name"); 
			String email = request.getParameter("email");
			String phone_1 = request.getParameter("phone_1"); 
	        String phone_2 = request.getParameter("phone_2"); 
	        String phone_3 = request.getParameter("phone_3"); 
	        String hopedate = request.getParameter("hopedate"); 
	        String hopehour = request.getParameter("hopehour");
	        String postcode = request.getParameter("postcode");
	        String address = request.getParameter("address"); 
	        String detailAddress = request.getParameter("detailAddress"); 
	        String extraAddress = request.getParameter("extraAddress");
	        String demand = request.getParameter("demand");
	        
	     // 유효성 검사때문에 3개로 나눠진 휴대폰번호 합치기
	      String mobile = phone_1 + phone_2 + phone_3;  
	      
	      AssembleVO member = new AssembleVO(fk_userid, fk_odrcode, name, email, mobile, hopedate, hopehour, postcode, address, detailAddress, extraAddress, demand);
		
	      String message = "";
	      String loc = "";
		
	      try {
		         InterServiceDAO sdao = new AssembleDAO();  
		         int n = sdao.applyAssemble(member); // 메소드가 성공적으로 이루어져 db에 업데이트가 된 경우 1
		        
		        
		         if(n==1) { // ### 신청이 성공하면 신청 상세에 대한 이메일을 보낸다 ###
		         	boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도		         	

					GoogleMail mail = new GoogleMail();

					try {
						mail.sendmail(email, name, fk_userid, fk_odrcode);
						sendMailSuccess = true; // 메일전송 성공
	
						 
			     	}catch(Exception e) { // 메일 전송이 실패한 경우
	 					e.printStackTrace();
	 					sendMailSuccess = false; // 메일 전송 실패했음을 기록함.
					}
		        	
					if(sendMailSuccess == true) {
						message = "신청이 완료되었습니다. 입력하신 이메일로 확인메일이 전송되었습니다.";
						loc = request.getContextPath()+"/index.one"; // 인덱스페이지로 이동한다.
					}
					else {
						message = "신청이 완료되었습니다. (이메일 오류로 확인메일 전송이 실패되었으니 문의 바랍니다.)";
						loc = request.getContextPath()+"/index.one"; // 인덱스페이지로 이동한다.
					}
				}
		         
	       }catch(SQLException e){
	    	   e.printStackTrace();
	    	   message = "sql구문 에러발생";
	           loc = "javascript:history.back()"; // 자바스크립트를 이용한  이전페이지로 이동하는 것.
	       }
	 
		
	       request.setAttribute("message", message);
	       request.setAttribute("loc", loc);  
	       
	      // super.setRedirect(false);
	       super.setViewPage("/WEB-INF/msg.jsp");
	 }      
	       
     
	
		}// end of public void execute(HttpServletRequest request, HttpServletResponse response)-----

	}
	
	
