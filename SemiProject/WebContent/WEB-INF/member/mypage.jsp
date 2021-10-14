<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <!-- jstl을 사용하기 위함  -->    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 


<jsp:include page="/WEB-INF/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 


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
   
   #tblMemberUpdate input {
   	border:none;
   } 
   
   
   .star { color: red;
           font-weight: bold;
           font-size: 12pt;
   } 
   
   
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
	var b_flagEmailDuplicateClick = false;
	// 수정하기 버튼 클릭시 "이메일 중복확인"을 클릭했는지 안 했는지를 알아보기 위한 용도이다.

	$(document).ready(function(){
		
		$("span.error").hide();
		

		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == ""){
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblMemberUpdate :input").prop("disabled", true);
				$(this).prop("disabled", false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberUpdate :input").prop("disabled", false);
				
				$(this).parent().find(".error").hide();		
			}
			
		});// end of $("inpu#name").blur(function(){})------------------
		
		
		$("input#pwd").blur(function(){
			
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	     	// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
				
			var pwd = $(this).val();
			
			var bool = regExp.test(pwd); // 정규표현식에 맞는지 test한다.
		
	     	if(!bool){ 
	     		// 암호가 정규표현식에 위배된 경우	
				$("table#tblMemberUpdate :input").prop("disabled",true); // 우선 다 input 못 하게 막아뒀다가
				$(this).prop("disabled",false); // pwd칸만 활성화시키자
		
				$(this).parent().find(".error").show(); // error 메시지 보이기
				$(this).focus(); // focuse를 pwd로
			}
			else{
				// 암호가 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled",false); // 다시 활성화
			 
			    $(this).parent().find(".error").hide(); // error메시지 숨기기
			}
		});// end of $("input#pwd").blur(function(){})----------------
		
		
		$("input#pwdcheck").blur(function(){
			
			var pwd = $("input#pwd").val();
			var pwdcheck = $("input#pwdcheck").val();
		
			if(pwd != pwdcheck){
				// 암호와 암호확인값이 다른 경우
				$("table#tblMemberUpdate :input").prop("disabled",true); // 우선 다 못하게 막아뒀다가
				$(this).prop("disabled",false); // pwdcheck칸만 활성화시키자
				$("input#pwd").prop("disabled",true); // pwd칸은 비활성화
				
				$(this).parent().find(".error").show(); // error메시지 보이기
				$("input#pwd").focus();
			}
			else{
				// 암호와 암호확인값이 같은 경우
				$("table#tblMemberUpdate :input").prop("disabled",false); // 다시 활성화

			    $(this).parent().find(".error").hide(); // error메시지 숨기기
			}
			
		}); // end of $("input#pwdcheck").blur(function(){})---------------
		
		
		$("input#email").blur(function(){ 
			
	        var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	     	// 이메일 정규표현식 객체 생성
	     	
			var email = $(this).val();
			
			var bool = regExp.test(email); //이메일이 정규표현식에 맞는지 test
		
	     	if(!bool){ 
	     		// 이메일이 정규표현식에 위배된 경우	
				$("table#tblMemberUpdate :input").prop("disabled",true); // 우선 다 못하게 막아뒀다가
				$(this).prop("disabled",false); // email칸만 활성화시키자
		
				$(this).parent().find(".error").show(); // error메시지 보이기
				$(this).focus(); // focus를 email로
			}
			else{
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled",false); // 다시 활성화
			 
			    $(this).parent().find(".error").hide(); // error메시지 숨기기
			}
			
		}); // end of $("input#email").blur(function(){})---------------
		
		
		$("input#hp2").blur(function(){
			
			var regExp = /^[1-9][0-9]{3}$/i;
			
			var hp2 = $(this).val();
			
			var bool = regExp.test(hp2);
			
			if(!bool){
				// 국번이 정규표현식에 위배된 경우
				$("table#tblMemberUpdate :input").prop("disabled", true);
				$(this).prop("disabled", false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled", false);
				$(this).parent().find(".error").hide();	
			}

		}); // end of $("input#hp2").blur(function(){})--------------
		
		
		$("input#hp3").blur(function(){
			
			var regExp = /^\d{4}$/i;
			
			var hp3 = $(this).val();
			
			var bool = regExp.test(hp3);
			
			if(!bool){
				// 정규표현식에 위배된 경우
				$("table#tblMemberUpdate :input").prop("disabled", true);
				$(this).prop("disabled", false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled", false);
				
				$(this).parent().find(".error").hide();		
			}	
		}); // end of $("input#hp3").blur(function(){})---------------
		
		
		
		$("img#zipcodeSearch").click(function(){
			 new daum.Postcode({
	               oncomplete: function(data) {
	                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                  var addr = ''; // 주소 변수
	                  var extraAddr = ''; // 참고항목 변수

	                  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                      addr = data.roadAddress;
	                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                      addr = data.jibunAddress;
	                  }

	                  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                  if(data.userSelectedType === 'R'){
	                      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                          extraAddr += data.bname;
	                      }
	                      // 건물명이 있고, 공동주택일 경우 추가한다.
	                      if(data.buildingName !== '' && data.apartment === 'Y'){
	                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                      }
	                      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                      if(extraAddr !== ''){
	                          extraAddr = ' (' + extraAddr + ')';
	                      }
	                      // 조합된 참고항목을 해당 필드에 넣는다.
	                      document.getElementById("extraAddress").value = extraAddr;
	                  
	                  } else {
	                      document.getElementById("extraAddress").value = '';
	                  }

	                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                  document.getElementById('postcode').value = data.zonecode;
	                  document.getElementById("address").value = addr;
	                  // 커서를 상세주소 필드로 이동한다.
	                  document.getElementById("detailAddress").focus();
	               }
	           }).open();               	
		}); // end of $("img#zipcodeSearch").click(function(){})-----------
		

		// 이메일값이 변경되면 "이메일중복확인"을 클릭했는지 안 했는지를 알아보기 위한 용도
		$("input#email").bind("change", function(){
			b_flagEmailDuplicateClick = false;
			
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	     	// 이메일 정규표현식 객체 생성
	     	
			var email = $(this).val();
			
			var bool = regExp.test(email); //이메일이 정규표현식에 맞는지 test
		
	     	if(!bool){ 
	     		// 이메일이 정규표현식에 위배된 경우	
				$("table#tblMemberUpdate :input").prop("disabled",true); // 우선 다 못하게 막아뒀다가
				$(this).prop("disabled",false); // email칸만 활성화시키자
		
				$(this).parent().find(".error").show(); // error메시지 보이기
				$(this).focus(); // focus를 email로
				$("span#emailCheckResult").html($("input#email").val()+" ").css("color","white");
				
			}
			else{
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblMemberUpdate :input").prop("disabled",false); // 다시 활성화
			 
			    $(this).parent().find(".error").hide(); // error메시지 숨기기
			    $("span#emailCheckResult").html($("input#email").val()+"은 사용가능합니다.").css("color","green");
				
			}
			
			
		});// end of $("input#email").bind("change", function(){})----------
		
	});// end of $(document).ready(function(){})-----------------
	
	
	// 이메일 중복여부 검사하기
	function isExistEmailCheck(){
		
		b_flagEmailDuplicateClick = true;
		// 수정하기 버튼 클릭시 "이메일중복확인"을 클릭했는지 안 했는지를 알아보기 위한 용도
		
		// 첫번째 방법
		$.ajax({
			url:"<%= ctxPath%>/member/emailDuplicateCheck.one",
			type:"post",
			data:{"email":$("input#email").val()},
			dataType:"json",
			success:function(json){
				
			if(json.isExists){
					
				// 세션에 올라온 email과 입력해준 eamil이 같은 경우(즉, 이메일을 수정하지 않고 그대로 사용할 경우)	
				if( "${sessionScope.loginuser.email}" == $("input#email").val() ){
					 $("span#emailCheckResult").html($("input#email").val()+"은 사용가능합니다.").css("color","green");
				}
				else{
				// 새로 변경하기 위해 입력한 email이 이미 사용 중이라면
					$("span#emailCheckResult").html($("input#email").val()+ " 은 이미 사용중이므로 사용불가합니다." ).css("color","orange");
					$("input#email").val("");
				}			
			}
			else{
				// 입력한 email이 DB테이블에 존재하지 않는 경우라면
				var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		     	// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
					
				var pwd = $(this).val();
				
				var bool = regExp.test(pwd); // 정규표현식에 맞는지 test한다.
			
		     	if(!bool){ 
		     		// 암호가 정규표현식에 위배된 경우	
					$("table#tblMemberUpdate :input").prop("disabled",true); // 우선 다 input 못 하게 막아뒀다가
					$(this).prop("disabled",false); // pwd칸만 활성화시키자
			
					$(this).parent().find(".error").show(); // error 메시지 보이기
					$(this).focus(); // focuse를 pwd로
				}
				else{
					// 암호가 정규표현식에 맞는 경우
					$("table#tblMemberUpdate :input").prop("disabled",false); // 다시 활성화
				 
				    $(this).parent().find(".error").hide(); // error메시지 숨기기
				    $("span#emailCheckResult").html($("input#email").val() + "은 사용가능합니다.").css("color", "green");			
				}

				
				}
			},
			error: function(request, status, error){
				 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); 	
	}// end of function isExistEmailCheck(){}------------
	
	// 수정하기
	function goEdit(){
		
		// * 필수입력사항에 모두 입력이 되었는지 검사한다.
		var boolFlag = false; 
		
		$("input.requiredInfo").each(function(){
			var data = $(this).val().trim();
			if(data == ""){ // data가 공백이라면
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				boolFlag = true;
				return false;
			}	
		});
		
		if(boolFlag){ // 필수입력사항이 모두 입력되었다면
			return;	
		}
		
		if(!b_flagEmailDuplicateClick){
			// "이메일 중복확인"을 클릭했는지 안 했는지를 알아본다.
			alert("이메일중복확인을 클릭하여 이메일중복검사를 하세요.");
			return;
		}
		
		var frm = document.editFrm;
		frm.action = "<%= ctxPath%>/member/memberEditEnd.one";
		frm.method = "post";
		frm.submit();
		
	}// end of function goEdit(){}----------------
	
	
</script>

	<!-- 상단 컨텐츠 시작 -->
	<div class="container" style="max-width:950px; margin-top:40px; height: 1300px;">
	<div class="row custom-topcontents">
		
	<form name = "editFrm">
		<div id="head">
			<span style="font-size: 26pt"><b>&nbsp;계정 관리</b></span><br>
			<span class="mt-1"style="font-size: 10pt; margin-left:9px;">로그아웃을 하고 싶으신가요?</span>
			<a href="<%= ctxPath %>/login/logout.one"><button type="button" class="btn btn-link btn-sm text-body" style="text-decoration:underline">  
		  		로그아웃
			  </button></a>
		</div>
			<img class="w3-image" width="900" height="300" src="<%= ctxPath%>/images/제목 없음.png" style="margin-top:40px">	
		</div>

		<table id="tblMemberUpdate" class="table my-4" style="font-size: 10pt; border-collapse:separate; border-spacing:40px 30px">
		 
		  <tbody>
		    
		    <tr>
		      <th>이름&nbsp;<span class="star">*</span></th>	  
		   		<td> <input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/> 
             		 <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required/> 
           			 <span class="error">성명은 필수입력 사항입니다.</span>
           		</td>
			  </tr>
		 	     	   
		 	 <tr>
		 	 	<th>비밀번호&nbsp;<span class="star">*</span></th>
		 	 	<td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" required/>
           			 <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
        		</td>
		 	 </tr>
		 	 
		 	 <tr>
		 	 	<th>비밀번호 확인&nbsp;<span class="star">*</span></th>
		 	 	<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" required/> 
            		<span class="error">암호가 일치하지 않습니다.</span>
         		</td>
		 	 </tr>
		 	     	   
		 	     	   
		 	     	    
		    <tr>
		      <th>이메일&nbsp;<span class="star">*</span></th>      	      
		      <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" required/> 
	              <span class="error">이메일 형식에 맞지 않습니다.</span>
	               
	              <span style="display: inline-block; width: 80px; height: 20px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
	              <span id="emailCheckResult"></span>     
        	  </td>
		    </tr>
    
		    <tr>
		      <th>연락처</th>	      
		      <td style="width: 80%; text-align: left;">
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7)  }" />&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11)  }" />
             <span class="error">휴대폰 형식이 아닙니다.</span>
         	 </td>
		    </tr>

			<tr>
		      <th >우편번호</th>	      
		      <td style="width: 80%; text-align: left;">
              	<input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode}" size="6" maxlength="5" />&nbsp;&nbsp;
              	<%-- 우편번호 찾기 --%>
	            <img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" />
	            <span class="error">우편번호 형식이 아닙니다.</span>
         	  </td>
		    </tr>

		    <tr>
	    	  <th>주소</th>
	          <td style="width: 80%; text-align: left;">
           		<input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40" /><br/>
           		<input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="40" class="mt-1"/>&nbsp;<input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40"/> 
           			<br>
           		<span class="error">주소를 입력하세요</span>
         	   </td>
		    </tr>
		    	      

		    <tr>     
		      <td>
		      <td><button type="button" id="btnUpdate"class="btn btn-dark mt-3 mr-3" onClick="goEdit()" style="border-radius: 40px; margin-left:400px; font-size: 10pt">  
		  		<b>수정하기</b>
			  </button>
		     
		      <!-- Modal -->
		      <button type="button" id="btnUpdate" class="btn btn-outline-dark mt-3 " data-toggle="modal" style="border-radius: 40px; font-size: 10pt" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		<b>계정 탈퇴</b>
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
				        <button type="button" class="btn btn-primary" >계정 탈퇴</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		    </tr>

		  </tbody>
		</table>
		</form>
	</div>
	<!-- row 끝 -->
	<!-- 중앙 컨텐츠 끝 -->

	<hr>


</body>
</html>


<jsp:include page="/WEB-INF/footer.jsp"/>