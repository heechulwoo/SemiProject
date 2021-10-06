<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<title>비대면 서비스</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/untactService.css" />

<jsp:include page="../header.jsp" />


<body>
	<div class="mycontainer">
		<div class="wrapper">
			<h1 class="main-title">비대면 서비스</h1>
			<br>
			<h2 class="menu-title" style="">언택트로 만나는 IKEA</h2>

			<p class="my_p" style="margin-bottom: 3%;">
				코로나로 인해 사회적 거리는 더욱 멀어졌지만, 집과는 더욱 가까워진 요즘.<br> 집에서 즐기는 집을 위한 쇼핑,
				IKEA를 만날 수 있는 방법은 다양해요. IKEA의 다양한 비대면 서비스를 활용하여 집에서 안전하고 쾌적한 쇼핑을
				즐겨보세요. <br> <br>
			<hr>
			</p>

			<div class="flex_box">
				<div class="flex_item">
					<h1 class="menu-title" style="margin-bottom: 3%;">비대면 배송 서비스</h1>
					<p class="my_p" style="margin-top: 0.3vw; margin-bottom: 4vw;">배송
						방법 선택단계에서 비대면 배송 옵션을 체크하면 물품을 현관 앞에 배송한 후 문자메시지를 발송합니다.</p>
					<br>
				</div>
				<div class="flex_item">
					<img src="../images/untacttrack.jpg" alt="배송서비스 설명이미지" class="my_img">
				</div>
			</div>

			<hr>

			<h1 class="menu-title" style="margin-top: 4vw; margin-bottom: 2vw;">전화주문
				서비스</h1>
			<p class="my_p">
				온라인 주문이 익숙하지 않으신가요? 그렇다면 전화주문 서비스를 이용해보세요.<br> 친절한 안내와 함께 수월하게
				제품을 구매하실 수 있어요.
			</p>

			<div class="flex_box">
				<div class="flex_item">
					<h1 class="menu-title" style="margin-top: 4vw; margin-bottom: 0;">전화
						문의</h1>
						<br>
					<h2 class="menu-title">1670-4532</h2>
					<p class="my_p" style="margin-bottom: 5%;">
						월요일-일요일<br> 오전 10시 - 오후 9시
					</p>
					<a href="contactUs.html" role="button" class="my_btn">문의하기</a>
				</div>

				<div class="flex_item">
					<img class="my_img" src="../images/phoneorder.jpg"
						alt="전화주문은 3번을 눌러주세요">
				</div>
			</div>

			<hr style="margin-top: 4vw; margin-bottom: 4vw;">

			<a href="<%=ctxPath%>/service/services.one" role="button"
				role="button" class="my_btn_black">모든 서비스 보기</a>

		</div>
	</div>
	<!-- end of container -->

</body>

<jsp:include page="../footer.jsp" />