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
    html {
      position: relative;
      min-height: 90%;
      margin: 0;
    }
    body {
      min-height: 100%;
    }
    footer {
      position: absolute;
      left: 0;
      bottom: -100px;
      width: 100%;
      text-align: center;
    }
    
    .sidetoggle{
    width: 120px !important;
    
    }
    
    .sidedropdownmenu{
    font-family: Verdana, sans-serif;
    font-size: 14px;
    }
    
    .sidetoggle{
    color: #0058AB !important;
    }
    
   .sidedropdownitem{
   color: #0058AB !important;
   }
   
   .sidedropdownitem:active {
	background-color: #FBD92F;
   }
</style>

<script>
	$(document).ready(function(){
	
		$("div.product").hover(function(){
			
			$(this).children("div.hidden").css("visibility","visible");
			
		},function(){
			$(this).children("div.hidden").css("visibility","hidden");
		})
		
		
		var loginuser = "${sessionScope.loginuser}";
		var loginuser_id = "${sessionScope.loginuser.userid}";
		// console.log(loginuser);
		// console.log(loginuser_id);
		/* 관리자메뉴 드롭다운 반응형   */
		if (loginuser != null && loginuser_id == "admin"){
			$(window).resize(function() { // 창 사이즈 변화감지
				var widthnow = window.innerWidth;
				var element = document.getElementById("sidedropdown");
				// console.log(widthnow)
				if(widthnow < 1200) {
				//창 가로 크기가 1200 미만일 경우
			    element.classList.remove("dropright"); // 오른쪽으로 열리는 드롭다운 속성 삭제			
				}
				
				if(widthnow > 1200) {
					//창 가로 크기가 1200 초과일 경우
				element.classList.add("dropright"); // 오른쪽으로 열리는 드롭다운 속성 추가			
					}
			});
		}
	
		/* 검색  */
		
		// 검색어에서 엔터를 하면 검색하러 가도록 한다.
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13){ 
				goSearch();
			}
		});
		
	}); // end of $(document).ready(function(){}----------------------

			
	// Function Declaration  
	function w3_open() {
	  document.getElementById("mySidebar").style.display = "block";
	}
	 
	function w3_close() {
	  document.getElementById("mySidebar").style.display = "none";
	}


	function goSearch(){	
	
	/* 	console.log($("input#searchWord").val());
		
		if( $("input#searchWord").val() == ""){ // 검색어가 없다면
			return false;// 검색이 취소된다.
		}
		 */
		var frm = document.searchFrm;
		frm.action = "<%= ctxPath%>/product/admin/searchResult.one";
		frm.method = "GET";
		frm.submit();
		
	}// end of goSearch ------------------------------

</script>
</head>

<body>

