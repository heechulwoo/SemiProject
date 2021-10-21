<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    

<jsp:include page="/WEB-INF/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

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
   
   div#container {
   font-family: Arial
   }
   
   
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		$("input#name").focus(); // 첫번째 input인 name에 focus
				
		$("input#name").blur(function(){ // focus가 있다가 잃었을 때
			
			var name = $(this).val().trim();
			if(name == ""){ // 입력하지 않거나 공백만 입력한 경우
				$("table#tblMemberRegister :input").prop("disabled", true); // 우선 다 막아뒀다가
				$(this).prop("disabled", false); // 성명칸만 활성화시키자
				// .prop는 속성값을 가져오거나 추가한다.
				
				$(this).parent().find(".error").show(); // error 메시지 보이게
				$(this).focus(); // focus를 name으로
			}
			else { // 공백이 아닌 글자를 입력했을 경우
				
				$("table#tblMemberRegister :input").prop("disabled", false);
			
				$(this).parent().find(".error").hide();
				
			}
			
			
		}); // end of $("input#name").blur(function(){})-----------------
		
		
		$("input#userid").blur(function(){
			
			var userid = $(this).val().trim();
			if(userid == ""){
				$("table#tblMemberRegister :input").prop("disabled", true); // 우선 다 막아뒀다가
				$(this).prop("disabled", false); // 성명칸만 활성화시키자
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				$("table#tblMemberRegister :input").prop("disabled", false);
				$(this).parent().find(".error").hide();
			}
	
		}); // end of $("input#userid").blur(function(){})-------------
		
		
		
		$("input#pwd").blur(function(){
			
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var pwd  = $(this).val();
			
			var bool = regExp.test(pwd); // 정규표현식에 맞는지 test한다.
			
			if(!bool){
				$("table#tblMemberRegister :input").prop("disabled", true);
				$(this).prop("disabled", false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				$("table#tblMemberRegister :input").prop("disabled", false);
				
				$(this).parent().find(".error").hide();
			}
		
		}); // end of $("input#pwd").blur(function(){})---------------
		
		
		$("input#pwdcheck").blur(function(){
			
			var pwd = $("input#pwd").val();
			var pwdcheck = $("input#pwdcheck").val();
			
			if(pwd != pwdcheck){
				
				$("table#tblMemberRegister :input").prop("disabled", true);
				$(this).prop("disabled", false);
				$("input#pwd").prop("disabled", true);
				
				$(this).parent().find(".error").show();
				$("input#pwd").focus();
			}
			else {
				$("table#tblMemberRegister :input").prop("disabled", false);
				$(this).parent().find(".error").hide();		
			}
			
		}); // end of $("input#pwdcheck").blur(function(){})------------------
		
		
		$("input#email").blur(function(){
			
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			
			var email = $(this).val();
			
			var bool = regExp.test(email);
			
			if(!bool){
				$("table#tblMemberRegister :input").prop("disabled", true);
				$(this).prop("disabled", false);
				
				$(this).parent().find(".error").show();
				$(this).focus();				
			}
			else{
				$("table#tblMemberRegister :input").prop("disabled", false);
				$(this).parent().find(".error").hide();
			}
		}); // end of $("input#email").blur(function(){})--------------
		
		
		$("input#hp2").blur(function(){
			
			var regExp = /^[1-9][0-9]{3}$/i;
			
			var hp2 = $(this).val();
			
			var bool = regExp.test(hp2);
			
			if(!bool){
				$("table#tblMemberRegister :input").prop("disabled", true);
				$(this).prop("disabled", false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
				
			}
			else{
				$("table#tblMemberRegister :input").prop("disabled", false);
				$(this).parent().find(".error").hide();
				
			}
		});// end of $("input#hp2").blur(function(){})------------------
		
		
		$("input#hp3").blur(function(){ // focus가 있다가 잃었을 때
			
		    //  var regExp = /^[0-9]{4}$/i;
		    //  또는  
		        var regExp = /^\d{4}$/i;
		     	// 숫자 4자리만 들어오도록 검새해주는 정규표현식 객체 생성
		     	
				var hp3 = $(this).val();
				
				var bool = regExp.test(hp3);
			
		     	if(!bool){ 
		     		// 마지막 전화번호 4자리가 정규표현식에 위배된 경우	
					$("table#tblMemberRegister :input").prop("disabled",true); // 우선 다 못하게 막아뒀다가
					$(this).prop("disabled",false); // 성명칸만 활성화시키자
			
					$(this).parent().find(".error").show();
					$(this).focus();
				}
				else{
					// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
					$("table#tblMemberRegister :input").prop("disabled",false); // 다시 활성화
				 
				    $(this).parent().find(".error").hide();
				}
				
			}); // end of $("input#hp3").blur(function(){})-------------------
		
			
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
	      	});
		//////////////////////////////////////////////////////////
		var mmhtml = "";
		for(var i=1; i<=12; i++){
			if(i<10){
				mmhtml += "<option>0"+i+"</option>";
			}
			else{
				mmhtml += "<option>"+i+"</option>";
			}
		}// end of for----------------
		
		$("select#birthmm").html(mmhtml);
		
		var ddhtml = "";
		for(var i=1; i<=31; i++) {
			if(i<10){
				ddhtml += "<option>0"+i+"</option>";
			}
			else{
				ddhtml += "<option>"+i+"</option>";
			}
		}// end of for---------------------
		
		$("select#birthdd").html(ddhtml);
		
		// =================== 아이디 중복검사하기  ===================
		$("img#idcheck").click(function(){
		
			b_flagIdDuplicateClick = true;
			// 가입하기 버튼을 클릭시 "아이디중복확인"을 클릭했는지 안했는지 알아보기 위한 용도임
			
			$.ajax({
				url:"<%= ctxPath%>/member/idDuplicateCheck.one",
				type:"post",
				data:{"userid":$("input#userid").val()},
				dataType:"json",
				success:function(json){
					
					if(json.isExists){
						// 입력한 userid가 이미 사용 중이라면
						$("span#idcheckResult").html($("input#userid").val()+" 은 이미 사용 중이므로 사용불가합니다.").css("color", "orange");
						$("input#userid").val("");
					}
					else{
						// 입력한 userid가 DB 테이블에 존재하지 않는 경우라면
						$("span#idcheckResult").html($("input#userid").val()+" 은 사용가능합니다.").css("color", "green");
					}
				},
				error: function(request, status, error){
					alert("code: " +request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					
				}
			});
			
		});// end of $("img#idcheck").click(function(){})----------------
		
		
		// 아이디값이 변경되면 가입하기 버튼을 클릭시 "아이디 중복확인"을 클릭했는지 안 했는지 알아보기 위한 용도
		$("input#userid").bind("change", function(){
			b_flagIdDuplicateClick = false; // 다시 초기화
		});
		
		// 이메일값이 변경되면 "이메일 중복확인"을 클릭했는지 안 했는지 알아보기 위한 용도
		$("input#email").bind("change", function(){
			b_flagEmailDuplicateClick = false;
		});
		
	});// end of $(document).ready(function(){})----------------

	
	
	// =================== 이메일 중복검사하기  ===================
	
	function isExistEmailCheck(){
		
		b_flagEmailDuplicateClick = true;
        // 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
   		
   	 // 첫번째 방법
   	 $.ajax({
   		 url:"<%= ctxPath%>/member/emailDuplicateCheck.one", 
   		 type:"post",
   		 data:{"email":$("input#email").val()},
   		 dataType:"json",	 
   		 success:function(json){ // json 타입으로 온다.
                
              if(json.isExists){
             	 // 입력한 email이 이미 사용 중이라면
             	 $("span#emailCheckResult").html($("input#email").val()+ " 은 이미 사용중이므로 사용불가합니다.").css("color","orange");
             	 $("input#email").val("");
              }
              else{
             	 //입력한 email이 DB 테이블에 존재하지 않는 경우라면
             	 $("span#emailCheckResult").html($("input#email").val()+" 은 사용가능합니다.").css("color","green");
              }

   		 },
   		 error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         }  		 
   	  });					
		
	}// end of function isExistEmailCheck(){})---------------------
	

	// 가입하기
	function goRegister(){
		
		// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
		var boolFlag = false; 
		
		$("input.requiredInfo").each(function(){
			var data = $(this).val().trim();
			if(data == ""){ // data가 공백이라면
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				boolFlag = true;
				return false; 				
			}
		});
		
		if(boolFlag){
			return; // 종료
		}
		
		var radioCheckedLength = $("input:radio[name=gender]").length;
		
		if(radioCheckedLength == 0){ // 성별 radio가 체크되지 않았다면
			alert("성별을 선택하셔야 합니다.");
			return; // 종료
		}
		
		var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length;
		
		if(checkboxCheckedLength == 0){ // 동의 checkbox가 체크되지 않았다면
			alert("이용약관에 동의하셔야 합니다.");
			return; // 종료
		}
		
		if(!b_flagIdDuplicateClick){ // ID중복검사를 클릭하지 않았다면
			alert("아이디중복확인 클릭하여 ID중복검사를 하세요.");
			return; // 종료
		}
		
		if(!b_flagEmailDuplicateClick){ // email중복검사를 클릭하지 않았다면
			alert("이메일중복확인 클릭하여 이메일중복검사를 하세요.");
			return; // 종료
		}
		
		var frm = document.registerFrm;
		frm.action = "memberRegister.one";
		frm.method = "post";
		frm.submit();
		
		
	}// end of function goRegister(){}---------------
	

	
