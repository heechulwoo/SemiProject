<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<%
	String ctxPath = request.getContextPath();
%>  

    
<jsp:include page="../header.jsp"/>

<style type="text/css">

	
	a {text-decoration: none;
	   font-weight: normal;
	   color: black;}

	
	
	#accordion {
		  background-color: white;
		  cursor: pointer;
		  border: none;
		  text-align: left;
		  outline: none;
		  font-size: 18pt;
		  font-weight: bolder;
		  transition: 0.4s;
		  text-decoration: underline;
	}
	
</style>

<script	type="text/javascript">

	$(document).ready(function() {
		
	});
	
	// === 제품 색상 선택하기 함수 === //
	function goEditPersonal() {
		
		// 나의 정보 수정하기 팝업창 띄우기 
	    var url = "<%= request.getContextPath()%>/product/eachProductColor.one";
	     
	    // 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
	    var pop_width = 450;
	    var pop_height = 700;
	    var pop_left = Math.ceil( (window.screen.width - pop_width) / 2 ); 		// 정수로 형변환
	    var pop_top  = Math.ceil( (window.screen.height - pop_height) / 2 );	// 정수로 형변환
	    
	    window.open(url, "colorEdit",
	                "left=" + pop_left + ", top=" + pop_top + ", width=" + pop_width + ", height=" + pop_height);
	 }

</script>

