package contact.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.ConsultWriteDAO_sm;
import contact.model.InterConsultWriteDAO_sm;
import member.model.MemberVO;

public class DeleteConsultAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		
			// === 로그인했을 때만 조회가 가능하도록 한다 == //
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null ) {
				// 로그인 했을 경우
				
				Map<String, String> paraMap = new HashMap<>(); // map만들어서 조건을 담아서 method로 갈 것
				
				String fk_userid = request.getParameter("fk_userid");
				String askno = request.getParameter("askno");
				
				if( loginuser.getUserid().equals(fk_userid) ) {
					// 로그인한 사용자가 자신의 글을 삭제하는 경우
					
					
					
					////////////////////////////////////////////////////////////////////////////
										
					// 삭제 할 파일의 경로를 구하고 File 객체 생성한다. 
					
					// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
					ServletContext svlCtx = session.getServletContext(); // 세션 값 가져오기
					String uploadFileDir = svlCtx.getRealPath("/images"); // 이미지 폴더 안에 넣을 것임(이미지 폴더가 어디있는지 알려줄 것임) -- 파일이 저장될 경로
					
					// System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir); 
					
					
					// **** 시스템에 업로드 되어진 파일설명서 첨부파일명 및 오리지널파일명 알아오기  **** //
					InterConsultWriteDAO_sm cdao = new ConsultWriteDAO_sm();
					Map<String, String> map = cdao.getAskFileName(askno);  // 첨부파일명 & 오리지널파일명 알아오기
					
					// 경로에 파일네임을 덧붙여서 위치를 정확하게 알려주는 것 
					String filePath = uploadFileDir + "\\" + map.get("ask_systemFileName");
					// map.get("ask_systemFileName") 은 파일서버에 업로드 되어진 파일명임.
					

					// File 객체 생성하기
					File Cfile = new File(filePath);
					
					System.out.println("filePath : " +filePath);
					
					
					if(Cfile.exists()){
						
						Cfile.delete();
						System.out.println("(문의글 삭제 처리) 파일 삭제됨");
						
						// System.out.println("확인용 fk_userid : "+fk_userid);
						// System.out.println("확인용 askno => "+ askno);
						
						// DB에 보내주기 //
						paraMap.put("fk_userid", fk_userid);
						paraMap.put("askno", askno);
						
						cdao = new ConsultWriteDAO_sm();
						int n = cdao.consultOneDelete(paraMap); // 문의글 삭제 메소드
						
						//////////////////////////////////////////////////////////
						
						String message = "문의글 삭제가 완료되었습니다! 게시판에서 확인해주세요 :-)";
				        String loc = request.getContextPath()+"/contact/consultList.one";
				         
				        request.setAttribute("message", message);
				        request.setAttribute("loc", loc);
				         
				        // super.setRedirect(false);
				        super.setViewPage("/WEB-INF/msg.jsp");
						
						
						
					}else{
						System.out.println("(문의글 삭제 처리) 파일 없음");
						
						// System.out.println("확인용 fk_userid : "+fk_userid);
						// System.out.println("확인용 askno => "+ askno);
						
						// DB에 보내주기 //
						paraMap.put("fk_userid", fk_userid);
						paraMap.put("askno", askno);
						
						cdao = new ConsultWriteDAO_sm();
						int n = cdao.consultOneDelete(paraMap); // 문의글 삭제 메소드
						
						//////////////////////////////////////////////////////////
												
						String message = "문의글 삭제가 완료되었습니다! 게시판에서 확인해주세요 :-)";
						String loc = request.getContextPath()+"/contact/consultList.one";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						// super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
						
					}
					
					////////////////////////////////////////////////////////////////////////////
					
				
				}
				else {
					// 로그인한 사용자가 다른 사용자의 글을 삭제하려고 시도하는 경우 
					
					String message = "다른 사용자의 문의글 삭제는 불가합니다. 회원님의 글만 삭제가 가능합니다.";
					String loc = request.getContextPath()+"/contact/consultList.one";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
					
				}
				
			}
			else {
				// 로그인 안 한 경우
				
				String message = "문의글을 삭제 하기 전에 먼저 로그인을 해주세요!";
				String loc = request.getContextPath()+"/login/login.one";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
		
		
		
	}

}
