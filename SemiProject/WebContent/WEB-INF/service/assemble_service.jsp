<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<title>조립 서비스</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/assemble.css" />

<jsp:include page="../header.jsp" />

<body>
	<div class="mycontainer">
		<h1 class="main-title">조립 서비스</h1>
		<img class="my_img" src="../images/assembleservice.jpg" />
		<p class="my_p">
			저희 제품은 고객이 직접 조립할 수 있도록 명확하게 디자인되어 있지만 도움이 필요한 경우 집이나 사무실에서 이용할 수 있도록
			조립서비스를 준비했습니다. 저희에게 조립을 맡기고 소중한 시간을 아끼세요. <br>
			<br>
		<hr>
		</p>

		<h1 class="menu-title">서비스 요금</h1>
		<ul class="my_ul" style="margin-bottom: 3vw;">
			<li>기본 요금 5만원을 시작으로, 제품 가격에 따라 <b>5만원</b> 단위로 서비스 요금이 부과됩니다.
			</li>
			<br>
			<li>조립이 필요한 제품 가격을 합산하여 조립서비스 요금이 책정됩니다.</li>
		</ul>
		<div class="tablewrapper">
		<table>
			<tr>
				<th>조립하고자 하는 상품의 가격</th>
				<th>조립서비스 비용</th>
			</tr>
			<tr>
				<td>~ 249,999원</td>
				<td>50,000원</td>
			</tr>
			<tr>
				<td>250,000원 ~ 499,999원</td>
				<td>100,000원</td>
			</tr>
			<tr>
				<td>500,000원 ~ 749,999원</td>
				<td>150,000원</td>
			</tr>
			<tr>
				<td>750,000원 ~ 999,999원</td>
				<td>200,000원</td>
			</tr>
			<tr>
				<td>1,000,000원 ~ 1,499,999원</td>
				<td>250,000원</td>
			</tr>
			<tr>
				<td>1,500,000원 ~ 1,999,999원</td>
				<td>300,000원</td>
			</tr>
			<tr>
				<td>500,000원이 증가할 때 마다</td>
				<td>+50,000원</td>
			</tr>
		</table>
		</div>


		<hr style="margin-bottom: 3vw;">
		<h1 class="menu-title">서비스 신청 방법</h1>
		<p class="my_p">조립 서비스 신청은 가까운 매장 직원에게 문의하거나 고객지원센터로 연락하세요. 공식 온라인몰에서
			주문시, 고객지원센터에 24시간 이내 전화 또는 주문내역 페이지에서 신청하세요.</p>

		<a href="<%= ctxPath%>/service/assemble_apply.one" role="button" class="my_btn"
			style="margin-top: 2vw; margin-bottom: 4vw;">조립 서비스 온라인 신청</a>

		<hr>
		<h3 class="menu-title" style="margin-top: 3vw;">서비스 이용 시 유의사항</h3>
		<ul class="my_ul" >
			<li>조립 서비스는 독립적인 조립 서비스 파트너 업체가 제공합니다.</li>
			<br>
			<li>조립 서비스 가능 지역 및 서비스 관련 문의는 고객지원센터로 연락 주시기 바랍니다.</li>
			<br>
			<li>소파 조립 서비스의 요금은 6만원입니다. 단, 암체어나 풋스툴은 일반 조립 서비스 가격표를 참고해 주세요.</li>
			<br>
			<li>예정된 배송시간에 부재일 경우 배송비가 추가로 부과 될 수 있습니다.</li>
			<br>
			<li>포장재는 환경친화적인 방식으로 처리합니다</li>
			<br>
		</ul>

		<a href="<%= ctxPath%>/service/services.one" role="button" class="my_btn"
			style="margin-top: 2vw; margin-bottom: 4vw;">모든 서비스 보기</a>
	</div>
</body>

<jsp:include page="../footer.jsp"/>