<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
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
			<h4 class="ml-2 mt-5 pt-4 h4" style="font-weight: bold;">구매 정보</h4><br>
			
			<c:forEach begin="0" end="0" var="odrDetailVO" items="${requestScope.orderList}">
				<c:choose>
					<c:when test="${odrDetailVO.deliverstatus eq '1'}">
						<i class="fas fa-receipt fa-lg mx-2 my-2 float-left"></i>
						<h5 class="mx-1 my-1 float-left" style="font-weight: bold;">주문 접수됨</h5>
					</c:when>
					<c:when test="${odrDetailVO.deliverstatus eq '2'}">
						<i class="fas fa-truck fa-lg mx-2 my-2 float-left"></i>
						<h5 class="mx-1 my-1 float-left" style="font-weight: bold;">배송중</h5>
					</c:when>
					<c:when test="${odrDetailVO.deliverstatus eq '3'}">
						<i class="fas fa-home fa-lg mx-2 my-2 float-left"></i>
						<h5 class="mx-1 my-1 float-left" style="font-weight: bold;">배송완료</h5>
					</c:when>
				</c:choose>
			</c:forEach>
			
			<br><br><br>
			<c:if test="${not empty requestScope.orderList}">
				<c:forEach begin="0" end="0" var="odrDetailVO" items="${requestScope.orderList}">
					<h4 class="mx-2" style="font-weight: bold;">${odrDetailVO.mvo.name}&nbsp;님의 구매 내역</h4><br>
				</c:forEach>
			</c:if>
			
			<hr class="float-left" style="width: 400px;">
			<br><br>
			<div class="float-left mx-2">
				<i class="fas fa-shopping-basket fa-lg pt-2"></i>
			</div>
			<div class="float-left" id="totalOrder">
				<h6 class="mx-1 my-2" style="font-weight: bold;">이케아 온라인</h6>
				<c:if test="${not empty requestScope.orderList}">
				    <c:forEach begin="0" end="0" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="mx-1 my-2">구매 날짜 : ${odrDetailVO.povo.odrdate} </span><br>
						<span class="mx-1 my-2">주문 번호 : ${odrDetailVO.povo.odrcode}</span><br>
						<span class="mx-1 my-2">합계 : <fmt:formatNumber value="${odrDetailVO.povo.odrtotalprice}"/>&nbsp;원</span>
					</c:forEach>
				</c:if>
				
			</div>
		</div>
		<div class="col-11 col-lg-4 mb-5 align-self-center">
			<h4 class="ml-2 mt-5 pt-4 h4" style="font-weight: bold;">이 배송에 포함된 제품 ( ${requestScope.cnt} )개</h4>
			<hr class="float-left" style="width: 90%;"><br><br>
			
			<c:if test="${not empty requestScope.orderList}">
				<c:forEach var="odrDetailVO" items="${requestScope.orderList}">
					<div class="float-left mx-2">
						<a href="<%= ctxPath%>/product/eachProduct.one?pnum=${odrDetailVO.pvo.pnum}"><img src="<%= ctxPath%>/image_ikea/${odrDetailVO.pvo.prodimage}" style="width: 90px;"/></a>
					</div>
					<div class="float-left ml-2 col-lg-5">
						<a href="<%= ctxPath%>/product/eachProduct.one?pnum=${odrDetailVO.pvo.pnum}"><label class="mx-1 mb-2 h6" style="font-weight: bold; cursor: pointer;">${odrDetailVO.pvo.pname}</label></a><br>
						<span class="mx-1" style="font-size: 9pt;">${odrDetailVO.pcvo.cname}, ${odrDetailVO.pvo.color}</span><br>
						<span class="mx-1" style="font-size: 10pt;">제품 번호 : ${odrDetailVO.pvo.pnum}</span><br>
						<span class="mx-1" style="font-size: 10pt; font-weight: bold;">제품 가격 : ￦<fmt:formatNumber value="${odrDetailVO.pvo.price}" /></span><br><br>
						<span class="mx-1" style="font-size: 10pt;">수량 : ${odrDetailVO.oqty}</span><br>
					</div>
					<hr class="float-left" style="width: 90%;"><br><br><br>
				</c:forEach>
			</c:if>
			<div class="px-2 my-4" style="clear: both; width: 90%; font-weight: bold;">
				<span class="my-1 float-left">합계</span>
				<c:if test="${not empty requestScope.orderList}">
					<c:forEach begin="0" end="0" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="my-1 float-right"><fmt:formatNumber value="${odrDetailVO.povo.odrtotalprice}"/>&nbsp;원</span><br>
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
					<c:forEach begin="0" end="0" var="odrDetailVO" items="${requestScope.orderList}">
						<span class="mx-2 my-2" style="font-size: 11pt;"><fmt:formatNumber value="${odrDetailVO.povo.odrtotalprice}"/>&nbsp;원</span><br>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
		
</div>	
	
<jsp:include page="../footer.jsp" />