</script>	




  <!-- 상단 컨텐츠 시작 -->
  <div class="container" style="max-width:850px; margin-top:40px; height:1500px; font-family:'Verdana'">
	<div class="row custom-topcontents">
		<h1>&nbsp;<b>회원 가입</b></h1>
			<img class="w3-image" width="1000" height="300" src="<%= ctxPath%>/images/제목 없음.png" style="margin-top:40px">	
		</div>
	
	<div class="row" id="divRegisterFrm">
	   <div class="col-md-12" >
	   <form name="registerFrm">
	  
	   <table id="tblMemberRegister" style="font-size: 10pt">
	      <thead>
	      </thead>
	      <tbody>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
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
	            <input type="text" id="address" name="address" size="40" placeholder="주소" /><br>
	            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" class="mt-1"/>&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
	            <span class="error">주소를 입력하세요</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">성별</td>
	         <td style="text-align: left;">
	            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="width: 10%" class="ml-3">남자</label>
	            <input type="radio" id="female" name="gender" value="2"/><label for="female" style="width: 10%" class="ml-3">여자</label>
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
	            <label for="agree" style="width: 20%">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
	         </td>
	      </tr>
	      <tr>
	         <td colspan="2" style="text-align: center; vertical-align: middle;">
	         <!-- iframe 태그가 문서를 넣어주는곳이다 -->
	            <iframe src="../iframeAgree/agree.html" width="100%" height="200px" class="box" ></iframe>
	         </td>
	      </tr>
	      <tr>
	         <td colspan="2" style="line-height: 90px;" class="text-center">
	
	            <button type="button" id="btnRegister" class="btn btn-dark btn-lg" onClick="goRegister()" style="border-radius: 30px"><h6>가입하기</h6></button> 
	         
	         </td>
	      </tr>
	      </tbody>
	   </table>
	   </form>
	   </div>
	</div>
</div>
		
	<!-- row 끝 -->
	<!-- 중앙 컨텐츠 끝 -->

	<hr>


 <!-- .container 끝 -->


<!-- 사이드바 function -->    
	
</body>
</html>


<jsp:include page="/WEB-INF/footer.jsp"/>