<!-- Sidebar 시작 -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none;z-index:2;width:40%;min-width:300px" id="mySidebar">
  <div class="container">
	  <a href="javascript:void(0)" onclick="w3_close()"class=" w3-button" style="border-radius: 70px; margin:30px"><i class="fas fa-times"></i></a>
	  <a class="navbar-brand" href="<%= ctxPath%>/index.one" style="margin-left:30px"><img src="<%= ctxPath%>/images/logo.png" alt="IKEA_logo" width="90" height="35"/></a>
  </div>
  <div class="container text-dark" style="margin:30px 130px; font-size:14px">
      <h2><a href="<%= ctxPath%>/product/productAll.one"><b>모든 제품</b></a></h2><br>
      <c:forEach var="cvo" items="${requestScope.categoryList}" varStatus="status">
	  	<a href="<%= ctxPath%>/product/productByCategory.one?cnum=${cvo.cnum}" onclick="w3_close()" class="w3-bar-item w3-button text-dark"><b>${cvo.cname}</b></a>
	  </c:forEach>
	  <br><br>
	  <a href="<%= ctxPath%>/service/support.one" onclick="w3_close()" class="w3-bar-item w3-button text-dark">고객지원</a>
	  <a href="<%= ctxPath%>/product/shipping.one" onclick="w3_close()" class="w3-bar-item w3-button text-dark">배송조회</a>

	  <a href="<%= ctxPath%>/member/mypage.one" onclick="w3_close()" class="w3-bar-item w3-button text-dark">마이페이지</a>	  
 	  <c:if test="${loginuser == null}"><div style="margin:40px 0 0 15px"><a href="<%= ctxPath %>/login/login.one" class="text-dark">로그인</a></div></c:if>
 	  <c:if test="${loginuser == null}"><div style="margin:15px 0 0 15px"><a href="<%= ctxPath %>/member/register.one" class="text-dark">회원가입</a></div></c:if>
	  <c:if test="${loginuser != null}"><div style="margin:40px 0 0 15px; font-weight: bolder; " >${loginuser.name}님</div></c:if>
	  
	  <c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin'}">
		<li style="list-style: none;" class="nav-item dropdown dropright" id="sidedropdown">
			<a class="nav-link dropdown-toggle menufont_size sidetoggle" href="#" id="navbarDropdown" data-toggle="dropdown"> 
			   	관리자 메뉴		                            
			</a>
		<div class="dropdown-menu sidedropdownmenu" aria-labelledby="navbarDropdown">
		    <a class="dropdown-item sidedropdownitem" href="<%= ctxPath %>/member/memberList.one">회원 목록</a>
			<div class="dropdown-divider"></div>
			<a class="dropdown-item sidedropdownitem" href="<%= ctxPath %>/product/admin/productRegister.one">제품 등록</a>
			<div class="dropdown-divider"></div>
			<a class="dropdown-item sidedropdownitem" href="<%= ctxPath %>/contact/consultList.one">문의글 조회</a>
			<a class="dropdown-item sidedropdownitem" href="<%= ctxPath %>/service/assembleList.one">조립 서비스 신청 조회</a>
			<a class="dropdown-item sidedropdownitem" href="<%= ctxPath %>/contact/selfReturnList.one">셀프 반품 신청 조회</a>
					<a class="dropdown-item sidedropdownitem" href="<%= ctxPath %>/contact/productOrderList.one">주문내역 조회</a>
		 </div>
		</li>
      </c:if>

	  <c:if test="${loginuser != null}"><div style="margin:15px 0 0 15px"><a href="<%= ctxPath %>/login/logout.one" >로그아웃</a></div></c:if>		

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
		      <a class="nav-link text-body" href="<%= ctxPath%>/service/support.one"><b>고객지원</b></a>
		    </li>
		  </ul>
		 
	    <form name="searchFrm" class="mx-2 my-auto d-inline w-100">
	        <div class="input-group">
	            <input type="text" class="form-control border" name="searchWord" id="searchWord" style=" border-radius: 25px; " placeholder="검색어 입력">
	            <span class="input-group-append">
	                <button class="btn btn-outline-secondary border" style=" border-radius: 20px;" type="button" onClick="goSearch();">
	                    <i class="fa fa-search"></i>
	                </button>
	            </span>
	        </div>
	    </form>
	    
		<ul class="navbar-nav w-25 list-group-horizontal mt-sm-0 mt-2 mx-auto nav_text">
	    	<li class="nav-item text" style="margin-left:50px"><a class="nav-link text-body text-dark fa fa-truck fa-lg" href="<%= ctxPath%>/product/shipping.one"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-user fa-lg" href="<%= ctxPath%>/member/mypage.one"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-heart fa-lg" href="<%= ctxPath%>/product/wishlistDetail.one"></a></li>
	    	<li class="nav-item ml-2 text"><a class="nav-link text-body text-dark fa fa-shopping-bag fa-lg" href="<%= ctxPath%>/product/shoppingCart.one"></a></li>
	   	</ul>	  
	</nav>
</div>
<!-- 상단 네비게이션 끝 --> 