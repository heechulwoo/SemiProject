<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>   

<jsp:include page="../header.jsp"/>


<style>

div#consultWrite {
  padding-top: 50px;
  margin-bottom: 50px;
  border-bottom: solid 1px gray;
}
table#tblConsultWrite {
  width: 93%;
  border: solid 1px gray;
  margin: 10px;
}
tr {
  margin-bottom: 10px;
}
td#bor {
  background-color: #f5f5f5;
  text-align: center;
}
td#detail {
  padding-left: 15px;
}
table#tblConsultWrite #th {
  height: 40px;
  text-align: center;
  background-color: #99c2ff;
  font-size: 14pt;
}
table#tblConsultWrite td {
  line-height: 30px;
  padding-top: 8px;
  padding-bottom: 8px;
}
.star {
  color: red;
  font-weight: bold;
  font-size: 13pt;
}
button#writeBtn,
button#backBtn {
  width: 8em;
  text-align: center;
  display: inline-block;
  font-weight: bold;
  padding: 0.7rem 1.3rem;
  font-size: 0.75rem;
  border-radius: 30px;
  background-color: black;
  color: white;
  justify-content: center;
}
button#writeBtn:hover,
button#backBtn:hover {
  opacity: 0.8;
  text-decoration: none;
}
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		
		<%-- 이름 --%>
		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == "") {
				// 이름을 입력하지 않거나 공백만 입력한 경우
				$("table#tblConsultWrite :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
			//	$(this).next().show();
			//  또는
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 이름에 공백이 아닌 글자를 입력했을 경우
				$("table#tblConsultWrite :input").prop("disabled",false);
			//	$(this).next().hide();
			//  또는
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		<%-- 이메일 --%>
		$("input#email").blur(function(){
			
		    var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		    // 이메일 정규표현식 객체 생성
		    
			var email = $(this).val();
		    
			var bool = regExp.test(email);
		    
			if(!bool) {
				// 이메일이 정규표현식에 위배된 경우
				$("table#tblConsultWrite :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblConsultWrite :input").prop("disabled",false);
			
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		<%-- 휴대전화 --%>
		$("input#hp2").blur(function(){
			
		    var regExp = /^[1-9][0-9]{3}$/i; 
		    // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
		    
			var hp2 = $(this).val();
		    
			var bool = regExp.test(hp2);
		    
			if(!bool) {
				// 국번이 정규표현식에 위배된 경우
				$("table#tblConsultWrite :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("table#tblConsultWrite :input").prop("disabled",false);
			
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#hp3").blur(function(){
			
		//  var regExp = /^[0-9]{4}$/i;
		//  또는    
		    var regExp = /^\d{4}$/i; 
		    // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
		    
			var hp3 = $(this).val();
		    
			var bool = regExp.test(hp3);
		    
			if(!bool) {
				// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
				$("table#tblConsultWrite :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
				$("table#tblConsultWrite :input").prop("disabled",false);
			
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		<%-- 제목 --%>
		$("input#asktitle").blur(function(){
			
			var asktitle = $(this).val().trim();
			if(asktitle == "") {
				// 이름을 입력하지 않거나 공백만 입력한 경우
				$("table#tblConsultWrite :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
			//	$(this).next().show();
			//  또는
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 이름에 공백이 아닌 글자를 입력했을 경우
				$("table#tblConsultWrite :input").prop("disabled",false);
			//	$(this).next().hide();
			//  또는
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 asktitle 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		<%-- 내용 --%>
		$("textarea#askcontent").blur(function(){
			
			var askcontent = $(this).val().trim();
			if(askcontent == "") {
				// 이름을 입력하지 않거나 공백만 입력한 경우
				$("table#tblConsultWrite :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
			//	$(this).next().show();
			//  또는
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 이름에 공백이 아닌 글자를 입력했을 경우
				$("table#tblConsultWrite :input").prop("disabled",false);
			//	$(this).next().hide();
			//  또는
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 asktitle 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
	});// end of $("textarea#asktitle").blur(function(){})-------------------------------------------
	
	
	
	
	
	
	// ===== Function Declaration =====
		
		
	// --- 글내용 글자 수 제한 --- //
	// Byte 수 체크 제한
	function fnChkByte(obj, maxByte)
	{
	    var str = obj.value;
	    var str_len = str.length;
	
	
	    var rbyte = 0;
	    var rlen = 0;
	    var one_char = "";
	    var str2 = "";
	
	
	    for(var i=0; i<str_len; i++)
	    {
	        one_char = str.charAt(i);
	        if(escape(one_char).length > 4) {
	            rbyte += 2;                                         //한글2Byte
	        }else{
	            rbyte++;                                            //영문 등 나머지 1Byte
	        }
	        if(rbyte <= maxByte){
	            rlen = i+1;                                         //return할 문자열 갯수
	        }
	     }
	     if(rbyte > maxByte)
	     {
	        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
	        str2 = str.substr(0,rlen);                              //문자열 자르기
	        obj.value = str2;
	        fnChkByte(obj, maxByte);
	     }
	     else
	     {
	        document.getElementById('byteInfo').innerText = rbyte;
	     }
	}
		
	
	
	// --- 취소 버튼 클릭 시 --- //
	function goBack() {
		
		location.href="javascript:history.back();"; // 이전 페이지로 이동 
		
	}// end of function goBack() {}---------------------------------------------------------
	
	
	
	// --- 작성하기 버튼 클릭 시 --- //
	function goConsult() {
		
		// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
		var boolFlag = false;
		
	    $("input.requiredInfo").each(function(){
		    var data = $(this).val().trim();
		    if(data == "") {
			    alert("*표시된 필수입력사항은 모두 입력해주세요.");
			    boolFlag = true;
			    return false; // break; 라는 뜻이다.
		    }
	    }); 
	    
		
		if(boolFlag) {
			return; // 종료
		}
		
		<%-- 이용약관 동의 --%>
		var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length;
		
		if(checkboxCheckedLength == 0) {
			alert("이용약관 동의에 체크해주세요.");
			return; // 종료
		}
		
		
		<%-- 문의 게시글에 대한 업로드 --%>
		var frm = document.consultFrm;
		frm.action = "uploadConsult.one";
		frm.method = "post";
		frm.submit();
		
		
		
	}// end of function goConsult() {}-------------------------------------------------------
	
	
</script>


	
    <div class="container">
    
     <!-- 이케아 상담 글쓰기 시작 -->
      <div id="consultWrite" class="col-md-auto">
        <h1 style="font-weight: bold">문의글 작성</h1>
        <br>
        <p>
		          궁금한 점이 있으세요?<br>
			 신청서를 통해 IKEA에 대한 궁금한 점을 문의해주세요.
        </p>
        <br>
      </div>
      <!-- 이케아 상담 글쓰기 끝 -->
    
      <!-- 상담 글쓰기 폼 시작 -->
      <div class="row justify-content-center" id="divConsultFrm">
        <div class="col-md-12" align="center">
          <form name="consultFrm" enctype="multipart/form-data"> 
          <!-- form 태그안에      enctype="multipart/form-data" 추가하기 -->
          
            <table id="tblConsultWrite">
              <thead>
                <tr>
                  <th class="bg-dark text-white" colspan="2" id="th">
			                      문의글 작성 (
			          <span style="font-size: 10pt; font-weight: bold" >
			          	<span class="star">*</span>
			                       표시는 필수입력사항입니다.</span>)
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td colspan="2" style="text-align: center; vertical-align: middle">
                    <iframe src="../iframeAgree/agree.html" width="85%" height="200px" class="box"></iframe>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="border-bottom: solid 1px gray">
                    <label for="agree" style="width: 20%">이용약관에 동의합니다</label>&nbsp;&nbsp;
                    <input type="checkbox" id="agree" />
                  </td>
                </tr>
                <tr>
                  <td
                    colspan="2"
                    style="border-bottom: solid 1px gray; color: red">
                    &nbsp;&nbsp;※ 문의 카테고리에서 해당 되는 사항을 1개 선택해주세요.
                  </td>
                </tr>
				
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold; background-color: #d9d9d9;" >
                    	문의 카테고리<span class="star">*</span>
                  </td>
                  <td style="width: 80%; text-align: left">
                    <select id="category" name="category" style="margin-left: 2%; width: 70%; padding: 8px" class="requiredInfo" required>
                      <option id="ask1">상품 정보</option>
                      <option id="ask2">상품 추천</option>
                      <option id="ask3">배송/방문설치</option>
                      <option id="ask4">사용 상 문의</option>
                      <option id="ask5">A/S 접수</option>
                      <option id="ask6">납품확인서 발급</option>
                      <option id="ask7">제안/칭찬/불만족</option>
                      <option id="ask8">기타 문의사항</option>
                    </select>
                  </td>
                </tr>

                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">성명&nbsp;<span class="star">*</span></td>
                  <td id="detail" style="width: 80%; text-align: left">
                  	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" />
                    <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required />
                    <span class="error">이름은 필수입력 사항입니다.</span>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	이메일&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" required />
                    <span class="error">이메일 형식에 맞지 않습니다. 다시 입력해주세요!</span>
                    
                    <%-- 
	                    <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span>
	                    <span id="emailCheckResult"></span>
                    --%>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%;">
                    	휴대전화&nbsp;
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly/>&nbsp;-&nbsp;
                    <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" />&nbsp;-&nbsp;
                    <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" />
                    <span class="error">휴대폰 형식이 아닙니다.</span>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="font-weight: bold; width: 20%;">
                    <label class="title" for="asktitle">제목&nbsp;
                    	<span class="star">*</span>
                    </label>
                  </td>
                  <td id="detail" style="width: 80%;">
                    <input type="text" id="asktitle" name="asktitle" placeholder="제목을 입력해주세요." class="requiredInfo" required style="width: 450px;" maxlength="25"/>
                  	<span class="error">제목은 필수입력 사항입니다.</span>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="font-weight: bold; width: 20%;">
                    <label class="title" for="askcontent">내용&nbsp;
                    	<span class="star">*</span>
                    </label>
                  </td>
                  <td id="detail" style="width: 80%;">
                    <textarea rows="7" cols="50" id="askcontent" name="askcontent" onKeyUp="javascript:fnChkByte(this,'1000')" placeholder="내용을 입력해주세요." class="requiredInfo" required></textarea>
                  	<span class="error">내용은 필수입력 사항입니다.</span>
                  </td>
                </tr>
            
            <%-- 파일첨부 --%>
                <tr>
			      <td width="20%" id="bor">이미지 파일첨부(선택)</td>
			      <td width="80%" align="left" style="border-top: hidden; border-bottom: hidden;">
			         <input type="file" id="cImgFile" name="cImgFile" />
			      </td>
			   </tr>
           
                <tr>
                  <td colspan="2" style="line-height: 90px;" class="text-center">
                    <button type="button" id="writeBtn" class="btn" onClick="goConsult();">작성하기</button>
                    <button type="button" id="backBtn" class="btn" onClick="goBack()">취소</button> <!-- 뒤로가기 수정하기 -->
                  </td>
                </tr>
                
              </tbody>
            </table>
            
          </form>
        </div>
      </div>
      <!-- 상담 글쓰기 폼 시작 -->

      <hr>

    </div>
    <!-- .container 끝 -->
    
    
    
<jsp:include page="../footer.jsp"/>
