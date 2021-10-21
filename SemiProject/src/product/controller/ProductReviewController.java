package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO_kgh;
import product.model.ProductDAO_kgh;
import product.model.ProductReviewVO;

public class ProductReviewController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_pnum = request.getParameter("fk_pnum");
		
		// 제품 번호에 해당하는 제품의 리뷰 글 select 하기
		InterProductDAO_kgh pdao = new ProductDAO_kgh();
		List<ProductReviewVO> reviewList = pdao.reviewList(fk_pnum);
		
		JSONArray jsonArr = new JSONArray();
		
		if(reviewList != null && reviewList.size() > 0) {
			
			for(ProductReviewVO reviewvo : reviewList) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("review_seq", reviewvo.getReview_seq());
				jsobj.put("userid", reviewvo.getFk_userid());
				jsobj.put("title", reviewvo.getTitle());
				jsobj.put("content", reviewvo.getContent());
				jsobj.put("registerdate", reviewvo.getRegisterdate());
				
				jsonArr.put(jsobj);
			}
			
			// 현재 보고 있는 페이지
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			// 한 페이지에 보여줄 리뷰의 개수
			int sizePerPage = 5;
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			try {
				Integer.parseInt(currentShowPageNo);
			} catch (Exception e) {
				currentShowPageNo = "1";
			}
			
			// === 리뷰 글에 대한 페이지바 만들기 === //
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize는 블럭당 보여지는 페이지 번호의 개수
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수까지 증가하는 용도
			
			
			
		}
		
		
		String json = jsonArr.toString();
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
