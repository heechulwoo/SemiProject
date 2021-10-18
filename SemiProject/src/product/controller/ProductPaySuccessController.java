package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO_kgh;
import product.model.ProductDAO_kgh;

public class ProductPaySuccessController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String odpnum = request.getParameter("odpnum");
		String odoqty = request.getParameter("odoqty");
		String odcartno = request.getParameter("odcartno");
		String odtotalprice = request.getParameter("odtotalprice");
		String sumTotalPrice = request.getParameter("sumTotalPrice");
		
		String odrName = request.getParameter("odrName");
		String odrMobile = request.getParameter("odrMobile");
		String odrPostcode = request.getParameter("postcode");
		String odrAddress = request.getParameter("address");
		String odrDetailAddress = request.getParameter("detailAddress");
		String odrExtraAddress = request.getParameter("extraAddress");
		
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
		
	}

}
