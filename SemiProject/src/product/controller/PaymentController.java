package product.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO_kgh;
import product.model.ProductDAO_kgh;
import product.model.ProductImageVO_kgh;
import product.model.ProductVO_kgh;

public class PaymentController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser != null) {
				
				String odpnum = request.getParameter("odpnum");
				String odoqty = request.getParameter("odoqty");
				String odcartno = request.getParameter("odcartno");
				String odtotalprice = request.getParameter("odtotalprice");
				
				int totalPrice = 0;
				int sumTotalPrice = 0;
				int VAT = 0;
				
				InterProductDAO_kgh pdao = new ProductDAO_kgh();
				List<ProductImageVO_kgh> odProdimgList = new ArrayList<>();
				ProductImageVO_kgh pimgVO = new ProductImageVO_kgh();
				
				if(odpnum.indexOf(",") >= 0) {
					String[] odpnumArr = odpnum.split(",");
					String[] odtotalpriceArr = odtotalprice.split(",");

					for (int i = 0; i < odpnumArr.length; i++) {
//						System.out.println(odpnumArr[i]);
//						System.out.println(odoqtyArr[i]);
//						System.out.println(odtotalpriceArr[i]);

						// 주문하려는 상품의 대표 이미지 가져오는 메소드 생성
						pimgVO = pdao.getProdImage(odpnumArr[i]);
						odProdimgList.add(pimgVO);
						
//						System.out.println(odProdImgList.get(i));
						
						totalPrice += Integer.parseInt(odtotalpriceArr[i]) * 0.9;
						VAT += Integer.parseInt(odtotalpriceArr[i]) * 0.1;
					}
					
					sumTotalPrice = totalPrice + VAT + 8000;
					
//					System.out.println(totalPrice);	
//					System.out.println(VAT);
//					System.out.println(sumTotalPrice);
					
				}
				else {
					
					// 주문하려는 상품의 대표 이미지 가져오는 메소드 생성
					pimgVO = pdao.getProdImage(odpnum);
					odProdimgList.add(pimgVO);
					
					
					totalPrice += Integer.parseInt(odtotalprice) * 0.9;
					VAT += Integer.parseInt(odtotalprice) * 0.1;
					sumTotalPrice += totalPrice + VAT + 8000;
					
//					System.out.println(totalPrice);	
//					System.out.println(VAT);
//					System.out.println(sumTotalPrice);
					
//					System.out.println(odProdImgList.toString());
					
				}
				
				// 배송 예정일 구하기
				Date date = new Date();
				SimpleDateFormat sdformat = new SimpleDateFormat("yyyy.MM.dd");
				
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				
				cal.add(Calendar.DATE, 3);
				String shipmentDate = sdformat.format(cal.getTime());
				
				
				request.setAttribute("odProdimgList", odProdimgList);
				request.setAttribute("totalPrice", totalPrice);
				request.setAttribute("VAT", VAT);
				request.setAttribute("sumTotalPrice", sumTotalPrice);
				request.setAttribute("shipmentDate", shipmentDate);
				
			//	System.out.println(sumTotalPrice);
				
				request.setAttribute("loginuser", loginuser);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/payment.jsp");
			}
			else {
				// 로그인을 안했으면
				String message = "상품 구매를 하기 위해서는 먼저 로그인을 하세요!!";
		        String loc = "javascript:history.back()";
				
		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		        
//		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		
		}
		else {
			// 로그인한 사용자가 다른 사용자의 정보를 통해 구매할 경우
			String message = "비정상적인 접근은 불가합니다.!!";
            String loc = "javascript:history.back()";
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
       //   super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
            return;
		}
		
	}

	
	
}
