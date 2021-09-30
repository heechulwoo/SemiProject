<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<!DOCTYPE html>
<html>
<head>
<title>IKEA SSANGYONG ｜ 이케아 쌍용</title>

<!-- title icon -->
<link rel="icon" href="<%= ctxPath%>/images/ico.jpg">

<!-- Font Awesome 5 Icons -->
<script src="https://kit.fontawesome.com/69a29bca1e.js" crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Optional JavaScript -->
<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>


<link rel="stylesheet" href="<%= ctxPath%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />

<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- w3schools 탬플릿 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
	label {
		width: 90%;
	}
	.card {
		border: none;	
	}
	.hidden {
		visibility: hidden;
	}
	
	@media screen and (max-width:1025px) {
		.nav_text {
			display: none;
		}
	}
</style>

<script>

	$(document).ready(function(){
	
	$("div.product").hover(function(){
		
		$(this).children("div.hidden").css("visibility","visible");
		
	},function(){
		$(this).children("div.hidden").css("visibility","hidden");
	})
	
});
</script>

<!-- 사이드바 function -->    
<script>
	function w3_open() {
	  document.getElementById("mySidebar").style.display = "block";
	}
	 
	function w3_close() {
	  document.getElementById("mySidebar").style.display = "none";
	}
</script>
</head>


<body>

<!-- Sidebar 시작 -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none;z-index:2;width:40%;min-width:300px" id="mySidebar">
  <div class="container">
	  <a href="javascript:void(0)" onclick="w3_close()"class=" w3-button" style="border-radius: 70px; margin:30px"><i class="fas fa-times"></i></a>
	  <a class="navbar-brand" href="index.html" style="margin-left:30px"><img src="<%= ctxPath%>/images/logo.png" alt="IKEA_logo" width="90" height="35"/></a>
  </div>
  <div class="container text-dark" style="margin:30px 130px; font-size:14px">
      <h2><b>모든 제품</b></h2><br>
	  <a href="#" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>암케어/카우치</b></a>
	  <a href="#" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>사무용의자</b></a>
	  <a href="#" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>식탁의자</b></a>
	  <a href="#" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>스툴/벤치</b></a>
	  <a href="#" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>바의자</b></a>
	  <a href="#" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>어린이의자</b></a><br><br>
	  <a href="#고객지원" onclick="w3_close()" class="w3-bar-item w3-button text-dark">고객지원</a>
	  <a href="#배송조회" onclick="w3_close()" class="w3-bar-item w3-button text-dark">배송조회</a>
	  <a href="#마이페이지" onclick="w3_close()" class="w3-bar-item w3-button text-dark">마이페이지</a>
 </div>
</nav>
<!-- Sidebar 끝-->


<!-- 상단 네비게이션 시작 -->
<div class="container" style="max-width:1600px">		
	<nav class="navbar navbar-expand-sm  navbar-light  w3-border-bottom w3-border-light-grey w3-padding-16">
	  <div class="w3-button w3-padding-16 w3-left" style="border-radius: 70px" onclick="w3_open()"><i class="fas fa-align-justify"></i></div>
		  <a class="navbar-brand ml-4" href="index.html"><img src="<%= ctxPath%>/images/logo.png" alt="IKEA_logo" width="90" height="37"/></a>
	
		  <ul class="navbar-nav  nav_text" style="font-size:14px">
		    <li class="nav-item text ml-xl-4 ml-2">
		      <a class="nav-link text-body" href="productMain2.html"><b>모든 제품</b></a>
		    </li>
		    <li class="nav-item ml-2 mr-5" >
		      <a class="nav-link text-body" href="#고객지원"><b>고객지원</b></a>
		    </li>
		  </ul>
		 
	        <div class="input-group" style="max-width:530px">
	            <input type="text" class="form-control " style=" border-radius: 25px; background-color: #f2f2f2; border: 0px; height:50px" placeholder="&emsp;검색어 입력">
	           <span class="input-group-append"> 
	                <button class="btn btn-outline-secondary border ml-1" style="border-radius: 20px" type="button">
	                    <i class="fa fa-search"></i>
	                </button>
	            </span>
	        </div>

		<ul class="navbar-nav w-15  list-group-horizontal nav_text">
	    	<li class="nav-item text" style="margin-left:50px"><a class="nav-link text-body text-dark fa fa-truck fa-lg" href="#"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-user fa-lg" href="#"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-heart fa-lg" href="wishList.html"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-shopping-bag fa-lg" href="#"></a></li>
	   	</ul>	  


	</nav>
