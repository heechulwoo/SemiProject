<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp" />

<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
	});
	
	function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
	
</script>

<div id="container" class="container-fluid mt-4 ml-3">
	<div class="row ml-2">
		<div class="col-lg-2"></div>
		<div class="col-11 col-md-4">
			<h4 class="ml-2 mt-5 pt-4" style="font-weight: bold;">구매 세부 정보</h4><br>
			<i class="fas fa-receipt fa-lg mx-2 my-2 float-left"></i>
			<h5 class="mx-1 my-1 float-left" style="font-weight: bold;">주문 접수됨</h5>
			<br><br><br>
			<h4 class="mx-2" style="font-weight: bold;">구매 정보</h4><br>
			<hr class="float-left" style="width: 400px;">
			<br><br>
			<div class="float-left mx-2">
				<i class="fas fa-shopping-basket fa-lg pt-2"></i>
			</div>
			<div class="float-left" id="totalOrder">
				<h6 class="mx-1 my-2" style="font-weight: bold;">이케아 온라인</h6>
				<c:if test="${not empty requestScope.orderList}">
				    <c:forEach begin="1" end="1" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="mx-1 my-2">구매 날짜 : ${odrDetailVO.povo.odrdate} </span><br>
						<span class="mx-1 my-2">주문 번호 : ${odrDetailVO.povo.odrcode}</span><br>
						<span class="mx-1 my-2">합계 : ${odrDetailVO.povo.odrtotalprice}</span>
					</c:forEach>
				</c:if>
				
			</div>
		</div>
		<div class="col-11 col-lg-4 mb-5 align-self-center">
			<h4 class="ml-2 mt-5 pt-4" style="font-weight: bold;">이 배송에 포함된 제품 ( ${requestScope.cnt} )개</h4>
			<hr class="float-left" style="width: 90%;"><br><br>
			
			<c:if test="${not empty requestScope.orderList}">
				<c:forEach var="odrDetailVO" items="${requestScope.orderList}">
					<div class="float-left mx-2">
						<img src="<%= ctxPath%>/image_ikea/${odrDetailVO.pvo.prodimage}" style="width: 90px;"/>
					</div>
					<div class="float-left ml-2 col-lg-5">
						<label class="mx-1 mb-2" style="font-weight: bold;">${odrDetailVO.pvo.pname}</label><br>
						<span class="mx-1" style="font-size: 10pt;">${odrDetailVO.pcvo.cname}</span><br>
						<span class="mx-1" style="font-size: 10pt;">제품 번호 : ${odrDetailVO.pvo.pnum}</span><br>
						<span class="mx-1" style="font-size: 10pt; font-weight: bold;">제품 가격 : ￦ ${odrDetailVO.pvo.price}</span><br><br>
						<span class="mx-1" style="font-size: 10pt;">수량 : ${odrDetailVO.oqty}</span><br>
					</div>
					<hr class="float-left" style="width: 90%;"><br><br><br>
				</c:forEach>
			</c:if>
			<div class="px-2 my-4" style="clear: both; width: 90%; font-weight: bold;">
				<span class="my-1 float-left">합계</span>
				<c:if test="${not empty requestScope.orderList}">
					<c:forEach begin="1" end="1" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="my-1 float-right">${odrDetailVO.povo.odrtotalprice}원</span><br>
					</c:forEach>
				</c:if>
			</div>
			<div class="px-2 my-4" style="clear: both; width: 90%; font-size: 10pt;">
				<span class="my-1 float-left">VAT</span>
				<c:if test="${not empty requestScope.orderList}">
					<c:forEach begin="1" end="1" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="my-1 float-right">${odrDetailVO.povo.odrtotalprice}원</span><br>
					</c:forEach>
				</c:if>
			</div>
			<hr class="float-left" style="width: 90%;"><br><br>
			<h5 class="mx-1 my-1" style="font-weight: bold;">결제정보</h5>
			<hr class="float-left" style="width: 90%;"><br><br>
			<div class="float-left mx-2">
				<i class="far fa-credit-card fa-lg pt-2"></i>				
			</div>
			<div class="float-left">
				<h6 class="mx-2 my-2" style="font-weight: bold;">신용카드</h6>
				<c:if test="${not empty requestScope.orderList}">
					<c:forEach begin="1" end="1" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="mx-2 my-2" style="font-size: 11pt;">${odrDetailVO.povo.odrtotalprice}원</span><br>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
		
</div>	
	
<jsp:include page="../footer.jsp" />