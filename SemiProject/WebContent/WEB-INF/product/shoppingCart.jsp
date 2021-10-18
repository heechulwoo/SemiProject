<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		showCartList();
		
		// 수량이 변경되었을때
		$(document).on("change", "select.oqty", function(){
			
			var oqty = $(this).val();
	//		var price = $(this).parent().children(".price").text();
	//		var proprice = productPrice(price,oqty);
	//		$(this).parent().parent().parent().children().children("span.productprice").html('￦'+proprice.toLocaleString("en"));
			
	//		totalPrice();
			// 수량이 변경되면 db에 저장해야하는지?
			var cartno = $(this).parent().children(".cartno").val();
		//	console.log(cartno);
		//	console.log(oqty);
			
			$.ajax({
				url:"<%= request.getContextPath()%>/product/cartEdit.one",
				type:"POST",
				data:{"cartno":cartno,
					  "oqty":oqty},
				dataType:"JSON",
				success:function(json){
					if(json.n == 1){
						alert("주문수량이 변경되었습니다.");   
						$("div#displayAll").empty();
						showCartList();
						totalPrice();
					}
			    },
			    error: function(request, status, error){
			       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			});
			
			
			
		}); // end of $(document).on("change", "select.pqty", function(){})----------------------
		
		// 제품별 삭제눌렀을때
		$(document).on("click", "button.deletecart", function(){
			
			var pnum = $(this).parent().children(".pnum").val();
			
			var confirmYN = confirm("장바구니에서 삭제하시겠습니까?");
			
			if(confirmYN) {
				deleteOneCart(pnum);
				alert("장바구니에서 삭제했습니다.");
				$("div#displayAll").empty();
				showCartList();
				totalPrice();
			}
			
		});
		
		// 장바구니 삭제하기를 눌렀을때
		$(document).on("click", "button.deleteAllcart", function(){
			
			var confirmYN = confirm("장바구니를 모두 삭제하시겠습니까?");
			
			if(confirmYN){
			
				$("button.deletecart").each(function(index,item){
					
					var pnum = $(this).parent().children(".pnum").val();
					deleteOneCart(pnum);
					
				});	
				alert("장바구니를 모두 삭제했습니다.");
				$("div#displayAll").empty();
				showCartList();
				$("span#totalPrice").html('￦0');
			}
			
		});
		
		// 결제하기 버튼을 눌렀을때
		$(document).on("click", "button.goPurchase", function(){
			
			var allCnt = $("input[name=cartno]").length;
			//  console.log(allCnt);
			if(allCnt > 0){
				
				var pnumArr = new Array();
	            var oqtyArr = new Array();
	            var cartnoArr = new Array();
	            var totalPriceArr = new Array();
	            
	            for(var i=0; i<allCnt; i++) {
	            	pnumArr.push( $(".pnum").eq(i).val() );
                    oqtyArr.push( $(".oqty").eq(i).val() );
                    cartnoArr.push( $(".cartno").eq(i).val() );
                    totalPriceArr.push( $(".totalPrice").eq(i).val() ); 	
	            }
	            
	            var pnumjoin = pnumArr.join();
	            var oqtyjoin = oqtyArr.join();
	            var cartnojoin = cartnoArr.join();
	            var totalPricejoin = totalPriceArr.join();

	            var sumtotalPrice = 0;
	            
	            for(var i=0; i<totalPriceArr.length; i++) {
	               sumtotalPrice += parseInt(totalPriceArr[i]);
	            }
 	         	console.log("확인용 pnumjoin : " + pnumjoin);             // 확인용 pnumjoin : 3,56,59
	         	console.log("확인용 oqtyjoin : " + oqtyjoin);             // 확인용 oqtyjoin : 3,2,3
	          	console.log("확인용 cartnojoin : " + cartnojoin);         // 확인용 cartnojoin : 14,13,11
	          	console.log("확인용 totalPricejoin : " + totalPricejoin); // 확인용 totalPricejoin : 30000,2000000,30000
	          	console.log("확인용 sumtotalPrice : " + sumtotalPrice);   // 확인용 sumtotalPrice : 2060000
	            
	            var bool = confirm("결제페이지로 이동하시겠습니까?");
 	          
 	         	if(bool){
 	          		var frm = document.orderFrm;
	 	          	frm.odpnum.value = pnumjoin;
	 	          	frm.odoqty.value = oqtyjoin;
	 	          	frm.odcartno.value = cartnojoin;
	 	          	frm.odtotalprice.value = totalPricejoin;
	 	          	
	 				frm.action="<%= ctxPath%>/product/payment.one";
	 				frm.method="POST";
	 				frm.submit();
 	         	}
	        <%--    
	            if(bool){
	            	$.ajax({
	                     url:"<%= request.getContextPath()%>/product/payment.one",
	                     type:"POST",
	                     data:{"pnumjoin":pnumjoin,
	                          "oqtyjoin":oqtyjoin, 
	                          "cartnojoin":cartnojoin,
	                          "totalPricejoin":totalPricejoin,
	                          "sumtotalPrice":sumtotalPrice},
	                     dataType:"JSON",     
	                     success:function(json){
                  	    if(json.isSuccess == 1) {
	                           location.href="<%= request.getContextPath()%>/shop/orderList.up"; 
	                        }
	                        else {
                               location.href="<%= request.getContextPath()%>/shop/orderError.up"; 
	                        }  
	                     },
	                     error: function(request, status, error){
	                        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                     }
	                  });
	            }
	            --%>
			}
			else {
				alert("장바구니에 제품을 담아주세요!");
			}
            
            
		});
		
	});// end of $(document).ready(function(){})
	
	//Function Declaration
	function showCartList() {
		var loginuser = "${sessionScope.loginuser}";
		if(loginuser != "") {
			$.ajax({
				url:"/SemiProject/product/cartlistJSON.one",
				type:"POST",
				dataType:"JSON",
				success:function(json) {
					var html = "";
					var SumtotalPrice = 0;
					if( json.length == 0) {
		                html += "장바구니가 비었습니다.";
		                $("div#deleteAll").empty();
						// 상품 결과를 출력하기
						$("div#displayAll").html(html);
					}
					else if( json.length > 0) {
						// 데이터가 존재하는 경우
						$("div#deleteAll").html('<button class="btn btn-outline-danger btn-sm badge-pill my-3 deleteAllcart">장바구니 삭제하기</button>');
						$.each(json,function(index, item){
							html += '<div class="row">' +
										'<div class="col-3">' +
											'<a href="<%= ctxPath%>/product/eachProduct.one?pnum='+item.pnum+'"><img src="<%= ctxPath%>/image_ikea/'+item.prodimage+'" style="width:100%"></a>' +
										'</div>' +
										'<div class="col-6">' +
											'<div class="mb-2"><b><a href="<%= ctxPath%>/product/eachProduct.one?pnum='+item.pnum+'">'+item.pname+'</a></b></div>' +
											'<div>'+
												'<span>'+item.cname+'</span><br>'+
												'<span class="eachpnum" style="font-size:small;">'+item.pnum+'</span>'+
											'</div>'+
											'<div class="pt-2">'+
												'<span class="price" style="display:none">'+item.price+'</span>'+
												'<select class="badge-pill py-2 px-3 oqty">';
													for(var i=1; i<=Number(item.pqty); i++) {
														if( i == item.oqty){
															html += '<option value="'+i+'" selected>'+i+'</option>';
														}
														else{
															html += '<option value="'+i+'">'+i+'</option>';
														}
													}	
										html +=	'</select>'+
											'<input type="hidden" value="'+item.cartno+'" name="cartno" class="cartno"/>' +
											'</div>'+
										'</div>'+
										'<div class="col-3">'+
											'<span class="productprice" style="font-weight:bold;">￦'+(item.price * item.oqty).toLocaleString("en")+'</span><br>'+
											'<input type="hidden" value="'+(item.price * item.oqty)+'" name="totalPrice" class="totalPrice"/>' +
											'<span style="font-size:small;">개당가격</span><br>' +
											'<span class="eachprice" style="font-size:small;">￦'+item.price.toLocaleString("en")+'</span><br>'+
											'<button class="btn btn-outline-danger btn-sm badge-pill mt-5 deletecart">삭제하기</button>'+
											'<input type="hidden" value="'+item.pnum+'" name="pnum" class="pnum"/>' +
									//		'<span class="pnum" style="display:none;">'+item.pnum+'</span>'+
										'</div>'+
									'</div>'+
									'<hr>';
							
									SumtotalPrice += (item.price * item.oqty);
								
						}); // end of $.each(json,function(index, item){})---------
						
						// 상품 결과를 출력하기
						$("div#displayAll").append(html);
						
						// 합계
						$("span#SumtotalPrice").html('￦'+SumtotalPrice.toLocaleString("en"));
					
						// 결제페이지에 보낼 총금액
						$("input#totalAllPrice").val(SumtotalPrice);
					
					}
					
				//	$("div#rightside").show();
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		else {
			alert("로그인이 필요합니다.");
		}
	}// end of function showCartList()---------------------------
	
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
		$("span#SumtotalPrice").html('￦'+total.toLocaleString("en"));
	}
	
	function deleteOneCart(pnum){
		
		var userid = "${sessionScope.loginuser.userid}";
		
		$.ajax({
			url:"/SemiProject/product/deleteOneCartJSON.one",
			type:"POST",
			data:{"pnum":pnum
				 ,"userid":userid
			},
			success:function() {
				// alert("장바구니에서 삭제했습니다.");
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}
</script>

<div class="container-fluid container-xl">
		<div class="row mt-4">
			<div class="col-md-8">
				<h2 class="mb-4"><b>장바구니</b></h2>
				<div id="deleteAll"></div>
				<div id="displayAll">
				
				</div>
				
			</div>
			<div class="col-md-4">
				<div class="h5 pb-3 mt-lg-3" id="summary" style="border-bottom: 2px solid black;"><b>주문 내역</b></div>
				<h5 style="font-weight:bold;">총 주문금액&nbsp;&nbsp;&nbsp;&nbsp;<span id="SumtotalPrice">￦0</span></h5>
				<div class="text-center">
					<button class="btn btn-info btn-lg px-md-3 py-md-5 btn-block goPurchase">결제하기</button>
					<form name="orderFrm">
						<input type="hidden" value="" name="odpnum" id="odpnum"/>
						<input type="hidden" value="" name="odoqty" id="odoqty"/>
						<input type="hidden" value="" name="odcartno" id="odcartno"/>
						<input type="hidden" value="" name="odtotalprice" id="odtotalprice"/>
						<input type="hidden" value="" name="odsumtotalprice" id="totalAllPrice"/>
					</form>
				</div>
				<hr class="my-5">
		    <%--     
				<p>
					<button class="btn dropdown-toggle btn-block" type="button" data-toggle="collapse" data-target="#demo1">
						쿠폰 입력
				    </button>
		        </p>
				<div class="collapse mb-1" id="demo1" >
					<div class="card card-body">
					   	<div><i class="fas fa-exclamation-circle text-primary"></i> 주문당 1개의 쿠폰만 사용할 수 있습니다.</div>
					   	<input class="my-2" type="text" placeholder="쿠폰 코드 입력">
					   	<button class="btn btn-outline-dark badge-pill">쿠폰 적용</button>
					</div>
			    </div>
			--%>    
			    <div class="my-3">
			    	<div class="my-1"><i class="far fa-check-circle"></i> 반품 정책 365일 이내에 제품 환불 가능</div>
			    	<div class="my-1"><i class="fas fa-lock"></i> SSL 데이터 암호화로 안전한 쇼핑</div>
			    </div>
			</div>
		</div>
	</div>

<jsp:include page="../footer.jsp"/>	