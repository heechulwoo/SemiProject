<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<script type="text/javascript">

	var range = "pname";
	
	$(document).ready(function(){
		
		$("span#totalCount").hide();
	    $("span#count").hide();
	      
		// 상품 게시물을 더보기 위하여 "더보기" 버튼 클릭액션에 대한 초기값 호출하기 
	    // 즉, 맨처음에는 "더보기" 버튼을 클릭하지 않더라도 클릭한 것 처럼 8개의 상품을 게시해주어야 한다는 말이다. 
		displayAll(1);
		
		// 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기  
		$("button#btnMore").click(function(){
			
			if($(this).text() == "처음으로") {
				$("div#displayAll").empty();
				$("span#end").empty();
				displayAll(1);
				$(this).text("더보기");
			}
			else {
				displayAll($(this).val());
			}
			
		});
		
		$("button[name=range]").click(function(){
			range = $(this).val();
			$("div#displayAll").empty();
			$("span#end").empty();
			$("span#count").text("0");
			displayAll(1);
			
		});
		
		$("input.filter").click(function(){
			console.log($(this).val());
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
				var pqty = "1";
				
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
		
	}); // end of $(document).ready(function(){})---------------------------

	
	// Function Declaration
	var len = 24;
	function displayAll(start){
		var cnum = "${requestScope.cnum}";
	//	console.log(cnum);
		$.ajax({
			url:"/SemiProject/product/mallDisplayJSON.one",
		//	type:"GET",
			data:{"range":range
				 ,"start":start	 // "1"  "9"  "17"
				 ,"len":len
				 ,"cnum":cnum}, 
			dataType:"JSON",
			success:function(json) {
				var html = "";
				
				if( start == "1" && json.length == 0) {
					// 처음부터 데이터가 존재하지 않는 경우
	                // !!! 주의 !!!
	                // if(json == null) 이 아님!!!
	                // if(json.length == 0) 으로 해야함!!
	                html += "현재 상품 준비중....";
					
					// 상품 결과를 출력하기
					$("div#displayAll").html(html);
				}
				else if( json.length > 0) {
					// 데이터가 존재하는 경우
					$.each(json,function(index, item){
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
					}); // end of $.each(json,function(index, item){})---------
					
					// 상품 결과를 출력하기
					$("div#displayAll").append(html);
					
					// >>> !!! 중요 !!! 더보기... 버튼의 value 속성에 값을 지정하기 <<< //  
					$("button#btnMore").val(Number(start)+len);
					// 더보기... 버튼의 value 값이  9  로 변경된다.
					// ...
					// 더보기... 버튼의 value 값이  41  로 변경된다.(존재하지 않는 것)
					
					// count 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					$("span#count").text( Number($("span#count").text()) + json.length );
					
					// 더보기... 버튼을 계속해서 클릭하여 count 값과 totalCount 값이 일치하는 경우 
					if( $("span#count").text() == $("span#totalCount").text() ) {
						$("span#end").html("더이상 조회할 제품이 없습니다.");
						$("button#btnMore").text("처음으로");
						$("span#count").text("0");
					}
					
				}
				
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}// end of displayAll(start)---------------------
</script>

	<div class="container-fluid container-xl">
		<h6 class="my-3 py-2" style="font-size: 10pt;"><a href="<%= ctxPath%>/product/productAll.one">제품</a> &gt; <a href="<%= ctxPath%>/product/productAll.one">의자</a> &gt; ${requestScope.cname} </h6>
		<h2 class="mb-4"><b>${requestScope.cname}</b></h2>
		
		<div class="row my-2">
			<p class="col-md-7">
					의자를 찾고 계신가요? IKEA에는 다양한 의자가 준비되어 있어서 집안에 필요한 의자를 쉽게 찾으실 수 있어요. 포인트를 줄 수 있는 특이한 의자, 편안한 식탁의자, 공간을 많이 차지하지 않는 접이식 의자, 인체공학적 사무용 의자... 어떤 의자를 원하시든 맞는 의자를 만나실 수 있을 거예요.
			</p>
		</div>
		<div>
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
	</div>
	<div class="container-fluid container-xl mt-1 mb-5" >
		<div class="row" id="displayAll">
		</div>
		<hr>
		<div class="text-center">
			<span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>
			<button type="button" class="btn btn-light" id="btnMore" value="">더보기</button>
			<span id="totalCount">${requestScope.totalCount}</span>
			<span id="count">0</span>
		</div>
	</div>
	
<jsp:include page="../footer.jsp"/>