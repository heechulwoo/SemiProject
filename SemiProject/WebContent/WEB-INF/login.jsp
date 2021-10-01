<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <!-- jstl을 사용하기 위함  -->    


<!doctype html>
<html lang="ko">
<head>

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
  
  
</head>

<body>

<!-- Sidebar 시작 -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none;z-index:2;width:40%;min-width:300px" id="mySidebar">
  <div class="container">
     <a href="javascript:void(0)" onclick="w3_close()"class=" w3-button" style="border-radius: 70px; margin:30px"><i class="fas fa-times"></i></a>
     <a class="navbar-brand" href="index.html" style="margin-left:30px"><img src="./images/logo.png" alt="IKEA_logo" width="90" height="35"/></a>
  </div>
  <div class="container" style="margin:30px 130px; font-size:14px">
      <h2><b>모든 제품</b></h2><br>
     <a href="#" onclick="w3_close()" class="w3-bar-item w3-button"><b>암케어/카우치</b></a>
     <a href="#" onclick="w3_close()" class="w3-bar-item w3-button"><b>사무용의자</b></a>
     <a href="#" onclick="w3_close()" class="w3-bar-item w3-button"><b>식탁의자</b></a>
     <a href="#" onclick="w3_close()" class="w3-bar-item w3-button"><b>스툴/벤치</b></a>
     <a href="#" onclick="w3_close()" class="w3-bar-item w3-button"><b>바의자</b></a>
     <a href="#" onclick="w3_close()" class="w3-bar-item w3-button"><b>어린이의자</b></a><br><br>
     <a href="#고객지원" onclick="w3_close()" class="w3-bar-item w3-button">고객지원</a>
     <a href="#배송조회" onclick="w3_close()" class="w3-bar-item w3-button">배송조회</a>
     <a href="#마이페이지" onclick="w3_close()" class="w3-bar-item w3-button">마이페이지</a>
  </div>
</nav>
<!-- Sidebar 끝-->


<!-- 상단 네비게이션 시작 -->
<div class="container">      
 <nav class="navbar navbar-expand-sm  navbar-light  w3-border-bottom w3-border-light-grey w3-padding-16">
  <div class="w3-button w3-padding-16 w3-left" style="border-radius: 70px" onclick="w3_open()"><i class="fas fa-align-justify"></i></div>
     <a class="navbar-brand" href="index.html" style="margin-left:25px"><img src="./images/logo.png" alt="IKEA_logo" width="90" height="35"/></a>

     <ul class="navbar-nav" style="font-size:14px">
       <li class="nav-item text">
         <a class="nav-link text-body" href="board.html"><b>모든 제품</b></a>
       </li>
       <li class="nav-item" >
         <a class="nav-link text-body" href="#고객지원"><b>고객지원</b></a>
       </li>
     </ul>
   
    <div class="w3-right w3-hide-small w3-text-black" style="margin-left:500px">
      <b>
      <a href="#배송조회" class="w3-bar-item w3-button h6"><i class="fa fa-truck"></i></a>
      <a href="login.html" class="w3-bar-item w3-button h6"><i class="fa fa-user"></i></a>
      <a href="#위시리스트" class="w3-bar-item w3-button h6"><i class="fa fa-heart"></i></a>
      <a href="#장바구니" class="w3-bar-item w3-button h6"><i class="fa fa-shopping-bag"></i></a>
      </b>
    </div>      
 </nav>
</div>
<!-- 상단 네비게이션 끝 --> 

<div class="container pt-5">
<div class="container"  style="max-width:1000px">
<!-- 상단 컨텐츠 시작 -->
 <div class="row custom-topcontents">
	<div class="col-md-3 px-4">
		<h2 ><b>로그인</b></h2>
		<p style="font-size: 9pt;  margin-top:40px">IKEA 계정이 없으신가요?<br> 지금 바로 만들어보세요</p>
		<span class="card-text"><i class="fa fa-pen"></i></span>
		<a href="memberRegister.html" style="font-size:14px"><b>회원가입</b></a> 
	</div>
	<div class="col-md-9">
		<img src="./images/loginpage.jpg" class="img-fluid"	alt="반응형 로그인 이미지" width="750" height="300">
 	</div>
 </div>
