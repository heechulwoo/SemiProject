package common.controller;

import javax.servlet.http.*;

public class IndexController extends AbstractController {

/*	
	@Override
	public String toString() {
		return "### 클래스 IndexController 의 인스턴스 메소드 toString() 호출됨 ###";
	}
*/
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// IndexController 클래스의 인스턴스 메소드
		
		
		
	//	super.setRedirect(false); // 기본값이 false 이므로 forward로 페이지를 보여주고 싶을때는 생략가능
		super.setViewPage("/WEB-INF/index.jsp");
		
	}
	
}
