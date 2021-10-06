<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

	<div class="container-fluid container-xl">
		<div class="row mt-4">
			<div class="col-md-8">
				<h2 class="mb-4"><b>위시리스트</b></h2>
				<div class="my-3">
					<a href="">위시리스트</a><span> 관리하기</span>
				</div>
				<div class="px-3 py-4 border">
					<b>위시리스트를 보관하세요!</b>
					<p>이 위시리스트는 임시로 저장됩니다. <a href="#"><span style="text-decoration: underline;">가입 또는 로그인</span></a> 다시 방문할 때까지 위시리스트를 보관할 수 있어요</p>
				</div>
				<hr>
				<div class="row">
					<div class="col-3">
						<img src="<%= ctxPath%>/images/chair1.jpg" style="width:100%">
					</div>
					<div class="col-6">
						<div class="mb-2"><b><a href="">TOBIAS 토비아스</a></b></div>
						<div>
							<span>의자,투명/크롬도금</span><br>
							<span><small>603.496.72</small></span>
						</div>
						<div class="pt-2">
							<select class="badge-pill py-2 px-3">
								<optgroup>
									<option value="1" selected>1</option>
									<option value="2">2</option>
								</optgroup>
							</select>
							<button class="btn btn-outline-success badge-pill mb-1"><i class="fa fa-shopping-cart"></i></button>
						</div>
					</div>
					<div class="col-3">
						<span><b>￦89,900</b></span>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-3">
						<img src="<%= ctxPath%>/images/chair1.jpg" style="width:100%">
					</div>
					<div class="col-6">
						<div class="mb-2"><b><a href="">TOBIAS 토비아스</a></b></div>
						<div>
							<span>의자,투명/크롬도금</span><br>
							<span><small>603.496.72</small></span>
						</div>
						<div class="pt-2">
							<select class="badge-pill py-2 px-3">
								<optgroup>
									<option value="1" selected>1</option>
									<option value="2">2</option>
								</optgroup>
							</select>
							<button class="btn btn-outline-success badge-pill mb-1"><i class="fa fa-shopping-cart"></i></button>
						</div>
					</div>
					<div class="col-3">
						<span><b>￦89,900</b></span>
					</div>
				</div>
				<hr>
			</div>
			<div class="col-md-4">
				<div class="h5 pb-3" id="summary" style="border-bottom: 2px solid black;"><b>위시리스트 요약</b></div>
				<h5><b>정가&nbsp;&nbsp;&nbsp;&nbsp;￦104,000</b></h5>
				<div class="text-center">
					<div class="mb-2">이 제품을 온라인으로 구매하시겠어요?</div>
					<button class="btn btn-info btn-lg px-md-3 py-md-5 w-100"><i class="fa fa-shopping-cart"></i>&nbsp;장바구니에 모든 제품 추가</button>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../footer.jsp"/>	