<!-- 상단 컨텐츠 끝 -->



<!-- 중앙 컨텐츠 시작 -->
<div class="row custom-topcontents">
 <div class="col-md-3"></div>
		
 <div class="col-md-9" style="font-size:12px">
		
	<!-- 경고 메시지 시작 -->
	<div class="alert alert-warning alert-dismissible fade show" role="alert">
           공용으로 사용하는 PC에서는 &quot;아이디 기억하기&quot;를 체크하면 개인정보 유출의 위험이있습니다.
	  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	    <span aria-hidden="true">&times;</span>
	  </button>
	</div>  
	<!-- 경고 메시지 끝 -->
		
	<!-- 로그인 폼 시작 -->
	<form action="login.do" method="post"  class="font-weight-bolder">
	<fieldset>
	   <div class="row pt-4">
		<div class="col-md-9">
			
			<div class="form-group row"  style="margin-left:10px" >	
				<div class="col-md-3">
					<label for="email">아이디</label>
				</div>
				<div class="col-md-9">
					<input class="form-control" type="email" style="font-size:12px" id="email" name="email" placeholder="아이디" autocomplete="off" required /> 
				</div>
			</div>
			
			<div class="form-group row"  style="margin-left:10px">
				<div class="col-md-3">
					<label for="pwd">비밀번호</label>
				</div>
				<div class="col-md-9">
					<input class="form-control" type="password" style="font-size:12px" id="pwd" name="pwd"	placeholder="비밀번호" required />
				</div>
			</div>
			
			<div class="form-group"  style="margin-left:24px">
				<label for="user_remember_me">아이디 기억하기</label>
				<input type="checkbox" id="user_remember_me" name="remember" value="1" />
			
	
		<!-- 아이디 찾기 시작 -->
		<a style="cursor: pointer; margin-left:26px" data-toggle="modal" data-target="#modalid" data-dismiss="modal">아이디찾기</a> /
		          
		<!-- Modal 시작-->
		<div class="modal fade" id="modalid">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal header -->
		      <div class="modal-header">
		        <h5 class="modal-title">아이디 찾기</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal body -->
		      <div class="modal-body">
		        <h6>아이디 찾기 모달</h6>
		  	  </div>
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				<button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- modal 끝-->
		<!-- 아이디 찾기 끝-->
	
		<!--비밀번호 찾기 시작-->
		<a style="cursor: pointer;" data-toggle="modal" data-target="#modalpwd" data-dismiss="modal">비밀번호 찾기</a> 
		          
		<!-- Modal 시작-->
		<div class="modal fade" id="modalpwd">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal header -->
		      <div class="modal-header">
		        <h5 class="modal-title">비밀번호 찾기</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal body -->
		      <div class="modal-body">
		        <h6>비밀번호 찾기 모달</h6>
		  		  </div>
		      
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				<button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- modal 끝-->
		<!-- 비밀번호 찾기 끝 -->
	</div>
	</div>
	
	<div class="col-md-3">
       <input class="btn btn-primary" type="submit" value="로그인" style="height: 85px;" />
    </div>
 </div>
 </fieldset>
</form>
<!-- 로그인 폼 끝 -->
	</div>
</div>
<!-- row 끝 -->
<!-- 중앙 컨텐츠 끝 -->
</div><hr>


<!-- Footer -->
 <div id="footer">
	<div class="w3-light w3-center w3-padding-24">Powered by <a href="https://www.sist.co.kr/index.jsp" title="W3.CSS" target="_blank" class="w3-hover-opacity">©SSANGYONG</a></div>
</div> 
</div>	
 <!-- container 끝 -->


	
<!-- 사이드바 function -->    
<script>
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}
</script>	

</body>
</html>

