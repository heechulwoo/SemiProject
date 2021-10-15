package common.controller;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.*;

import member.model.MemberVO;
import my.util.MyUtil_jy;
import product.model.*;

public abstract class AbstractController implements InterCommand {

	private boolean isRedirect = false;
	// isRedirect 변수의 값이 false 이라면 view단 페이지(.jsp)로  forward 방법(dispatcher)으로 이동시키겠다. 
    // isRedirect 변수의 값이 true 이라면 sendRedirect 로 페이지이동을 시키겠다.
	
	private String viewPage;
	// viewPage 는 isRedirect 값이 false 이라면 view단 페이지(.jsp)의 경로명 이고,
	// isRedirect 값이 true 이라면 이동해야할 페이지 URL 주소 이다.
	
	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}


	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	

	////////////////////////////////////////////
	// 로그인 유무를 검사해서 로그인 했으면 true를 리턴해주고
	// 로그인 안 했으면 false를 리턴해주도록 한다.
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			// 로그인한 경우
			return true;
		}
		else {
			// 로그인 안 한 경우
			return false;
		}
	
	}

	/////////////////////////////////////////////////////////////
	// ***** 제품목록(Category)을 보여줄 메소드 생성하기 ***** //
	// VO를 사용하지 않고 Map 으로 처리
	public void getCategoryList(HttpServletRequest request) throws SQLException {
	
		InterProductDAO pdao = new ProductDAO();
		
		List<Map<String,String>> categoryList = pdao.selectCategoryImage();
		request.setAttribute("categoryList", categoryList);
	
	}
	
	// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
    public void goBackURL(HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	session.setAttribute("goBackURL", MyUtil_jy.getCurrentURL(request));
    }
	
}
