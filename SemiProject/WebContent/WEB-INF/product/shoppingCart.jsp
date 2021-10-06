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
				<h2 class="mb-4"><b>장바구니</b></h2>
				<div class="row">
					<div class="col-3">
						<img src="<%= ctxPath%>/images/chair1.jpg" style="width:100%">
					</div>
					<div class="col-6">
						<div class="mb-2"><b><a href="">TOBIAS 토비아스</a></b></div>
						<div class="mb-2">
							<span>의자,투명/크롬도금</span><br>
						</div>
						<div class="">
							<select class="badge-pill py-2 px-3 mr-3">
								<optgroup>
									<option value="1">1</option>
									<option value="2">2</option>
								</optgroup>
							</select>
							<span class="mr-2"><a href="">삭제</a></span>
							<span><a href="">위시리스트 저장</a></span>
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
						<div class="mb-2">
							<span>의자,투명/크롬도금</span><br>
						</div>
						<div class="">
							<select class="badge-pill py-2 px-3 mr-3">
								<optgroup>
									<option value="1">1</option>
									<option value="2">2</option>
								</optgroup>
							</select>
							<span class="mr-2"><a href="">삭제</a></span>
							<span><a href="">위시리스트 저장</a></span>
						</div>
					</div>
					<div class="col-3">
						<span><b>￦89,900</b></span>
					</div>
				</div>
				<hr>
			</div>
			<div class="col-md-4">
				<div class="h5 pb-3" id="summary" style="border-bottom: 2px solid black;"><b>주문 내역</b></div>
				<h5><b>총 주문금액&nbsp;&nbsp;&nbsp;&nbsp;￦104,000</b></h5>
				<div class="text-center">
					<button class="btn btn-info btn-lg px-md-3 py-md-5 btn-block">결제하기</button>
				</div>
				<hr class="my-5">
				<p>
					<button class="btn dropdown-toggle btn-block" type="button" data-toggle="collapse" data-target="#demo1">
						쿠폰 입력
				    </button>
		        </p>
				<div class="collapse mb-1" id="demo1" >
					<div class="card card-body">
					   	<div><i class="fas fa-exclamation-circle text-primary"></i> 주문당 1개의 쿠폰만 사용할 수 있습니다.</div>
					   	<input class="my-2" type="text" placeholder="쿠폰 코드 입력">
					   	<button class="btn btn-outline-dark badge-pill">쿠폰 적용</button>
					</div>
			    </div>
			    <div class="my-3">
			    	<div class="my-1"><i class="far fa-check-circle"></i> 반품 정책 365일 이내에 제품 환불 가능</div>
			    	<div class="my-1"><i class="fas fa-lock"></i> SSL 데이터 암호화로 안전한 쇼핑</div>
			    </div>
			</div>
		</div>
	</div>

<jsp:include page="../footer.jsp"/>	