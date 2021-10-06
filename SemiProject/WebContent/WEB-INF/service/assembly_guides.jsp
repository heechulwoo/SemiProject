<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<title>이렇게 조립하세요!</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/assembly_guides.css" />

<jsp:include page="../header.jsp" />

<body>
	<div class="mycontainer">
		<h1 class="main-title">이렇게 조립하세요!</h1>
		<hr />
		<h2 class="menu-title">"조립 준비하기"</h2>
		<p class="assemble_caution">
			<b> IKEA 제품을 조립하기 전에 다음의 주의사항을 확인해주세요. 조립이 끝난 다음에는 사용 전에 평평한 바닥에
				놓고 안정적인지 확인합니다. 제품 구성에 고정장치가 포함된 경우에는 해당 부품을 사용하여 제품이 넘어지지 않도록 잘
				고정시켜주세요. 주기적으로 나사를 다시 조여주면 더욱 오랫동안 사용할 수 있습니다. </b>
		</p>
		<hr />
		<article>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">1.</h2>
					<p class="step_item">내부의 구성품이 손상되지 않도록 주의해주세요.</p>
				</div>
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">2.</h2>
					<p class="step_item">IKEA의 제품은 대부분이 조립 제품입니다. 조립을 시작하기 전에 설명서를
						자세히 읽어주세요. 조립에 대해 궁금한 내용은 해당 제품을 구입한 IKEA 매장에 문의하세요.</p>
				</div>
				<img src="../images/step1.jpg" alt="사용설명서를 읽은 후 IKEA에 문의하는 그림" />
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">3.</h2>
					<p class="step_item">나중에 필요한 경우를 대비하여 소책자와 조립 설명서는 보관해두는 게
						좋습니다.</p>
				</div>
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">4.</h2>
					<p class="step_item">조립 설명서를 참고하여 제품 구성에 포함되어 있는 부품과 나사가 부족하지
						않은지, 결함은 없는지 확인하세요. 부품이 부족하거나 결함이 있는 경우에는 부품번호를 확인한 후 영수증과 조립 설명서를
						지참하고 IKEA 매장의 교환 및 환불 카운터를 찾아주세요. 부품 선반에서 직접 필요한 부품을 픽업할 수 있습니다.
						부품 번호는 조립 설명서의 부품 그림 옆에 적혀있는 6자리 숫자입니다. 원하는 부품을 찾을 수 없을 때는 교환 및 환불
						카운터에서 6자리 번호와 제품명 혹은 8자리 제품번호를 알려주시면 담당직원이 찾아드립니다.</p>
				</div>
				<img src="../images/step2.jpg" alt="조립에 필요한 나사의 종류를 나타내는 그림"
					class="step_item" />
			</div>
			<div class="step" class="step_item">
				<div class="step_text">
					<h2 class="menu-title">5.</h2>
					<p class="step_item">조립 설명서를 참고하여 필요한 공구를 준비하세요. 나사의 모양과 크기에 맞는
						드라이버를 사용하는 게 좋습니다.</p>
				</div>
				<img src="../images/step3.jpg" alt="올바른 공구를 준비할 것을 권장하는 그림"
					class="step_item" />
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">6.</h2>
					<p class="step_item">조립 설명서의 그림에 두 사람이 있는 경우에는 조립이나 설치에 2명 이상이
						필요하다는 것을 의미합니다. 조립 설명서를 미리 보고 몇 명이 필요한지 확인하세요. 특히 무거운 제품은 옮기거나 조립할
						때 각별한 주의가 필요합니다.</p>
				</div>
				<img src="../images/step4.jpg" alt="두 사람이 작업할 것을 권장하는 그림"
					class="step_item" />
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">7.</h2>
					<p class="step_item">부상을 예방할 수 있는 장갑이나 고글 등의 보호장비를 착용하기 바랍니다.</p>
				</div>
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">8.</h2>
					<p class="step_item">바닥이나 벽, 주변 가구가 손상되지 않도록 카페트나 담요, 완충제 등을
						사용하세요. 공간이 충분한 장소에서 조립해야 합니다.</p>
				</div>
				<img src="../images/step5.jpg" alt="작업 시 카펫 사용을 권장하는 그림"
					class="step_item" />
			</div>
			<div class="step">
				<div class="step_text">
					<h2 class="menu-title">9.</h2>
					<p class="step_item">조립 설명서에 따라 조립하세요.처음에 너무 나사를 단단하게 조이면 뒤틀림
						현상이 발생할 수 있습니다. 어느 정도 조립이 완성될 때까지는 나사를 가볍게 조여두고 나중에 한꺼번에 단단하게
						조여주세요. 또한 나사를 너무 세게 조이면 나사나 부품이 손상될 수도 있습니다.</p>
				</div>
			</div>
		</article>
	</div>
	
<!-- 줄 띄우기 용 -->
   <br><br><br><br><br>
</body>


<jsp:include page="../footer.jsp"/>