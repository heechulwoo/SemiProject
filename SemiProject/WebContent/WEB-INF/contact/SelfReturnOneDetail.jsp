<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>

<jsp:include page="../header.jsp"/>

<style>
	
	div#selfReturnDetail {
	  padding-top: 70px;
	  padding-bottom: 50px;
	  border-bottom: solid 1px gray;
	}
	
	div#detail {
	  padding-top: 70px;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	}
	
	div#rvoInfo {
	  padding-top: 30px;
	}
	
	table#tblDetailReturn {
	  border: solid #d9d9d9 2px;
	  border-left: hidden; 
	  border-right: hidden;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	  border-collapse: separate;
  	  border-spacing: 0 20px;
	}
	
	.rDetail {
	  border-right: solid #d9d9d9 2px;
	  font-weight: bold;
	}
	
	.detailcontent {
	  padding-left: 30px;
	}
	
	button#backBtn,
	button#firstBtn,
	button#changeBtn,
	button#deleteBtn {
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
	button#backBtn:hover,
	button#firstBtn:hover,
	button#changeBtn:hover,
	button#deleteBtn:hover {
	  opacity: 0.8;
	  text-decoration: none;
	}
	
</style>


<script type="text/javascript">
	
	
	var goBackURL = "";
	
	$(document).ready(function() {
		
		goBackURL = "${requestScope.goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&"); // 공백을 다시 &로 바꿔주기
		
		
		
		<%-- DB status 값을 가져다가  해당 radio 값 checked시키기 --%>
		$("select#status option").each(function(){

		    if($(this).val()=="${requestScope.rvo.status}"){

		      $(this).attr("selected","selected"); // attr적용안될경우 prop으로 
				
		    }

		  });
		
	}); // end of $(document).ready(function(){})--------------------------
	
	
	
	// === Function Declaration === //
	
	
	// 문의글 목록으로 가기(검색결과, 페이지 관련 정보 남아있는 것)
	function goSelfReturnList() {
		location.href = "/SemiProject"+goBackURL;
	}// end of function goSelfReturnList(){}----------------------------------
	
	
	
	// 셀프 반품 상태 수정하기
	function goChange() {
		
		
		var result = confirm('회원의 셀프 반품 상태를 수정하시겠습니까?'); 
		
		if(result) { 
			// 수정한다.(YES)
			
			<%-- 셀프 반품 상태 수정하기 --%>
			var frm = document.selfReturnDetailFrm;
			frm.action = "<%= ctxPath%>/contact/editSelfReturn.one";
			frm.method = "post";
			frm.submit();
			
		}
		else { 
		// 수정 안한다. (NO)
		
		}
		
	
	}// end of function goChange(){}---------------------------------------
	
	
	
	
</script>

<!--  -->

