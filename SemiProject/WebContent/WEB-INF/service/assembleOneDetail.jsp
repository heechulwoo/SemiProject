<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<title>조립 서비스 온라인 신청</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/assemble_form.css" />

<!-- 제이쿼리  -->
<script
src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<style>
td{
padding: 0 0 0 3%;
border-bottom: 1px solid #F7F7F8;
}
th{
text-align: center;
}

</style>

<script type="text/javascript">

var goBackURL = "";

	$(document).ready(function(){

		goBackURL = "${requestScope.goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&");
		
		
		 
		$(".info").each(function(index, item){ // 필수 입력사항이 아닌 값에 입력한 것이 없는 경우
			var val = $(this).text().trim();
			
			if(val == ""){ 
				$(item).text("없음");
			}
			
		}); // end of $("input.requiredInfo").each(function()-------
		
		
	
}); // end of $(document).ready(function(){------------

	
//Function Declaration

	function checkOnlyOne(element) { // 체크박스 선택 시 하나만 선택되도록 함
		  const checkboxes 
		      = document.getElementsByName("progress");
		  
		  checkboxes.forEach((box) => {
		    box.checked = false;
		  })
		  
		  element.checked = true;
		}


	function goupdate(){ // 어느 곳에 체크했는지 알아와서 값 보내기
		
		var progress = 0;
		var assembleno = "${avo.assembleno}";
		
		var finish = $("input#finish").prop("checked"); // true or false
		// console.log(finish);
		
		if(finish){
			progress = 1;
		}
		
		var cancel = $("input#cancel").prop("checked");
		// console.log(cancel);
		
		if(cancel){
			progress = 2;
		}
		// console.log(progress);
		
		location.href="<%=ctxPath%>/service/progressUpdate.one?assembleno="+assembleno+"&progress="+progress;
		
	}
	
		
	function goAssembleList(){// 원래 있던 위치로 돌아감
	location.href = "<%= request.getContextPath()%>"+goBackURL;
						// 		/SemiProject		+
	}
	

	

	
</script>

<body>
<div class="mycontainer">
	<h1 class="main-title">신청번호 <span style="color:#0058AB;">${avo.assembleno}</span> :  <span style="color:#0058AB;">${avo.name}</span>님의 조립신청상세</h1>
	<hr />
	<div class="wrapper">
		<table class="formtable" style="border: 1px solid #F7F7F7;">
			<tbody>
			
				<tr>
					<th style="border-top: 2px solid #0058AB;">신청인 아이디</th>
					<td style="border-top: 2px solid lightgray;" class="info">${avo.fk_userid}</td>
				</tr>
				
				<tr>
					<th>신청인 성명</th>
					<td class="info">${avo.name}</td>
				</tr>

				<tr>
					<th>신청인 이메일</th>
					<td class="info">${avo.email}</td>
				</tr>

				<tr>
					<th>신청인 연락처</th>
					<td class="info">${fn:substring(avo.mobile, 0,3)} - ${fn:substring(avo.mobile, 3,7)} - ${fn:substring(avo.mobile, 7,11)} </td>
				</tr>

				<tr>
					<th>주문번호</th>
					<td class="info">${avo.fk_odrcode}
						<a href="<%= ctxPath%>/contact/productOrderOneDetail.one?fk_userid=${avo.fk_userid}&odrcode=${avo.fk_odrcode}&goBackURL=${requestScope.goBackURL}"; class="mybtn">주문 내역 확인하기 </a>
						</td>
				</tr>
				<tr>
					<th>조립서비스 희망일</th>
					<td class="info">${avo.hopedate}</td>
				</tr>

				<tr>
					<th>조립 서비스 희망시간</th>
					<td class="info">${avo.hopehour}</td>
					<br>
					<br>
				</tr>
				<tr>
					<th>설치 장소</th>
					<td class="info">
					우편번호: ${avo.postcode}<br>
					${avo.address}&nbsp;${avo.detailaddress}&nbsp;${avo.extraaddress}
					</td>
				</tr>
				
				<tr>
					<th>요청사항</th>
					<td class="info">${avo.demand}</td>
				</tr>
				
				<tr>
					<th>신청일자</th>
					<td class="info">
					${avo.assembledate}
					</td>
				</tr>
				
				<tr>
					<th>진행상황</th>
					<td class="info">
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
			</tbody>
		</table>
		
		<div class="updateprogress">
			<div class="check" style="margin-bottom: 1%;">
				<input type="checkbox" name="progress" value="finish" id="finish" onclick='checkOnlyOne(this)'><label class="mylabel" for="finish" style="color:#0058AB; font-size: 0.9rem;"><b>상담 및 예약 완료</b></label>&nbsp;&nbsp;
				<input type="checkbox" name="progress" value="cancel" id="cancel" onclick='checkOnlyOne(this)'><label class="mylabel" for="cancel" style="color:#fc4958; font-size: 0.9rem;"><b>서비스 신청 취소</b></label>
			</div>
			<button type="button" class="mybtn"
					style="margin: auto;" onClick="goupdate();">상태 변경하기</button>	
		</div>
		<hr>
		<a type="button" class="mybtn_black" style="margin-top: 3%; margin: 3% auto;"
			onclick="goAssembleList()">목록으로 돌아가기</a>
			
	</div>
	</div>
		&nbsp;&nbsp;
	<!-- 줄 띄우기 용 -->
    <br><br><br><br><br>
	
</body>

<jsp:include page="../footer.jsp"/>