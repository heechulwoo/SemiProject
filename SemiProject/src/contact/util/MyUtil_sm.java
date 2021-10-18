package contact.util;

import javax.servlet.http.HttpServletRequest;

public class MyUtil_sm {
	
	
	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		
		String currentURL = request.getRequestURL().toString(); // return 타입이 StringBuffer 니까 toString !!!
		// getRequestURL() : ? 앞까지 알려주는 것임 , 
	//	System.out.println("~~~ 확인용 currentURL => " + currentURL);
	// 	~~~ 확인용 currentURL => http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString();
	//	System.out.println("~~~ 확인용 queryString => " + queryString);
	//	~~~ 확인용 queryString => currentShowPageNo=5&sizePerPage=5&searchType=name&searchWord=%EC%9C%A0	(GET방식일 경우)
	//	~~~ 확인용 queryString => null (POST 방식일 경우)	
		
		if( queryString != null ) { // GET 방식일 경우
			currentURL += "?" + queryString;
			
		}
		
		
	//	System.out.println("~~~ 확인용 currentURL => " + currentURL);
	//	~~~ 확인용 currentURL => http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=5&sizePerPage=5&searchType=name&searchWord=%EC%9C%A0
		
		String ctxPath = request.getContextPath();
		//     
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();   // http://localhost:9090/MyMVC 여기까지의 길이
		// 			21번째			+        6
		
		currentURL = currentURL.substring(beginIndex);  // http://localhost:9090/MyMVC/ 여기까지 자른 것, 즉 자른부분이후부터
		// /member/memberList.up?currentShowPageNo=5&sizePerPage=5&searchType=name&searchWord=%EC%9C%A0 를 의미
		
		return currentURL;
	}
	
	
	
}
