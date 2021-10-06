<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<style>

div#returnTitle {
  padding-top: 70px;
  padding-bottom: 30px;
}

div#returnSubtitle{
  padding-top: 35px;
  padding-bottom: 35px;
}

h1,
h2,
h4,
h5 {
  font-weight: bold;
  color: black;
}

#contents1,
#contents2,
#contents3,
#contents4,
#contents5 {
  margin-bottom: 50px;
}

#contents5{
	padding-bottom: 100px;
}

p {
	margin-bottom: 18px;
}

li#list {
	margin-bottom: 20px;
}

a {
  text-decoration: none;
  text-decoration: underline;
  color: black;
}

a:hover {
  color: inherit;
}	
	
</style>


<script type="text/javascript">

</script>


	<div class="container">
		
		<!-- 제목 시작 -->
	      <div id="returnTitle">
	        <h1>반품 정책</h1>
	        <br>
	        <img class="return_policy-img img-fluid" src="../images/return_policy.png" alt="반품 정책" />
	      </div>
	      <div id="returnSubtitle">
		      <h4>관대한 반품 정책으로 더욱 편리한 IKEA쇼핑을 경험하세요</h4>
		      <p>IKEA에서 구매한 제품이 마음에 들지 않더라도, 시간은 충분합니다.</p>
	      </div>
	    <!-- 제목 끝 -->
	    
	    <!-- 내용 시작 -->
	    <div id="contents1" class="row">
	      <div class="col-md-8">
		      <h5>합리적인 환불 정책</h5>
		      <br>
		      <p>이 환불 정책에 명시된 약관은 한국 IKEA 매장 및 웹사이트와 앱에서 구매한 모든 상품에 적용됩니다.</p>
		      <p>*바이백 상품과 알뜰코너 상품은 교환 적용대상에서 제외됩니다.</p>
		      <p>IKEA는 구매 이후의 고객 만족도를 매우 중요하게 생각합니다. 제품이 완전히 만족스럽지 않거나 마음이 바뀐 경우, 365일 이내에 영수증(구매증빙)과 구매시 결제 수단, 그리고 제품을 가져오시면 환불해 드립니다.</p>
	      	  <p>단순 개봉 후 미사용 제품은 전액 환불 가능하며, 조립하였으나 재판매 가능한 상태의 경우에는 아래 차감 금액 기준에 따라 환불 받으실 수 있습니다. 자세한 내용은 아래 “ 얼마를 환불 받게 되나요?” 에서 확인해 주세요.</p>
	      	  <p>환불 조건이 충족되지 않는 경우에는 구매시와 동일한 결제수단으로 환불되지 않고, 제품 교환 또는 IKEA 환불카드를 수령하는 것으로 대체될 수 있으며, 구매 증빙없는 환불 요청은 거절될 수 있습니다.</p>
	      	  <p>이 정책은 고객의 마음이 변한 경우에 적용되며 고객의 법적 권한 및 IKEA 상업 보증 외에 부가적으로 적용됩니다. 제품에 결함이 있거나 설명서와 동일한 상태가 아닌 경우에는 언제든지 IKEA에 반품할 권한이 있습니다.</p>
	      </div>
	      <div class="col-md-4">
	      </div>
	    </div>
	    
	    <div id="contents2" class="row">
	      <div class="col-md-8">
		      <h5>얼마를 환불받게 되나요?</h5>
		      <br>
		      <p>제품 구매 시 사용한 신용카드, 직불카드 또는 IKEA 환불카드로 결제했던 금액이 환불 처리됩니다. 지불 수단에 따라 환불 수단은 변경될 수 있습니다. 제품 손상으로 인해 상품 가치가 하락한 경우 IKEA는 이러한 손해를 환불 금액에서 아래와 같이 차감할 권리를 가집니다.</p>
		      <br>
		      <ul>
		      	<li id="list">미개봉 , 단순 개봉했지만 미조립/미사용 제품은 구매일 이후 365일 이내 전액 환불 가능합니다.</li>
		      	<li id="list">단순 개봉 후 미사용 기준은 “조립 안된 사용감 없는- 얼룩, 흠집등이 없는 상태 “이며, 별도의 포장재 없이 판매되는 제품의 경우 “택이 제거되지 않고 제품 설명 및 고시정보 스티커가 부착된 상태”를 의미합니다.</li>
		      	<li id="list">조립하였으나 재판매 가능한 상태인 경우는 아래의 기준에 따릅니다.</li>
		      	<ul>
		      		<li id="list">구매일 기준 30일 이내 반품 시 구매 금액의 20% 차감 후 환불카드로 환불</li>
		      		<li id="list">구매일 기준 30일 경과 60일 이내 반품 시 구매 금액의 30% 차감 후 환불카드로 환불</li>
		      		<li id="list">구매일 기준 60일 경과 90일 이내 반품 시 구매 금액의 40% 차감 후 환불카드로 환불</li>
		      		<li id="list">구매일 기준 90일 경과 반품 시 구매 금액의 70% 차감 후 환불카드로 환불 또는 바이백 서비스 기준 적용 가능</li>
		      	</ul>
		      </ul>
		      <p>*배송 서비스를 구매한 경우 배송 완료일 기준으로 차감 비율이 적용됩니다.</p>
		      <p>*알뜰코너 제품도 차감 비율이 적용됩니다.</p>
	      </div>
	      <div class="col-md-4">
	      </div>
	    </div>
	    
	    <div id="contents3" class="row">
	      <div class="col-md-8">
		      <h5>상품을 환불하는 방법은 무엇인가요?</h5>
		      <br>
		      <p>고객의 편의를 위해 다음과 같이 2가지 환불 방법을 제공하고 있습니다.</p>
		      <p>1. 환불 받을 제품, 구매 시 결제했던 카드, 그리고 영수증(구매증빙)을 가지고 365일 이내 언제든지 한국 내 IKEA 매장을 방문하시면 환불을 받으실 수 있습니다. (IKEA 플래닝 스튜디오 천호와 신도림에서는 교환/환불이 불가능합니다).</p>
		      <p>2. 매장에 방문이 어려우신가요? 직접 방문하지 않고 배송사를 통해 제품을 수거해 드릴 수 있습니다. 반품비는 택배로 반품되는 경우 5,000원, 트럭으로 반품되는 경우 49,000원으로 적용됩니다. 반품접수를 원하신다면 <a href="contactUs.html">IKEA 고객지원센터</a>로 문의해주세요.</p>
	      </div>
	      <div class="col-md-4">
	      </div>
	    </div>
	    
	    <div id="contents4" class="row">
	      <div class="col-md-8">
		      <h5>수거 서비스를 이용하려면 어떤 준비가 필요한가요?</h5>
		      <br>
		      <p>
		      	수거 작업을 간소화할 수 있도록 IKEA측에 배송 주소 및 관련 사항(상품을 수거해야 하는 층, 좁은 문의 여부 등)을 가능한 한 자세히 알려주시기 바랍니다. 또한 지정한 수거 위치에 적합한 접근 수단을 확보하는 데에도 동의해 주셔야 합니다.
		      </p>
		      <p>
		      	담당자가 수거로 인해 상품이나 고객의 자산이 손상될 가능성이 있다고 판단하는 경우 이를 고객에게 알리고, 수거 문서에도 이러한 우려 사항을 기록할 수 있습니다. 우려 사항이 있어도 담당자가 상품을 수거하기를 원하시는 경우, IKEA는 수거 과정에서 발생한 어떤 손상 및 파손에 대해서 책임지지 않습니다(상품 수거 과정에 합리적인 수준의 주의를 기울였을 경우).
		      </p>
		      <p>
		      	또한 담당자가 제공하는 수거 문서에 수거가 수행되었음을 확인하는 고객 서명이 반드시 필요합니다. 고객 본인이 직접 상품 수거 과정을 확인할 수 없는 경우 본인을 대신할 성인 대리자를 지정할 수 있습니다.
		      </p>
	      </div>
	      <div class="col-md-4">
	      </div>
	    </div>
	    
	    <div id="contents5" class="row">
	      <div class="col-md-8">
		      <h5>서비스 주문을 취소할 수 있나요?</h5>
		      <br>
		      <p>
		      	배송, 조립 또는 설치 등의 서비스를 주문하신 경우, 각 서비스 약관에 명시되어 있는 취소 가능한 시점 이전까지 주문을 취소할 수 있습니다. 각 서비스 약관은 이곳에서 확인할 수 있습니다.
		      </p>
		      <p>
		      	고객이 서비스 개시에 명시적으로 동의했고 수행된 서비스를 취소할 권한이 없다는 점을 미리 인지했다면 해당 고객에게는 수행된 서비스를 취소할 권리가 없습니다. 취소 시점까지 수행되지 않은 서비스에 대한 비용은 환불 처리해 드립니다.
		      </p>
	      </div>
	      <div class="col-md-4">
	      </div>
	    </div>
	    
	    <!-- 내용 끝 -->
	    <!-- container 끝 -->  
		
	</div>
	
	
<jsp:include page="../footer.jsp"/>
	