</div>
<!-- 상단 네비게이션 끝 --> 
 
 

<!-- header 시작-->
<header class="w3-display-container w3-content w3-wide" style="max-width:1100px; margin-top:40px" id="home">
<div class="container w3-padding-16">
	<div id="carousel" class="carousel slide" data-ride="carousel">
	  <ol class="carousel-indicators">
	    <li data-target="#carousel" data-slide-to="0" class="active"></li>
	    <li data-target="#carousel" data-slide-to="1"></li>
	    <li data-target="#carousel" data-slide-to="2"></li>
	  </ol>
	  
	  <div class="carousel-inner">
	  
	   <div class="carousel-item active">
	      <img src="<%= ctxPath%>/images/main3.jpg" class="d-block w-100" alt="...">
	      <div class=" d-none d-md-block w3-display-right w3-margin-left w3-right"> 
		    <h3 class="w3-text-white"><b>IKEA 소파 제품은<br>아늑한 공간을 선사합니다.</b></h3>
		 </div> 		      
	    </div>
	    
	    <div class="carousel-item">
	      <img src="<%= ctxPath%>/images/main2.jpg" class="d-block w-100" alt="...">
	      <div class=" d-none d-md-block w3-display-left w3-margin-left w3-right"> 
		    <h3 class="w3-text-white"><b>편안한 재택강의를 위한  <br>사무용 의자를 만나보세요.</b></h3>
		  </div> 		      
	    </div>
	  
	    <div class="carousel-item">
	      <img src="<%= ctxPath%>/images/main1.jpg" class="d-block w-100" alt="..."> 
	      <div class=" d-none d-md-block w3-display-middle w3-margin-left w3-right"> 
		    <h3 class="text-center text-white"><b>2022.01.01.</b></h3>
		    <h3 class="w3-text-white"><b>IKEA 쌍용점이 여러분을 찾아갑니다.</b></h3>
		  </div> 
	    </div>    
	  </div>
	  
	  <a class="carousel-control-prev" href="#carousel" role="button" data-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="carousel-control-next" href="#carousel" role="button" data-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>
  </div>
</header>
<!-- header 끝-->

<!-- Page content 시작-->
<div class="w3-content w3-padding text-dark" style="max-width:1130px">

<!-- 인기제품 시작 -->
  <div class="w3-container w3-padding-32" id="about">
    <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16"><b>IKEA 인기제품</b></h3>
    <p style="font-size:12px">고객들의 솔직 후기로 사랑받고 있는 IKEA의 인기제품을 확인해 보세요!</p>
  </div>

<div class="container-fluid container-xl mt-1">
	<div class="row">
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">				
			<img src="<%= ctxPath%>/images/MARIUS.jpg" style="width:100%">
	        <span class="w3-bar-item" style="font-size:12px"><b>MARIUS 마리우스</b></span><br>
	        <span class="w3-opacity" style="font-size:12px">스툴</span><br>
	                  ￦<span style="font-size:20px"><b>5,000 &emsp;</b></span>					        
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">
		        <img src="<%= ctxPath%>/images/TOBIAS.jpg" style="width:100%">
			      <span class="w3-bar-item" style="font-size:12px"><b>TOBIAS 토비아스</b></span><br>
			      <span class="w3-opacity" style="font-size:12px">식탁의자</span><br>
			                ￦<span style="font-size:20px"><b>89,900 &emsp;</b></span>
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">
		        <img src="<%= ctxPath%>/images/PELLO.jpg" style="width:100%">
			      <span class="w3-bar-item" style="font-size:12px"><b>PELLO 펠로</b></span><br>
			      <span class="w3-opacity" style="font-size:12px">패브릭 암체어</span><br>
			                ￦<span style="font-size:20px"><b>40,000 &emsp;</b></span>
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">
		        <img src="<%= ctxPath%>/images/TEODORES.jpg" style="width:100%">
			      <span class="w3-bar-item" style="font-size:12px"><b>TEODORES 테오도레스</b></span><br>
			      <span class="w3-opacity" style="font-size:12px">식탁의자</span><br>
			                ￦<span style="font-size:20px"><b>27,900 &emsp;</b></span>
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
	
	</div>
