<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>


<div class="container-fluid container-xl mb-3">
		<h2 class="mb-4"><b>위시리스트</b></h2>
		<div class="px-3 py-4 border">
			<b>위시리스트를 보관하세요!</b>
			<p>이 위시리스트는 임시로 저장됩니다. <a href="#"><span style="text-decoration: underline;">가입 또는 로그인</span></a> 다시 방문할 때까지 위시리스트를 보관할 수 있어요</p>
		</div>
		<div class="mt-3">
			<a href="">위시리스트</a>
			<div><small class="text-secondary">7개의 제품</small></div>
		</div>
		<a class="row justify-content-between mb-5" href="<%= ctxPath%>/product/wishlistDetail.one">
			<div class="col-md-3 col-6">
			    <img src="<%= ctxPath%>/images/chair1.jpg" style="width:100%">
			</div>
			<div class="col-md-3 col-6">
		        <img src="<%= ctxPath%>/images/chair3.jpg" style="width:100%">
			</div>
			<div class="col-md-3 col-6">
		        <img src="<%= ctxPath%>/images/chair2.jpg" style="width:100%">
			</div>
			<div class="col-md-3 col-6">
		        <img src="<%= ctxPath%>/images/chair4.jpg" style="width:100%">
			</div>
		</a>
		<button class="btn badge-pill btn-dark py-3 px-4" ><i class="fas fa-clipboard-list"></i>&nbsp;위시리스트 만들기</button>
	</div>
	
	
<jsp:include page="../footer.jsp"/>	