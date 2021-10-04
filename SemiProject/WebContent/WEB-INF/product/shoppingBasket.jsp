<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>    

<style type="text/css">

	#shoppingBasketItem {
		margin-top: 500px;
		margin-left: 200px;
		width: 40%;
		float: left;
	}
	
	#shoppingBasket {
		display: inline-block;
		float: left;
	}
	
	#shoppingListItem {
		margin-right: 250px;
		float: right;
		width: 30%;
	}
	
	
</style>


<script type="text/javascript">

	
</script>

<jsp:include page="../header.jsp" />

	<div class="container my-5" id="shoppingBasketItem">
	
		<h2 id="shoppingBasket" class="my-4" style="font-weight: bold;">장바구니</h2>
		
		<i id="trashcan" class="my-4 fas fa-trash-alt fa-lg" style="cursor: pointer; float: right;"></i>
		
		<br><br><br><br><br>
		
		<img class="my-4" src="<%= ctxPath%>/image_ikea/몰테1.webp" style="width: 200px; float: left;" /><br>
		<label class="mx-4" style="font-weight: bold; width: 150px;">FLINTAN 플린탄</label>
		<span style="float: right;">80,000원</span><br>
		<label class="ml-4" style="width: 85px;">사무용의자</label>,&nbsp; <label style="width: 300px;">블랙</label><br><br>
		
		<div class="container ml-2" style="width: 100px; float: left;">
			<select class="form-control">
			  <option>1</option>
			  <option>2</option>
			  <option>3</option>
			  <option>4</option>
			  <option>5</option>
			  <option>6</option>
			  <option>7</option>
			  <option>8</option>
			  <option>9</option>
			  <option>10</option>
			</select>
		</div>
		<button class="btn btn-secondary" style="width: 70px;">삭제</button>
		
	</div>
	
	<div class="container my-5" id="shoppingListItem">
		<h4 class="mt-5 mb-4" style="font-weight: bold; width: 200px;">주문내역</h4><br>
		<label style="width: 300px;">FLINTAN 플린탄</label>
		<span class="mr-5 float-right">80,000 원</span><br>
		<label style="width: 300px;">FLINTAN 플린탄</label>
		<span class="mr-5 float-right">80,000 원</span><br>
		<hr class="my-3" style="border: solid 2px #666666; float: left; width: 500px; border-radius: 25px;">
		<br>
		
		<label style="width: 200px;">총 주문금액</label>
		<span class="mr-5 float-right">160,000 원</span><br><br>
		<button class="btn my-2" style="background-color: #004d99; color: white; width: 250px; height: 60px; font-weight: bold; border-radius: 5px; font-size: 16pt;">결제하기</button>
	</div>

<jsp:include page="../footer.jsp" />