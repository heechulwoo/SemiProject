package service.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import my.util.MyUtil_jay;
import service.model.*;

public class AssembleListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	// 카테고리 목록 얻어오기 
	super.getCategoryList(request);	
	
	// == 관리자 (admin)으로 로그인 했을 때만 조회가 가능하도록 한다. == //
	HttpSession session = request.getSession();
		
	MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
	if(loginuser != null && "admin".equals(loginuser.getUserid()) ) {
		// 관리자로 로그인 했을 경우
	
		InterServiceDAO sdao = new AssembleDAO();
		
		Map<String,String> paraMap = new HashMap<>();
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
	
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
        
		String sizePerPage = request.getParameter("sizePerPage");
		// 한 페이지당 화면상에 보여줄 회원의 개수
		
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
        // currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
		if(currentShowPageNo == null) {
			currentShowPageNo= "1";
		}
		
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
        // sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
		if(sizePerPage == null || !("15".equals(sizePerPage)) ) {
			// 처음들어와서 페이지당 보이는 수를 선택 하지 않은 경우이거나, url에 get방식으로 임의로 넣은 경우 무조건 기본값 15개씩 보이기
			sizePerPage = "15";
		}
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		try {
			Integer.parseInt(currentShowPageNo); 	
			
		} catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		// 페이징 처리를 한 조립 신청 목록 보여주기
		List<AssembleVO> assembleList = sdao.assembleApplyMember(paraMap); // dao에서 sql문으로 나온 결과물assembleList
		
		request.setAttribute("assembleList", assembleList); // 전송하기 위해 키값으로 저장
		request.setAttribute("sizePerPage", sizePerPage); // 전송하기 위해 키값으로 저장		
		
		// **** ==== 페이지바 만들기 시작 ==== ****
		String pageBar = ""; // ul > li요소 만들기 위함.
		
		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 15개)까지만 증가하는 용도이다.
		
		// !!! 아래는 pageNo를 구하는 공식이다.
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		// 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
		int totalPage = sdao.getTotalPage(paraMap);
		// 총 페이지는 데이터베이스에서 가져온다. (mdao의 sql문)
		
		// 검색어가 없을 경우 get방식 url주소에 null이 넣어지고 'null'이 검색되는 경우를 방지
		if(searchType == null) {
			searchType="";	
		}
		
		if(searchWord == null) {
			searchWord="";	
		}
		
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord",searchWord);
		
		// **** [이전] [맨처음] 만들기 **** //
		if(pageNo != 1) {
		 pageBar +=  "<li class='page-item'><a class='page-link' href='assembleList.one?currentShowPageNo=1&sizePerPage="+sizePerPage+
				 	"&searchType="+searchType+"&searchWord="+searchWord+"'>이전</a></li>";
		
		 pageBar +=  "<li class='page-item'><a class='page-link' href='assembleList.one?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+
				 	"&searchType="+searchType+"&searchWord="+searchWord+"'>맨처음</a></li>";
		}
		
	 while( !(loop > blockSize || pageNo > totalPage) ) {
			 
		 // 누른 페이지 번호에 active 주기(누른 상태 보이기)
		 if(pageNo == Integer.parseInt(currentShowPageNo)) {
			 pageBar +=  "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
		 }
			 
		 else {
			 pageBar +=  "<li class='page-item'><a class='page-link' href='assembleList.one?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+
					 	"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
		 }
		 
		 loop++;  
		 
		 pageNo++; 
		 
	 }// end of while-------------------------------------
		 
		// **** [다음] [마지막] 만들기 **** //
		// while문을 빠져나올 때 pageNo ==> 16 
		 
		 if(pageNo <= totalPage) { // 마지막 페이지에서는 [다음],[마지막]이 없어야 한다.
		 pageBar +=  "<li class='page-item'><a class='page-link' href='assembleList.one?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+
				 	"&searchType="+searchType+"&searchWord="+searchWord+"'>다음</a></li>";

		 pageBar +=  "<li class='page-item'><a class='page-link' href='assembleList.one?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+
				 	"&searchType="+searchType+"&searchWord="+searchWord+"'>마지막</a></li>";
		 
		 }
		 request.setAttribute("pageBar", pageBar);
				
		// **** ==== 페이지바 만들기 끝 ==== ****
		 
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
		String currentURL = MyUtil_jay.getCurrentURL(request); 
		// 목록으로 돌아가기를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임. 
	 
		currentURL = currentURL.replaceAll("&"," ");
		request.setAttribute("goBackURL", currentURL);
			
	// super.setRedirect(false);
	super.setViewPage("/WEB-INF/service/assembleList.jsp"); 
	
	}
	else {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			 String message = "관리자만 접근이 가능합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
		}	
	}

}
