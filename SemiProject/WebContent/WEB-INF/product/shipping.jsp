<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>    

<style type="text/css">
	
	div#container {
		margin-top: 200px; 
	}
	
	#message {
		display: inline-block;
		width: 90%;
	}
	
	
	button {
		width: 80%;
		height: 50px;
		font-weight: bold;
		
	}
	
</style>


<script type="text/javascript">

	
</script>

<jsp:include page="../header.jsp" />
	<div id="container" class="container-fluid">
		<div class="row my-5 justify-content-center">
			<div class="col-11 col-lg-4 mb-5 align-self-center">
				<h3 class="mb-3 mx-1" style="font-weight: bold;">주문 조회 및 관리</h3>
				<div id="message" class="mx-1 my-3 px-3 py-3" style="border-left: 5px solid #2e2eb8; border-radius: 5px; box-shadow: 3px 3px 3px 3px #d9d9d9;">
					주문번호는 결제 후 발송되는 주문 확인(Order confirmation) 메일에서 확인하거나 메일 하단의 주문내역 보기 버튼을 클릭하면 간단히 구매 내역을 확인할 수 있습니다.
				</div>
			</div>
			<div id="orderForm" class="col-11 col-lg-4 mb-5 align-self-center">
				<div id="form" class="contianer mx-5 px-4" style="inline;">
					<h4>주문번호</h4>
					<input type="text" class="form-control my-3" id="shippingNo" name="shippingNo" placeholder="공백없이 9-10자리 숫자"/>
					<br>
					<h4>이메일</h4>
					<input type="text" class="form-control my-3" id="email" name="email" placeholder="주문자 이메일"/>
					<br>
					<button type="button" class="btn btn-dark">주문 조회</button>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../footer.jsp" />