package contact.controller;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import contact.model.ConsultWriteDAO_sm;
import contact.model.InterConsultWriteDAO_sm;

public class FileDownloadAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 카테고리 목록 얻어오기 
		super.getCategoryList(request);	

		
		
		// ===== ***** 파일 다운로드 해주기 ***** ===== //
		
			String askno = request.getParameter("askno");
			
			
			try {
				
				// 다운로드 할 파일의 경로를 구하고 File 객체 생성한다. 
				HttpSession session = request.getSession();
				
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
				ServletContext svlCtx = session.getServletContext(); // 세션 값 가져오기
				String uploadFileDir = svlCtx.getRealPath("/images"); // 이미지 폴더 안에 넣을 것임(이미지 폴더가 어디있는지 알려줄 것임) -- 파일이 저장될 경로
				
			    // System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir); 
				// === 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> C:\NCS\workspace(jsp)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MyMVC\images
				
				
				// **** 시스템에 업로드 되어진 파일설명서 첨부파일명 및 오리지널파일명 알아오기  **** //
				InterConsultWriteDAO_sm cdao = new ConsultWriteDAO_sm();
				Map<String, String> map = cdao.getAskFileName(askno);  // 첨부파일명 & 오리지널파일명 알아오기
				
				// 경로에 파일네임을 덧붙여서 위치를 정확하게 알려주는 것 
				String filePath = uploadFileDir + "\\" + map.get("ask_systemFileName");
													  // map.get("ask_systemFileName") 은 파일서버에 업로드 되어진 파일명임.
				
				// File 객체 생성하기
				File file = new File(filePath);
				
				// MIME TYPE 설정하기 (우리가 다운 받을 파일의 종류를 의미)
		        // (구글에서 검색어로 MIME TYPE 을 해보면 MIME TYPE에 따른 문서종류가 쭉 나온다)
				String mimeType = svlCtx.getMimeType(filePath); // 다운 받아야할 스트링타입의 파일이 안에 들어와야함
				
				// System.out.println("~~~ 확인용 mimeType =>" + mimeType);
				// ~~~ 확인용 mimeType =>application/pdf		.pdf 파일임
				// ~~~ 확인용 mimeType =>application/jpg		.jpg 파일임
				// ~~~~ 확인용 mimeType => application/vnd.openxmlformats-officedocument.spreadsheetml.sheet    엑셀파일임.
				
				if( mimeType == null ) {
					mimeType = "application/octet-stream"; 
					// 한글파일은 해외에선 안쓰이므로 직접 쓰게 되어있다.
					// "application/octet-stream" 은 일반적으로 잘 알려지지 않은 모든 종류의 이진 데이터를 뜻하는 것임. 
				}
				
				response.setContentType(mimeType); // 받아올 데이터값 설정해줌
				
				
				// 다운로드 되어질 파일명 알아와서 설정해주기(오리지날 파일명)
				String ask_orginFileName = map.get("ask_orginFileName");
				
				// map.get("ask_orginFileName")이 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 파일명임.
				
				// === 파일명에 한글이 포함된 경우, 한글이 깨지는 것을 방지 ===
				// ask_orginFileName(다운로드 되어지는 파일명)이 한글일때  
		        // 한글 파일명이 깨지지 않도록 하기위한 웹브라우저 별로 encoding 하기 및  다운로드 파일명 설정해주기
				String downloadFileName = "";
				String header = request.getHeader("User-Agent");
				
				if (header.contains("Edge")){
		            downloadFileName = URLEncoder.encode(ask_orginFileName, "UTF-8").replaceAll("\\+", "%20");
		             response.setHeader("Content-Disposition", "attachment;filename=" + downloadFileName);
		          } else if (header.contains("MSIE") || header.contains("Trident")) { // IE 11버전부터는 Trident로 변경됨.
		             downloadFileName = URLEncoder.encode(ask_orginFileName, "UTF-8").replaceAll("\\+", "%20");
		             response.setHeader("Content-Disposition", "attachment;filename=" + downloadFileName);
		         } else if (header.contains("Chrome")) {
		            downloadFileName = new String(ask_orginFileName.getBytes("UTF-8"), "ISO-8859-1");
		             response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
		         } else if (header.contains("Opera")) {
		            downloadFileName = new String(ask_orginFileName.getBytes("UTF-8"), "ISO-8859-1");
		             response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
		         } else if (header.contains("Firefox")) {
		            downloadFileName = new String(ask_orginFileName.getBytes("UTF-8"), "ISO-8859-1");
		             response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
		         }
				
				
				// *** 다운로드할 요청 파일을 읽어서 클라이언트로 파일을 전송하기 *** //
				FileInputStream finStream = new FileInputStream(file);
				// 1byte 기반 파일 입력 노드스트림 생성
				
				
				ServletOutputStream srvOutStream = response.getOutputStream();
				// 1byte 기반 파일 출력 노드스트림 생성 
		        // ServletOutputStream 은 바이너리 데이터를 웹 브라우저로 전송할 때 사용함.
				
				byte arrb[] = new byte[4096];
		        int data = 0;
		        while ((data = finStream.read(arrb, 0, arrb.length)) != -1) {
		           srvOutStream.write(arrb, 0, data);
		        }// end of while---------------------------
				
		        srvOutStream.flush(); // 보내주기
				
		        srvOutStream.close(); // 자원 닫기
		        finStream.close();    // 자원 닫기
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
		
		
		
	}

}
