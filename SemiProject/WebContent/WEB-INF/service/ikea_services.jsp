<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<title>고객 서비스</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/services.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
	
<jsp:include page="../header.jsp" />

<body>
	<div class="mycontainer">
		<h1 class="main_title">IKEA 서비스</h1>
		<div style="margin-bottom: 5%">직접 해도 좋고, 도움을 받아도 좋아요. 여러분의 생활이
			더욱 간편해지는 다양한 서비스를 제공합니다.</div>

		<div class="service-wrapper2">
			<div class="service-item">
				<i class="fas fa-truck"></i>
				<h3 class="service-title">배송 서비스</h3>
				<p class="service-description">무거운 물건은 IKEA에 맡겨주세요.</p>
				<a href="<%= ctxPath%>/service/shipping_service.one" class="my_a"><u>자세히보기</u></a>
			</div>

			<div class="service-item">
				<i class="fas fa-tools"></i>
				<h3 class="service-title">조립 서비스</h3>
				<p class="service-description">조립을 맡기고 소중한 시간을 아끼세요.</p>
				<a href="<%= ctxPath%>/service/assemble_service.one" class="my_a"><u>자세히보기</u></a>
			</div>

			<div class="service-item">
				<i class="fas fa-mobile-alt"></i>
				<h3 class="service-title">비대면 서비스</h3>
				<p class="service-description">주문부터 상담까지 집에서도 가능해요!</p>
				<a href="<%= ctxPath%>/service/untact_service.one" class="my_a"><u>자세히보기</u></a>
			</div>
		</div>
	</div>
	<!-- end of container -->
</body>

<jsp:include page="../footer.jsp"/>
