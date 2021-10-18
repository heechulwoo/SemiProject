package product.controller;

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

public class ProductRegisterAction extends AbstractController {

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
				
			// 카테고리 목록을 조회해오기
			List<Map<String,String>> categoryList = adao.getCategoryList(request);
			
			request.setAttribute("categoryList", categoryList);
			
			//super.setRedirect(false);
		  	super.setViewPage("/WEB-INF/product/admin/productRegister.jsp");
				
			}	
			
			  else { // post이라면 // 파일을 첨부해서 보내는 폼태그 ==> cos.jar 라이브러리를 다운받아 사용
			  
			  MultipartRequest mtrequest = null;
			  
			 // 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다. 
			  ServletContext svlCtx = session.getServletContext(); 
			  String uploadFileDir = svlCtx.getRealPath("/image_ikea"); // 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir
			  
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
			  
			  // === 제품정보를 DB의 tbl_product 테이블에 insert ===
			  
			  // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
			  String fk_cnum = mtrequest.getParameter("fk_cnum"); 
			  String pname = mtrequest.getParameter("pname");
			  
			  // 업로드되어진 시스템의 첨부파일 이름(파일서버에 업로드 되어진 실제파일명)을 얻어 올때는 
			  // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
			  // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
			  
			  String pimage1 = mtrequest.getFilesystemName("pimage1");
			  
			  String price = mtrequest.getParameter("price"); 
			  String color = mtrequest.getParameter("color");
			  String stockdate = mtrequest.getParameter("stockdate"); 
			  String pqty = mtrequest.getParameter("pqty");
			  
			  String productSummary = mtrequest.getParameter("productSummary"); 
			  String productInfo = mtrequest.getParameter("productInfo");
			  
			  // 시큐어코드 작성하기 
			  productSummary = productSummary.replaceAll("<", "&lt;");
			  productSummary = productSummary.replaceAll(">", "&gt;");
			  
			  productInfo = productInfo.replaceAll("<", "&lt;"); 
			  productInfo = productInfo.replaceAll(">", "&gt;");
			  
			  // 입력한 내용에서 엔터는 <br>로 변환시키기 
			  productSummary = productSummary.replaceAll("\r\n", "<br>"); 
			  productInfo = productInfo.replaceAll("\r\n", "<br>");
			  
			  int pnum = adao.getPnumOfProduct(); // 제품번호 채번해오기
			  
			  ProductVO pvo = new ProductVO();
			  
			  pvo.setPnum(fk_cnum+Integer.toString(pnum));
			  pvo.setFk_cnum(fk_cnum);
			  pvo.setPname(pname); 
			  pvo.setProdimage(pimage1);
			  pvo.setPrice(Integer.parseInt(price)); 
			  pvo.setPqty(Integer.parseInt(pqty));
			  pvo.setColor(color); 
			  pvo.setPinpupdate(stockdate);
			  pvo.setPsummary(productSummary); 
			  pvo.setPcontent(productInfo);
			  
			  
			  String message = ""; String loc= "";
			  
			  
			  try { 
				  // tbl_product 테이블에 제품정보 insert 하기
				  adao.productInsert(pvo);
				  
				  // tbl_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 
				  
				  String str_attachCount = mtrequest.getParameter("attachCount");
				  
				  int attachCount = 0;
				  
				 // 파일을 최소 4개 이상 올려야 하는 유효성 검사를 뷰단에서 하기 때문에 값은 무조건 있다.
	             attachCount = Integer.parseInt(str_attachCount);
	             			  
				// 첨부파일의 파일명(파일서버에 업로드 되어진 실제파일명) 알아오기 
	             for(int i=0; i<attachCount; i++) {
	            	 
	            	 String attachFileName = mtrequest.getFilesystemName("attach"+i);
	            	 
	            	 adao.product_imagefile_Insert(pvo, attachFileName);
	            	 							// pnum 은 위에서 채번해온 제품번호이다.
	            	 
	             	}// end of for-------------------------
	             
				  message = "제품등록을 성공적으로 완료했습니다."; 
				  loc = request.getContextPath()+"/product/admin/productRegister.one"; 
			  }
			  catch(SQLException e){ 
				  e.printStackTrace(); message = "SQL오류로 제품등록을 실패했습니다.";
				  loc = request.getContextPath()+"/product/admin/productRegister.one"; 
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
