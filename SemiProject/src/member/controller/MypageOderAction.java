package member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import product.model.*;

public class MypageOderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/* 지워야함지워야함 */
		
		/*
		String message = "";
        String loc = "";
		
		try {
		// 카테고리 목록 얻어오기 
		    super.getCategoryList(request);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			InterMemberDAO_jy mdao = new MemberDAO_jy();
			
			String userid = loginuser.getUserid();
			
			// System.out.println(userid);  ==> leess
			
		//	ProductVO pvo = new ProductVO();
			
			
			List<ProductOrderVO_kgh> ProductList = mdao.selectMyPageOderList(userid);
			
			request.setAttribute("ProductList", ProductList);
			
			super.setViewPage("/WEB-INF/member/mypageOder.jsp");
		
  	   } catch (NullPointerException e) {

  		 message = "로그인을 먼저 해주세요!";
         loc = request.getContextPath()+"/index.one"; // 시작페이지로 이동한다.
		
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);
         
      // super.setRedirect(false);
         super.setViewPage("/WEB-INF/msg.jsp");
  	   }
		//setRedirect(false);
	*/ 	
	}

}
