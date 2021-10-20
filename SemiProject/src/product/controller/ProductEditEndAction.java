package product.controller;

import java.io.IOException;

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
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ProductEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null && "admin".equals(loginuser.getUserid()) ) {
				
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
					request.setAttribute("loc", request.getContextPath()+"/index.one");
				 
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
				if(pimage1 == null) {
					pimage1 = mtrequest.getParameter("beforeProdimage");
				}
				
				String price = mtrequest.getParameter("price"); 
				String color = mtrequest.getParameter("color");
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
				
				String pnum = mtrequest.getParameter("pnum");
				
				ProductVO pvo = new ProductVO();
				
				pvo.setPnum(pnum);
				pvo.setFk_cnum(fk_cnum);
				pvo.setPname(pname); 
				pvo.setProdimage(pimage1);
				pvo.setPrice(Integer.parseInt(price)); 
				pvo.setPqty(Integer.parseInt(pqty));
				pvo.setColor(color); 
				pvo.setPsummary(productSummary); 
				pvo.setPcontent(productInfo);
				
				
				String message = ""; String loc= "";
				
				
				// tbl_product 테이블에 제품정보 update 하기
				InterProductDAO pdao = new ProductDAO();
				InterAdminDAO adao = new AdminDAO();
				pdao.updateProduct(pvo);
				 
				// tbl_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 
		  		String lastimg = mtrequest.getFilesystemName("lastimg");
		  		 
		  		String str_attachCount = mtrequest.getParameter("attachCount");
		  		int attachCount = 0;
		  		
		  		if( !"".equals(str_attachCount) ) {
		  			attachCount = Integer.parseInt(str_attachCount);
		  		}
		  		 
		  		String str_beforeLastIndex = mtrequest.getParameter("beforeLastIndex");
		  		int beforeLastIndex = 0;
		  		 
		  		if( !"".equals(str_beforeLastIndex) ) {
		  			beforeLastIndex = Integer.parseInt(str_beforeLastIndex);
		  		}
		  		 
				if(lastimg != null && attachCount > 0) { // 제품사이즈 이미지 변경이 있고 나머지 이미지변경도 있는 경우
					 // pnum에 해당하는 추가이미지파일 모두 지우고 새로 insert 전부 해주기
					pdao.deleteImages(pnum);
					 
					for(int i=0; i<attachCount; i++) {
						String attachFileName = mtrequest.getFilesystemName("attach"+i);
			          	 
			          	adao.product_imagefile_Insert(pvo, attachFileName);
			          	 
			        }// end of for-------------------------
					adao.product_imagefile_Insert(pvo, lastimg);
					 
				} else if(lastimg != null && attachCount == 0) { // 제품사이즈 이미지 변경이 있고 나머지 이미지변경이 없는 경우
					// pnum에 해당하는 추가이미지파일 모두 지우고 새로 insert 전부 해주기
					pdao.deleteImages(pnum);
					 
					for(int i=1; i<beforeLastIndex; i++) { 
			         	String attachFileName = mtrequest.getParameter("beforeImage"+i);
			          	 
			          	adao.product_imagefile_Insert(pvo, attachFileName);
			          	 
			        }// end of for-------------------------
					adao.product_imagefile_Insert(pvo, lastimg);
					 
				} else if(lastimg == null && attachCount > 0) { // 제품사이즈 이미지 변경이 없고 나머지 이미지변경한 경우
					lastimg = mtrequest.getParameter("beforelastImage");
					// pnum에 해당하는 추가이미지파일 모두 지우고 새로 insert 전부 해주기
					pdao.deleteImages(pnum);
					 
					for(int i=0; i<attachCount; i++) {
			         	String attachFileName = mtrequest.getFilesystemName("attach"+i);
			          	 
			          	adao.product_imagefile_Insert(pvo, attachFileName);
			          	 
			        }// end of for-------------------------
					adao.product_imagefile_Insert(pvo, lastimg);
				} 
		           
				message = "제품수정을 성공적으로 완료했습니다."; 
				loc = request.getContextPath()+"/index.one"; 
				
				
				request.setAttribute("message", message); 
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
				}
				
			}
			
		else {
			// **** POST 방식으로 넘어온 것이 아니라면 **** //
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
		
	

}
