<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>   


<%-- 헤더 없애서 받아옴 --%>

<!DOCTYPE html>
<html>
<head>
<title>IKEA SSANGYONG ｜ 이케아 쌍용 - 셀프 반품</title>

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

<%-- 헤더 없애서 받아옴 --%>


<%-- <jsp:include page="../header.jsp"/> --%>

<style>
	
div#selfReturn {
  padding-top: 70px;
  padding-bottom: 50px;
  border-bottom: solid 1px gray;
}
div#selfReturnFrm {
  padding-top: 70px;
  padding-bottom: 70px;
}
table#tblSelfReturn {
  width: 93%;
  border: solid 1px gray;
  margin: 10px;
}
tr {
  margin-bottom: 10px;
}
td#bor {
  border: none;
  background-color: #f5f5f5;
  text-align: center;
  margin: 1px;
}
td#detail {
  padding-left: 20px;
}
table#tblSelfReturn #th {
  height: 40px;
  text-align: center;
  background-color: #f5f5f5;
  font-size: 14pt;
}
table#tblSelfReturn td {
  /* border: solid 1px gray;  */
  line-height: 30px;
  padding-top: 8px;
  padding-bottom: 8px;
}
.star {
  color: red;
  font-weight: bold;
  font-size: 13pt;
}
button#returnBtn,
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
button#returnBtn:hover,
button#backBtn:hover {
  opacity: 0.8;
  text-decoration: none;
}

button#goOrderView {
  width: 12em;
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

button#goOrderView:hover {
  opacity: 0.8;
  text-decoration: none;
}


/* CSS 로딩 구현 시작(bootstrap 에서 가져옴) 시작 */
.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #80ccff;
  border-bottom: 16px solid #80ccff;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
/* CSS 로딩 구현 시작(bootstrap 에서 가져옴) 끝 */
	
</style>