<div class="container">

	<!-- 이케아 셀프 반품 회원 세부내용 보기 시작 -->
	<div id="selfReturnDetail" class="col-md-auto">
	  <h1 style="font-weight: bold">셀프 반품 세부내용 보기</h1>
	    <br>
	    <p>
	    	셀프 반품을 신청한 회원의 세부내용입니다.<br>
	    	회원의 반품 상태을 변경할 수 있습니다.<br>
	    </p>
	    <br>
	</div>
	<!-- 이케아 셀프 반품 회원 세부내용 보기 끝 -->
	
	
	
	<!-- 셀프 반품 회원  세부내용 시작 -->
	<form name="selfReturnDetailFrm">
	<div id="detail" class="col-md-auto">
		<c:if test="${ empty requestScope.rvo }"> 
			셀프 리스트가 존재하지 않습니다. 다시 확인해주세요!<br>
		</c:if>	
		
		<c:if test="${ not empty requestScope.rvo }"> 
			<c:set var="returnno" value="${requestScope.rvo.returnno}" />
			<c:set var="fk_userid" value="${requestScope.rvo.fk_userid}" />
			<c:set var="fk_odrcode" value="${requestScope.rvo.fk_odrcode}" />
			<c:set var="name" value="${requestScope.rvo.name}" />
			<c:set var="email" value="${requestScope.rvo.email}" />
			<c:set var="mobile" value="${requestScope.rvo.mobile}" />
			<c:set var="whyreturn" value="${requestScope.rvo.whyreturn}" />
			<c:set var="wherebuy" value="${requestScope.rvo.wherebuy}" />
			<c:set var="plusreason" value="${requestScope.rvo.plusreason}" />
	   		<c:set var="returndate" value="${requestScope.rvo.returndate}" />
	  <%--  <c:set var="status" value="${requestScope.rvo.status}" />   
	  --%>
	   		
			
			
			
			<h3 class="col-md-auto" style="font-weight: bold;"><span style="color: #80ccff;">${requestScope.rvo.name}</span>님의 반품 신청내역</h3>
			
			<div id="rvoInfo" class="col-md-auto"> 
				
				
				<table id="tblDetailReturn" style="width: 80%;">
				<tbody>
					<tr>
				      <td width="25%" class="rDetail" style="padding-top: 10px;">반품번호</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.rvo.returnno}
				         <input type="hidden" name="returnno" value="${requestScope.rvo.returnno}" />
				      </td>   
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail" style="padding-top: 10px;">회원아이디</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.rvo.fk_userid}
				         <input type="hidden" name="fk_userid" value="${requestScope.rvo.fk_userid}" />
				      </td>   
				   </tr>
				   
				   <tr>
				      <td width="25%" class="rDetail" style="padding-top: 10px;">주문번호</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.rvo.fk_odrcode}  <%-- ${requestScope.cvo.fk_userid} --%>
				         <input type="hidden" name="fk_odrcode" value="${requestScope.rvo.fk_odrcode}" />
				      </td>   
				   </tr>
				   
				   <tr>
				      <td width="25%" class="rDetail">회원명</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.rvo.name}
				         <input type="hidden" name="name" value="${requestScope.rvo.name}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail">이메일</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.rvo.email}
				         <input type="hidden" name="email" value="${requestScope.rvo.email}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail">휴대폰</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11)}
				         <input type="hidden" name="mobile" value="${requestScope.rvo.mobile}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail">반품사유</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.rvo.whyreturn}
				         <input type="hidden" name="whyreturn" value="${requestScope.rvo.whyreturn}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail">구입처</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;" >
				         ${requestScope.rvo.wherebuy}
				         <input type="hidden" name="wherebuy" value="${requestScope.rvo.wherebuy}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail">추가 반품 사유</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.rvo.plusreason}
				         <input type="hidden" name="plusreason" value="${requestScope.rvo.plusreason}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="rDetail">반품신청일 </td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.rvo.returndate}
				         <input type="hidden" name="returndate" value="${requestScope.rvo.returndate}" />
				      </td>
				   </tr>
				   
				   <%-- 반품상태 체크 --%>
				   <tr>
				      <td width="25%" class="rDetail">반품상태 </td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         <select id="status" name="status" style="margin-left: 2%; width: 50%; padding: 8px">
	                      <option id="status1" value="0">신청완료</option>
	                      <option id="status2" value="1">반품취소</option>
	                      <option id="status3" value="2">반품완료</option>
				         </select>
				      </td>
				   </tr>
				</tbody>
				</table>
				
			</div>
			
		</c:if>
		
		<div id="buttons">
			<button style="margin-top: 50px;" type="button" id="backBtn" class="btn" onclick="goSelfReturnList()">셀프 반품 목록</button>
		   	&nbsp;&nbsp;
		   	<button style="margin-top: 50px;" type="button" id="firstBtn" class="btn" onclick="javascript:location.href='selfReturnList.one'">처음으로</button>
		   	&nbsp;&nbsp;
		   	<button style="margin-top: 50px;" type="button" id="changeBtn" class="btn" onclick="goChange()">반품상태 변경</button>
		   	&nbsp;&nbsp;
		</div>
	</div>
	</form>
	<!-- 셀프 반품 회원  세부내용 끝 -->
		
</div>
<!-- .container 끝 -->

<!-- 줄 띄우기 용 -->
<br><br><br><br><br> 

<jsp:include page="../footer.jsp"/>