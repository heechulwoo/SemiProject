<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%> 

<jsp:include page="../header.jsp"/>

<style>

div#trackingMain {
  padding-top: 70px;
  padding-bottom: 70px;
  border-bottom: solid 1px gray;
}

div#trackingDoMain {
  padding-top: 70px;
  padding-bottom: 70px;
  border-bottom: solid 1px gray;
}

div#helpDetail {
  padding-top: 70px;
  padding-bottom: 50px;
}

h3 {
  font-weight: bold;
}

a#shipBtn {
  width: 10em;
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

a#orderBtn {
  width: 15em;
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

a#helpBtn {
  width: 10em;
  text-align: center;
  display: inline-block;
  font-weight: bold;
  padding: 0.7rem 1.3rem;
  font-size: 0.75rem;
  border-radius: 30px;
  background-color: white;
  color: black;
  justify-content: center;
  border: solid 1px gray;
}

a#shipBtn:hover,
a#orderBtn:hover {
  opacity: 0.8;
  text-decoration: none;
  color: #8c8c8c;
}

a#helpBtn:hover {
  width: 10em;
  text-align: center;
  display: inline-block;
  font-weight: bold;
  padding: 0.7rem 1.3rem;
  font-size: 0.75rem;
  border-radius: 30px;
  background-color: black;
  color: white;
  justify-content: center;
  border: solid 1px black;
}
</style>


<script type="text/javascript">

</script>



	<div class="container">
	
	<!-- 이케아 배송 조회 제목 시작 -->
      <div id="trackingMain" class="col-md-auto">
        <h1 style="font-weight: bold">배송조회 및 관리</h1>
        <br><br>
        <p>
		    주문한 제품이 지금 어디에 있는지 알고 싶으신가요? 아니면 주문 내용에 변경하고 싶은 부분이 있나요?<br>
		    걱정하지 마세요. IKEA의 주문 조회 및 관리 서비스가 도와드릴 수 있어요.
        </p>
		<br>
        <ul>
        	<li>2021년 1월 1일 주문 건부터 제품 출고 이후 배송취소 요청시에는 운반비를 포함한 반품비 29,000원이 부과됩니다. (배송비에서 반품비 29000원 차감 후 환불됩니다.)</li>
        </ul>
        
      </div>
      <!-- 이케아 배송 조회 제목 끝 -->
      
      <!-- 이케아 배송 조회 하기 시작 -->
      <div class="row">
        <div id="trackingDoMain" class="col-md-6">
          <h3>배송조회</h3>
          <p>
		            구입한 제품이 지금 어디에 있는지 정확히 알고 싶으신가요?<br>
		            주문을 추적하면 걱정을 덜 수 있을 거예요.
          </p>
          <br><br><br>
          <a href="<%= ctxPath%>/product/shipping.one" role="button" class="btn" id="shipBtn" style="margin-top: 2vw; margin-bottom: 4vw">
          	배송 조회
          </a>
        </div>
        <div id="trackingDoMain" class="col-md-6">
          <h3>주문 관리</h3>
          <p>
                              트럭 배송 시간을 변경해야 하거나, 주문 취소 또는 조립 서비스가 필요하다면 여기에서 도와드릴게요.
          </p>
          <p>
		           주문 확인을 위해 아래의 주문 조회 및 관리 페이지에서 주문번호와 이메일 또는 전화번호를 함께 입력해주세요.
          </p>
          <a href="<%= ctxPath%>/product/shipping.one" role="button" class="btn" id="orderBtn" style="margin-top: 2vw; margin-bottom: 4vw">
          	주문 조회 및 관리하기
          </a>
          <p>주문번호는 결제 후 발송되는 주문 확인(Order confirmation) 메일에서 확인할 수 있습니다.</p>
          <p>또는 메일 하단의 주문내역 보기 버튼을 클릭하면 간단히 구매 내역을 확인할 수 있습니다.</p>
        </div>
      </div>
      <!-- 이케아 배송 조회 하기 끝 -->
      
      <!-- 이케아 도움말 더보기 시작 -->
      <div id="helpDetail" class="col-md-auto">
        <h3>도움말 더보기</h3>
        <br><br>
        <p>
		    궁금한 점이 있거나 도움이 필요하다면 고객 센터에 문의하여 필요한 답을 찾아보세요.
        </p>
		<br>
		<a href="<%= ctxPath%>/contact/contactUs.one" role="button" class="btn" id="helpBtn" style="margin-top: 2vw; margin-bottom: 4vw">
			문의하기
		</a>
      </div>
      <!-- 이케아 도움말 더보기 끝 -->
	
	
	
	</div>
	

    <!-- container 끝 -->
    
    <!-- 줄 띄우기 용 -->
    <br><br><br><br><br> 
    
<jsp:include page="../footer.jsp"/>    