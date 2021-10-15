<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    
<!-- header, footer가 아님 독립적으로 쓰인다. -->
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

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		var method = "${requestScope.method}";
		console.log("method => " + method);
		
		if(method == "GET"){
			$("div#div_findResult").hide();
		}
		else if (method == "POST") { // else도 가능한
			
			$("input#name").val("${requestScope.name}");
			$("input#email").val("${requestScope.email}");
		}
		
		// === 이메일 유효성 검사 ===
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
				$("span#error").hide();
			}	
		});// end of $("input#email").blur(function(){})--------------
		
		
		// === 아이디 찾기 버튼 클릭 ===
		$("button#btnFind").click(function(){
			
			// 찾기 버튼 클릭시 유효성검사 다시 진행
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	 			     	
			var email = $("input#email").val();
			var bool = regExp.test(email);
			
			if(!bool){
				// 이메일이 정규표현식에 위배된 경우
				$("span.error").show();
				$("input#email").focus();
			}
			else{
				// 이메일이 정규표현식에 맞는 경우
				$("span#error").hide();
				
				var frm = document.idFindFrm;
				frm.action = "<%= ctxPath%>/login/idFind.one";
				frm.method = "post";
				frm.submit();
			}
		});

	});


</script>




<form name="idFindFrm" style="font-size:13px">
		   
		   <ul style="list-style-type: none; margin-top: 70px" >
		         <li class="my-3">
		            <label for="userid" style="display: none">성명</label>
		            <input type="text" name="name" id="name" size="50" class="ml-4" style="height: 35px" placeholder="성명" autocomplete="off" required />
		         </li>
		         <li class="my-4">
		            <label for="userid" style="display: none">이메일</label>
		            <input type="text" name="email" id="email" size="50" class="ml-4" style="height: 35px" placeholder="이메일" autocomplete="off" required /><br>
		        	<span class="error mt-2 ml-3" style="color:#cc0014">이메일 형식에 맞지 않습니다.</span>
		         </li>
		   </ul>
		   
		   <div class="my-4">
		    <p class="text-center">
		       <button type="button" class="btn" id="btnFind" style="margin-left:33px; background-color:#00579c; color:white; border-radius: 50px; font-size:13px; width: 354px; height:50px"><b>아이디 찾기</b></button>
		    </p>
		   </div>
		
		   
		   <div class="my-3" id="div_findResult">
		      <p class="text-center">
		           	가입하신 아이디는&emsp;<span style="font-size: 16pt; font-weight: bold;">${requestScope.userid}</span>
		      </p>
		   </div>
	   
	
	</form> 
