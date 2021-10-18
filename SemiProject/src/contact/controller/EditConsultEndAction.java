package contact.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import contact.model.ConsultWriteDAO_sm;
import contact.model.InterConsultWriteDAO_sm;
import member.model.MemberVO;

public class EditConsultEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/////////////////////////////////////////////////////////////////////////
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/index.jsp"); // 인덱스로 가자
		}
		
		else {
			// POST 방식
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null) {
				// 로그인 한 경우
				
				
				// ===== *** 이미지 첨부파일 처리 시작 *** ===== //
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				MultipartRequest mtrequest = null;
				
				ServletContext svlCtx = session.getServletContext(); // 세션 값 가져오기
				String uploadFileDir = svlCtx.getRealPath("/images"); // 이미지 폴더 안에 넣을 것 -- 파일이 저장될 경로
				
				System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir); 
				// === 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\SemiProject\images
				
				
				
				// === 파일을 업로드 해준다. === //
				try {
				
				mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy()); // 생성자 처리
				
				
				} catch(IOException e) {
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나, 최대용량 10MB를 초과했으므로 파일업로드 실패했습니다. 다시 확인해주세요.");
		            request.setAttribute("loc", request.getContextPath()+"/contact/consultList.one"); 
		              
		            super.setViewPage("/WEB-INF/msg.jsp");
		            return; // 종료
				}

				
				
				
				Map<String, String> paraMap = new HashMap<>(); // map만들어서 조건을 담아서 method로 갈 것
				
				String fk_userid = mtrequest.getParameter("fk_userid");
				String askno = mtrequest.getParameter("askno");
				
				System.out.println("확인용 fk_userid: "+fk_userid);
				
				
				if( loginuser.getUserid().equals(fk_userid) ) {
					// 로그인한 사용자가 자신의 정보를 수정하는 경우
					
					// DB에 보내주기 //
					// paraMap.put("fk_userid", fk_userid);
					// paraMap.put("askno", askno);
					
					
		
				
				
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
				// === 첨부 이미지 파일을 올렸으니 그 다음으로 문의글정보를 (이름, 아이디, 휴대전화,...) DB의 tbl_ask 테이블에 insert 를 해주어야 한다.  ===
				
					
					String name = mtrequest.getParameter("name");
					String email = mtrequest.getParameter("email"); 
					String hp1 = mtrequest.getParameter("hp1"); 
					String hp2 = mtrequest.getParameter("hp2"); 
					String hp3 = mtrequest.getParameter("hp3");
					String category = mtrequest.getParameter("category");
					String asktitle = mtrequest.getParameter("asktitle");
				//	String askcontent = mtrequest.getParameter("askcontent");
					
		
				//	위의 request 전부 다 mtrequest.getParameter(---) 로 바꿔주기 !
					
					// 이미지는 다운로드할 수 있게 해주기
					// 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어 올때는 
		        	// cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
		        	// 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
					
					String ask_systemFileName = mtrequest.getFilesystemName("cImgFile");
					// 제품설명서 파일명(파일서버에 업로드 되어진 실제파일명)
					
					String ask_orginFileName = mtrequest.getOriginalFileName("cImgFile");
					// 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명
		        	// 제품설명서 파일명 입력은 선택사항이므로 NULL 이 될 수 있다.
		        	// 첨부파일들 중 이것만 파일다운로드를 해주기 때문에 getOriginalFileName(String name) 메소드를 사용한다.
					
		
					
					String mobile = hp1+hp2+hp3;
					
					// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
					String askcontent = mtrequest.getParameter("askcontent");
			        askcontent = askcontent.replaceAll("<", "&lt;");
			        askcontent = askcontent.replaceAll(">", "&gt;");
					
					
					
				//  입력한 내용에서 엔터는 <br>로 변환시키기
			        askcontent = askcontent.replaceAll("\r\n", "<br>");	
					
					
					
					
			        System.out.println("확인 이메일 : " + email);
					
					// DB에 보내주기 //
					paraMap.put("askno", askno);
					paraMap.put("fk_userid", fk_userid);
					paraMap.put("category", category);
					paraMap.put("name", name);
					paraMap.put("email", email);
					paraMap.put("mobile", mobile);
					paraMap.put("asktitle", asktitle);
					paraMap.put("askcontent", askcontent);
					paraMap.put("ask_systemFileName", ask_systemFileName);
					paraMap.put("ask_orginFileName", ask_orginFileName);
					
					
					// ###### 문의게시글 수정이 성공되면 문의게시글 리스트로 넘어감 ###### //
					try {
						
						InterConsultWriteDAO_sm cdao = new ConsultWriteDAO_sm();
						int n = cdao.updateConsult(paraMap); // 얘도 메소드에 파일 관련 내용 추가
						
						if(n==1) {
							
							 String message = "문의글 수정이 완료되었습니다! 게시판에서 확인해주세요 :-)";
					         String loc = request.getContextPath()+"/contact/consultList.one";
					         
					         request.setAttribute("message", message);
					         request.setAttribute("loc", loc);
					         
					         // super.setRedirect(false);
					         super.setViewPage("/WEB-INF/msg.jsp");
							
							
						//	super.setRedirect(false);
						//	super.setViewPage("/WEB-INF/contact/consultList.jsp");
							
						}
					} catch(SQLException e) {
						String message = "SQL구문 에러발생";
						String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
					
					
					
				}// end of if( loginuser.getUserid().equals(fk_userid) )--------------------------------
				
				
				else {
					// 로그인한 사용자가 다른 사용자의 정보를 수정하려고 시도하는 경우 
					
					String message = "다른 사용자의 정보변경은 불가합니다. 회원님의 글만 수정이 가능합니다.";
					String loc = request.getContextPath()+"/contact/consultList.one";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
					
				}
				
		
			
		    }// end of if(loginuser != null)----------------------------------------
			
			else {
				
				// 로그인을 안한 경우
		         String message = "로그인한 사용자만 접근이 가능합니다. 로그인을 해주세요!";
		         String loc = request.getContextPath()+"/login/login.one";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		         // super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
	 		}
			
			
		}// end of else (// POST 방식) ------------------------------------------
		
		
		
		/////////////////////////////////////////////////////////////////////////
		
	}

}
