package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController {

/*
	@Override
	public String toString() {
		return "@@@ 클래스 MainController 의 인스턴스 메소드 toString() 호출됨 @@@";
	}
*/
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// MainController 클래스의 인스턴스 메소드
		
		// System.out.println("MainController 클래스의 execute 메소드 호출됨");
		
		super.setRedirect(true);
		this.setViewPage("index.one");
	}
	
}
