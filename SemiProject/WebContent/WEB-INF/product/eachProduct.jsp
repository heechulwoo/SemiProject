<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<%
	String ctxPath = request.getContextPath();
%>  

    
<jsp:include page="../header_kgh.jsp"/>

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
	
	.buttonClick {
		background-color: #ff1a1a;
		color: white;
	}
	
	div#productReview {
		width: 100%;
		text-align: left;
		max-height: 250px;
		overflow: auto;
	}
	
</style>

<script	type="text/javascript">

	$(document).ready(function() {
		
		goProductReview()
		
		var pnum = "${requestScope.pvo.pnum}";
		
		var localWishList = JSON.parse(localStorage.getItem('wishlist'));
		
		if(JSON.parse(localStorage.getItem('wishlist')) != null && JSON.parse(localStorage.getItem('wishlist')).indexOf(pnum)>=0 ){
			   $("button#prdWishList").addClass("buttonClick");
		}
		
		// 제품 수량에 spinner 달아주기
		$("input#spinnerPqty").spinner({
			spin:function(event,ui){
	            if(ui.value > 100) {
	               $(this).spinner("value", 100);
	               return false;
	            }
	            else if(ui.value < 1) {
	               $(this).spinner("value", 1);
	               return false;
	            }
			}
		});// end of $("input#spinnerPqty").spinner({ })
		
		// 위시리스트 추가하기 함수
		$("button#prdWishList").click(function() {
			
			var pnum = "${requestScope.pvo.pnum}";
			
			var localWishList = JSON.parse(localStorage.getItem('wishlist'));
			
			if(localWishList == null) {
				alert("위시리스트에 저장되었습니다.");
				localWishList = [];
				localWishList.push(pnum);
			//	("button#prdWishList").addClass("buttonClick");
				$("button#prdWishList").addClass("buttonClick");
			}
			else {
				var index = localWishList.indexOf(pnum);
				if(index >= 0) {
					localWishList.splice(index, 1);
					alert("위시리스트를 제거합니다.");
				//	("button#prdWishList").removeClass("buttonClick");
					$("button#prdWishList").removeClass("buttonClick");
				}
				else {
					alert("위시리스트에 저장되었습니다.");
					localWishList.push(pnum);
				//	("button#prdWishList").addClass("buttonClick");
					$("button#prdWishList").addClass("buttonClick");
				}
			}
			
			localStorage.setItem("wishlist", JSON.stringify(localWishList));
			
		});// end of $("button#prdWishList").click(function() {})
		
		// 장바구니 추가하기 함수
		$("button#shopBasketList").click(function() {
			var loginuser = "${sessionScope.loginuser}";
	        if (loginuser != "") {
	            
	            var pnum = ${requestScope.pvo.pnum};
	            var pqty = $("input#spinnerPqty").val();
	            
	            var regExp = /^[0-9]+$/;
	            var bool = regExp.test(pqty);
	            
	            if(!bool) {
	            	alert("주문 개수는 1개 이상이어야 합니다.");
	            	return;
	            }
	            
	            if(pqty < 1) {
	            	alert("주문 개수는 1개 이상이어야 합니다.");
	            	return;
	            }
	            
	            $.ajax({
	               url:"/SemiProject/product/saveCartJSON.one",
	               type:"POST",
	               data:{"pnum":pnum
	                  , "pqty":pqty
	                  }, 
	               success:function() { // 콜백함수
	                  alert("장바구니에 추가했습니다.");
	               },
	               error: function(request, status, error){
	                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                 }
	            });
	         }
	         else {
	            alert("장바구니 기능은 로그인이 필요합니다.");
	            location.href="<%=ctxPath%>/login/login.one";
	         }

		});// end of $("button#shopBasketList").click(function() {})
		
		// 구매하기 버튼을 클릭할 때 구매창으로 넘어가는 함수
		$("button#productBuy").click(function() {
			
			// alert("구매버튼 확인용");
			var odoqty = $("input#spinnerPqty").val()
			var totalp = ${requestScope.pvo.price} * odoqty;
			console.log(totalp);
			
			
			var loginuser = "${sessionScope.loginuser}";
	        if (loginuser != "") {
	            
	        	var frm = document.orderFrm;
	            frm.odpnum.value = ${requestScope.pvo.pnum};
	            frm.odoqty.value = odoqty;
	            frm.odtotalprice.value = totalp;
	            
	            console.log(frm.odpnum.value);
	            console.log(frm.odoqty.value);
	            console.log(frm.odtotalprice.value);
	            
	            var regExp = /^[0-9]+$/;
	            var bool = regExp.test(odoqty);
	            
	            if(!bool) {
	            	alert("주문 개수는 1개 이상이어야 합니다.");
	            	return;
	            }
	            
	            if(odoqty < 1) {
	            	alert("주문 개수는 1개 이상이어야 합니다.");
	            	return;
	            }
	            else if(odoqty > ${requestScope.pvo.pqty}) {
	            	alert("재고량보다 더 많은 수량은 구매가 불가합니다.");
	            	return;
	            }
	            
	            
	        	var bool = confirm("결제를 진행하시겠습니까?");
	        	
	        	if(bool) {
	        		
	        		frm.method = "POST";
	        	    frm.action = "<%= request.getContextPath()%>/product/payment.one";
	        	    frm.submit();
	        	}
	            
	        }
	        else {
	        	alert("구매를 이용할 때 로그인이 필요합니다.");
	        	location.href="<%=ctxPath%>/login/login.one";
	        }
		});
		
	});// end of $(document).ready(function() {})
	
	// == Function Declaration == //
	// === 제품 색상 선택하기 팝업창 함수 === //
	function goEditPersonal() {
		
		var pname = $("h5#pname").text();
		
		// 상품 이름의 " " 위치 추출하기
		var index = pname.indexOf(" ");
		
		// 상품 이름의 한글 부분만 추출하기
		var pname_kor = pname.substring(index+1);
		
		// 제품 색상 선택 팝업창 띄우기 
	    var url = "<%= request.getContextPath()%>/product/eachProductColor.one?pname=" + pname_kor;
	     
	    // 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
	    var pop_width = 450;
	    var pop_height = 700;
	    var pop_left = Math.ceil( (window.screen.width - pop_width) / 2 ); 		// 정수로 형변환
	    var pop_top  = Math.ceil( (window.screen.height - pop_height) / 2 );	// 정수로 형변환
	    
	    window.open(url, "colorEdit",
	                "left=" + pop_left + ", top=" + pop_top + ", width=" + pop_width + ", height=" + pop_height);
	 }
	
	// 팝업창에서 색상 클릭시 해당 제품 페이지로 이동하는 함수
	function goProductPage(pnum) {
		
		location.href="<%=ctxPath%>/product/eachProduct.one?pnum=" + pnum;
		
	} 
	
	// 리뷰를 보여주는 함수
	function goProductReview() {
		$.ajax({
			url:"<%= ctxPath%>/product/productReview.one",
			type:"GET",
	        data:{"fk_pnum":"${requestScope.pvo.pnum}"},
			dataType:"JSON",
			success:function(json) {
				var html = "<table class='table col-12'>"
			    			+"<thead>"
						      +"<tr>"
						        +"<th>번호</th>"
						        +"<th>글제목</th>"
						        +"<th>글내용</th>"
						        +"<th>작성일자</th>"
						      +"</tr>"
						    +"</thead>"
			    			+"<tbody>";
				
				console.log(json);
				console.log(json.length);
				if(json.length > 0) {
					$.each(json, function(index, item) {
						
						html += "<tr>"
							        +"<td>" + item.review_seq + "</td>"
							        +"<td>" + item.title + "</td>"
							        +"<td>" + item.content + "</td>"
							        +"<td>" + item.registerdate + "</td>"
							    "</tr>";
					});
				}
				else {
					html += "<tr class='text-center'>"
							  +"<td colspan='4'>등록된 상품 후기가 없습니다.</td>"
						   +"</tr>";
				}
				
				html += "</tbody>"
				  	+"</table>";
				
				  	$("div#productReview").html(html);
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}
	
</script>

<div class="container-fluid">
	<h6 class="my-3 py-2 px-5 ml-3" style="font-size: 10pt;"><a href="<%= ctxPath%>/index.one">제품</a> > <a href="<%= ctxPath%>/product/productAll.one">의자</a> > <a href="<%= ctxPath%>/product/productByCategory.one?cnum=${requestScope.pvo.fk_cnum}">${requestScope.pvo.categvo.cname}</a> > ${requestScope.pvo.pname}</h6>
	
	<div class="container-fluid mx-2 px-5">
		<div class="row my-2">
			<div class="col-12 col-lg-7 mx-2">
				<div class="row justify-content-between ">
					<c:if test="${not empty pvo}">
						<div class="col-6 col-md-6 mx-0 my-3"><img src="<%= ctxPath%>/image_ikea/${pvo.prodimage}" style="width: 95%;"/></div>
					</c:if>
					<c:if test="${not empty pimgList}">
						<c:forEach var="pimgList" items="${requestScope.pimgList}">
							<c:if test="${not empty pimgList.imgfilename}">
								<div class="col-6 col-md-6 mx-0 my-3" style="display: flex; align-items: center;"><img src="<%= ctxPath%>/image_ikea/${pimgList.imgfilename}" style="width: 95%;"/></div>
							</c:if>
						</c:forEach>
					</c:if>
				
				</div>
			</div>
			<div class="col-9 col-lg-4 ml-5 pl-4 my-4" style="float: right; width: 30%;">
				<div class="row justify-content-between">
					<div class="col-7"><h5 id="pname" style="font-weight: bold;">${requestScope.pvo.pname}</h5></div>
					<div class="col-5"><h5 id="price" class="text-left" style="font-weight: bold;"><fmt:formatNumber  value="${requestScope.pvo.price}"/>&nbsp;원</h5></div>
				</div>
				<div>
				
				<form name="orderFrm">
					<span style="font-size: 10pt">${requestScope.pvo.categvo.cname}, ${requestScope.pvo.color}</span>
					<br>
					<hr>
					<input type="hidden" name="odpnum" value="${requestScope.pvo.pnum}"/>
					<input type="hidden" id="odtotalprice" name="odtotalprice" value="" />
					<a href="javascript:goEditPersonal();" class="btn btn-outline-light btn-lg" style="font-weight: bold;">색상</a><br>
					<div class="radio mt-3 mb-2" style="font-size: 10pt;">
					  <label class="mr-1"><input class="mr-2" type="radio" name="optradio" checked>${requestScope.pvo.color}</label>
					</div>
					<input class="mb-2 mt-1" id="spinnerPqty" name="odoqty" value="1" style="width: 40px; height: 20px;">개<br>
					<br>
				</form>
					<c:set var="pvoPqty" value="${requestScope.pvo.pqty}" />
					
					<c:choose>
						<c:when test="${pvoPqty eq 0}">
							<button id="buyButton" class="btn btn-secondary btn-lg mb-3" disabled="disabled" style="width: 270px; height: 50px; font-weight: bold;" >품절</button>
						</c:when>
						<c:otherwise>
							<button id="productBuy" class="btn btn-primary btn-lg mb-3" style="width: 270px; height: 50px; font-weight: bold;" >구매하기</button>
						</c:otherwise>
					</c:choose>
					
					<c:choose>
						<c:when test="${pvoPqty eq 0}">
							<button id="shopBasketList" class='ml-2 btn btn-outline-secondary mb-3 btn-sm savecart' disabled="disabled" style="width: 70px;  height: 50px"><i class='fa fa-shopping-cart fa-lg'></i></button>
						</c:when>
						<c:otherwise>
							<button id="shopBasketList" class='ml-2 btn btn-outline-success mb-3 btn-sm savecart' style="width: 70px;  height: 50px"><i class='fa fa-shopping-cart fa-lg'></i></button>
						</c:otherwise>
					</c:choose>
									
					<c:choose>
						<c:when test="${pvoPqty eq 0}">
							<button id="prdWishList" class="ml-2 btn btn-outline-secondary mb-3 btn-light" disabled="disabled" style="width: 70px;  height: 50px"><i class="far fa-heart fa-lg"></i></button>
						</c:when>
						<c:otherwise>
							<button id="prdWishList" class="ml-2 btn btn-outline-danger mb-3 btn-light" style="width: 70px;  height: 50px"><i class="far fa-heart fa-lg"></i></button>
						</c:otherwise>
					</c:choose>
					
					<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
						<button id="" class="btn btn-warning btn-lg mb-3" onclick="location.href='<%= ctxPath%>/product/admin/productEdit.one?pnum=${requestScope.pvo.pnum}'" style="width: 270px; height: 50px; font-weight: bold;" >제품 수정</button>
					</c:if>
					
					<br><br><br>
					<i class="mr-2 fas fa-truck"></i>
					<span style="font-size: 11pt;">배송 옵션은 결제 단계에서 확인 가능합니다</span>
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
						          	<c:set var="pvo" value="${requestScope.pvo}"/>
						          	
						          	<c:choose>
						          		<c:when test="${pvo.pqty eq 0}">
						          			<span style="font-size: 10pt; font-weight: bold; color: red;">재고 없음</span>
						          		</c:when>
						          		<c:otherwise>
								          	<span style="font-size: 10pt; font-weight: bold; color: green;">재고 있음</span>
						          		</c:otherwise>
						          	</c:choose>
						          	
						        </div>
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
						  
						</div>				
					</div>
					
			</div>
		</div>
		<div class="w-100"></div>
		
		<div class="my-5 mx-3 px-2">
			<h5 class="my-3" style="width: 60%;">${requestScope.pvo.psummary}</h5><br>
			<h6><span style="font-size: 10pt; font-weight: bold;">제품 번호</span></h6>
			<span class="mt-0 pt-0 badge badge-dark" id="productNo">${requestScope.pvo.pnum}</span>
		</div>
		<hr>
		<div class="my-4 mx-3 px-2">
			<a href="demo1" class="my-4 ml-2" id="accordion" data-toggle="collapse" data-target="#demo1">제품 설명</a>
			<a href="demo1" class="ml-1 mb-2" data-toggle="collapse" data-target="#demo1" ><i class="fas fa-plus"></i></a>
			<div id="demo1" class="collapse">
			   <p class="ml-3 my-3" style="width: 50%;">
			   		${requestScope.pvo.pcontent}
			   </p>
			</div>
			  
			<hr>
			
			<a href="demo2" class="my-4 ml-2" id="accordion" data-toggle="collapse" data-target="#demo2">제품 크기</a>
			<a href="demo2" class="ml-1 mb-3" data-toggle="collapse" data-target="#demo2" ><i class="fas fa-plus"></i></a>
			<div id="demo2" class="collapse my-3">
			  	<div class="row">
			  		<div class="col-9 col-lg-3">
			  			<c:if test="${not empty pimgList}">
							<c:forEach var="pimgList" items="${requestScope.pimgList}" varStatus="status">
								<c:if test="${status.last}">
						  	 		<img src="<%= ctxPath%>/image_ikea/${pimgList.imgfilename}" style="width: 100%;"/>
								</c:if>
			  				</c:forEach>
			  			</c:if>
			 		</div>
			 	</div>
			</div>
			<hr>
			
			<h3 class="h4 font-weight-bold ml-2 mb-3">상품평</h3>
			
			<div id="productReview" class="col-12 col-lg-6 container-fluid my-3 float-left">
			<%-- 상품 후기들이 들어오는 div --%>
			</div>
			
			<br><br>
			<div class="col-12 col-lg-10 container-fluid float-left">
			<h5 class="my-2 px-2" style="font-weight: bold;">유사한 제품</h5><br>
			
			<div class="row justify-content-start my-2" align="center">
				<c:if test="${not empty sameProductList}">
					<c:forEach var="sameProductVO" items="${requestScope.sameProductList}">
						<div class="col-6 col-lg-2 px-0 my-3">
							<a href="<%= ctxPath%>/product/eachProduct.one?pnum=${sameProductVO.pnum}"><img class="my-1" src="<%= ctxPath%>/image_ikea/${sameProductVO.prodimage}" style="width: 90%;"/></a><br>
							<a href="#" style="font-weight: bold; color: black; text-align: center;">${sameProductVO.pname}</a><br>
							<span><fmt:formatNumber value="${sameProductVO.price}"/>원</span>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<br><br><hr><br><br><br>
			
		</div>
	</div>
</div>
</div>
<jsp:include page="../footer.jsp"/>