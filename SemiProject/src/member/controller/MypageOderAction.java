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
		

		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		InterMemberDAO_jy mdao = new MemberDAO_jy();
		
		System.out.println("나의 주문보기의 userid" + loginuser);
		
		String userid = loginuser.getUserid();
		
		// System.out.println(userid);  ==> leess
		
	//	ProductVO pvo = new ProductVO();
		
		
		List<ProductOrderVO_kgh> ProductList = mdao.selectMyPageOderList(userid);
		
		request.setAttribute("ProductList", ProductList);
		
		
		//setRedirect(false);
		super.setViewPage("/WEB-INF/member/mypageOder.jsp");
	}

}
