<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>




<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>



<style type="text/css">

   body {
    /*   border: solid 1px gray; */
      margin: 0;
      padding: 0; 
      font-family: Arial, "MS Trebuchet", sans-serif;
      word-break: break-all; /* 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
   }
   
   div#container {
    /*   border: solid 1px blue; */
      width: 80%;
      margin: 0 auto;
   }
   
   legend {
      font-size: 20pt;
   }
   
   ul {
    /*   border: solid 1px red; */ 
      list-style-type: none;
      padding: 0;
   }
   
   ul > li {
      line-height: 40px;
   }

   label.title {
    /*   border: solid 1px blue; */
      display: inline-block;
      width: 100px;
      color: navy;
      font-weight: bold;
   }

    input.myinput {
       height: 20px;
    }

   input[type=button] , input[type=reset] {
      width: 100px;
      height: 40px;
      background-color: #00579c;
      color: #fff;
      font-size: 16pt;
      margin: 20px 0 0 40px;
      border: none;
      border-radius: 12px;
      cursor: pointer;
   }
   
   /* CSS 로딩 구현 시작(bootstrap 에서 가져옴) */
	.loader {
	  border: 13px solid #f3f3f3;
	  border-radius: 50%;
	  border-top: 13px solid #3498db;
	  width: 30px;
	  height: 30px;
	  -webkit-animation: spin 2s linear infinite; /* Safari */
	  animation: spin 2s linear infinite;
	}
	
	/* Safari */
	@-webkit-keyframes spin {
	  0% { -webkit-transform: rotate(0deg); }
	  100% { -webkit-transform: rotate(360deg); }
	}
	
	@keyframes spin {
	  0% { transform: rotate(0deg); }
	  100% { transform: rotate(360deg); }
	}
	/* CSS 로딩 구현 끝(bootstrap 에서 가져옴) */
   
   

</style>


<script>

	$(document).ready(function(){
		
		$("input.userid").val("${requestScope.userid}");
		
		
		 $(".loader").hide(); // CSS 로딩화면 감추기
		
		
		// 찾기
		$("input#OK").click(function(){
			
			$(".loader").show();
			
			var useridVal = $("input#userid").val().trim();
			var pwdVal = $("input#pwd").val().trim();
			var emailVal = $("input#email").val().trim();
			
			
			
			// 아이디 및 이메일에 대한 정규표현식을 사용한 유효성검사는 생략하겠습니다.
			if( useridVal != "" && pwdVal !="" && emailVal != "" ) {
				
				
				var frm = document.restart;
				frm.action = "<%= ctxPath%>/login/restart.one";
				frm.method = "POST";
				frm.submit();
				
			}
			else {
				alert("값을 모두 입력해주세요!!");
				return;
			} 

		});// end of $("input#OK").click(function(){})----------------
		
		
		

		// 인증하기
		$("button#btnConfirmCode").click(function(){
			
			var frm = document.verifyCertificationFrm;
			
		//	frm.useridHidden.value = ${requestScope.userid};
			frm.userCertificationCode.value = $("input#input_confirmCode").val();  /* form에 input_confirmCode의 value값을 담음 */
			
			frm.action = "<%= ctxPath%>/login/verifyCertification_jy.one";
			frm.method = "POST";
			frm.submit();
			
			
		}); // end of $("button#btnConfirmCode").click(function(){})------------------------------

		
	}); // end of $(document).ready(function(){})-=

	
</script>


<body>
	<form action="" name="restart">
		<div class="container">
		<!-- <nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none; z-index:2; width:240%; min-width:300px" id="sidebarId"> -->
			   <div class="container" style="float:left; color:white; background-color:#00579c; max-width:800px; height:1000px; "> 
				  <a class="navbar-brand" href="<%= ctxPath%>/index.one"><img src="<%= ctxPath%>/images/logo2.jpg" alt="IKEA_logo" width="87" height="36" style="margin-top: 50px; margin-left: 30px"/></a>			  
				  <div style="margin-top:120px; margin-left:150px; margin-right:100px">
					  	<span style="font-size:50px; margin-left:30px;"><b>휴면해제</b></span><br>
					  	<span style="font-size:19px; margin-left:30px; " >휴면해제 후 정상적으로 이용이 가능합니다.</span>
				  </div>
			   </div>
			   
		   
	        	<div id="restart">
	        		<div style="border: none; margin:0 0 0 90px; width:850px; height: 350px;" >
			    		<ul style=" padding:300px 0 50px 1000px; width:450px; height: 350px;">
			               <li>
			                  <label class="title" for="userid" style="color: black;">아이디</label>
			                  <input type="text" class="myinput" name="userid" id="userid" size="20" style="height: 40px; width: 200px;" maxlength="20" autofocus required placeholder="예: hongkildong" />          
			                  <span></span>
			               </li>
			               
			               <li style="margin-top: 10px">
			                  <label class="title" for="passwd1" style="color: black;">패스워드</label>
			                  <input type="password" class="myinput" name="pwd" id="pwd" style="height: 40px; width: 200px;" size="20" maxlength="20" required />
			                  <span></span>
			               </li>
			               <li style="margin-top: 10px; margin-bottom: 20px;">
			                  <label class="title" for="email" style="color: black;">이메일</label>
			                  <input type="email" class="myinput" name="email" id="email" style="height: 40px; width: 200px;" size="20" maxlength="20" required placeholder="인증번호를 받으실 이메일" />           
			               	<div style="display: flex">
   								<div class="loader" style="margin-right: 100px;"></div>
  							</div>
			               </li>
			                
			             
							 <c:if test="${requestScope.isUserRestart == false}">
							 	<span style="color: red; padding-left: 30px; ">사용자 정보를 바르게 입력해주세요</span>
							 </c:if>
							 
							 <c:if test="${requestScope.isUserRestart == true && requestScope.sendMailSuccess == false}">
							 	<span style="color: red; padding-left: 30px; ">메일발송이 실패했습니다.</span>
							 </c:if>
			                <c:if test="${requestScope.isUserRestart == true && requestScope.sendMailSuccess == true}">
							 	<span style="font-size: 10pt; padding-left: 10px; ">인증코드가 ${requestScope.email}로 발송되었습니다.</span><br>
						   	    <span style="font-size: 10pt; padding-left: 90px; ">인증코드를 입력해주세요.</span><br>
						   	    <input style="margin-left: 70px; margin-top: 20px; height: 30px; width: 200px; " type="text" name="input_confirmCode" id="input_confirmCode" required />
						   	    <br>
	   	    					<!-- 남은시간<span id ="timer" style="font-size: 10pt; color: red; padding-left: 120px;" ></span> -->
						   	    <br><br>
						   	    <button style="margin-left: 130px;" type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>
							 </c:if>
							 
			               <li>
			                  <input id="OK" type="button"  style="margin-left: 80px; margin-top:50px; width: 180px;" value="확인" />
			               </li>
			            </ul>
	       	 		</div>
	        	</div>
        	</div>
 	</form>       

</body>


<form name="verifyCertificationFrm">
	<input type="hidden" class="userid" name="userid" />
	<input type="hidden" name="userCertificationCode" />
</form>
 