</div>
<!-- 인기제품 끝 -->


 
	<!-- 신제품 시작 -->
	<div class="w3-container w3-padding-32" id="about">
	  <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16"><b>신제품을 만나보세요</b></h3>
	  <p style="font-size:12px">스마트하고 관리가 편리하며 쌓아둘 수 있는 스툴과 몸을 감싸주는 아늑한 소파까지 다양한 신제품을 만나보세요.</p>
	</div>

<div class="container-fluid container-xl mt-1">
	<div class="row">
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">				
			  <img src="<%= ctxPath%>/images/STOCKHOLM.jpg" style="width:100%">
		      <span class="w3-bar-item" style="font-size:12px"><b>STOCKHOLM 2017 스톡홀름</b></span><br>
		      <span class="w3-opacity" style="font-size:12px">라탄 암체어</span><br>
		                ￦<span style="font-size:20px"><b>329,000 &emsp;</b></span>		        
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">
		      <img src="<%= ctxPath%>/images/EKERO.jpg" style="width:100%">
		      <span class="w3-bar-item" style="font-size:12px"><b>EKERO 에케뢰</b></span><br>
		      <span class="w3-opacity" style="font-size:12px">천연가죽 암체어</span><br>
		                ￦<span style="font-size:20px"><b>199,000 &emsp;</b></span>
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">
	          <img src="<%= ctxPath%>/images/KLIMPFJALL.jpg" style="width:100%">
		      <span class="w3-bar-item" style="font-size:12px"><b>KLIMPFJALL 클림프피엘</b></span><br>
		      <span class="w3-opacity" style="font-size:12px">벤치</span><br>
		                ￦<span style="font-size:20px"><b>119,000 &emsp;</b></span>
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
		
		<div class="col-md-3 col-6 product">
			<div class="hidden my-2">
                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
            </div>
			<a href="" class="text-body">
		      <img src="<%= ctxPath%>/images/PERJOHAN.jpg" alt="Dan" style="width:100%">
		      <span class="w3-bar-item" style="font-size:12px"><b>PERJOHAN 페리오한</b></span><br>
		      <span class="w3-opacity" style="font-size:12px">침대협탁</span><br>
		                ￦<span style="font-size:20px"><b>29,900 &emsp;</b></span>
	        </a>
	        <div class="hidden">
                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
            </div>
		</div>
	
	</div>
