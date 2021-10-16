<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/assembleList.css" />

<jsp:include page="../header.jsp" />

<style type="text/css">
	tr.applyInfo:hover{
		background-color: #fff9dd;
	    cursor: pointer;
	}
</style>

<title>관리자 메뉴 - 조립 서비스 신청 현황 조회</title>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 페이지를 옮겨도 검색창에 검색어가 그대로 남아있게 함
		if("${requestScope.searchWord}" != "" ){
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}")
		}
		
		// *** select 태그에 대한 이벤트는  click 이 아니라 change 이다. *** // 
		$("select#sizePerPage").bind("change", function(){
			goSearch();	
			
		});
		
		// 선택한 select 값이 나오게끔 한다.
		if("${requestScope.sizePerPage}" != "") {
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		}
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13){ // 검색어에서 엔터(keycode 13)를 하면 검색하러 가도록 한다.
				goSearch();
			}
			
		});
		
		
		// 특정 신청을 클릭하면 상세를 보여주도록 한다.
		$("tr.applyInfo").click(function(event){
	
			var $target = $(event.target);
			// console.log($target.html());
			
			// console.log($target.parent().find(".userid").text());
		 		 
			// 또는 
			console.log($(this).children(".assembleno").text());
	 			
			var assembleno = $target.parent().find(".assembleno").text();
			
			location.href="<%=ctxPath%>/service/assembleOneDetail.one?assembleno="+assembleno+"&goBackURL=${requestScope.goBackURL}";
																				
		
		}); 
		
	
	}); // end of $(document).ready(function() {}-----------------------
	
// Function Declaration
function goSearch(){
	var frm = document.assembleFrm;
	frm.action = "assembleList.one"
	frm.method =  "get";
	frm.submit();
}			
	
</script>

<div class="mycontainer">
	<h1 class="main-title">조립 서비스 신청 현황</h1>
	<hr />
	<div class="wrapper">
		<form name="assembleFrm" class="assembleFrm">
			<select id="searchType" name="searchType">
				<option value="assembleno">신청번호</option>
				<option value="fk_userid">아이디</option>
				<option value="name">이름</option>
				<option value="mobile">연락처</option>
			</select> <input type="text" id="searchWord" name="searchWord" />

			<%-- form 태그내에서 전송해야할 input 태그가 만약에 1개 밖에 없을 경우에는 유효성검사가 있더라도 
               유효성 검사를 거치지 않고 막바로 submit()을 하는 경우가 발생한다.
               이것을 막아주는 방법은 input 태그를 하나 더 만들어 주면 된다. 
               그래서 아래와 같이 style="display: none;" 해서 1개 더 만든 것이다. 
       --%>
			<input type="text" style="display: none;" />
			<%-- 조심할 것은 type="hidden" 이 아니다. --%>

			<button type="button" class="mybtn_black" onclick="goSearch();"
				style="margin-right: 30px;">검색</button>

		</form>

		<table id="assembleTbl" class="table table-bordered formtable"
			style="width: 90%; margin-top: 20px;">
			<thead>
				<tr>
					<th>신청일</th>
					<th>신청번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>상태</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="avo" items="${requestScope.assembleList}">
					<!-- dao에서 처리가 다 끝난 assembleList를 변수 avo에 넣기   -->
					<tr class="applyInfo">
						<td>${avo.assembledate}</td>
						<!-- get 다음 첫글자 소문자  -->
						<td class="assembleno">${avo.assembleno}</td>
						<td>${avo.fk_userid}</td>
						<td>${avo.name}</td>
						<td>${fn:substring(avo.mobile, 0,3)} - ${fn:substring(avo.mobile, 3,7)} - ${fn:substring(avo.mobile, 7,11)} </td>
						<td>
							<c:choose>
							<c:when test ="${avo.progress eq 0}">
							대기
							</c:when>
							<c:when test ="${avo.progress eq 1}">
							완료
							</c:when>
							<c:when test ="${avo.progress eq 2}">
							취소
							</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<nav class="pagebar">
		
				<ul class="pagination" style="margin: auto;">${requestScope.pageBar}</ul>
			
		</nav>
	</div>
</div>
<jsp:include page="../footer.jsp" />
