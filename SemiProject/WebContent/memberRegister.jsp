<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!doctype html>
<html lang="ko">

<style>
   table#tblMemberRegister {
          width: 93%;
          
          /* 선을 숨기는 것 */
          border: hidden;
          
          margin: 10px;
   }  
   
   table#tblMemberRegister #th {
         height: 40px;
         text-align: center;
         background-color: silver;
         font-size: 14pt;
   }
   
   table#tblMemberRegister td {
         /* border: solid 1px gray;  */
         line-height: 30px;
         padding-top: 18px;
         padding-bottom: 8px;
   }
   
   .star { color: red;
           font-weight: bold;
           font-size: 13pt;
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
		
		$("span.error").hide();
				
	});


</script>	



  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>회원가입</title>
	<link rel="icon" href="./images/ico2.jpg">


    
<body>
  <div class="container ">
 
	
<!-- 상단 네비게이션 시작 -->
<div class="container" style="max-width:1500px">      

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

	<!-- 상단 컨텐츠 시작 -->
		
<div class="container" style="max-width:850px"> 
	<div class="row custom-topcontents">
		<div class="col-md-5">
			<h4 class="bg-primary text-white"><b>&nbsp;IKEA Family 회원가입</b></h4>
			<!-- <p class="h7">외워야 할 비밀번호가 많아 불편하셨죠?이제 일회용 코드를 이용하여 간편하게 로그인하세요.</p> -->
		
		</div>
	
	
  	<img class="w3-image w-900 ml-2" src="./images/제목 없음.png">	 
  	
  		 
	<div class="row" id="divRegisterFrm">
	   <div class="col-md-12" >
	   <form name="registerFrm">
	   <table id="tblMemberRegister">
	      <thead>
	      </thead>
	      <tbody>
	      <tr>
	         <td style="width: 10%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" name="name" id="name" class="requiredInfo" /> 
	            <span class="error">성명은 필수입력 사항입니다.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp;
	             <!-- 아이디중복체크 -->
	              <img id="idcheck" src="<%= ctxPath%>/images/b_id_check.gif" style="vertical-align: middle;" />
	             <span id="idcheckResult"></span>
	             <span class="error">아이디는 필수입력 사항입니다.</span>
	         </td> 
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />
	            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
	            <span class="error">암호가 일치하지 않습니다.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" /> 
	             <span class="error">이메일 형식에 맞지 않습니다.</span>
	             
	            
	             <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
	             <span id="emailCheckResult"></span>
	            
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">연락처</td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
	             <span class="error">휴대폰 형식이 아닙니다.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">우편번호</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
	           
	            <img id="zipcodeSearch" src="<%= ctxPath%>/images/b_zipcode.gif" style="vertical-align: middle;" />
	            <span class="error">우편번호 형식이 아닙니다.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">주소</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
	            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
	            <span class="error">주소를 입력하세요</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">성별</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
	            <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">생년월일</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" style="width: 80px;" required />
	            
	            <select id="birthmm" name="birthmm" style="margin-left: 2%; width: 60px; padding: 8px;">
	             
	            </select> 
	            
	            <select id="birthdd" name="birthdd" style="margin-left: 2%; width: 60px; padding: 8px;">
	             
	            </select> 
	         </td>
	      </tr>
	      
	    <!--   <tr>
	         <td style="width: 20%; font-weight: bold;">생년월일</td>
	         <td style="width: 80%; text-align: left;">
	            <input type="text" id="datepicker">
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">재직기간</td>
	         <td style="width: 80%; text-align: left;">
	            From: <input type="text" id="fromDate">&nbsp;&nbsp; 
	            To: <input type="text" id="toDate">
	         </td>
	      </tr> -->
	         
	      <tr>
	         <td colspan="2">
	            <label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
	         </td>
	      </tr>
	      <tr>
	         <td colspan="2" style="text-align: center; vertical-align: middle;">
	         <!-- iframe 태그가 문서를 넣어주는곳이다 -->
	            <iframe src="../iframeAgree/agree.html" width="100%" height="150px" class="box" ></iframe>
	         </td>
	      </tr>
	      <tr>
	         <td colspan="2" style="line-height: 90px;" class="text-center">
	
	            <button type="button" id="btnRegister" class="btn btn-dark btn-lg" onClick="goRegister();">가입하기</button> 
	         
	         </td>
	      </tr>
	      </tbody>
	   </table>
	   </form>
	   </div>
	</div>
		
		 	

		
		</div>
		
	</div>
	<!-- row 끝 -->
	<!-- 중앙 컨텐츠 끝 -->
</div>

	<hr>

	<!-- 푸터 시작 -->
	<div id="footer">
		<div class="w3-light w3-center w3-padding-24">Powered by <a href="https://www.sist.co.kr/index.jsp" title="W3.CSS" target="_blank" class="w3-hover-opacity">©SSANGYONG</a></div>
	</div>
	
 <!-- .container 끝 -->


	
</body>
</html>