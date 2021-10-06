<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<style>
	
div#untactCallMain {
  padding-top: 70px;
  padding-bottom: 30px;
}

/* 유튜브 크기 조절 시작 */
 #youtube {
  position: relative;
  padding-bottom: 35.25%;
  padding-top: 30px;
  height: 0;
  overflow: hidden;
}
#youtube iframe,
#youtube object,
#youtube embed {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 80%;
}
/* 유튜브 크기 조절 끝 */

#youtube,
#recommend {
	margin-top: 30px;
}

h3,
h4,
h5,
h6 {
  font-weight: bold;
}

#rContent > li {
  margin-bottom: 12px;
}

a#untactIkea {
  font-weight: bold;
}
a#untactIkea:hover{
  opacity: 0.8;
  color: #808080;
  font-weight: bold;
}

img#untactDetail {
  width: 350px;
  height: 200px;
}

.receive {
  font-weight: bold;
}

div#untactCallOrder {
  margin-top: 50px;
  padding-bottom: 70px;
  border-bottom: solid 1px gray;
}

div#questions {
  padding-top: 70px;
  padding-bottom: 70px;
}
	
</style>


<script type="text/javascript">

</script>


	<div class="container">
      <!-- 이케아 비대면 전화 주문 서비스 시작 -->
      <!-- 제목 시작 -->
      <div id="untactCallMain" class="col-md-auto">
        <h1 style="font-weight: bold">비대면 전화 주문 서비스</h1>
        <br><br>
        <p>
	           안전한 쇼핑을 선호하게 된 요즘, 온라인 주문 마저도 힘들게 느껴진다면, 걱정하지 마세요.<br>
	           편리하고 안전한 구매를 위해 IKEA의 전문가들이 도와 드릴게요!<br>
	     IKEA 매장과 고객지원센터 전문가들이 비대면으로 구매 할 수 있는 서비스를 제공합니다.<br>
        </p>
      </div>
      <!-- 제목 끝 -->

      <!-- 중간 컨텐츠 시작 -->
      <div id="untactCallContent" class="row">
        <div id="youtube" class="col-md-6">
          <iframe width="350" height="200" src="https://www.youtube.com/embed/rW_HZXcGzUo" title="YouTube video player" frameborder="0" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
        <div id="recommend" class="col-md-6">
          <h4>
		            전화 주문 1670-4532<br>
		            주중/주말 10:00 ~ 20:30
          </h4>
          <br>
          <h6>이런분들께 추천드려요!</h6>
          <br><br>
          <ul id="rContent">
            <li>온라인 주문이 어려워요.</li>
            <li>장바구니에 제품이 담기지 않아요.</li>
            <li>결제 진행 시 오류가 발생해요.</li>
            <li>주문과 동시에 조립서비스를 신청하고 싶어요.</li>
            <li>대량구매를 하고 싶어요. (제품별 구매 수량 100개 이상)</li>
            <li>IKEA for Business 구매 및 플래닝 상담 문의를 하고싶어요.</li>
          </ul>
        </div>
      </div>
      <!-- 중간 컨텐츠 끝 -->

      <!-- 주문방법 시작 -->
      <div id="untactCallOrder">
        <h3>주문 방법</h3>
        <br><br>
        <div class="row">
          <div id="order1" class="col-md-4">
            <h5>1단계</h5>
            <p>
              <a id="untactIkea" href="<%= ctxPath%>/member/register.one">IKEA.kr 회원가입</a> 후 로그인 한 상태에서 위시리스트에 원하는 제품을 담아 주세요.
            </p>
            <img id="untactDetail" class="untactCall1-img img-fluid" src="../images/untactCall1.png" alt="주문방법1"/>
          </div>
          <div id="order2" class="col-md-4">
            <h5>2단계</h5>
            <p>
              <span class="receive">접수 버튼을 클릭하신 후</span> 접수해주세요.
            </p>
            <img id="untactDetail" class="untactCall2-img img-fluid" style="margin-top: 1.5vw" src="../images/untactCall2.png" alt="주문방법2" />
          </div>
          <div id="order3" class="col-md-4">
            <h5>3단계</h5>
            <p>전문 상담원을 통해 원하는 제품을 구매해 보세요.</p>
            <img id="untactDetail" class="untactCall3-img img-fluid" style="margin-top: 1.5vw" src="../images/untactCall3.png" alt="주문방법3" />
          </div>
        </div>
      </div>
      <!-- 주문방법 끝 -->

      <!-- 자주하는 질문 시작 -->
      <div id="questions" class="col-md-auto">
        <h3>자주하는 질문</h3>
        <br><br>
        <p style="font-weight: bold">
          Q. 온라인 배송비와 매장 배송비는 어떻게 다른가요?<br>
          A. <a id="untactIkea" href="shipping_service.html">배송비 확인하기</a>
        </p>

        <br />

        <p style="font-weight: bold">
          Q.조립 서비스도 가능한가요?<br>
          A. <a id="untactIkea" href="assemble_service.html">조립 서비스 알아보기</a>
        </p>
      </div>
      <!-- 자주하는 질문 끝 -->

      <!-- 이케아 비대면 전화 주문 서비스 끝 -->
    </div>

    <!-- container 끝 -->
    
    <!-- 줄 띄우기 용 -->
    <br><br><br><br><br> 
    
<jsp:include page="../footer.jsp"/>