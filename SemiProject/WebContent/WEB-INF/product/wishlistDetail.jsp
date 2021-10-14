<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<script type="text/javascript">

	$(document).ready(function(){
		showWishList();
		
		// 삭제하기 버튼을 눌렀을때
		$(document).on("click", "button.deletewish", function(){
			var localWishList = JSON.parse(localStorage.getItem('wishlist'));
			var pnum = $(this).parent().children(".pnum").text();
			var index = localWishList.indexOf(pnum);
			
			localWishList.splice(index, 1);
			localStorage.setItem('wishlist', JSON.stringify(localWishList));
			$("div#displayAll").empty();
			showWishList();
			totalPrice();
			
		});
		
		// 위시리스트 삭제하기를 눌렀을때
		$(document).on("click", "button.deleteAllwish", function(){
			
			localStorage.removeItem('wishlist');
			$("div#displayAll").empty();
			showWishList();
			$("span#totalPrice").html('￦0');
			
		});
		
		// 수량이 변경되었을때
		$(document).on("change", "select.pqty", function(){
			
			var pqty = $(this).val();
			var price = $(this).parent().children(".price").text();
			var proprice = productPrice(price,pqty);
			$(this).parent().parent().parent().children().children("span.productprice").html('￦'+proprice.toLocaleString("en"));
			
			totalPrice();
			
		}); // end of $(document).on("change", "select.pqty", function(){})----------------------
		
		// 제품별 장바구니 버튼을 눌렀을 경우
		$(document).on("click", "button.savecart", function(){
			var loginuser = "${sessionScope.loginuser}";
			if (loginuser != "") {
				
				var pnum = $(this).parent().parent().parent().children().children().children("span.eachpnum").text();
				var pqty = $(this).parent().children("select.pqty").val();
				
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
		
		// 장바구니에 모든 제품 추가 버튼을 눌렀을때	saveAllcart
		//////////////////////////////////
		$(document).on("click", "button#saveAllcart", function(){
			var localWishList = JSON.parse(localStorage.getItem('wishlist'));
			
			if(localWishList != null && localWishList.length > 0) {
				var loginuser = "${sessionScope.loginuser}";
				// console.log(loginuser);
				if ( loginuser != "" ) {
					
					$("button.savecart").each(function(index,item){
						
						var pnum = $(this).parent().parent().parent().children().children().children("span.eachpnum").text();
						var pqty = $(this).parent().children("select.pqty").val();
						
						// console.log(pnum);
						// console.log(pqty);
						
						$.ajax({
							url:"/SemiProject/product/saveCartJSON.one",
							type:"POST",
							data:{"pnum":pnum
								, "pqty":pqty
								}, 
							success:function() { // 콜백함수
								if(index == 0){
									alert("장바구니에 추가했습니다.");
								}
							},
							error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					        }
						});
						
					});
					
				}
				else {
					alert("장바구니 기능은 로그인이 필요합니다.");
					location.href="<%=ctxPath%>/login/login.one";
				}
				
			} else {
					alert("위시리스트가 비었습니다.");
			}
		}); // end of $(document).on("click", "button.savecart", function(){})-------------------
		
		
		
	}); // end of $(document).ready(function(){})-------------------------

	// Function Declaration
	function showWishList() {
		
		var localWishList = JSON.parse(localStorage.getItem('wishlist'));
		
//		console.log(localWishList);
//		console.log(JSON.stringify(localWishList));	// ["20009172","10009024"]
//		console.log(typeof(JSON.stringify(localWishList)));	// string
//		console.log(localWishList.length);	// localWishList가 있지만 텅 비었으면 0
		if(localWishList != null && localWishList.length > 0) {
			$.ajax({
				url:"/SemiProject/product/wishlistJSON.one",
			//	type:"GET",
				data:{"localWishList":JSON.stringify(localWishList)}, 
				dataType:"JSON",
				success:function(json) {
					var html = "";
					var totalPrice = 0;
					if( json.length == 0) {
						// 처음부터 데이터가 존재하지 않는 경우
		                // !!! 주의 !!!
		                // if(json == null) 이 아님!!!
		                // if(json.length == 0) 으로 해야함!!
		                html += "위시리스트가 비었습니다.";
						
						// 상품 결과를 출력하기
						$("div#displayAll").html(html);
					}
					else if( json.length > 0) {
						// 데이터가 존재하는 경우
						$("div#deleteAll").html('<button class="btn btn-outline-danger btn-sm badge-pill mt-5 deleteAllwish">위시리스트 삭제하기</button>');
						$.each(json,function(index, item){
							html += '<div class="row">' +
										'<div class="col-3">' +
											'<a href=""><img src="<%= ctxPath%>/image_ikea/'+item.prodimage+'" style="width:100%"></a>' +
										'</div>' +
										'<div class="col-6">' +
											'<div class="mb-2"><b><a href="">'+item.pname+'</a></b></div>' +
											'<div>'+
												'<span>'+item.cname+'</span><br>'+
												'<span class="eachpnum" style="font-size:small;">'+item.pnum+'</span>'+
											'</div>'+
											'<div class="pt-2">'+
												'<span class="price" style="display:none">'+item.price+'</span>'+
												'<select class="badge-pill py-2 px-3 pqty">';
													for(var i=1; i<=Number(item.pqty); i++) {
														html += '<option value="'+i+'">'+i+'</option>';
													}	
										html +=	'</select>'+
												'<button class="btn btn-outline-success badge-pill mb-1 savecart"><i class="fa fa-shopping-cart"></i></button>'+
											'</div>'+
										'</div>'+
										'<div class="col-3">'+
											'<span class="productprice" style="font-weight:bold;">￦'+(item.price).toLocaleString("en")+'</span><br>'+
											'<button class="btn btn-outline-danger btn-sm badge-pill mt-5 deletewish">삭제하기</button>'+
											'<span class="pnum" style="display:none;">'+item.pnum+'</span>'+
										'</div>'+
									'</div>'+
									'<hr>';
							
									totalPrice += item.price;
									
						}); // end of $.each(json,function(index, item){})---------
						
						// 상품 결과를 출력하기
						$("div#displayAll").append(html);
						
						// 합계
						$("span#totalPrice").html('￦'+totalPrice.toLocaleString("en"));
					}
					
				//	$("div#rightside").show();
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		else {
	//		$("div#rightside").hide();
			$("div#displayAll").html("위시리스트가 비었습니다.");
			$("span#totalPrice").html('￦0');
			$("div#deleteAll").empty();
		}
	}// end of function showWishList()---------------------------
	
	function productPrice(price,pqty){
		return (price * pqty);
	}
	
	function totalPrice(){
		var total = 0;
		$("span.productprice").each(function(index, item){
			var text = $(this).text();
			text = text.substring(1);
		//	console.log(text);
			total += Number(text.split(",").join(""));
		});
		// console.log(total);
		$("span#totalPrice").html('￦'+total.toLocaleString("en"));
	}
	
</script>


	<div class="container-fluid container-xl">
		<div class="row mt-4">
			<div class="col-md-8">
				<h2 class="mb-4"><b>위시리스트</b></h2>
				<div class="my-3">
					<span>위시리스트 관리하기</span>
				</div>
				<div class="px-3 py-4 border">
					<b>위시리스트를 보관하세요!</b>
					<p>이 위시리스트는 임시로 저장됩니다. <a href="/SemiProject/login/login.one"><span style="text-decoration: underline;">가입 또는 로그인</span></a> 다시 방문할 때까지 위시리스트를 보관할 수 있어요</p>
				</div>
				<div id="deleteAll"></div>
				<hr>
				<div id="displayAll">
					
				</div>
				
			</div>
			<div class="col-md-4" id="rightside">
				<div class="h5 pb-3" id="summary" style="border-bottom: 2px solid black;"><b>위시리스트 요약</b></div>
				<h5 style="font-weight:bold;">합계&nbsp;&nbsp;&nbsp;&nbsp;<span id="totalPrice">￦0</span></h5>
				<div class="text-center mb-3">
					<div class="mb-2">이 제품을 온라인으로 구매하시겠어요?</div>
					<button class="btn btn-info btn-lg px-md-3 py-md-5 w-100" id="saveAllcart"><i class="fa fa-shopping-cart"></i>&nbsp;장바구니에 모든 제품 추가</button>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../footer.jsp"/>	