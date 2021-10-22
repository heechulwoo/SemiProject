<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
   String ctxPath = request.getContextPath();
    //     /MyMVC
%>  

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Font Awesome 5 Icons -->
<script src="https://kit.fontawesome.com/69a29bca1e.js" crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
<style>
      html,
   /*   body {
        width: 30%;
        height: 30%;
        margin: 0;
        color:#00579c;
      } */
      .loader {
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        color:#00579c;
      }
    </style>
<script type="text/javascript">

      $(document).ready(function(){
    	 
    	  $(".loader").hide();
    	  $("span.error").hide();
    	  
    	  var method = "${requestScope.method}";
             console.log("method => " + method);
          
           if(method == "GET") {
              $("div#div_findResult").hide();
           }
           else if(method == "POST") {
              $("input#userid").val("${requestScope.userid}");
              $("input#email").val("${requestScope.email}");
              $("div#div_findResult").show();
               
              if( ${requestScope.sendMailSuccess == true } ){
            	  $("div#div_btnFind").hide();
              }
           }   

           
        	// === 이메일 유효성 검사===  	    
			  $("input#email").blur(function(){	    	
		    	
				var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	 			     	
		    	var email = $(this).val();
		    	var bool = regExp.test(email);
		    	
		    	if(!bool){
		    		// 이메일이 정규표현식에 위배된 경우					
					$("span.error").show();
		    		$(this).focus();
		    	}
		    	else{
		    		// 이메일이 정규표현식에 맞는 경우
		    		$("span.error").hide();
		    	}
		    });//end of $("input#email").blur(function(){}------------- 
           
		    		
    	  	// === 비밀번호 찾기 버튼 클릭 ===
    	  	$("button#btnFind").click(function(){
         
		         var useridVal = $("input#userid").val().trim();
		         var emailVal = $("input#email").val().trim();
		        
		         if( useridVal != "" && emailVal != "" ) {
		        	$(".loader").show();
		        	$(".FindFrm").hide();
		            var frm = document.pwdFindFrm;
		            frm.action = "<%= ctxPath%>/login/pwdFind.one";
		            frm.method = "POST";
		            frm.submit();
		         }
		         else {
		            alert("아이디와 이메일을 입력하세요!!");
		            return;
		         }
    		}); // end of $("button#btnFind").click(function(){})------------	
		    
		         	
		    		
    	  	// === 이메일로 인증키를 받은 후 인증하기 ===
    	  	$("button#btnConfirmCode").click(function(){
    	  
	 		  var frm = document.verifyCertificationFrm;
	 		  
	 		  frm.userid.value = $("input#userid").val();
	 		  frm.userCertificationCode.value = $("input#input_confirmCode").val();
	 		  
	 		  frm.action = "<%= ctxPath%>/login/verifyCertification.one";
	 		  frm.method = "POST";
	 		  frm.submit();
    	  	}); // end of $("button#btnConfirmCode").click(function(){})-------------------

    	  			  
    	  	
    	 	 
    	  	
    	  	
      }); 
      
</script>
<%-- CSS 로딩화면 구현한것--%>
		   <div class="container" style="display:flex">
		   		<div class="loader" style="margin:auto"><i class="fas fa-spinner fa-6x fa-spin"></i></div>
				<p class="loader ml-4" style="white-space: nowrap; margin-top:20px"><b>이메일 전송 중...</b></p>
			</div>
<div class="FindFrm">	
<form name="pwdFindFrm" id="pwdFindFrm" style="font-size:20px">
   <ul style="list-style-type: none; margin-top: 150px" id="pwdFindFrm">
         <li class="my-3">
            <label for="userid" style="display: none">성명</label>
			<input type="text" name="userid" id="userid" size="50" style="height: 60px"  placeholder="아이디" autocomplete="off" required />
		 </li>
         <li class="my-4">
             <label for="userid" style="display: none">이메일</label>
		     <input type="text" name="email" id="email" size="50" style="height: 60px" placeholder="이메일" autocomplete="off" required />
	     	 <br>
	     	 <span class="error" style="color:#cc0014">이메일 형식에 맞지 않습니다.</span>
	     </li>
   </ul>
   <div class="my-4" id="div_btnFind">
        <p class="text-center">
           <button type="button" class="btn" id="btnFind" style="margin-left:37px; background-color:#00579c; color:white; border-radius: 50px; font-size:18px; width: 540px; height:70px">
           <b>비밀번호 찾기</b></button>
        </p>   
   </div>

   <div class="my-3 ml-4" id="div_findResult">
        <p class="text-center">
	       <c:if test="${requestScope.isUserExist == false}">
	          <span style="color: #cc0014;">사용자 정보가 없습니다.</span>
	       </c:if>
	       
	       <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
	          <span style="color: #cc0014;">메일발송이 실패했습니다.</span>
	       </c:if>
	       
	       <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
	          <span style="font-size: 10pt;">인증코드가 ${requestScope.email}로 발송되었습니다.</span><br>
              <span style="font-size: 10pt;">인증코드를 입력해주세요.</span><br>
              <input type="text" name="input_confirmCode" id="input_confirmCode" class="mt-2" required />
              <br><br>
              <button type="button" class="btn" id="btnConfirmCode" style="background-color:#00579c; color:yellow; border-radius: 50px; font-size:14px; width: 300px; height:50px; margin-left:10px">
              	<b>인증하기</b></button>
	       </c:if>
	 </p>
   </div>   
      
</form>
</div>		

<form name="verifyCertificationFrm">
	<input type="hidden" name="userid" />
	<input type="hidden" name="userCertificationCode" />
</form>


