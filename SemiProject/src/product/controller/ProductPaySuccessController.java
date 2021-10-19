package product.controller;

import java.sql.SQLException;
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

	// === 전표(주문코드)를 생성하는 메서드 생성하기 === //
	private String getOdrCode() throws SQLException {
		
		InterProductDAO_kgh pdao = new ProductDAO_kgh();
		
		String odrcode = pdao.getodrCode();
		
		return odrcode;
	}
	
	
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
			
			if(odcartno == "") {
				odcartno = null;
			}
			
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
	            
            // System.out.println(sumtotalprice);
            
            InterProductDAO_kgh pdao = new ProductDAO_kgh();
            
            HashMap<String, Object> paraMap = new HashMap<String, Object>();
            
            // 주문 테이블에 userid insert
            HttpSession session = request.getSession();
            MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
            
            // 주문 테이블에 insert
            paraMap.put("userid", loginuser.getUserid());
            
            String odrcode = getOdrCode();
            paraMap.put("odrcode", odrcode);
            
            paraMap.put("sumtotalprice", sumtotalprice);
            
            // 주문 상세 테이블에 insert
            paraMap.put("pnumArr", pnumArr);
            paraMap.put("oqtyArr", oqtyArr);
            paraMap.put("totalPriceArr", totalPriceArr);
            
            // 배송지 테이블에 insert
            paraMap.put("postcode", postcode);
            paraMap.put("address", address);
            paraMap.put("detailAddress", detailAddress);
            paraMap.put("extraAddress", extraAddress);
            paraMap.put("name", name);
            paraMap.put("email", email);
            paraMap.put("mobile", mobile);
            
            // 장바구니 테이블에 delete
            paraMap.put("odcartno", odcartno);

            
        	/// *** Transaction 처리해주는 메서드 *** //
        	int isSuccess = pdao.orderAdd(paraMap);
        	
        	JSONObject jsobj = new JSONObject();
        	
        	jsobj.put("isSuccess", isSuccess);
        	
        	if(isSuccess == 1) {
        		
        		System.out.println("주문 처리 성공");
        		
        		// 주문일자 가져오기
        		String orderdate = pdao.selectOrderDate(odrcode);
        		
        		System.out.println(orderdate);
        		
        		paraMap.put("orderdate", orderdate);
        		
        		// == 주문이 완료되면 email 발송 시작 == //
        		GoogleMail_kgh mail = new GoogleMail_kgh();
        		
        		mail.sendmail(loginuser.getEmail(), odrcode, orderdate, sumtotalprice);
        		// == 주문이 완료되면 email 발송 끝 == //
        		
        	}
        	else {
        		jsobj.put("isSuccess", 0);
        	}
            
            String json = jsobj.toString();
            request.setAttribute("json", json);
            
            super.setRedirect(false);
            super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		    
	}
			
}