<div class="container-fluid">
	<h6 class="my-3 py-2 px-5 ml-3" style="font-size: 10pt;"><a href="<%= ctxPath%>/index.one">제품</a> > <a href="<%= ctxPath%>/product/productAll.one">의자</a> > <a href="#">스툴의자</a> > ${requestScope.pvo.pname}</h6>
	
	<div class="container-fluid mx-2 px-5">
		<div class="row my-2">
			<div class="col-12 col-lg-7 mx-2">
				<div class="row justify-content-between ">
					<c:if test="${not empty pimgList}">
						<c:forEach var="pimgList" items="${requestScope.pimgList}">
							<div class="col-6 col-md-6 mx-0 my-3"><img src="<%= ctxPath%>/image_ikea/${pimgList.imgfilename}" style="width: 95%;"/></div>
						</c:forEach>
					</c:if>
				<%-- 
					<div class="col-6 col-md-6 mx-0 my-3"><img src="<%= ctxPath%>/image_ikea/마리우스_화이트1.webp" style="width: 95%;"/></div>
					<div class="col-6 col-md-6 mx-0 my-3"><img src="<%= ctxPath%>/image_ikea/마리우스_화이트2.webp" style="width: 95%;"/></div>
					<div class="col-6 col-lg-6 mx-0 my-3"><img src="<%= ctxPath%>/image_ikea/마리우스_화이트3.webp" style="width: 95%;"/></div>
					<div class="col-6 col-lg-6 mx-0 my-3"><img src="<%= ctxPath%>/image_ikea/마리우스_화이트4.webp" style="width: 95%;"/></div>				
				--%>	
				</div>
			</div>
			<div class="col-9 col-lg-4 ml-5 pl-4 my-4" style="float: right; width: 30%;">
				<div class="row justify-content-between">
					<div class="col-7"><h5 id="pname" style="font-weight: bold;">${requestScope.pvo.pname}</h5></div>
					<div class="col-4"><h5 id="price" style="font-weight: bold;">${requestScope.pvo.price}원</h5></div>
				</div>
				<div>
					<span style="font-size: 10pt">${requestScope.pvo.categvo.cname}, ${requestScope.pvo.color}</span>
					<br>
					<hr>
					<a href="javascript:goEditPersonal();" class="btn btn-outline-light btn-lg" style="font-weight: bold;">색상</a><br>
					<div class="radio mt-3 mb-2" style="font-size: 10pt;">
					  <label class="mr-1" ><input class="mr-2" type="radio" name="optradio" checked>${requestScope.pvo.color}</label>
					  <span class="rounded-circle mr-5" id="colorbox" style="background-color: #f2f2f2;"></span><br>
					</div>
					<br><br>
					<button class="btn btn-primary btn-lg" style="width: 300px; height: 50px; font-weight: bold;" >구매하기</button>
					<button class="ml-2 btn btn-primary btn-light" style="width: 70px;  height: 50px"><i class="far fa-heart"></i></button>
					<br><br><br>
					<i class="mr-2 fas fa-truck"></i>
					<span style="font-size: 11pt;">결제시 배송 옵션보기</span>
					<br>
					<hr>
					<i class="mr-2 fas fa-store"></i>
					<a href="#" data-toggle="modal" data-target="#myModal" style="font-size: 11pt; font-weight: bold; text-decoration: underline;">매장 재고 확인</a>
						<div class="container">
						
						  <!-- The Modal -->
						  <div class="modal" id="myModal">
						    <div class="modal-dialog">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div class="modal-header">
						          <h5 class="modal-title" style="font-weight: bold;">지점별 현재 제품 보유 현황</h5>
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						        </div>
						        
						        <!-- Modal body -->
						        <div class="modal-body my-3">
						          	<span style="font-weight: bold;">고양점</span><br>
						          	<span style="font-size: 10pt">덕양구 권율대로 420, 고양시</span><br>
						          	<span style="font-size: 10pt; font-weight: bold; color: green;">재고 있음</span>
						          	<hr class="my-3">
						          	<span style="font-weight: bold;">고양점</span><br>
						          	<span style="font-size: 10pt">덕양구 권율대로 420, 고양시</span><br>
						          	<span style="font-size: 10pt; font-weight: bold; color: green;">재고 있음</span>
						          	<hr class="my-3">
						          	<span style="font-weight: bold;">고양점</span><br>
						          	<span style="font-size: 10pt">덕양구 권율대로 420, 고양시</span><br>
						          	<span style="font-size: 10pt; font-weight: bold; color: green;">재고 있음</span>
						        </div>
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
						  
						</div>				</div>
			</div>
		</div>
		
		
		<div class="my-5 mx-3 px-4">
			<h5 class="my-3" style="width: 55%;">${requestScope.pvo.psummary}</h5><br>
			<h6><span style="font-size: 10pt; font-weight: bold;">제품 번호</span></h6>
			<span class="mt-0 pt-0 badge badge-dark" id="productNo">${requestScope.pvo.pnum}</span>
		</div>
		<hr>
		<div class="my-4 mx-3 px-4">
			<a href="demo1" class="my-4 ml-2" id="accordion" data-toggle="collapse" data-target="#demo1">제품 설명</a>
			<a href="demo1" class="ml-1 mb-2" data-toggle="collapse" data-target="#demo1" ><i class="fas fa-plus"></i></a>
			<div id="demo1" class="collapse">
			   <p class="ml-3 my-3" style="width: 50%;">
			   		${requestScope.pvo.pcontent}
			<%-- 고밀도폼을 사용하여 오랫동안 의자를 편안하게 사용할 수 있어요.<br><br>
				 의자의 높이를 조절하여 편안하게 앉을 수 있습니다.<br><br>
				 안전바퀴가 압력 감지 잠금 메커니즘을 갖추고 있어 일어나면 안전하게 고정되고, 앉으면 자동으로 잠금이 해제됩니다.<br><br>
				 가정용 적합성 테스트를 한 제품입니다.<br><br>
				 부드러운 바닥에서 사용하는 바퀴입니다.<br>
			  --%>
			  </p>
			</div>
			  
			<hr>
			
			<a href="demo2" class="my-4 ml-2" id="accordion" data-toggle="collapse" data-target="#demo2">제품 크기</a>
			<a href="demo2" class="ml-1 mb-3" data-toggle="collapse" data-target="#demo2" ><i class="fas fa-plus"></i></a>
			<div id="demo2" class="collapse my-3">
			  	<div class="row">
			  		<div class="col-9 col-lg-3">
			  			<c:if test="${not empty pimgList}">
							<c:forEach begin="3" end="3" var="pimgList" items="${requestScope.pimgList}">
					  	 		<img src="<%= ctxPath%>/image_ikea/${pimgList.imgfilename}" style="width: 100%;"/>
			  				</c:forEach>
			  			</c:if>
			 		</div>
			 	</div>
			</div>
			<hr>
			
			<button class="my-3" id="accordion">상품평</button>
			<br><br>
			<h5 class="my-2 px-2" style="font-weight: bold;">유사한 제품</h5><br>
			
			<div class="container-fluid">
			
				<div class="row justify-content-start my-2" align="center">
					<c:if test="${not empty sameProductList}">
						<c:forEach var="sameProductVO" items="${requestScope.sameProductList}">
							<div class="col-6 col-lg-2 px-0 my-3">
								<a href="<%= ctxPath%>/product/eachProduct.one?pnum=${sameProductVO.pnum}"><img class="my-1" src="<%= ctxPath%>/image_ikea/${sameProductVO.prodimage}" style="width: 90%;"/></a><br>
								<a href="#" style="font-weight: bold; color: black; text-align: center;">${sameProductVO.pname}</a><br>
								<span>${sameProductVO.price}</span>
							</div>
						</c:forEach>
					</c:if>
			<%--		
					<div class="col-6 col-lg-2 px-0 my-3">
						<a href="#"><img class="my-1" src="/SemiProject1/image_ikea/잉올프_앤티크스테인1.webp" style="width: 90%;"/></a><br>
						<a href="#" style="font-weight: bold; color: black; text-align: center;">INGOLF 잉올프</a><br>
						<span>49,900원</span>
					</div>
					<div class="col-6 col-lg-2 px-0 my-3">
						<a href="#"><img class="my-1" src="/SemiProject1/image_ikea/닐솔레_자작나무1.webp" style="width: 90%;"/></a><br>
						<a href="#" style="font-weight: bold; color: black; text-align: center;">NILSOLLE 닐솔레</a><br>
						<span>49,900원</span>
					</div>
					<div class="col-6 col-lg-2 px-0 my-3">
						<a href="#"><img class="my-1" src="/SemiProject1/image_ikea/쉬레_자작나무1.webp" style="width: 90%;"/></a><br>
						<a href="#" style="font-weight: bold; color: black; text-align: center;">KYRRE 쉬레</a><br>
						<span>14,900원</span>
					</div>
					<div class="col-6 col-lg-2 px-0 my-3">
						<a href="#"><img class="my-1" src="/SemiProject1/image_ikea/쿨라베리_브라운1.webp" style="width: 90%;"/></a><br>	
						<a href="#" style="font-weight: bold; color: black; text-align: center;">KULLABERG 쿨라베리</a><br>
						<span>59,000원</span>
					</div>
				</div>
			 --%>
			</div>
			<br><br><hr><br><br><br>
			
		</div>
	</div>
</div>
</div>
<jsp:include page="../footer.jsp"/>