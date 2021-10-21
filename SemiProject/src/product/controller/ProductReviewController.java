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
		
		String pageBar = "";
		
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
			
			// 한 페이지에 보여줄 리뷰의 개수
			int sizePerPage = 5;
			
			// 전체 페이지 개수
			int totalPage = 0;
			
			// DB에서 특정 제품(fk_pnum)에 대한 리뷰의 총 개수 알아오기(select)
			int totalCountReviews = pdao.getTotalCountReviews(fk_pnum);
			
			totalPage = (int)Math.ceil((double)totalCountReviews / sizePerPage);
			
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			int currentShowPageNo = 0;
			
			try {
				if(str_currentShowPageNo == null) {
					currentShowPageNo = 1;
				}
				else {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
					
					if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
			
			// === 리뷰 글에 대한 페이지바 만들기 === //
			String url = "productReview.one";
			
			int blockSize = 10;
			// blockSize는 블럭당 보여지는 페이지 번호의 개수
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수까지 증가하는 용도
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			// *** [맨처음][이전] 만들기 *** //
			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
	            pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while(!(loop > blockSize || pageNo > totalPage)) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='" + url + "?currentShowPageNo=" + pageNo + "'>"+pageNo+"</a></li>";
				}
				
				loop++;
				pageNo++;
			}
			
			// *** [다음][마지막] 만들기 *** // 
	        if( pageNo <= totalPage ) {
	            pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	            pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	        }
	        
	        request.setAttribute("pageBar", pageBar);
			
		}
		
		
		String json = jsonArr.toString();
		
		request.setAttribute("json", json);
		request.setAttribute("pageBar", pageBar);
		
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
