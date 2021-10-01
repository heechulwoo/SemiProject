<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <!-- jstl을 사용하기 위함  -->    


<%-- <jsp:include page="" /> 아직 헤더 없음 --%>

    
<!doctype html>
<html lang="ko">

<style>

   table#tblMemberRegister {
          width: 93%;
          
          /* 선을 숨기는 것 */
          border: hidden;
          
          margin: 10px;
   }  
   
   table#tblMemberRegister#th {
         height: 40px;
         text-align: center;
         background-color: silver;
   }
   
   table#tblMemberRegister td {
         /* border: solid 1px gray;  */
         line-height: 30px;
         padding-top: 18px;
         padding-bottom: 8px;
   }
   
   .star { color: red;
           font-weight: bold;
           font-size: 12pt;
   }
   
   
   
</style>


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


<script type="text/javascript">


	$(document).ready(function(){
		
		$("button#nameChange").click(function(){
	
			 window.open("changeName.html", "change",
             "left=350px, top=100px, width=600px, height=600px");
			
		});
		
		
	});


</script>




  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>마이페이지</title>
	<link rel="icon" href="./images/ico2.jpg">

	
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
    
    <!-- Font Awesome 5 Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- 직접 만든 CSS -->
   <!--  <link rel="stylesheet" href="./css/mycss.css"> -->
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    
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
<div class="container" style="max-width:1300px ">		

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
	
	<form class="form-inline my-2 my-lg-0" style="margin-left:50px">
	      <input class="form-control mr-sm-2 w-800" style="width:450px;  border-radius: 25px; font-size:12px" type="search" placeholder="검색어 입력" aria-label="Search">
	      <a><button class="btn my-2 my-sm-0 btn-outline-secondary" type="submit" style="border-radius: 20px"><i class="fa fa-search"></i></button></a>
	</form>
		  
	 <div class="w3-right w3-hide-small w3-text-black" style="margin-left:90px">
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


	<!-- 상단 컨텐츠 시작 -->
	<div class="container" style="max-width:950px; margin-top:40px">
	<div class="row custom-topcontents">
		
			<h2><b>&nbsp;계정 관리</b></h2>
	
			<img class="w3-image" width="1000" height="300" src="./images/제목 없음.png" style="margin-top:40px">	
		</div>

		<table class="table my-4" style="font-size: 10pt">
		  <thead>
		  <tr>
		      <th class="table-light" >나의 정보</th>
		      <td></td>
		      <td></td>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th>아이디(이메일)</th>
		      <td>leess@naver.com</td>
		      <td></td>
		    </tr>
		    <tr>
		      <th>이름</th>
		      <td>이순신</td>
		      <td>
		      <!-- Modal 시작-->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">이름 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    <tr>
		      <th>휴대폰번호</th>
		      <td>010-5556-5456</td>
		      <td>
		      
		      <!-- Modal 시작-->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModalphon">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModalphon">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">휴대폰번호 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    
		    <tr>
		      <th >배송지</th>
		      <td>서울특별시 마포구 쌍용아파트</td>
		      <td>
		     <!-- Modal -->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">배송지 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    
		    <tr>
		      <th style="font-size: 10pt">마지막 비밀번호 변경일자</th>
		      <td>2021/09/08</td>
		      <td>
		      <!-- Modal -->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">비밀번호 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    <tr>
		      <th></th>
		      <td></td>
		      <td>
		      <!-- Modal -->
		      <button type="button" class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		회원 탈퇴
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">회원탈퇴창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				        <button type="button" class="btn btn-primary">탈퇴</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		    </tr>

		  </tbody>
		</table>

	</div>
	<!-- row 끝 -->
	<!-- 중앙 컨텐츠 끝 -->

	<hr>

	<!-- 푸터 시작 -->
	<div id="footer">
		<div class="w3-light w3-center w3-padding-24">Powered by <a href="https://www.sist.co.kr/index.jsp" title="W3.CSS" target="_blank" class="w3-hover-opacity">©SSANGYONG</a></div>
	</div>


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
