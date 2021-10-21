package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class ProductEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 내정보(회원정보)를 수정하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if( super.checkLogin(request) ) {
			// 로그인을 했으면
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( loginuser.getUserid().equals("admin")) {
				// 관리자로 로그인 한 경우
				
				super.getCategoryList(request);
				
				String pnum = request.getParameter("pnum");
				
				InterProductDAO_kgh pdao = new ProductDAO_kgh(); 
				
				ProductVO_kgh pvo = pdao.selectProductDetail(pnum);
				List<ProductImageVO_kgh> pimgList = pdao.selectProductImage(pnum);
				
				request.setAttribute("pvo", pvo);
				request.setAttribute("pimgList", pimgList);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/admin/productEdit.jsp");	
				
			}
			else {
				// 로그인한 사용자가 관리자가 아닐경우
				String message = "접근권한이 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
				
			}

		}
		else {
			// 로그인을 안 했다면
			String message = "로그인이 필요합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
