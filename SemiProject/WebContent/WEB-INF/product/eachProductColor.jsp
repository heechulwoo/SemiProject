<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>

<html>
<head>
<title>IKEA SSANGYONG ｜ 이케아 쌍용</title>

<!-- title icon -->
<link rel="icon" href="<%= ctxPath%>/images/ico.jpg">

<!-- Font Awesome 5 Icons -->
<script src="https://kit.fontawesome.com/69a29bca1e.js" crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Optional JavaScript -->
<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>


<link rel="stylesheet" href="<%= ctxPath%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />

<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- w3schools 탬플릿 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		
	});

	function goProductPage() {
		
		var pnum = $("input:checked").val();
		
		window.opener.goProductPage(pnum);
		
		self.close();
		
	}
	
</script>
</head>
<body>
	<h3 class="justify-content-center ml-5 my-4 pt-2 pl-3" style="font-weight: bold;">색상 선택</h3>
	<div class="container-fluid my-2">
		
		<c:if test="${not empty requestScope.productColorList}">
			<c:forEach var="prodColorVO" items="${requestScope.productColorList}">
				<div class="row justify-content-center my-2">
					<div class="col-6 col-lg-6">
						<label for="color${prodColorVO.pnum}"><img class="float-right"  src="<%= ctxPath%>/image_ikea/${prodColorVO.prodimage}" style="width: 60%;"/></label>
					</div>
					<div class="col-6 col-lg-6 align-self-center">
						<label for="color${prodColorVO.pnum}">${prodColorVO.color}</label>
						<input type="radio" id="color${prodColorVO.pnum}" name="productColor" value="${prodColorVO.pnum}"/>
					</div>
				</div>
			</c:forEach>
		</c:if>
	<%--
		<div class="row justify-content-center my-1">
			<div class="col-6 col-lg-6">
				<img class="float-right" src="<%= ctxPath%>/image_ikea/레이파르네_다크옐로1.webp" style="width: 60%;"/>
			</div>
			<div class="col-6 col-lg-6 align-self-center">
				<label for="color1">다크옐로</label>
				<input type="radio" id="color1" name="productColor" value="다크옐로"/>
			</div>
		</div>
		<div class="row justify-content-center my-2">
			<div class="col-6 col-lg-6">
				<img class="float-right" src="<%= ctxPath%>/image_ikea/레이파르네_다크옐로1.webp" style="width: 60%;"/>
			</div>
			<div class="col-6 col-lg-6 align-self-center">
				<label for="color2">다크옐로</label>
				<input type="radio" id="color2" name="productColor" value="다크옐로"/>
			</div>
		</div>
		<div class="row justify-content-center my-2">
			<div class="col-6 col-lg-4">
				<img class="float-right" src="<%= ctxPath%>/image_ikea/레이파르네_다크옐로1.webp" style="width: 60%;"/>
			</div>
			<div class="col-6 col-lg-4 align-self-center">
				<label for="color3">다크옐로</label>
				<input type="radio" id="color3" name="productColor" value="다크옐로"/>
			</div>
		</div>
		<div class="row justify-content-center my-2">
			<div class="col-6 col-lg-4">
				<img class="float-right" src="<%= ctxPath%>/image_ikea/레이파르네_다크옐로1.webp" style="width: 60%;"/>
			</div>
			<div class="col-6 col-lg-4 align-self-center">
				<label for="color4">다크옐로</label>
				<input type="radio" id="color4" name="productColor" value="다크옐로"/>
			</div>
		</div>
		 --%>
		
		<br>
		<div class="d-flex justify-content-center" style="display: inline-block;">
			<button class="btn btn-info btn-lg" onclick="goProductPage();">선택</button>
		</div>
	</div>
</body>
</html>