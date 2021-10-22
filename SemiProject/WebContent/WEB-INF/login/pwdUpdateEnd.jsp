<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    
    
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<style>
   #div_pwd {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   #div_pwd2 {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   #div_updateResult {
      width: 90%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;      
      position: relative;
   }
   
   #div_btnUpdate {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error1").hide();
		$("span.error2").hide();
		
		// === 비밀번호1 유효성 검사 ===
		$("input#pwd").blur(function(){
			
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		    // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			var pwd = $(this).val();
		    var bool = regExp.test(pwd);
		    
		    if(!bool){
		    	// 이메일이 정규표현식에 위배된 경우
		    	$(this).val("")
		    	$("span.error1").show();
		    	$(this).focus();
		    }
		    else{
		    	// 이메일이 정규표현식에 맞는 경우
		    	$("span.error1").hide();
		    }   
		});// end of $("input#pwd").blur(function(){})------------
		
		// === 비밀번호2 유효성 검사 ===
		$("input#pwd2").blur(function(){
			
			var pwd = $("input#pwd").val();
			var pwd2 = $("input#pwd2").val();
			
			if(pwd != pwd2){
				// 비밀번호가 일치하지 않는 경우
				$("span.error2").show();
				$("input#pwd").val("");
				$(this).val("");
				$(this).focus();
			}
			else{
				// 일치하는 경우
				$("span.error2").hide();
			}
			
		});// end of $("input#pwd2").blur(function(){})-----------
		
		
		 // === 새 비밀번호 저장 클릭 === 
		 $("button#btnUpdate").click(function(){ 
		    	
		 	var pwd = $("input#pwd").val().trim();
		 	var pwd2 = $("input#pwd2").val().trim();
		 	
		 	if(pwd != "" && pwd2 != "") { 
		 		// 비밀번호와 비밀번호 확인을 모두 입력했다면
	 			var frm = document.pwdUpdateEndFrm;
        		frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.one";
        		frm.method="POST";
        		frm.submit();   
		 	}
		 	else{
		 		alert("새로운 비밀번호를 입력하세요!!");
		 		return;
		 	}	 	    
		}); // end of $("button#btnUpdate").click(function(){})------------
		

	}); // end of $(document).ready(function(){})----------------------

</script>

<form name="pwdUpdateEndFrm" style="margin-top:90px">
   <div id="div_pwd">
      <input type="password" name="pwd" id="pwd" size="40" style="height: 60px; margin:40px 0 0 53px; font-size: 18pt" placeholder="새로운 비밀번호" required />
   	  <span style="font-size:14pt; white-space : nowrap; color:#cc0014; margin-left:54px" class="error1">암호는 영문자, 숫자, 특수기호가 혼합된 8~15 글자로 입력하세요.</span>
   </div>
   
   <div id="div_pwd2">
      <input type="password" name="pwd2" id="pwd2" size="40" style="height: 60px; margin:7px 0 0 53px; font-size: 18pt" placeholder="새로운 비밀번호 확인" required />
   	  <br><span style="font-size:9pt; color:#cc0014; margin-left:54px" class="error2">암호가 일치하지 않습니다.</span>
   </div>
   
   <input type="hidden" name="userid" value="${requestScope.userid}" /> 
	
	<c:if test="${requestScope.method == 'GET'}">
		<div id="div_btnUpdate" >		
			<button type="button" class="btn" id="btnUpdate" style=" background-color:#00579c; color:white; margin-left:50px; border-radius: 50px; font-size:18px; width: 520px; height:70px">
			<b>새로운 비밀번호 저장</b></button>
     	</div>
	</c:if>	
	
<c:if test="${requestScope.method == 'POST' && requestScope.n == 1}">
		<div id="div_updateResult" style="font-size: 18pt; margin-left:50px" class="mt-4"><b>${requestScope.userid}님의 비밀번호가 변경되었습니다.</b><br>
        </div> 
</c:if>
</form>


    