<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".loader").hide(); // CSS 로딩화면 감추기
		
		$("span.error").hide();
		
		
		<%-- 주문번호 odrcode --%>
	
	<%--	
		$("select#odrcode").blur(function(){
				
				var odrcode = $(this).val();
			
				if( odrcode != ${requestScope.odrcode} ) {
					// 주문번호가 제대로 선택되지 않은 경우
					$("table#tblSelfReturn :input").prop("disabled",true);
					$(this).prop("disabled",false);
				
				    $(this).parent().find(".error").show();
				    $(this).focus();
				}
				else {
					// 주문번호가 제대로 선택된 경우
					$("table#tblSelfReturn :input").prop("disabled",false);
				
					$(this).parent().find(".error").hide();
				}
				
			});// 아이디가 odrcode 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	--%>
		
		
		
		<%-- 이름 --%>
		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == "") {
				// 이름을 입력하지 않거나 공백만 입력한 경우
				$("table#tblSelfReturn :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
			//	$(this).next().show();
			//  또는
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 이름에 공백이 아닌 글자를 입력했을 경우
				$("table#tblSelfReturn :input").prop("disabled",false);
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
				$("table#tblSelfReturn :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblSelfReturn :input").prop("disabled",false);
			
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
				$("table#tblSelfReturn :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("table#tblSelfReturn :input").prop("disabled",false);
			
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
				$("table#tblSelfReturn :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
				$("table#tblSelfReturn :input").prop("disabled",false);
			
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		
				
	});// end of $(document).ready(function(){})---------------------------------------
	
	
	
	// Function Declaration
	
	
	// 주문조회 
	function goOrder() {
		
		location.href="<%= ctxPath%>/product/shipping.one";
		
	}// end of goOrder-------------------------------------------
	
	
	// 셀프 반품신청서 작성하기
	function goReturn() {
		
	// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
		var boolFlag = false;
		
	    $("input.requiredInfo").each(function(){
		    var data = $(this).val().trim();
		    if(data == "") {
			    alert("*표시된 필수입력사항은 모두 입력해주세요.");
			    boolFlag = true;
			    return false; // break; 라는 뜻이다.
		    }
	    });// end of $("input.requiredInfo").each(function(){})------------------
	    
	    
	    $("select.requiredInfo").each(function(){
	    	var data = $(this).val().trim();
	    	if(data == "") {
			    alert("*표시된 필수입력사항은 모두 입력해주세요.");
			    boolFlag = true;
			    return false; // break; 라는 뜻이다.
		    }
		})// end of $("select.requiredInfo").each(function(){})------------------
	    
		
		if(boolFlag) {
			return; // 종료
		}
		
		<%-- 이용약관 동의 --%>
		var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length;
		
		if(checkboxCheckedLength == 0) {
			alert("이용약관 동의에 체크해주세요.");
			return; // 종료
		}
		
		
		var bool = confirm("셀프 반품을 신청하시겠습니까?");
		
		if(bool) {
			
			$(".loader").show(); // CSS 로딩화면 보여주기
			
		    <%-- 셀프 반품에 대한 이메일을 보내주기 --%>
			var frm = document.returnFrm;
			frm.action = "<%= ctxPath%>/contact/selfReturnSend.one";
			frm.method = "POST";
			frm.submit();
			
		}
		
		
		
	}// end of function goEdit() {}---------------------------------------
	
	
	
	
</script>



	<div class="container">
      <!-- 이케아 셀프반품 시작 -->
      <div id="selfReturn" class="col-md-auto">
        <h1 style="font-weight: bold">셀프 반품</h1>
        <br>
        <p>
		          셀프 반품 접수 후 매장 내 교환환불 코너에 제품을 가져오시면 됩니다.<br>
		          플래닝 스튜디오, 이케아 랩에서는 반품할 수 없습니다.<br>
		          셀프 반품은 단순 변심 사유에 한하여 접수 가능합니다.
        </p>
        <br>
      </div>
      <!-- 이케아 셀프반품 끝 -->
      
      <%-- CSS 로딩화면 구현한것--%>
	  <div style="display: flex;">
		<div class="loader" style="margin: auto;"></div>
	  </div>

      <!-- 상담 글쓰기 폼 시작 -->
      <div class="row justify-content-center" id="selfReturnFrm">
        <div class="col-md-12" align="center">
          <form name="returnFrm">
          
            <table id="tblSelfReturn">
              <thead>
                <tr>
                  <th class="bg-dark text-white" colspan="2" id="th">
                    	셀프 반품 (
                    	<span style="font-size: 10pt; font-weight: bold">
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
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	주문번호&nbsp;<span class="star">*</span>
                  </td>
                  
                  <td id="detail" style="width: 80%; text-align: left">
                    <%-- <input type="text" name="odrcode" id="odrcode" value="${requestScope.odrcode}" class="requiredInfo" required /> --%>
                    
                    <%-- c:forEach 로 주문번호 값 불러오기 --%>
                    <select name="odrcode" id="odrcode" class="requiredInfo" required >
	                     <option value="">선택해주세요.</option>
	                     <c:forEach var="item" items="${requestScope.odrcode}" >
					          <option>${item}</option>
					     </c:forEach>
                    </select>
                    <span class="notice"><button type="button" id="goOrderView" class="btn" onclick="goOrder();" style="margin-left: 17px;">주문번호 조회하기</button></span>
                    <span class="error">주문번호는 필수입력 사항입니다.</span>
                  </td>
                  
                </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	반품사유<span class="star">*</span>
                  </td>
                  <td style="width: 80%; text-align: left">
                    <select id="whyreturn" name="whyreturn" style="margin-left: 2%; width: 70%; padding: 8px" class="requiredInfo" required >
                      <option value="">선택해주세요.</option>
                      <option id="rw1">원하는 스타일, 색상 또는 크기가 아닙니다.</option>
                      <option id="rw2">필요한 것보다 더 많이 구입했습니다.</option>
                      <option id="rw3">다른 곳에서 더 낮은 가격의 제품을 찾았습니다.</option>
                      <option id="rw4">제가 찾는 제품이 아닙니다.</option>
                      <option id="rw5">제품 정보가 제품과 다르게 안내되었습니다.</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	성명&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                  	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" />
                    <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required />
                    <span class="error">성명은 필수입력 사항입니다.</span>
                  </td>
                </tr>                
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	이메일&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" required />
                    <span class="error">이메일 형식에 맞지 않습니다. 다시 입력해주세요!</span>
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
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	구입처<span class="star">*</span>
                  </td>
                  <td style="width: 80%; text-align: left">
                    <select id="wherebuy" name="wherebuy" style="margin-left: 2%; width: 200px; padding: 8px" class="requiredInfo" required >
                      <option value="">선택해주세요.</option>
                      <option id="wb1">IKEA 광명</option>
                      <option id="wb2">IKEA 기흥</option>
                      <option id="wb3">IKEA 고양</option>
                      <option id="wb4">IKEA 쌍용</option>
                      <option id="wb5">IKEA 동부산</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%;">
                    	추가 내용&nbsp;
                  </td>
                  <td id="detail" style="width: 80%; height: 100px;">
                    <textarea name="plusReason" cols="50" rows="5" id="plusReason" placeholder="추가적인 반품 사유가 있다면 기입해주세요."></textarea>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="line-height: 90px" class="text-center">
                    
                    <button type="button" id="returnBtn" class="btn" onClick="goReturn();">작성하기</button>
                    <button type="button" id="backBtn" class="btn" onClick="self.close()">취소</button> <!-- self.close() 는 현재 팝업창 닫기 -->
                  </td>
                </tr>
              </tbody>
              
            </table>
          </form>
        </div>
      </div>
      <!-- 상담 글쓰기 폼 끝 -->

      <hr>

      
    </div>
    <!-- .container 끝 -->
    
	<!-- 줄 띄우기 용 -->
    <br><br><br><br><br> 
    
<jsp:include page="../footer.jsp"/>    