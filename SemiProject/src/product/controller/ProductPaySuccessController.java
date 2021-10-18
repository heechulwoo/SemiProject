package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO_kgh;
import product.model.ProductDAO_kgh;

public class ProductPaySuccessController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String mobile = request.getParameter("mobile");
			
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");
			
			String odpnum = request.getParameter("odpnum");
			String odoqty = request.getParameter("odoqty");
			String odcartno = request.getParameter("odcartno");
			String odtotalprice = request.getParameter("odtotalprice");
			
			String sumtotalprice = request.getParameter("sumtotalprice");
			
			JSONObject jsobj = new JSONObject();
			String json = "";
			
			// 장바구니에서 주문할 경우(장바구니 번호가 존재)
		    if(odpnum != null && 
		       odoqty != null && 
		       odcartno != null && 
		       odtotalprice != null && 
		       sumtotalprice != null) {
		    
		    	
		    	// ===== Transaction 처리하기 ===== // 
	            // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
	            // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	            // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	            // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
	            // 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
	            // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	            // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	            // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
	        
	            // === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
	            // === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === // 
		    	
		    	String[] pnumArr = odpnum.split(",");	// "3,56,59" ==> [3,56,59]
		    											
		    	String[] oqtyArr = odoqty.split(",");
	            String[] totalPriceArr = odtotalprice.split(",");
		    /*	
	            for(int i=0; i<pnumArr.length; i++) {
	                System.out.println("~~~~ 확인용 pnum: " + pnumArr[i] + ", oqty: " + oqtyArr[i] + ", totalPrice: " + totalPriceArr[i]); 
	            }
	        */   
	            
	            InterProductDAO_kgh pdao = new ProductDAO_kgh();
	            
	            HashMap<String, Object> paraMap = new HashMap<String, Object>();
	            paraMap.put("pnumArr", pnumArr);
	            paraMap.put("oqtyArr", oqtyArr);
	            paraMap.put("totalPriceArr", totalPriceArr);
	            paraMap.put("odcartno", odcartno);
	            paraMap.put("sumtotalprice", sumtotalprice);
	            
	            HttpSession session = request.getSession();
	            MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	            paraMap.put("userid", loginuser.getUserid());
	            
	            // 주문코드(명세서번호) 채번하기
	            
	            // Transaction 처리를 해주는 메소드 
	            // int isSuccess = pdao.orderAdd(paraMap);
	            
	            // jsobj.put("isSuccess", isSuccess);
	            
	        	// **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고
	            //      이어서 주문이 완료되었다라는 email 보내주기  **** //
	       /*     if(isSuccess == 1) {
	            	
	            	// 세션에 저장되어져 있는 loginuser 정보를 갱신
	            	
	            	////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
	            	
	            	
	            	////////// === 주문이 완료되었다는 email 보내기 끝 === ///////////
	            }
	       */     
		    }
		    
		    // 제품 상세정보 페이지에서 바로 주문할 경우(장바구니 번호 존재 X)
		    else if(odpnum != null && 
				    odoqty != null && 
				    odcartno == null && 
				    odtotalprice != null && 
				    sumtotalprice != null) {
		 	
		    	
		    	// ===== Transaction 처리하기 ===== // 
	            // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
	            // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	            // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	            // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
	            // 5. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	            // 6. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	            // 7. **** SQL 장애 발생시 rollback 하기(rollback) **** 
	        
	            // === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
	            // === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === // 
		    	
		    	String[] pnumArr = odpnum.split(",");	// "3" ==> [3]
														
				String[] oqtyArr = odoqty.split(",");
				String[] totalPriceArr = odtotalprice.split(",");
			/*	
				for(int i=0; i<pnumArr.length; i++) {
					System.out.println("~~~~ 확인용 pnum: " + pnumArr[i] + ", oqty: " + oqtyArr[i] + ", totalPrice: " + totalPriceArr[i]); 
				}
		    */	
		    	
		 	}
		    else {
		    	jsobj.put("isSuccess", 0);
		    }
		    
		    json = jsobj.toString();
		    request.setAttribute("json", json);
		    
		    super.setRedirect(false);
		    super.setViewPage("/WEB-INF/jsonview.jsp");
		    
		}
			
		
	/*	
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		
		InterProductDAO_kgh pdao = new ProductDAO_kgh();
		
		// 주문 테이블에 주문내역 insert하고 주문번호 select 하기
		String odrCode = pdao.insertOrder(userid, sumTotalPrice);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("odrCode", odrCode);
		paraMap.put("odrName", odrName);
		paraMap.put("odrMobile", odrMobile);
		paraMap.put("odrPostcode", odrPostcode);
		paraMap.put("odrAddress", odrAddress);
		paraMap.put("odrDetailAddress", odrDetailAddress);
		paraMap.put("odrExtraAddress", odrExtraAddress);
		
		
		Map<String, String> odrparaMap = new HashMap<>();
		odrparaMap.put("odrCode", odrCode);
		
		
		if(odrCode.length() > 0) {
			
			// 해당 주문번호를 통해 배송지 insert하기
			pdao.insertAddress(paraMap);
			
			if(odpnum.indexOf(",") >= 0) {
				String[] odpnumArr = odpnum.split(",");
				String[] odoqtyArr = odoqty.split(",");
				String[] odtotalpriceArr = odtotalprice.split(",");
				String[] odcartnoArr = odcartno.split(",");

				for (int i = 0; i < odpnumArr.length; i++) {
					String odpnumIndex = odpnumArr[i];
					String odoqtyIndex = odoqtyArr[i];
					String odcartnoIndex = odtotalpriceArr[i];

					odrparaMap.put("odpnumIndex", odpnumIndex);
					odrparaMap.put("odoqtyIndex", odoqtyIndex);
					odrparaMap.put("odcartnoIndex", odcartnoIndex);
					
					// 주문상세 테이블에 주문 상세내역 insert 하기
					int n = pdao.insertOrderDetail(odrparaMap);
	
					// 제품 테이블의 재고 수량 update 하기
					pdao.updatePqty(odpnumIndex, odoqtyIndex);
					
					// 장바구니에 해당 하는 상품 목록 delete 하기
					pdao.deleteCartno(odcartnoIndex);
				}
				
			}
	}
			
		*/	
			
		
	}

}
