package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import my.util.MyUtil_jy;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
	    super.getCategoryList(request);
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 한다. == //
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		if(loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			

			InterMemberDAO_jy mdao = new MemberDAO_jy();
			
			Map<String, String> paraMap = new HashMap<>();
			
			String searchType = request.getParameter("searchType"); 
			String searchWord =  request.getParameter("searchWord");
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			
			String sizePerPage = request.getParameter("sizePerPage");
			
			
			if( currentShowPageNo == null ) {				
				currentShowPageNo = "1";
			}
			
			

			if(sizePerPage == null || !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage) ) ) {
				sizePerPage = "10";
			}
			
			
			try { // 장난을 쳐온 경우를 대비한다.
				Integer.parseInt(currentShowPageNo);
			} catch (Exception e) {
				currentShowPageNo = "1";
			}
			
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);
			
			
			request.setAttribute("memberList", memberList);
			request.setAttribute("sizePerPage", sizePerPage);  // 넘어온 sizePerPage를 그대로 다시 넘겨준다.
			
			
			// ====== 페이지바 만들기 시작 ====== //
			String pageBar = "";
			
			int blockSize = 10;  // 토막당 보여지는 페이지 번호의 개수
			
			int loop = 1;
			
			int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기 
			int totalPage = mdao.getTotalPage(paraMap);
			// System.out.println("~~~~ 확인용 totalPage : " + totalPage);
			
			
			////////////////////////////////////////////////////////////////////////////////////
			if(searchType == null) {
				searchType = "";
			}
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			////////////////////////////////////////////////////////////////////////////////////
			
			// ====== 페이지바 만들기 시작 ====== //
			// **** [맨처음] [이전] 만들기  **** //

			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.one?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.one?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage ) ) {
				
				if( pageNo == Integer.parseInt(currentShowPageNo) ) { // 내가 보고자 하는 페이지만 숫자를 보여주고, 표시를 해준다
					// active는 클릭한곳을 표시해주는 부트스트랩
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				}
				else { // 나머지는 링크를 걸어둔다.
					pageBar += "<li class='page-item'><a class='page-link' href='memberList.one?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
				}
				
				loop++; // 1 2 3 4 5 6 7 8 9
				
				pageNo++;

				
			}// end of while
			
			
			// **** [다음] [마지막] 만들기  **** //
			// while문을 나올때 pageNo ==> 11이다.
			if(pageNo <= totalPage) {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.one?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";   
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.one?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
			}
			
			
			request.setAttribute("pageBar", pageBar);
			// ====== 페이지바 만들기 끝 ====== //
			
			
			super.setViewPage("/WEB-INF/member/memberList.jsp");
			
			
			
			
		}// end of if (loginuser != null && "admin".equals(loginuser.getuserid()) )
		
		else {
			
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		

		
	} // end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
