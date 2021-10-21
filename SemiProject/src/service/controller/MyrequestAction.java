package service.controller;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.SelfReturnVO;
import member.model.MemberVO;
import my.util.MyUtil_jay;
import product.model.*;
import service.model.AssembleVO;


public class MyrequestAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		Map<String,String> paraMap = new HashMap<>();
		
		if(loginuser != null) {
			
		
		String userid = loginuser.getUserid();
			
			InterAdminDAO adao = new AdminDAO();
			
			String currentShowPage1 = request.getParameter("currentShowPage1");
			String currentShowPage2 = request.getParameter("currentShowPage2");
			String currentShowPage3 = request.getParameter("currentShowPage3");
			// currentShowPage는 사용자가 보고자하는 페이지바의 페이지번호 이다.
	        
			String sizePerPage1 = request.getParameter("sizePerPage1");
			String sizePerPage2 = request.getParameter("sizePerPage2");
			String sizePerPage3 = request.getParameter("sizePerPage3");
			// 한 페이지당 화면상에 보여줄 회원의 개수
			
			if(currentShowPage1 == null) {
				currentShowPage1= "1";
			}
			if(currentShowPage2 == null) {
				currentShowPage2= "1";
			}
			if(currentShowPage3 == null) {
				currentShowPage3= "1";
			}
			
			if(sizePerPage1 == null || !("10".equals(sizePerPage1)) ) {
				// 처음들어와서 페이지당 보이는 수를 선택 하지 않은 경우이거나, url에 get방식으로 임의로 넣은 경우 무조건 기본값 5개씩 보이기
				sizePerPage1 = "5";
			}
			if(sizePerPage2 == null || !("10".equals(sizePerPage2)) ) {
				// 처음들어와서 페이지당 보이는 수를 선택 하지 않은 경우이거나, url에 get방식으로 임의로 넣은 경우 무조건 기본값 5개씩 보이기
				sizePerPage2 = "5";
			}
			if(sizePerPage3 == null || !("10".equals(sizePerPage3)) ) {
				// 처음들어와서 페이지당 보이는 수를 선택 하지 않은 경우이거나, url에 get방식으로 임의로 넣은 경우 무조건 기본값 5개씩 보이기
				sizePerPage3 = "5";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
	        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPage1); 	
				
			} catch (NumberFormatException e) {
				currentShowPage1 = "1";
			}
			try {
				Integer.parseInt(currentShowPage2); 	
				
			} catch (NumberFormatException e) {
				currentShowPage1 = "2";
			}
			try {
				Integer.parseInt(currentShowPage3); 	
				
			} catch (NumberFormatException e) {
				currentShowPage1 = "3";
			}
			
			
			paraMap.put("currentShowPage1", currentShowPage1);
			paraMap.put("sizePerPage1", sizePerPage1);
			
			paraMap.put("currentShowPage2", currentShowPage2);
			paraMap.put("sizePerPage2", sizePerPage2);
			
			paraMap.put("currentShowPage3", currentShowPage3);
			paraMap.put("sizePerPage3", sizePerPage3);
			
			paraMap.put("userid", userid);
			
			// 내 문의내역 목록 가져오기
			List<HashMap<String, String>> askList = adao.selectmyask(paraMap);
	
			request.setAttribute("askList", askList);   // 메소드에서 받아온 값을 뷰단으로 보내주기 			
			  
			// System.out.println(askList);

			 request.setAttribute("sizePerPage1", sizePerPage1); // 전송하기 위해 키값으로 저장	
			
			// 셀프반품 신청 목록 가져오기
			List<SelfReturnVO> returnList = adao.myReturnList(paraMap);

			request.setAttribute("returnList", returnList);
			
			 request.setAttribute("sizePerPage2", sizePerPage2); // 전송하기 위해 키값으로 저장	
			
			
			 // 내 조립신청 목록 가져오기(마이페이지) 
			List<AssembleVO> assembleList = adao.myAssembleList(paraMap);
	
			request.setAttribute("assembleList", assembleList);

		   request.setAttribute("sizePerPage3", sizePerPage3); // 전송하기 위해 키값으로 저장	
		   
		   
		// **** ==== 1111111 페이지바 만들기 시작 ==== ****
			String pageBar1 = ""; // ul > li요소 만들기 위함.
			
			int blockSize = 5;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 15개)까지만 증가하는 용도이다.
			
			// !!! 아래는 pageNo를 구하는 공식이다.
			int pageNo1 = ( (Integer.parseInt(currentShowPage1) - 1)/blockSize ) * blockSize + 1;
			int pageNo2 = ( (Integer.parseInt(currentShowPage2) - 1)/blockSize ) * blockSize + 1;
			int pageNo3 = ( (Integer.parseInt(currentShowPage3) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// 총페이지 알아오기
			int totalPage1 = adao.getTotalPage1(userid, sizePerPage1);
			int totalPage2 = adao.getTotalPage2(userid, sizePerPage2);
			int totalPage3 = adao.getTotalPage3(userid, sizePerPage3);
			// 총 페이지는 데이터베이스에서 가져온다. (mdao의 sql문)

			
			// **** [이전] [맨처음] 만들기 **** //
			if(pageNo1 != 1) {
			 pageBar1 +=  "<li class='page-item'>"
			 			+ "<a class='page-link' href='askList.one?currentShowPageNo=1&sizePerPage="+sizePerPage1
					 	+ "'>이전</a></li>";
			
			 pageBar1 +=  "<li class='page-item'><a class='page-link' href='myrequest.one?currentShowPageNo="
					 	+(pageNo1-1)+"&sizePerPage="+sizePerPage1+"'>맨처음</a></li>";
			}
			
		 while( !(loop > blockSize || pageNo1 > totalPage1) ) {
				 
			 // 누른 페이지 번호에 active 주기(누른 상태 보이기)
			 if(pageNo1 == Integer.parseInt(currentShowPage1)) {
				 pageBar1 +=  "<li class='page-item active'><a class='page-link' href='#'>"+pageNo1+"</a></li>"; 
			 }
				 
			 else {
				 pageBar1 +=  "<li class='page-item'><a class='page-link' href='myrequest.one?currentShowPageNo="
						 	+pageNo1+"&sizePerPage="+sizePerPage1+"'>"+pageNo1+"</a></li>";
			 }
			 
			 loop++;  
			 
			 pageNo1++; 
			 
		 }// end of while-------------------------------------
			 
			// **** [다음] [마지막] 만들기 **** //
			// while문을 빠져나올 때 pageNo ==> 16 
			 
			 if(pageNo1 <= totalPage1) { // 마지막 페이지에서는 [다음],[마지막]이 없어야 한다.
			 pageBar1 +=  "<li class='page-item'><a class='page-link' href='myrequest.one?currentShowPageNo="
					 	+pageNo1+"&sizePerPage="+sizePerPage1+"'>다음</a></li>";

			 pageBar1 +=  "<li class='page-item'><a class='page-link' href='myrequest.one?currentShowPageNo="
					 	+totalPage1+"&sizePerPage="+sizePerPage1+"'>마지막</a></li>";
			 
			 }
			 request.setAttribute("pageBar1", pageBar1);
					
			// **** ==== 페이지바 만들기 끝 ==== ****
			 
			 // **** ==== 2222222 페이지바 만들기 시작 ==== ****
			 String pageBar2 = ""; // ul > li요소 만들기 위함.
			 

			 // **** [이전] [맨처음] 만들기 **** //
			 if(pageNo2 != 1) {
				 pageBar2 +=  "<li class='page-item'>"
						 + "<a class='page-link' href='myrequest2.one?currentShowPageNo=1&sizePerPage="+sizePerPage2
						 + "'>이전</a></li>";
				 
				 pageBar2 +=  "<li class='page-item'><a class='page-link' href='myrequest2.one?currentShowPageNo="
						 +(pageNo2-1)+"&sizePerPage="+sizePerPage2+"'>맨처음</a></li>";
			 }
			 
			 while( !(loop > blockSize || pageNo2 > totalPage2) ) {
				 
				 // 누른 페이지 번호에 active 주기(누른 상태 보이기)
				 if(pageNo2 == Integer.parseInt(currentShowPage2)) {
					 pageBar2 +=  "<li class='page-item active'><a class='page-link' href='#'>"+pageNo2+"</a></li>"; 
				 }
				 
				 else {
					 pageBar2 +=  "<li class='page-item'><a class='page-link' href='myrequest2.one?currentShowPageNo="
							 +pageNo2+"&sizePerPage="+sizePerPage2+"'>"+pageNo2+"</a></li>";
				 }
				 
				 loop++;  
				 
				 pageNo2++; 
				 
			 }// end of while-------------------------------------
			 
			 // **** [다음] [마지막] 만들기 **** //
			 // while문을 빠져나올 때 pageNo ==> 16 
			 
			 if(pageNo2 <= totalPage2) { // 마지막 페이지에서는 [다음],[마지막]이 없어야 한다.
				 pageBar2 +=  "<li class='page-item'><a class='page-link' href='myrequest2.one?currentShowPageNo="
						 +pageNo2+"&sizePerPage="+sizePerPage2+"'>다음</a></li>";
				 
				 pageBar2 +=  "<li class='page-item'><a class='page-link' href='myrequest2.one?currentShowPageNo="
						 +totalPage2+"&sizePerPage="+sizePerPage2+"'>마지막</a></li>";
				 
			 }
			 request.setAttribute("pageBar2", pageBar2);
			 
			 // **** ==== 페이지바 만들기 끝 ==== ****
			 
			 // **** ==== 333333 페이지바 만들기 시작 ==== ****
			 String pageBar3 = ""; // ul > li요소 만들기 위함.
			 			 
			 // **** [이전] [맨처음] 만들기 **** //
			 if(pageNo3 != 1) {
				 pageBar3 +=  "<li class='page-item'>"
						 + "<a class='page-link' href='myrequest3.one?currentShowPageNo=1&sizePerPage="+sizePerPage3
						 + "'>이전</a></li>";
				 
				 pageBar3 +=  "<li class='page-item'><a class='page-link' href='myrequest3.one?currentShowPageNo="
						 +(pageNo3-1)+"&sizePerPage="+sizePerPage3+"'>맨처음</a></li>";
			 }
			 
			 while( !(loop > blockSize || pageNo3 > totalPage3) ) {
				 
				 // 누른 페이지 번호에 active 주기(누른 상태 보이기)
				 if(pageNo3 == Integer.parseInt(currentShowPage3)) {
					 pageBar3 +=  "<li class='page-item active'><a class='page-link' href='#'>"+pageNo3+"</a></li>"; 
				 }
				 
				 else {
					 pageBar3 +=  "<li class='page-item'><a class='page-link' href='myrequest3.one?currentShowPageNo="
							 +pageNo3+"&sizePerPage="+sizePerPage3+"'>"+pageNo3+"</a></li>";
				 }
				 
				 loop++;  
				 
				 pageNo3++; 
				 
			 }// end of while-------------------------------------
			 
			 // **** [다음] [마지막] 만들기 **** //
			 // while문을 빠져나올 때 pageNo ==> 16 
			 
			 if(pageNo3 <= totalPage3) { // 마지막 페이지에서는 [다음],[마지막]이 없어야 한다.
				 pageBar3 +=  "<li class='page-item'><a class='page-link' href='myrequest3.one?currentShowPageNo="
						 +pageNo3+"&sizePerPage="+sizePerPage3+"'>다음</a></li>";
				 
				 pageBar3 +=  "<li class='page-item'><a class='page-link' href='myrequest3.one?currentShowPageNo="
						 +totalPage3+"&sizePerPage="+sizePerPage3+"'>마지막</a></li>";
				 
			 }
			 request.setAttribute("pageBar3", pageBar3);
			 
			 // **** ==== 페이지바 만들기 끝 ==== ****
			 
			// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
			String currentURL = MyUtil_jay.getCurrentURL(request); 
			// 목록으로 돌아가기를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임. 
		 
			currentURL = currentURL.replaceAll("&"," ");
			request.setAttribute("goBackURL", currentURL);
			 
			
			super.setViewPage("/WEB-INF/service/myrequest.jsp");
			
		}
		else {
			// 로그인을 안한 경우 
			 String message = "로그인이 필요합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}	
	}	
	
}

