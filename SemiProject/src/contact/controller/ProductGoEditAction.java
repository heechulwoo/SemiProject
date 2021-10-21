package contact.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.InterProductOrderDAO_sm;
import contact.model.ProductOrderDAO_sm;
import contact.model.ProductOrderDetailVO_sm;
import contact.model.ProductOrderImgVO_sm;
import member.model.MemberVO;

public class ProductGoEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		// === 관리자(admin) 로 로그인했을 때만 배송상태 변경이 가능하도록 한다 === //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null && "admin".equals(loginuser.getUserid()) ) {
			// 관리자로 로그인 했을 경우
			
			String odrseqnum = request.getParameter("odrseqnum");
			String fk_odrcode = request.getParameter("fk_odrcode");
			String fk_pnum = request.getParameter("fk_pnum");
			
			// System.out.println("확인용 fk_odrcode => " + fk_odrcode);
			
			
			// 주문 세부내역 보여주기 (select)//
			InterProductOrderDAO_sm odao = new ProductOrderDAO_sm();
			ProductOrderDetailVO_sm ovo = odao.viewOrderDetail(odrseqnum); // 세부내역 보여주는 메소드
			
			// 이미지 보여주기(select) //
			ProductOrderImgVO_sm ivo = odao.viewOrderImg(fk_pnum);
			
			
			Map<String, String> map = odao.getUserEmail(fk_odrcode); // 유저 이메일 알아오기
			
			
			if(ovo != null) {
				
				//////////////////////////////////////////////////////////
				
				request.setAttribute("ovo", ovo); // 메소드에서 얻어온 값을 담아주기(세부내역)
				request.setAttribute("ivo", ivo); // 메소드에서 얻어온 값을 담아주기(이미지파일)
				request.setAttribute("map", map); // 메소드에서 얻어온 값을 담아주기(이메일 보내줄 용도)
				
				// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** // 
				String goBackURL = request.getParameter("goBackURL");
				request.setAttribute("goBackURL", goBackURL);
				
				
				// === 뷰 단 === //
				super.setRedirect(false); // 생략가능
				super.setViewPage("/WEB-INF/contact/productGoEdit.jsp");
				
			}
			else {
				// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 주문상세번호를 입력한 경우
				
				String message = "검색하신 주문 상세 내역은 존재하지 않습니다.";
				String loc = request.getContextPath()+"/contact/productOrderList.one";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
		}
		
		else {
			// 로그인을 안했거나, 관리자 계정이 아닌 경우
			
			String message = "로그인을 먼저 해주세요!";
			String loc = request.getContextPath()+"/login/login.one";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
		
		
		
	}

}
