<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>


<title>배송 서비스</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/shipping.css" />

<jsp:include page="../header.jsp" />

<body>

	<div class="mycontainer">
		<h1 class="main-title">배송 서비스</h1>
		<img src="../images/shipping.jpg" alt="아이들이 이케아 플랫박스 근처에서 노는 사진" class="myimg"/>

		<p class="my_p">
			무거운 물건을 집까지 들고가기 힘드시죠? 대부분의 제품은 플랫팩 포장으로 간편하게 가져갈 수 있도록 디자인되어 있어요.
			그러나 집에서 편하게 제품을 받을 수도 있죠. 온라인 주문이든 매장 주문이든 원하는 주소지와 일정으로 배송해드립니다. 편리한
			배송 옵션을 살펴보세요. <br>
			<br>
		<hr>
		</p>

		<h1 class="menu-title" style="margin-top: 4vw; margin-bottom: 0%;">비대면
			가구 배송 안내</h1>
		<p class="my_p" style="margin-top: 0.3vw; margin-bottom: 4vw;">
		이제 가구도 안전하게 비대면으로 배송 받아보세요! 배송 기사님과의 연락으로 쉽게 이용할 수 있습니다.<br>
		</p>
		<ol style="margin-top: 1vw; margin-bottom: 4vw;">
			<li>배송기사님이 배송 한 시간 전에 고객님께 연락 드립니다.</li>
			<li>만약 비대면 배송을 원하시면 사전에 배송기사님께 알려주세요.</li>
			<li>고객 요청에 따라 문 앞 비대면 배송 혹은 가정 내 원하시는 방까지 배송해드립니다.</li>
		</ol>

		<hr style="margin-top: 5vw;">

		<h1 class="menu-title" style="margin-top: 4vw; margin-bottom: 2vw;">온라인
			배송 요금</h1>
		<div class="flex-box">
			<div class="flex-item" style="margin-right: 5vw;">
				<b style="text-decoration: underline; margin-bottom: 2vw;">택배 배송</b><br>
				<br> <span class="basicfee">기본요금 3,000원 부터~</span>
				<ul class="my_ul">
					<li>가로, 세로, 높이의 합: 200cm 미만</li>
					<li>가장 긴 변의 길이: 140cm 미만</li>
					<li>총 무게: 25kg 미만</li>
					<li>*주문한 제품의 실제 크기에 따라 요금이 상이할 수 있습니다.</li>
				</ul>
			</div>

			<div class="flex-item">
				<b style="text-decoration: underline; margin-bottom: 2vw;">가구 배송</b><br>
				<br> <span class="basicfee">기본요금 59,000원</span> <em>(제주도:
					109,000원)</em>
				<ul class="my_ul">
					<li>5 세제곱 미터까지 해당 요금으로 가능합니다.</li>
					<li>해당 요금은 온라인 주문시에만 적용됩니다.</li>
				</ul>
			</div>
		</div>
		<hr>


		<h1 class="menu-title" style="margin-top: 4vw; margin-bottom: 0;">구매하신
			제품의 배송 상태가 궁금하세요?</h1>
		<p class="my_p" style="margin-top: 0.3vw; margin-bottom: 2vw;">
			온라인 주문 내역 페이지에서 확인할 수 있습니다.<br>
		</p>

		<a href="<%= ctxPath%>/contact/contactUs.one" role="button" class="my_btn">문의하기</a>
		<hr style="margin-top: 10vw; margin-bottom: 4vw;">

		<a href="<%= ctxPath%>/service/services.one" role="button" class="my_btn_black">모든 서비스 보기</a>

	</div>
	<!-- end of container -->
</body>

<jsp:include page="../footer.jsp"/>