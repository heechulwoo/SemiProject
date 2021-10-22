<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>    
<jsp:include page="../header.jsp" />

<style type="text/css">
	
	div#container {
		margin-top: 150px; 
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

	$(document).ready(function() {
		
		$("span.error").hide();
		$("input#shippingNo").focus();	// 첫번째 input 주문번호(shippingNo)에 focus
		
		$("input#shippingNo").blur(function() {
			var regExp = /^[0-9]{10}$/i;
			
			var shippingNo = $(this).val().trim();
			
			var bool = regExp.test(shippingNo);
			
			if(!bool) {	// 주문번호가 정규표현식에 맞지 않는 경우
				$(this).next().show();
				$(this).focus();
			}
			else {
				$(this).next().hide();
			}
		}); // end of $("input#shippingNo").blur(function() {})
		
		$("input#shippingEmail").blur(function() {
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			
			var shippingEmail = $(this).val().trim();
			
			var bool = regExp.test(shippingEmail);
			
			if(!bool) {	// 주문자 이메일이 정규표현식이 맞지 않는 경우
				$(this).next().show();
				$(this).focus();
			}
			else {
				$(this).next().hide();
			}
		});// end of $("input#shippingEmail").blur(function() {})
		
		
	});// end of $(document).ready(function() {})
	
	// Function Declaration
	// 
	function goCheckOrder() {
		
		// *** 입력사항 기입 여부를 검사한다. *** //
		var boolFlag = false;
		
		var shippingNo = $("input#shippingNo").val().trim();
		var shippingEmail = $("input#shippingEmail").val().trim();
		
		if(shippingNo == "") {	// 데이터가 공백이면
			alert("주문 확인 입력사항을 입력하세요.");
			boolFlag = true;
			return false;	// break와 동일
		}
		
		if(shippingEmail == "") {	// 데이터가 공백이면
			alert("주문 확인 입력사항을 입력하세요.");
			boolFlag = true;
			return false;	// break와 동일
		}
		
		if(boolFlag) {
			return; // 종료
		}
		else {
			// 구매 내역 페이지로 이동
			$.ajax({
				url:"<%= ctxPath%>/product/shippingNoCheck.one",
				type:"post",
				data:{"shippingNo": $("input#shippingNo").val(),
					  "shippingEmail": $("input#shippingEmail").val()},
				dataType:"json",
				success: function(json) {
					
					if(json.isExists) {
						// 입력한 주문 코드가 있다면
						var frm = document.orderForm;
						frm.action = "orderConfirmation.one";
						frm.method = "post";
						frm.submit();
					}
					else {
						alert("입력한 주문정보가 존재하지 않습니다.");
					}
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			})
			
		}
		
	}
	
</script>


	<div id="container" class="container-fluid">
		<div class="row my-5 justify-content-center">
			<div class="col-11 col-lg-4 mb-5 align-self-center">
				<h3 class="mb-3 mx-1" style="font-weight: bold;">주문 조회 및 관리</h3>
				<div id="message" class="mx-1 my-3 px-3 py-3" style="border-left: 5px solid #2e2eb8; border-radius: 5px; box-shadow: 3px 3px 3px 3px #d9d9d9;">
					주문번호는 결제 후 발송되는 주문 확인(Order confirmation) 메일에서 확인하거나 메일 하단의 주문내역 보기 버튼을 클릭하면 간단히 구매 내역을 확인할 수 있습니다.
				</div>
			</div>
			<div  class="col-11 col-lg-4 mb-5 align-self-center">
				<form id="form" name="orderForm" class="contianer mx-5 px-4" style="inline;">
					<h4>주문번호</h4>
					<input type="text" class="form-control my-3" id="shippingNo" name="shippingNo" placeholder="공백없이 10자리 숫자"/>
					<span class="error">주문번호 형식에 맞지 않습니다.</span>
					<br>
					<h4>이메일</h4>
					<input type="text" class="form-control my-3" id="shippingEmail" name="shippingEmail" placeholder="주문자 이메일"/>
					<span class="error">이메일 형식에 맞지 않습니다.</span>
					<br><br>
					<button type="button" class="btn btn-dark" onClick="goCheckOrder()" style="border-radius: 30px">주문 조회</button>
				</form>
			</div>
		</div>
	</div>
<jsp:include page="../footer.jsp" />