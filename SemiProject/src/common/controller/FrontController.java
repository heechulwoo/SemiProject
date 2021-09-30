package common.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		description = "사용자가 웹에서 *.one 을 했을 경우 이 서블릿이 먼저 응답을 해주도록 한다", 
		urlPatterns = { "*.one" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "‪C:/git/SemiProject/SemiProject/WebContent/WEB-INF/Command.properties", description = "*.one에 대한 클래스의 매핑파일")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, Object> cmdMap = new HashMap<>();
	
	public void init(ServletConfig config) throws ServletException {
		
		String props = config.getInitParameter("propertyConfig");
		
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(props);
			
			Properties pr = new Properties();
			
			pr.load(fis);
			
			Enumeration<Object> en = pr.keys();
			
			while(en.hasMoreElements()) {
			
				String key = (String) en.nextElement();
				
				String className = pr.getProperty(key);
				
				if(className != null) {
					className = className.trim(); // Command.properties 에서 끝에 공백을 입력했을 수도 있으니 제거해줌
					
					Class<?> cls = Class.forName(className);
					
					Constructor<?> constrt = cls.getDeclaredConstructor();
					
					Object obj = constrt.newInstance();
					
					cmdMap.put(key, obj);
					
				}// end of if(className != null)--------------------------
				
			}// end of while-----------------------
			
		} catch (FileNotFoundException e) {
			System.out.println(">>> C:/git/SemiProject/SemiProject/WebContent/WEB-INF/Command.properties 파일이 없습니다. <<<");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println(">>> 문자열로 명명되어진 클래스가 존재하지 않습니다. <<<");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String uri = request.getRequestURI(); // http://localhost:9090 (포트번호) 이후부터 ? 앞까지 잘라옴
			
		String key = uri.substring(request.getContextPath().length()); // /MyMVC 이후로 /member/idDuplicateCheck.up 만 얻어오기
		
		AbstractController action = (AbstractController) cmdMap.get(key);
		// 추상클래스인 부모 클래스로 받아온다
		
		if(action == null) {
			System.out.println(">>> "+key+"은 URI 패턴에 매핑된 클래스가 없습니다. <<<");
			// >> /aaa.go URI 패턴에 매핑된 클래스가 없습니다. <<<
		}
		else {
			try {
				
                request.setCharacterEncoding("UTF-8");
                
				action.execute(request, response);
				
				boolean isRedirect = action.isRedirect();
				String viewPage = action.getViewPage();
				
				if( !isRedirect ) {
					
					if(viewPage != null) {
						RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
						dispatcher.forward(request, response);
					}
				}
				else {
					
					if(viewPage != null) {
						response.sendRedirect(viewPage);
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
