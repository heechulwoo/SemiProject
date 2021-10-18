package contact.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterProductOrderDAO_sm;
import contact.model.ProductOrderDAO_sm;
import contact.model.ProductOrderVO_sm;
import contact.util.MyUtil_sm;
import member.model.MemberVO;

public class ProductOrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	
		
		
		// === 관리자(admin) 로 로그인했을 때만 조회가 가능하도록 한다 === //
			HttpSession session = request.getSession();
			
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
				// 관리자로 로그인 했을 경우
				
				// DB에서 읽어와야한다.
				InterProductOrderDAO_sm odao = new ProductOrderDAO_sm();
				
				Map<String, String> paraMap = new HashMap<>(); // map만들어서 조건을 담아서 method로 갈 것
				
				String searchType = request.getParameter("searchType"); // 검색어 필터 를 의미 ("name", "userid", "email")가 올 것이다.
				String searchWord = request.getParameter("searchWord"); // 검색(input:text타입의 직접 입력 검색어) // "유" ... 
				// 아직 입력해주기 전까지는 null값
				
				// DB에 보내주기 //
				paraMap.put("searchType", searchType); // 아직 입력해주기 전까지는 null값
				paraMap.put("searchWord", searchWord); // 아직 입력해주기 전까지는 null값
				
				String currentShowPageNo = request.getParameter("currentShowPageNo"); 
				
				
				String sizePerPage = request.getParameter("sizePerPage"); 
				
				
				if(currentShowPageNo == null) {
					// 초기화면일 경우, 1페이지부터 보여줄 것
					currentShowPageNo = "1";
				}
				if(sizePerPage == null || !( "3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage) ) ) {
					
					// sizePerPage 가  null 이거나 user가 장난을 쳐서 3,5,10 이 아닌 경우
					sizePerPage = "10"; // 무조건 10을 해주겠다.
				}
				
				// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
		        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
				try {
					Integer.parseInt(currentShowPageNo);  // 얘가 int로 되어지는 지 먼저 알아보기
					
				} catch (Exception e) {
					currentShowPageNo = "1"; // 만약 currentShowPageNo 가 int가 아닌 경우 무조건 1페이지부터 보여주자
				}
				
				
				
				paraMap.put("currentShowPageNo", currentShowPageNo);
				paraMap.put("sizePerPage", sizePerPage);
				// paraMap 에는 총 4가지가 들어옴 : searchType, searchWord, currentShowPageNo, sizePerPage
				
				
				List<ProductOrderVO_sm> orderList = odao.selectPagingOrder(paraMap);
				//  문의글이 여러개 나오므로 LIST 로 받기
				
				request.setAttribute("orderList", orderList);   		  // 메소드에서 받아온 값을 뷰단으로 보내주기 
				request.setAttribute("sizePerPage", sizePerPage);         // (선택한 페이지를 그대로 남겨주기 위한 처리)
				
				System.out.println("확인용 => "+orderList);
				
				String pageBar = ""; // pagebar 는 ProductOrderList 의 nav안의 li에 들어간다
				
				int blockSize = 10;
				// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
				
				int loop = 1;
				// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
				
				// ===== !!!!! 아래는 pageNo 를 구하는 공식이다. !!!!! ===== //
				int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
				// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.  여기선 1, 11, 21, 31, 41 ...
				// currentShowPageNo 는 string 타입이므로 형변환 시켜줌
				
				// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체주문내역에 대한 총 페이지 수 알아오기
				int totalPage = odao.getTotalPage(paraMap); // totalPage를 DB에서 가져올 것임
				
				// System.out.println("~~~ 확인용 totalPage => " + totalPage);
				
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 맨 처음 아무런 검색어와, 검색필터를 안한 경우 null값이 나오므로 null값 대신에 공백을 주자
				
				if( searchType == null ) {
					searchType = "";
				}
				
				if( searchWord == null ) {
					searchWord = "";
				}
				
				
				request.setAttribute("searchType", searchType);   // 넘겨줘야 검색타입을 유지할 수 있다.
				request.setAttribute("searchWord", searchWord);   // 넘겨줘야 검색단어을 유지할 수 있다.
				
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
				// ***** [맨처음] [이전] 만들기 ***** //
				if( pageNo != 1 ) {
					// 현재 페이지가 1페이지만 아니라면, [맨처음]과 [이전] 버튼 사용가능
					 pageBar += "<li class='page-item'><a class='page-link' href='productOrderList.one?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>"; 
					 pageBar += "<li class='page-item'><a class='page-link' href='productOrderList.one?currentShowPageNo="+(pageNo - 1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>"; 
				}
				
				// 맨처음은 1페이지, 이전 페이지는 현재페이지보다 -1 해야함(== pageNo - 1)
				
				
				
				while( !(loop > blockSize || pageNo > totalPage) ) { // loop 가 blockSize 보다 커지면 반복문 멈춰(탈출)!  // totalPage 보다 pageNo가 커져도 반복문 그만
					
					if( pageNo == Integer.parseInt(currentShowPageNo) ) {
						// 보여주는 페이지가 내가 현재 클릭한 페이지인 경우
						pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
					}
					else {
						// 내가 현재 클릭한 페이지가 아닌 이외의 페이지에는 링크를 달아준다.
						pageBar += "<li class='page-item'><a class='page-link' href='productOrderList.one?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>"; 
						// 페이지바 만들기(href 안에는 현재 누른 페이지넘버 & 페이지당 보여줄 개수 정보 & 검색타입 정보 & 검색어 정보 를 포함한 위치넣기)
					}
					
					loop++;   // 1 2 3 4 5 6 7 8 9 10
					
					pageNo++; // 1 2 3 4 5 6 7 8 9 10
							  // 11 12 13 14 15 16 17 18 19 20
							  // 21 22 23 24 25 26 27 28 29 30
					  		  // 31 32 33 34 35 36 37 38 39 40
							  // 41 42 43
					
				}// end of while----------------------------------------------------------------------
				
				
				
				// ***** [다음] [마지막] 만들기 ***** //
				// pageNo ==> 11 이 된 상태에서 while문에서 빠져나오기 때문에
				if( pageNo <= totalPage ) {
					 pageBar += "<li class='page-item'><a class='page-link' href='productOrderList.one?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";
					 pageBar += "<li class='page-item'><a class='page-link' href='productOrderList.one?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
				}
				
				request.setAttribute("pageBar", pageBar); // 뷰단으로 넘기기 위해
				
				
				// ***** ========== 페이지 바 만들기 끝 ========== ***** //
				
				
				
				// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
				String currentURL = MyUtil_sm.getCurrentURL(request);
				// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
				
				currentURL = currentURL.replaceAll("&", " "); // 위의 URL의 & 를 ""(공백)으로 바꿔줌
			 	// System.out.println("~~~ currentURL => " + currentURL);
			 	// /member/memberList.up?currentShowPageNo=5 sizePerPage=5 searchType=name searchWord=%EC%9C%A0
				
				request.setAttribute("goBackURL", currentURL); // 받아온 URL을 뷰단으로 보내주기 위해 저장
				
				// super.setRedirect(false);
				   super.setViewPage("/WEB-INF/contact/ProductOrderList_sm.jsp");
				
			} // end of if( loginuser != null && "admin".equals(loginuser.getUserid()) ) --------------------------
			
			else {
				// 로그인을 안한 경우 또는 일반사용자로 로그인한 경우
				 String message = "관리자 계정만 접근이 가능합니다.";
				 String loc = request.getContextPath()+"/login/login.one";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      // super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
			}
				
				
				
		
		
	}

}
