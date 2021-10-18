<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
	String ctxPath = request.getContextPath();
%> 

<title>제품 검색</title>

<jsp:include page="../../header.jsp" /> 

<script type="text/javascript">

	const lenHIT = 8;
	// HIT 상품 "스크롤"을 할 때 보여줄 상품의 개수(단위)크기 

	var start = 1;
	var range = "pname";
	var searchWord = "${requestScope.searchWord}";
	
	$(document).ready(function(){

		 $("div#about").hide();
		
		// var totalcount = $("span#totalProdCount").val();
		// console.log(totalcount);	
		// searchResult.one?searchWord=이제이:255 
		
		// 검색창에 검색어가 그대로 남아있게 함
		if("${requestScope.searchWord}" != "" ){
			$("input#searchWord").val("${requestScope.searchWord}")
		}
		
		// 검색결과의 유무에 따라 다르게 보이기
		if("${requestScope.totalProdCount}" == "0"){
			$("div#exist").hide();
			$("div#noproduct").show();

		    $("div#result").hide();
		    $("div#new").show();
		    $("div#new2").show();
		    $("div#range").hide();
			
		    
		}
		else{
			$("div#exist").show();
			$("div#noproduct").hide();
			$("div#new1").hide();
			$("div#new2").hide();
			$("div#range").show();
		}
	
		displayProd(start); // 처음에만 호출	
	
			// ==== 스크롤 이벤트 발생시키기 시작 === //
			$(window).scroll(function(){
				   
	       		if($(window).scrollTop() + 1 >= $(document).height() - $(window).height()){
	    	   	// 현재 보이는 길이보다 문서의 길이가 크면 더 보기 위해 스크롤을 내린다. 내린 스크롤탑의 길이는 아직 보지 못한 길이보다 같거나 커야 한다.
	       		// 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1 을 더해서 보정한다.
	       		
	    	   	//	alert("다음 내용물 호출한다")
	       		
	       			const totalProdCount = Number($("span#totalProdCount").text()); // 굳이 형변환 안해도 됨
	       			const countProd = Number($("span#countProd").text());
	       			
	       			if(totalProdCount != countProd){ // 제품이 다 보여지지 않았을 경우에만
	       			start = start + lenHIT;
	       			displayProd(start);
	       		
	       			}
	       		}
	       	
	       		if($(window).scrollTop() == 0){
	       			// 다시 처음부터 시작하도록 한다.	
	       			$("div#displayProd").empty();
	       			$("span#end").empty();
	       			$("span#countProd").text("0");
	       			
	       			start = 1;
	       			displayProd(start);
	       		}
	       	
			}); //$(window).scroll(function(){}----------
			
			// ==== 스크롤 이벤트 발생시키기 끝 === //
		
			// 필터 클릭했을 때
			$("button[name=range]").click(function(){
				range = $(this).val();
				$("div#displayProd").empty();
				$("span#end").empty();
				$("span#countProd").text("0");
				displayProd(1);			
			});
			
			
			// 각 제품에 마우스를 올렸을때 위시리스트, 장바구니 버튼 보이게 하기
			$(document).on("mouseover", "div.product", function(){
				$(this).children("div.hide").css("visibility","visible");
			});
			$(document).on("mouseout", "div.product", function(){
				$(this).children("div.hide").css("visibility","hidden");
			});
			    
			
			// 위시리스트 버튼을 눌렀을때 session에 저장하기
			$(document).on("click", "div.wish", function(){
				
				var pnum = $(this).children("span.pnum").text();
				
				var localWishList = JSON.parse(localStorage.getItem('wishlist'));
				// console.log(localWishList);
				
				if(localWishList == null) {
					localWishList = [];
					localWishList.push(pnum);
					$(this).removeClass("hide");	// 위시리스트에 저장한 품목은 버튼을 숨기지 않고 보여줌
				}
				else{
					var index = localWishList.indexOf(pnum);
					if(index >= 0) {
						localWishList.splice(index, 1);
						$(this).addClass("hide");
					}
					else {
						localWishList.push(pnum);
						$(this).removeClass("hide");
					}
				}
				
				localStorage.setItem('wishlist', JSON.stringify(localWishList));
				
			});// end of $(document).on("click", "div.wish", function(){})---------------------
			
			// 장바구니에 저장 버튼을 눌렀을때
			$(document).on("click", "button.savecart", function(){
				var loginuser = "${sessionScope.loginuser}";
				if (loginuser != "") {
					
					var pnum = $(this).parent().children(".pnum").text();
					var pqty = 1;
					
					// console.log(pnum);
					// console.log(pqty);
					
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
			}); // end of $(document).on("click", "button.savecart", function(){})------------------------------
			
			
		
	}); // end of $(document).ready(function(){})-----------------------------
	
	
	// Function Declartion
	
	var len = 8;
	// display할  상품 정보를 요청하기(Ajax 로 처리함)
	function displayProd(start) {
		      
		$.ajax({
			url:"/SemiProject/product/SearchResultJSON.one",
			data:{"range":range
				 ,"start":start     
				 ,"len":lenHIT
				 ,"searchWord":searchWord},  
			dataType: "JSON",
			success:function(json){
			
				var html = "";
			
				if(start == "1" && json.length == 0){
					// 검색 결과가 존재하지 않는 경우

					
					// 검색 상품 결과를 출력하기
					$("div#displayProd").html(html);	
				}
				
				else if(json.length > 0){
					// 데이터가 존재하는 경우 
					$.each(json, function(index,item){
					
						html += "<div class='col-md-3 col-6 product'>";
						if(JSON.parse(localStorage.getItem('wishlist')) !=null && JSON.parse(localStorage.getItem('wishlist')).indexOf(item.pnum)>=0 ){
							html += "<div class='my-2 wish' style='visibility:visible;'>" 
						}
						else {
							html += "<div class='hide my-2 wish' style='visibility:hidden;'>"; 
							
						}
						html +=	"<span class='pnum' style='display:none'>"+item.pnum+"</span>"+
				                "<button class='btn btn-outline-danger btn-sm border-0'><i class='icon-link far fa-heart fa-lg'></i></button>" +
				            "</div>" +
							"<a href='<%= ctxPath%>/product/eachProduct.one?pnum="+item.pnum+"'>" +
						        "<img src='<%= ctxPath%>/image_ikea/"+item.prodimage+"' style='width:100%'>" +
						        "<span>"+item.pname+"<br><span class='w3-opacity' style='font-size:12px'>"+item.cname+"</span><br><b>￦"+(item.price).toLocaleString('en')+"</b></span>" +
					        "</a>" +
					        "<div class='hide' style='visibility:hidden;'>" +
				                "<button class='btn btn-outline-success btn-sm savecart'>Cart&ensp;<i class='fa fa-shopping-cart'></i></button>" +
				                '<span class="pnum" style="display:none;">'+item.pnum+'</span>'+
				            "</div>" +
						"</div>";	
						
					});// end of $.each(json, function(index,item){--------------------
			
					// 상품 결과를 출력하기
					$("div#displayProd").append(html);
			
					// countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					$("span#countProd").text(Number($("span#countProd").text()) + json.length);
					
				}
			},
			
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
			
		});      
		      
	}// end of function displayHIT(start) {}---------------------------------------

</script>
<div class="container-fluid container-xl">
		<div id="exist" style="margin-top: 3vw;">
			<h1>"<b>${requestScope.searchWord}</b>"와&nbsp;(과)&nbsp;일치하는 항목 표시</h1>
		</div>
		<div id="noproduct" style="margin-top: 3vw;">
			<h1>"<b>${requestScope.searchWord}</b>"와&nbsp;(과)&nbsp;일치하는 제품이 없습니다</h1>
			<small>&nbsp;&nbsp;&nbsp;원하시는 결과가 없으신가요? 찾으시는 제품의 이름이나 카테고리로 검색해보세요.</small>
		</div>		
			<div style="margin-top: 3vw;" id="range">
			  <button class="btn btn-light " type="button" name="range" id="low-price" value="price">
			  	낮은가격순
			  </button>
			  <button class="btn btn-light " type="button" name="range" id="high-price" value="price desc">
			  	높은가격순
			  </button>
			  <button class="btn btn-light " type="button" name="range" id="new" value="pinpupdate desc">
			  	최신순
			  </button>
			  <button class="btn btn-light " type="button" name="range" id="pro_name" value="pname">
			  	이름순
			  </button>
			</div>
		<hr>
		
	<div class="container-fluid container-xl mt-1 mb-5" >
	
	<%-- 검색 상품을 가져와서 디스플레이(스크롤 방식으로 페이징 처리한 것) --%>
		<div class="row" id="displayProd">
		<hr>
		</div>
		
	</div>

	<!-- 신제품 보여주기 -->
	<div class="w3-container w3-padding-32" style="padding:0;" id="new1">
		<h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">
			<b>IKEA의 신제품을 만나보세요</b>
		</h3>
		<p style="font-size: 12px">스마트하고 관리가 편리하며 쌓아둘 수 있는 스툴과 몸을 감싸주는 아늑한
			소파까지 다양한 신제품을 만나보세요.</p>
	</div>

	<div class="container-fluid container-xl mt-1" id=new2>
		<div class="row">
			<c:forEach var="pvo" items="${requestScope.newproductList}"
				varStatus="status">
				<div class="col-md-3 col-6 product">
					<div class="hidden my-2">
						<button class="btn btn-outline-danger btn-sm border-0">
							<i class="icon-link far fa-heart fa-lg"></i>
						</button>
					</div>
					<a href="" class="text-body"> <img
						src="<%= ctxPath%>/image_ikea/${pvo.prodimage}"
						style="width: 100%"> <span class="w3-bar-item"
						style="font-size: 12px"><b>${pvo.pname}</b></span><br> <span
						class="w3-opacity" style="font-size: 12px">${pvo.cname}</span><br>
						￦<span style="font-size: 20px"><b><fmt:formatNumber value="${pvo.price}" pattern="###,###" /> &emsp;</b></span>
					</a>
					<div class="hidden">
						<button class="btn btn-outline-success btn-sm">
							Cart&ensp;<i class="fa fa-shopping-cart"></i>
						</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 신제품 끝 -->	
	
	
	<!-- 검색 제품 결과수  -->
	<div class="text-center" id="result">
				<!-- <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>  -->
				<span id="countProd">0</span>&nbsp;/&nbsp;
				<span id="totalProdCount">${requestScope.totalProdCount}</span><span>개의 결과표시</span>
	
	</div>
	
</div>
<!-- 줄 띄우기 용 -->
<br><br><br><br><br>

<jsp:include page="../../footer.jsp" /> 



