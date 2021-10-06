<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<title>고객 지원</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/support.css">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<jsp:include page="../header.jsp" />
	
<body>
<div class="mycontainer">
	<h1 class="main-title">고객 지원</h1>

	<div class="service-wrapper1">
		<div class="flex_item">
			<a href="#" class="my_a"> 
			<img class="service-img" src="../images/track_package.jpg" alt="배송조회">
			<div class="myimg-title">배송조회 및 관리</div>
			</a>
		</div>
		<div class="flex_item">
			<a href="<%= ctxPath%>/service/faq.one" class="my_a"> <img class="service-img"
				src="../images/question.jpg" alt="자주묻는 질문">
				<div class="myimg-title">자주 묻는 질문</div>
			</a>
		</div>
		<div class="flex_item">
			<a href="<%= ctxPath%>/service/services.one" class="my_a"> <img class="service-img"
				src="../images/customer_services.jpg" alt="고객 서비스">
				<div class="myimg-title">IKEA 서비스</div>
			</a>
		</div>
		<div class="flex_item">
			<a href="<%= ctxPath%>/service/product_support.one" class="my_a"> <img class="service-img"
				src="../images/productsupport.jpg" alt="제품 지원">
				<div class="myimg-title">제품 지원</div>
			</a>
		</div>
	</div>
	<!-- end of wrapper1 -->
	<h2 class="menu-title" style="margin-top: 10%;">필요한 서비스를 살펴보세요</h2>

	<div class="service-wrapper2">
		<div class="service-item">
			<i class="fas fa-phone"></i>
			<h3 class="service-title">비대면 전화 주문 서비스</h3>
			<p class="service-description">온라인 주문이 어려우신가요? 원하는 제품을 전화로 쉽게
				주문해보세요</p>
			<a href="untactCall.html" class="my_a"><u>자세히보기</u></a>
		</div>

		<div class="service-item">
			<i class="fas fa-truck"></i>
			<h3 class="service-title">주문 조회 및 관리</h3>
			<p class="service-description">주문을 확인하거나, 변경 또는 취소가 필요하다면 이곳에서
				해결해보세요</p>
			<a href="#" class="my_a"><u>자세히보기</u></a>
		</div>

		<div class="service-item">
			<i class="fas fa-exchange-alt"></i>
			<h3 class="service-title">교환환불</h3>
			<p class="service-description">마음에 들지 않는 제품이 있나요? 교환 및 환불 방법을
				알려드릴게요</p>
			<a href="returnClaim.html" class="my_a"><u>자세히보기</u></a>
		</div>

	</div>

	<h2 class="menu-title" style="margin-top: 20vh; margin-bottom: 1vh;">도움이 필요하신가요?</h2>

	<div style="margin-bottom: 4vw;">
		<p>고객지원센터로 연락해주세요. 궁금한 사항은 저희가 해결해드릴게요.</p>
		<br>
		<br> <a role="button" class="my_btn" href="contactUs.html">IKEA 고객지원센터</a>
	</div>

	<br>
	<div class="storeinfo">
		<div class="storeimage">
			<img src="../images/landscape.jpg" alt="매장풍경">
		</div>

		<div class="storeinfo_side">
			<h2 class="menu-title" style="margin-bottom: 1vh;">가까운 IKEA 매장을 만나보세요</h2>
			<p style="margin-bottom: 2.5vw;">매장에서 다양한 아이디어를 만나보세요. 마음에 드는 제품을
				보며 영감을 얻고, 맛있는 스웨덴 간식과 음료도 잊지 말고 확인해보세요!</p>
			<div style="color: white">
				<a href="#" role="button" class="my_btn_black">매장 안내</a>
			</div>
		</div>
	</div>
	</div>
</body>

<jsp:include page="../footer.jsp"/>