</div>
<!-- 신제품 끝 -->



 <!-- 서비스 항목 시작 -->
 <div class="w3-content w3-padding" style="max-width:1170px; margin-top:80px">
    <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16"><b>IKEA 서비스</b></h3>
    <p style="font-size:12px">직접 해도 좋고, 도움을 받아도 좋아요. IKEA는 생활이 더욱 간편해지는 다양한 서비스를 제공합니다.</p>
 
   <div class="card-deck mb-5" style="margin-top:35px">
		  <div class="card bg-light text-black" style="margin-left:15px">
		    <div class="card-body text-center">
		      <span class="card-text"><i class="fa fa-truck"></i></span><br>
		      <span class="card-text" style="font-size:16px"><b>배송 서비스</b></span>
		      <p class="card-text mt-1" style="font-size:13px">편리한 배송 옵션을 살펴보세요</p>
	
		<!-- Button trigger modal1 -->
		<button type="button" class="btn btn-light" style="font-size:12px" data-toggle="modal" data-target="#Modal1">
		  더 보기
		</button>
		
		<!-- Modal1 -->
		<div class="modal fade" id="Modal1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal1 header -->
		      <div class="modal-header">
		      	<span class="card-text"><i class="fa fa-truck"></i></span>&ensp;
		        <h6 class="modal-title"><b>배송 서비스</b></h6>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal1 body -->
		      <div class="modal-body text-left border" style="font-size:12px">
		        <h5><b>비대면 배송 안내</b></h5><br>
		        <p>이제 의자도 안전하게 비대면으로 배송 받아보세요! 배송 기사님과의 연락으로 쉽게 이용할 수 있습니다.</p>
		        <p>1. 배송기사님이 배송 한 시간 전에 고객님께 연락 드립니다.</p>
		        <p>2. 만약 비대면 배송을 원하시면 사전에 배송기사님께 알려주세요.</p>
		        <p>3. 고객 요청에 따라 문 앞 비대면 배송 혹은 가정 내 원하시는 방까지 배송해드립니다.</p><br>
		        <h5><b>온라인 배송 요금</b></h5><br>
		        <p>택배 배송 : 기본요금 ￦3,000 부터</p>
		        <p>○ 가로, 세로, 높이의 합: 220cm 미만</p>
		        <p>○ 가장 긴 변의 길이: 140cm 미만</p>
		        <p>○ 총 무게: 25kg 미만</p>
		        <p>*주문한 제품의 실제 크기에 따라 요금이 상이할 수 있습니다.</p><br>
               </div>
               
		      <!-- Modal1 footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
		      </div> 
		    </div>
		  </div>
		</div>	  
		</div>
	 	</div>	  
		    
		  <div class="card bg-light text-black">
		    <div class="card-body text-center">
		      <span class="card-text"><i class="fa fa-pen"></i></span><br>
		      <span class="card-text" style="font-size:16px"><b>플래닝 서비스</b></span>
		      <p class="card-text mt-1" style="font-size:13px">제품 추천부터 배치까지 전문가의 <br>도움을 받아보세요</p>
		    
		<!-- Button trigger modal2 -->
		<button type="button" class="btn btn-light" style="font-size:12px" data-toggle="modal" data-target="#Modal2">
		  더 보기
		</button>
		
		<!-- Modal2 -->
		<div class="modal fade" id="Modal2">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal2 header -->
		      <div class="modal-header">
		      	<span class="card-text"><i class="fa fa-pen"></i></span>&ensp;
		        <h6 class="modal-title"><b>플래닝 서비스</b></h6>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal2 body -->
		      <div class="modal-body text-left border" style="font-size:12px">
		      	<p>나의 체형에 맞는 완벽한 의자를 찾고 싶으신가요? 소파를 어디에 두어야 할지 선택하기 어렵나요? 
				의자를 선택할 땐 세세한 것 하나 하나가 너무나 중요하죠. 아이디어가 있다면 나머지는 경험이 풍부한 플래너와 논의해보세요. 세부적인 부분까지 도와드려요. 풍부한 아이디어와 솔루션으로 도움을 드립니다.</p><br>
		        <h5><b>서비스 신청 방법</b></h5><br>
		        <p>○ IKEA Family는 1시간의 무료 플래닝 서비스를 체험하실 수 있습니다.</p>
		        <p>○ 전국 IKEA 매장과 플래닝 스튜디오, 온라인 원격 서비스로 이용가능합니다.</p>
		        <p>○ 원하는 서비스의 예약하기 버튼을 누르고 우편번호를 입력하여 살고 있는 지역과 가까운 매장을 선택해보세요.</p>
		        <p>○ 온라인 서비스는 예약 신청 후 매장 방문없이 자택에서 원격으로 진행됩니다.</p><br>
               </div>
               
		      <!-- Modal2 footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>	  
		</div>
 		</div>	     
		   
		  <div class="card bg-light text-black" style="margin-right:25px">
		    <div class="card-body text-center">
		      <span class="card-text"><i class="fa fa-tools"></i></span><br>
		      <span class="card-text" style="font-size:16px"><b>조립 서비스</b></span>
		      <p class="card-text mt-1" style="font-size:13px">IKEA에게 조립을 맡기고 소중한 <br>시간을 아끼세요</p>
		      
		<!-- Button trigger modal3 -->
		<button type="button" class="btn btn-light" style="font-size:12px" data-toggle="modal" data-target="#Modal3">
		  더 보기
		</button>
		
		<!-- Modal3 -->
		<div class="modal fade" id="Modal3">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal3 header -->
		      <div class="modal-header">
		      	<span class="card-text"><i class="fa fa-tools"></i></span>&ensp;
		        <h6 class="modal-title"><b>조립 서비스</b></h6>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal3 body -->
		      <div class="modal-body text-left border" style="font-size:12px">
		      	<p>IKEA 제품은 고객이 직접 조립할 수 있도록 명확하게 디자인되어 있지만 도움이 필요한 경우 집이나 사무실에서 이용할 수 있도록 조립 서비스를 준비했습니다. IKEA에게 조립을 맡기고 소중한 시간을 아끼세요. 간단한 스툴 조립부터 4인용 소파 전체에 이르기까지 조립 서비스 신청이 가능합니다.</p><br>
		        <h5><b>서비스 이용 시 유의사항</b></h5><br>
		        <p>○ IKEA 조립 서비스는 IKEA의 파트너인 독립적인 조립 서비스 업체가 제공합니다.</p>
		        <p>○ 소파 조립 서비스의 요금은 6만원입니다. 단, 암체어나 풋스툴은 일반 조립 서비스 가격표를 참고해 주세요.</p>
		        <p>○ 예정된 배송시간에 부재일 경우 배송비가 추가로 부과 될 수 있습니다.</p>
		        <p>○ 포장재는 환경친화적인 방식으로 처리합니다.</p><br>
               </div>
           
		      <!-- Modal3 footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>	  
		</div>
	 	</div>	  		     
		</div>
		</div>
	<!-- 서비스 항목 끝 -->	
 
 
  <!-- 추천제품 시작 -->
  <div class="w3-container w3-padding-32" id="projects">
    <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16"><b>추천 제품</b></h3>
  </div>
  
	<div class="w3-row" id="myGrid" style="margin-bottom:120px">
	  
	  <div class="w3-third">
	  <div class="w3-display-container">
	    <img src="<%= ctxPath%>/images/ULRIKSBERG.jpg" style="width:100%; margin:0px 15px 15px">
	      <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>ULRIKSBERG<br>울릭스베리<br><br>￦ 149,000</b></button>	                   
 	      </div>
	    </div>
	   
	   <div class="w3-display-container"> 
	    <img src="<%= ctxPath%>/images/RONNINGE.jpg" style="width:100%; margin:0px 15px 15px">
	    <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>RONNINGE<br>뢴닝에<br><br>￦ 99,900</b></button>	                   
 	      </div>
	    </div>
	   
	   <div class="w3-display-container"> 
	    <img src="<%= ctxPath%>/images/BUSKBO.jpg" style="width:100%; margin:0px 15px 15px">
	    <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>BUSKBO<br>부스크보<br><br>￦ 99,900</b></button>	                   
 	      </div>
	    </div>
	  </div>
	
	  <div class="w3-third">
	  
	  <div class="w3-display-container">
	    <img src="<%= ctxPath%>/images/ODGER2.jpg" style="width:87%; margin-left:30px">
	    <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>ODGER<br>오드게르<br><br>￦ 129,000</b></button>	                   
 	      </div>
	    </div>
	   
	   <div class="w3-display-container"> 
	    <img src="<%= ctxPath%>/images/ODGER.jpg" style="width:87%; margin:15px 30px">
	     <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>ODGER<br>오드게르<br><br>￦ 79,900</b></button>	                   
 	      </div>
	    </div>
	    
	    <div class="w3-display-container">
	    <img src="<%= ctxPath%>/images/ODGER3.jpg" style="width:87%; margin:0px 30px">
	    <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>ODGER<br>오드게르<br><br>￦ 129,000</b></button>	                   
 	      </div>
	    </div>
	    
	    <div class="w3-display-container">
	 	<img src="<%= ctxPath%>/images/ORFJALL.jpg" style="width:87%; margin:15px 30px">
	 	<div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>ORFJALL<br>외르피엘<br><br>￦ 69,900</b></button>	                   
 	      </div>
	    </div>
	  </div>
	
	  <div class="w3-third">
	  	<div class="w3-display-container">
		  <img src="<%= ctxPath%>/images/GISTAD.jpg" style="width:100%; margin-right:40px">
		  <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>GISTAD<br>이스타드<br><br>￦ 199,000</b></button>	                   
 	      </div>
	    </div>
	    
	    <div class="w3-display-container">
		  <img src="<%= ctxPath%>/images/ULRIKSBERG2.jpg" style="width:100%; margin:15px 40px 15px 0">
		  <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>ULRIKSBERG<br>울릭스베리<br><br>￦ 149,000</b></button>	                   
 	      </div>
	    </div>
	    
	    <div class="w3-display-container">
		  <img src="<%= ctxPath%>/images/OMTANKSAM.jpg" style="width:100%; margin-right:40px">  
		  <div class="w3-display-middle w3-display-hover">
      		<button class="btn my-2 my-sm-0 btn-light" type="submit" style="border-radius: 20px; font-size:13px"><b>OMTANKSAM<br>옴텡크삼<br><br>￦ 149,000</b></button>	                   
 	      </div>
	    </div> 
	  </div>
	</div>
 <!-- 추천제품 끝 -->
 </div>
 <!-- page content 끝-->	
 


<!-- Footer -->
<footer class="w3-center w3-light-grey w3-padding-16">
  <div class="w3-light w3-center w3-padding-24">Powered by <a href="https://www.sist.co.kr/index.jsp" title="W3.CSS" target="_blank" class="w3-hover-opacity">©SSANGYONG</a></div>
</footer>


</body>
</html>
