<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>   

<jsp:include page="../header.jsp"/>

<style>
	
div#returnMain {
  padding-top: 70px;
  padding-bottom: 70px;
  border-bottom: solid 1px gray;
}
div#returnDoMain {
  padding-top: 70px;
  padding-bottom: 70px;
  border-bottom: solid 1px gray;
}
div#breakDoMain {
  padding-top: 70px;
  padding-bottom: 70px;
}
a#returnIkea {
  font-weight: bold;
}
a#returnIkea:hover{
  opacity: 0.8;
  color: #808080;
  font-weight: bold;
}
div#otherDoMain {
  padding-top: 50px;
}
h3 {
  font-weight: bold;
}
img#returnClaim {
  width: 30vw;
}
a#returnBtn {
  width: 13em;
  text-align: center;
  display: inline-block;
  font-weight: bold;
  padding: 0.7rem 1.3rem;
  font-size: 0.75rem;
  border-radius: 30px;
  background-color: black;
  color: white;
  justify-content: center;
}
a#returnBtn:hover {
  opacity: 0.8;
  text-decoration: none;
}
i#arrow {
  font-size: 23pt;
}
	
</style>


<script type="text/javascript">


</script>



	<div class="container">
      <!-- 이케아 교환환불 제목 시작 -->
      <div id="returnMain" class="col-md-auto">
        <h1 style="font-weight: bold">교환환불</h1>
        <br /><br />
        <p>
          IKEA에서 구매한 제품이 마음에 들지 않으면 365일 이내에 가져오세요.<br />
                      구매 영수증과 사용하지 않은 제품을 가져오면 환불해 드립니다.<br />
        </p>

        <p></p>
        <p style="color: gray">
	             다만, 조건에 맞지 않으면, IKEA는 교환 및 환불 요청을 거절할 수 있습니다.
        </p>
      </div>
      <!-- 이케아 교환환불 제목 끝 -->

      <!-- 이케아 교환환불 하기 시작 -->
      <div class="row">
        <div id="returnDoMain" class="col-md-6">
          <h3>교환환불 하기</h3>
          <img id="returnClaim" class="service-img d-block w-100" src="../images/return1.png" alt="방문 수거" />
          <h5 style="font-weight: bold">방문 수거</h5>
          <br>
          <p>
		            매장 방문 없이 교환환불을 원하시면 방문 수거 서비스를 이용해 보세요.<br>
		            도심 지역의 제품 수거 비용은 택배 배송은 5,000원 부터, 트럭 배송은 49,000원 부터 시작합니다.<br>
		            서비스가 제공되지 않는 지역도 있으니, 가격과 일정에 관한 자세한 정보는 고객센터로 문의해주세요.
          </p>
        </div>
        <div id="returnDoMain" class="col-md-6">
          <h3>&nbsp;</h3>
          <img id="returnClaim" class="service-img d-block w-100" src="../images/return2.png" alt="매장" />
          <h5 style="font-weight: bold">매장</h5>
          <br>
          <p>
            <a id="returnIkea" href="<%= ctxPath %>/contact/stores.one">IKEA 매장</a>에서 교환/환불을 신청해보세요.
          </p>
          <p>
		            매장 방문전 이케아 웹사이트에서 '셀프 반품' 신청을 하시면 보다 쉽고
		            빠르게 반품할 수 있습니다.<br>
		            반품에 필요한 정보를 입력한 후 생성된 바코드와 영수증을 제품과 함께
		            매장의 교환환불코너에서 제시하면,<br>
		            추가 정보 입력 절차 없이 바로 반품이 가능합니다.<br>
          </p>
          <a href="<%= ctxPath %>/contact/selfReturn.one" role="button" id="returnBtn" class="btn" style="margin-top: 2vw; margin-bottom: 4vw" >셀프 반품 신청하기</a>
          <p>* 플래닝 스튜디오 (천호/신도림)에서는 교환/환불이 불가능합니다.</p>
          <p>
            * IKEA Lab에서 구매하신 제품은 셀프 반품 접수 대상이 아니며, IKEA
            Lab은 IKEA Lab에서 구매하신 제품에 한해 교환/환불이 가능합니다
          </p>
        </div>
      </div>

      <!-- 이케아 교환환불 하기 끝 -->

      <!-- 이케아 제품 누락 / 파손 제품 문의 / 주문 오류 시작 -->
      <div class="row">
        <div id="breakDoMain" class="col-md-6">
          <h3>제품 누락 / 파손 제품 문의 / 주문 오류</h3>
          <img id="returnClaim" class="service-img d-block w-100" src="../images/return3.png" alt="전화 문의하기" />
          <h5 style="font-weight: bold">전화 문의하기</h5>
          <br />
          <p>
                           제품 교환환불 문의 시 미리 제품사진을 찍어 국번 없이
            1670-4532(고객지원센터)에 문자로 보내주세요.<br>
                           그 후 연락 주시면 빠른 상담이 가능합니다.
          </p>
        </div>
        <div id="breakDoMain" class="col-md-6">
          <h3>&nbsp;</h3>
          <img id="returnClaim" class="service-img d-block w-100" src="../images/return4.png" alt="가까운 매장 방문하기" />
          <h5 style="font-weight: bold">가까운 매장 방문하기</h5>
          <br />
          <p>
                            가까운 IKEA 매장을 방문하시면, 언제나 최선을 다해 도와 드리겠습니다.
          </p>
          <p>
		          제품이 파손된 경우, 해당 제품과 함께 구매 영수증을 준비하고, 제품이
		          누락된 경우, 주문 확인서를 지참하면 됩니다.
          </p>
          <p>* 플래닝 스튜디오 (천호/신도림)에서는 교환/환불이 불가능합니다.</p>
        </div>
      </div>
      <!-- 이케아 제품 누락 / 파손 제품 문의 / 주문 오류 끝 -->
	  
	  <!-- 반품 및 품질 보증 시작 -->
      <div class="row">
        <div id="otherDoMain" class="col-md-6">
          <a id="returnIkea" href="<%= ctxPath %>/contact/returnPolicy.one">
            <img id="returnClaim" class="service-img d-block w-100" src="../images/return5.png" alt="반품 정책" style="margin-bottom: 0.5vw" />
            <h5 style="font-weight: bold">반품 정책</h5>
            <br>
            <i id="arrow" class="fas fa-arrow-right"></i>
          </a>
        </div>
        <div id="otherDoMain" class="col-md-6">
          <a id="returnIkea" href="<%= ctxPath %>/contact/warranty.one" style="margin-bottom: 3vw">
            <img id="returnClaim" class="service-img d-block w-100" src="../images/return6.png" alt="품질보증" style="margin-bottom: 2.3vw" />
            <h5 style="font-weight: bold">품질보증</h5>
            <br>
            <i id="arrow" class="fas fa-arrow-right" style="margin-bottom: 3vw"></i>
          </a>
        </div>
      </div>
      <!-- 반품 및 품질 보증 끝 -->
    </div>

    <!-- container 끝 -->
    
    <!-- 줄 띄우기 용 -->
    <br><br><br><br><br> 
    
<jsp:include page="../footer.jsp"/>    