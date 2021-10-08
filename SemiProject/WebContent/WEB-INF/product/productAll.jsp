<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<script type="text/javascript">

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
		
		$(document).on("mouseover", "div.product", function(){
			$(this).children("div.hide").css("visibility","visible");
		});
		$(document).on("mouseout", "div.product", function(){
			$(this).children("div.hide").css("visibility","hidden");
		});
	});

	
	// Function Declaration
	var len = 8;
	function displayAll(start){
		
		$.ajax({
			url:"/SemiProject/product/mallDisplayJSON.one",
		//	type:"GET",
			data:{"start":start	 // "1"  "9"  "17"
				 ,"len":len}, //  8	  8    8
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
						html += "<div class='col-md-3 col-6 product'>" +
									"<div class='hide my-2' style='visibility:hidden;'>" +
						                "<button class='btn btn-outline-danger btn-sm border-0'><i class='icon-link far fa-heart fa-lg'></i></button>" +
						            "</div>" +
									"<a href=''>" +
								        "<img src='<%= ctxPath%>/image_ikea/"+item.prodimage+"' style='width:100%'>" +
								        "<span>"+item.pname+"<br><b>￦"+(item.price).toLocaleString('en')+"</b></span>" +
							        "</a>" +
							        "<div class='hide' style='visibility:hidden;'>" +
						                "<button class='btn btn-outline-success btn-sm'>Cart&ensp;<i class='fa fa-shopping-cart'></i></button>" +
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
		<h6 class="my-3 py-2" style="font-size: 10pt;"><a href="#">제품</a> > 의자</a></h6>
		<h2 class="mb-4"><b>모든제품</b></h2>
		<div class="row justify-content-between mb-5">
			<c:forEach var="cvo" items="${requestScope.categoryList}" varStatus="status">
				<div class="col-md-2 col-6">
					<a href="">
				        <img src="<%= ctxPath%>/image_ikea/${cvo.prodimage}" style="width:100%">
				        <span>${cvo.cname}</span>
			        </a>
				</div>
			</c:forEach>
			
		</div>
		<div class="row my-2">
			<p class="col-md-7">
					의자를 찾고 계신가요? IKEA에는 다양한 의자가 준비되어 있어서 집안에 필요한 의자를 쉽게 찾으실 수 있어요. 포인트를 줄 수 있는 특이한 의자, 편안한 식탁의자, 공간을 많이 차지하지 않는 접이식 의자, 인체공학적 사무용 의자... 어떤 의자를 원하시든 맞는 의자를 만나실 수 있을 거예요.
			</p>
		</div>
		<div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	정렬
			  </button>
			  <div class="dropdown-menu">
				<div class="dropdown-item">			  
			    	<label for="low-price">낮은가격순&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="low-price"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="high-price">높은가격순&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="high-price"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="new">최신&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="new"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="pro_name">이름&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="pro_name"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="popular">인기있는&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="popular"/>
			    </div>
			  </div>
			</div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	카테고리
			  </button>
			  <div class="dropdown-menu">
				<c:forEach var="cvo" items="${requestScope.categoryList}" varStatus="status">
					<div class="dropdown-item">
					    <label for="${cvo.cnum}">${cvo.cname}</label> <input type = "checkbox" id="${cvo.cnum}">
			        </div>
				</c:forEach>
			  </div>
			</div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	가격
			  </button>
			  <div class="dropdown-menu">
			    <div class="dropdown-item">
				    <label for="9999">&#8361;0 - 9,999</label> <input type = "checkbox" id="9999">
		        </div>
			    <div class="dropdown-item">
				    <label for="19999">&#8361;10,000 - 19,999</label> <input type = "checkbox" id="19999">
		        </div>
			    <div class="dropdown-item">
				    <label for="29999">&#8361;10,000 - 19,999</label> <input type = "checkbox" id="29999">
		        </div>
			    <div class="dropdown-item">
				    <label for="39999">&#8361;10,000 - 19,999</label> <input type = "checkbox" id="39999">
		        </div>
			    <div class="dropdown-item">
				    <label for="40000">&#8361;40,000+</label> <input type = "checkbox" id="40000">
		        </div>
			  </div>
			</div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	색상
			  </button>
			  <div class="dropdown-menu">
			    <div class="dropdown-item">
				    <label class="w-75" for="gray">그레이</label> <input type = "checkbox" id="gray">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="beige">베이지</label> <input type = "checkbox" id="beige">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="white">화이트</label> <input type = "checkbox" id="white">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="black">블랙</label> <input type = "checkbox" id="black">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="brown">브라운</label> <input type = "checkbox" id="brown">
		        </div>
			  </div>
			</div>
		</div>
		<hr>
	</div>
	<div class="container-fluid container-xl mt-1 mb-5" >
		<div class="row" id="displayAll">
		</div>
		<hr>
		<div class="text-center">
			<button type="button" class="btn btn-light" id="btnMore" value="">더보기</button>
			<span id="totalCount">${requestScope.totalCount}</span>
			<span id="count">0</span>
		</div>
	</div>
	
<jsp:include page="../footer.jsp"/>