package member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO_jy;
import member.model.MemberDAO_jy;
import member.model.MemberVO;
import product.model.ProductOrderDetailVO_kgh;
import product.model.ProductOrderVO_kgh;
import product.model.ProductVO_kgh;

public class MypageOderDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String odrcode = request.getParameter("odrcode");
		
		// ProductOrderVO_kgh (tbl_order) --주문
		
		// ProductOrderDetailVO_kgh (tbl_order_detail) --주문상세
		// private ProductVO_kgh pvo;				// 제품 VO 주문상세에 포함
		// private ProductOrderVO_kgh povo;		    // 주문 VO	 주문상세에 포함
		
		// ProductVO_kgh (tbl_product) -- 제품
		
		InterMemberDAO_jy mdao = new MemberDAO_jy();
		
		
		List<ProductOrderDetailVO_kgh> odrDetail = mdao.selectBySpecName(odrcode);
		
		ProductOrderDetailVO_kgh pname = odrDetail.get(1);
		
		
		
		request.setAttribute("odrDetail", odrDetail);
		request.setAttribute("pname", pname);
		request.setAttribute("odrcode", odrcode);
		
		super.setViewPage("/WEB-INF/member/orderDetail.jsp");   
		   
		// System.out.println(odrcode); ==> 1329809811
		
		
	}

}



