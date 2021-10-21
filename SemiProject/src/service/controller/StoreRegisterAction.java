package service.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.AdminDAO;
import product.model.InterAdminDAO;
import product.model.ProductVO;
import service.model.StoreVO;

public class StoreRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	// 카테고리 목록 얻어오기 
			super.getCategoryList(request);		

			// == 관리자 (admin)으로 로그인 했을 때만 조회가 가능하도록 한다. == //
			
			HttpSession session = request.getSession();
			
			InterAdminDAO adao = new AdminDAO();
			
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null && "admin".equals(loginuser.getUserid()) ) {
				// 관리자로 로그인했을 경우
				
				String method = request.getMethod();
				
				if(!"POST".equalsIgnoreCase(method)) { // get이라면
					
				//super.setRedirect(false);
			  	super.setViewPage("/WEB-INF/service/storeRegister.jsp");
					
				}	
				
				  else { // post이라면 // 파일을 첨부해서 보내는 폼태그 ==> cos.jar 라이브러리를 다운받아 사용
				  
				  MultipartRequest mtrequest = null;
				  
				 // 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다. 
				  ServletContext svlCtx = session.getServletContext(); 
				  String uploadFileDir = svlCtx.getRealPath("/images"); // 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir
				  
				  // C:\git\SemiProject\ ??.metadata\.plugins\org...
				  
				  
				  // 파일업로드 
				  try { 
					  mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy()); 
					  
				  } catch(IOException e){
				  
					  request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
					  request.setAttribute("loc", request.getContextPath()+"/product/admin/productRegister.one");
					  
					  super.setViewPage("/WEB-INF/msg.jsp"); 
					  return; 
					  // 종료 
				  }
				  
				  // === 제품정보를 DB의 tbl_shoppingmap 테이블에 insert ===
				  
				  // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
				  String storename = mtrequest.getParameter("storename"); 
				  String postcode = mtrequest.getParameter("postcode");
				  String address = mtrequest.getParameter("address");
				  String detailaddress = mtrequest.getParameter("detailaddress");
				  String extraaddress = mtrequest.getParameter("extraaddress");
				  String openhour = mtrequest.getParameter("openhour");
				  String closehour = mtrequest.getParameter("closehour");
				  String ropenhour = mtrequest.getParameter("ropenhour");
				  String rclosehour = mtrequest.getParameter("rclosehour");
				  
				  // 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어 올때는 
				  // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
				  // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
				  
				  String storeimage = mtrequest.getFilesystemName("storeimage");
				  
				  StoreVO svo = new StoreVO();

				  svo.setStorename(storename);
				  svo.setPostcode(postcode);
				  svo.setAddress(address);
				  svo.setDetailaddress(detailaddress);
				  svo.setExtraaddress(extraaddress);
				  svo.setOpenhour(openhour);
				  svo.setClosehour(closehour);
				  svo.setRopenhour(ropenhour);
				  svo.setRclosehour(rclosehour);
				  svo.setStoreimg(storeimage);
				  
				  String message = ""; String loc= "";
				  
				  try { 
					  adao.storeInsert(svo);
					  
					  message = "제품등록을 성공적으로 완료했습니다."; 
					  loc = request.getContextPath()+"/service/storeRegister.one"; 
				  }
				  
				  
				  catch(SQLException e){ 
					  e.printStackTrace(); message = "SQL오류로 매장등록을 실패했습니다.";
					  loc = request.getContextPath()+"/service/storeRegister.one"; 
				  }
				  
				  request.setAttribute("message", message); 
				  request.setAttribute("loc", loc);
				  
				  super.setViewPage("/WEB-INF/msg.jsp");
				  
				  }
			 
			}
			else {
				// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
				 String message = "관리자만 접근이 가능합니다.";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      // super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
			}

	}

}
