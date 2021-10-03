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
		  <a class="navbar-brand ml-4" href="<%= ctxPath %>/index.one"><img src="<%= ctxPath%>/images/logo.png" alt="IKEA_logo" width="90" height="37"/></a>
	
		  <ul class="navbar-nav w-25 nav_text" style="font-size:14px">
		    <li class="nav-item text ml-xl-4 ml-2">
		      <a class="nav-link text-body" href="<%= ctxPath %>/product/productAll.one"><b>모든 제품</b></a>
		    </li>
		    <li class="nav-item ml-2 mr-2" >
		      <a class="nav-link text-body" href="#고객지원"><b>고객지원</b></a>
		    </li>
		  </ul>
		 
	    <form class="mx-2 my-auto d-inline w-100">
	        <div class="input-group">
	            <input type="text" class="form-control border" style=" border-radius: 25px; " placeholder="검색어 입력">
	            <span class="input-group-append">
	                <button class="btn btn-outline-secondary border" style=" border-radius: 20px;" type="button">
	                    <i class="fa fa-search"></i>
	                </button>
	            </span>
	        </div>
	    </form>

		<ul class="navbar-nav w-25 list-group-horizontal mt-sm-0 mt-2 mx-auto nav_text">
	    	<li class="nav-item text" style="margin-left:50px"><a class="nav-link text-body text-dark fa fa-truck fa-lg" href="<%= ctxPath%>/product/shipping.one"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-user fa-lg" href="#"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-heart fa-lg" href="<%= ctxPath%>/product/wishlist.one"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-shopping-bag fa-lg" href="#"></a></li>
	   	</ul>	  


	</nav>
</div>
<!-- 상단 네비게이션 끝 --> 