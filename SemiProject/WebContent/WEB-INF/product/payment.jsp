<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:::PAYAMENT PAGE:::</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<style type="text/css">

	div#main {
		margin: 0 auto;
		width: 90%;
	}
	
	
	
	.error {
		color : red;
	}

	

</style>

</head>
<body>

	<div id="main" class="container-fluid my-4">
	
		<img src="<%= ctxPath%>/image_ikea/IKEA.svg"/>
		<hr>
		<br>
		<div id="payCheckList" class="container-fluid mx-3 mb-4">
		  <div class="row justify-content-start no-gutters">
		  	<div class="col-12 col-lg-7">
		  	
		  	<div class="row justify-content-start">
		  	<div class="col-12 col-lg-12">
			    <div class="col-1 pl-2 mx-2 float-left"><h3 style="font-weight: bold; text-decoration: underline; height: 600px;">1</h3></div>
		    	<div class="col-11">
				    <div class="col-11 col-lg-9 mx-2"><h3 style="font-weight: bold;">배송방법</h3></div>
				    <div class="col-11 col-lg-9 mt-3"><span>배송지 : 대한민국</span></div>
				    <div class="col-10 col-lg-9 ml-2 my-4 jumbotron d-flex align-items-center" style="height: 10%;">
				    	<i class="fas fa-info-circle ml-1 mr-3 text-primary"></i>
				    	<span class="text-primary my-2" style="font-weight: bold;">매장 픽업 서비스 이용 불가</span>
				    </div>
				    <div class="col-10 col-lg-9 my-3 px-3 py-4 float-left" style = "border: solid 3px #004d99; border-radius: 5px;">
						<i class="fas fa-truck mr-2"></i>
						<span>배송서비스</span>
						<hr style="border: solid 2px #004d99; border-radius: 25px;">
				    	<span class="mx-2 my-2" style="font-weight: bold; font-size: 11pt;">일반 배송 : 8,000원</span><br>
				    	<span class="mx-2 my-2" style="font-size: 11pt;">택배 배송 : 출고예정일 이후 3-5일 이내 배송되며, 2박스 이상으로 분리배송 될 수 있습니다.</span><br><br>
				    	<span class="mx-2 my-2" style="font-weight: bold;font-size: 11pt;">출고 예정일</span><br>
				    	<span class="mx-2 my-2" style="font-size: 11pt;">2021.10.14 09:00 - 21:00</span><br>
					</div>
				    <div class="col-10 col-lg-9 my-3 float-left">
				    	<button class="btn" data-toggle="collapse" data-target="#payment1"  style="background-color: #004d99; color: white; width: 100%; height: 50px; font-weight: bold; border-radius: 25px;">다음</button>
				    </div>
				</div>
				
		  	</div>
		  	
		  	<div class="col-12 col-lg-12" id="payCheckList2" class="container mx-3 mb-4 ">
			  <div id="payment1" class="collapse row no-gutters">
				  <hr class="pb-5"style="width: 900px;" align="left">
				    <div class="col-1 pl-2 mx-2 float-left"><h3 style="font-weight: bold; text-decoration: underline; height: 400px;">2</h3></div>
				    <div class="col-10">
				    <div class="col-12 col-lg-10"><h3 style="font-weight: bold;">주문을 어디로 배송할까요?</h3></div>
				    <div class="col-12 col-lg-12 mt-4">
					    <form name="deliveryAddress" style="width: 95%;">
					    	<input type="text" class="form-control mb-1" id="lastname" name="lastname" placeholder="성"/>
					    	<span class="error">성을 입력하세요</span><br><br>
					    	
					    	<input type="text" class="form-control mb-1" id="firstname" name="firstname" placeholder="이름"/>
					    	<span class="error">이름을 입력하세요</span><br><br>
					    	
					    	<input type="text" class="form-control mb-1" id="email" name="email" placeholder="이메일"/>
					    	<span class="error">이메일을 올바르게 입력하세요</span><br><br>
					    	
					    	<input type="text" class="form-control mb-1" id="mobile" name="mobile" placeholder="전화번호 (예 : 01012341234)"/>
					    	<span class="error">전화번호를 올바르게 입력하세요</span><br><br>
					    	
					    	<button class="btn btn-dark mb-3" style="color: white; width: 200px; height: 50px; font-weight: bold; border-radius: 25px;">주소찾기</button>
					    	
					    	<input type="text" class="form-control mb-1" id="postcode" name="postcode" placeholder="우편번호"/>
					    	<span class="error">우편번호를 올바르게 입력하세요</span><br><br>
					    	
					    	<input type="text" class="form-control" id="address" name="address" placeholder="주소"/><br>	
					    	
					    	<input type="text" class="form-control mb-1" id="detailAddress" name="detailAddress" placeholder="상세주소"/>
					    	<span class="error">주소를 올바르게 입력하세요</span><br><br>
					    	
					    	<input type="text" class="form-control" id="detailDelivery" name="detailDelivery" placeholder="배송옵션(예 : 부재시 경비실에 맡겨주세요)"/>
					    	
					    </form>
					    
				    </div>
				    <div class="col-10 col-lg-9 my-3">
				    	<button class="btn my-3" data-toggle="collapse" data-target="#payment2" style="background-color: #004d99; color: white; width: 100%; height: 50px; font-weight: bold; border-radius: 25px;">다음</button></div>
				  	</div>
			  	</div>
			  </div>
			  <br><br>
			  
			  	<div class="col-12 col-lg-12" id="payCheckList3" class="container mx-3 mb-4">
				  	<div id="payment2" class="collapse row no-gutters">
						<hr class="pb-5" style="width: 850px;" >
						<div></div>
					  	<div class="col-1 pl-2 mx-2 "><h3 style="font-weight: bold; text-decoration: underline;">3</h3></div>
					  	<div class="col-10">
						  	<div class="col-12 col-lg-10 mt-1 mb-4"><h3 style="font-weight: bold;">어떤 방법으로 결제하시겠어요?</h3></div>
						    <div class="col-12 col-lg-10">
						    	<input class="mr-2" type="radio" checked/>
						    	<span class="mr-2">KG이니시스</span>
						    	<img src="<%= ctxPath%>/image_ikea/KG이니시스.jpg" style="width: 100px;"/>
						    	<h6 class="my-4">결제하기 버튼을 클릭하면 이니시스로 이동합니다.</h6>
						    	<input class="form-check-input ml-1" id="agreeCheckbox" name="agreeCheckbox" type="checkbox"/><label for="agreeCheckbox" class="ml-4">결제확인에 동의합니다.</label>
						    </div>
						    <div class="col-10 col-lg-9 my-4">
						    	<button class="btn" style="background-color: #004d99; color: white; width: 250px; height: 70px; font-weight: bold; border-radius: 50px; font-size: 16pt;">결제하기</button>
						    </div>
					    </div>
				    </div>
				    </div>
				  </div>
				</div>
				  	<div class="col-12 col-lg-4 float-right">
				  		<div class="sidenav ml-1 pl-1 my-3">
								<div class="row justify-content-between mb-5">
									<div class="col-6"><h5 style="font-weight: bold;">주문정보</h5></div>
									<div class="col-3 mr-2"><a href="#" class="float-right mr-3" style="color: gray; text-decoration: underline;">수정</a></div>
								</div>
								<div>
									<img src="<%= ctxPath%>/image_ikea/롱피엘_베이지1.webp" style="width: 100px;" /><br>
									<br><br>
									<h6 style="font-weight: bold;">주문 내역</h6>
									<br>
									<div class="row justify-content-between mb-3">
										<div class="col-6 my-2"><h6>주문 금액 (배송비 제외)</h6></div>
										<div class="col-4 my-2 mr-2 ml-auto"><h6><span class="float-right mr-2" id="price">39,000원</span></h6></div>
										<div class="w-100"></div>
										
										<div class="col-6 my-2"><h6>전체 서비스 비용</h6></div>
										<div class="col-4 my-2 mr-2 ml-auto"><h6><span class="float-right mr-2" id="serviceCharge">8,000원</span></h6></div>
										<div class="w-100"></div>
										
										<div class="col-6 my-2"><h6>주문 금액 (부가세 제외)</h6></div>
										<div class="col-4 my-2 mr-2"><h6><span class="float-right mr-2" id="totalPrice">43,546원</span></h6></div>
										<div class="w-100"></div>
										
										<div class="col-6 my-2"><h6>부가세 (10%)</h6></div>
										<div class="col-4 my-2 mr-2"><h6><span class="float-right mr-2" id="totalPrice">47,900원</span></h6></div>
										<div class="w-100"></div>
										
										<hr style="border: 2px solid black; width: 550px;">
										
										<div class="col-6 my-2"><h5 style="font-weight: bold;">총 주문 금액</h5></div>
										<div class="col-4 my-2 mr-2"><h5><span class=" float-right" id="totalPrice">47,900원</span></h5></div>
					
									</div>
									
									<i class="mr-2 fas fa-undo"></i>
									<span style="font-weight: bold;">반품 정책 365일 이내에 제품 환불 가능</span>
									<br><br>
									<i class="mr-2 fas fa-lock"></i>
									<span style="font-weight: bold;">SSL 데이터 암호화로 안전한 쇼핑</span>
								</div>
						</div>
				  	</div>
			  </div>
	   		</div>
		
		  
		  
		
	
</div>
</body>
</html>