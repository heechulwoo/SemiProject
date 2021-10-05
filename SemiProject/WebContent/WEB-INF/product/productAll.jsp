<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp"/>

<script>

</script>

	<div class="container-fluid container-xl">
		<nav aria-label="breadcrumb">
		  <ol class="breadcrumb pl-0" style="background-color: white;">
		    <li class="breadcrumb-item">제품</li>
		    <li class="breadcrumb-item active" aria-current="page"><a href="#">의자</a></li>
		  </ol>
		</nav>
		<h2 class="mb-4"><b>모든제품</b></h2>
		<div class="row justify-content-between mb-5">
			<div class="col-md-2 col-6">
				<a href="">
			        <img src="<%= ctxPath%>/images/chair1.jpg" style="width:100%">
			        <span>사무용의자</span>
		        </a>
			</div>
			<div class="col-md-2 col-6">
				<a href="">
			        <img src="<%= ctxPath%>/images/chair3.jpg" style="width:100%">
        			<span>식탁의자</span>
		        </a>
			</div>
			<div class="col-md-2 col-6">
				<a href="">
			        <img src="<%= ctxPath%>/images/chair2.jpg" style="width:100%">
 			        <span>어린이의자</span>
		        </a>
			</div>
			<div class="col-md-2 col-6">
				<a href="">
			        <img src="<%= ctxPath%>/images/chair4.jpg" style="width:100%">
			        <span>카페의자</span>
		        </a>
			</div>
			<div class="col-md-2 col-6">
				<a href="">
			        <img src="<%= ctxPath%>/images/chair5.jpg" style="width:100%">
			        <span>스툴</span>
		        </a>
			</div>
		</div>
		<div class="row my-2">
			<p class="col-md-7">
					의자를 찾고 계신가요? IKEA에는 다양한 의자가 준비되어 있어서 집안에 필요한 의자를 쉽게 찾으실 수 있어요. 포인트를 줄 수 있는 특이한 의자, 편안한 식탁의자, 공간을 많이 차지하지 않는 접이식 의자, 인체공학적 사무용 의자... 어떤 의자를 원하시든 맞는 의자를 만나실 수 있을 거예요.
			</p>
		</div>
		<div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	정렬
			  </button>
			  <div class="dropdown-menu">
				<div class="dropdown-item">			  
			    	<label for="low-price">낮은가격순&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="low-price"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="high-price">높은가격순&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="high-price"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="new">최신&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="new"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="pro_name">이름&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="pro_name"/>
			    </div>
				<div class="dropdown-item">			  
			    	<label for="popular">인기있는&nbsp;&nbsp;&nbsp;</label><input type="radio" name="range" id="popular"/>
			    </div>
			  </div>
			</div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	카테고리
			  </button>
			  <div class="dropdown-menu">
			    <div class="dropdown-item">
				    <label for="office">사무용의자</label> <input type = "checkbox" id="office">
		        </div>
			    <div class="dropdown-item">
				    <label for="dining">식탁의자</label> <input type = "checkbox" id="dining">
		        </div>
			    <div class="dropdown-item">
				    <label for="child">어린이의자</label> <input type = "checkbox" id="child">
		        </div>
			    <div class="dropdown-item">
				    <label for="cafe">카페의자</label> <input type = "checkbox" id="cafe">
		        </div>
			    <div class="dropdown-item">
				    <label for="stool">스툴</label> <input type = "checkbox" id="stool">
		        </div>
			  </div>
			</div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	가격
			  </button>
			  <div class="dropdown-menu">
			    <div class="dropdown-item">
				    <label for="9999">&#8361;0 - 9,999</label> <input type = "checkbox" id="9999">
		        </div>
			    <div class="dropdown-item">
				    <label for="19999">&#8361;10,000 - 19,999</label> <input type = "checkbox" id="19999">
		        </div>
			    <div class="dropdown-item">
				    <label for="29999">&#8361;10,000 - 19,999</label> <input type = "checkbox" id="29999">
		        </div>
			    <div class="dropdown-item">
				    <label for="39999">&#8361;10,000 - 19,999</label> <input type = "checkbox" id="39999">
		        </div>
			    <div class="dropdown-item">
				    <label for="40000">&#8361;40,000+</label> <input type = "checkbox" id="40000">
		        </div>
			  </div>
			</div>
			<div class="btn-group">
			  <button class="btn btn-light dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  	색상
			  </button>
			  <div class="dropdown-menu">
			    <div class="dropdown-item">
				    <label class="w-75" for="gray">그레이</label> <input type = "checkbox" id="gray">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="beige">베이지</label> <input type = "checkbox" id="beige">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="white">화이트</label> <input type = "checkbox" id="white">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="black">블랙</label> <input type = "checkbox" id="black">
		        </div>
			    <div class="dropdown-item">
				    <label class="w-75" for="brown">브라운</label> <input type = "checkbox" id="brown">
		        </div>
			  </div>
			</div>
		</div>
		<hr>
	</div>
	<div class="container-fluid container-xl mt-1 mb-5">
		<div class="row">
			<div class="col-md-3 col-6 product">
				<div class="hidden my-2">
	                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
	            </div>
				<a href="">
			        <img src="<%= ctxPath%>/images/chair1.jpg" style="width:100%">
			        <span>TOBIAS 토비아스<br><b>￦89,900</b></span>
		        </a>
		        <div class="hidden">
	                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
	            </div>
			</div>
			<div class="col-md-3 col-6 product">
				<div class="hidden my-2">
	                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
	            </div>
				<a href="">
			        <img src="<%= ctxPath%>/images/chair3.jpg" style="width:100%">
       				<span>LEIFARNE 레이파르네<br><b>￦49,900</b></span>
		        </a>
		        <div class="hidden">
	                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
	            </div>
			</div>
			<div class="col-md-3 col-6 product">
				<div class="hidden my-2">
	                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
	            </div>
				<a href="">
			        <img src="<%= ctxPath%>/images/chair2.jpg" style="width:100%">
			        	<span>NOLYMYRA 놀뮈라<br><b>￦35,000</b></span>
		        </a>
		        <div class="hidden">
	                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
	            </div>
			</div>
			<div class="col-md-3 col-6 product">
				<div class="hidden my-2">
	                <button class="btn btn-outline-danger btn-sm border-0"><i class="icon-link far fa-heart fa-lg"></i></button>
	            </div>
				<a href="">
			        <img src="<%= ctxPath%>/images/chair4.jpg" style="width:100%">
	      				<span>LOBERGET 로베리에트<br><b>￦39,000</b></span>
		        </a>
		        <div class="hidden">
	                <button class="btn btn-outline-success btn-sm">Cart&ensp;<i class="fa fa-shopping-cart"></i></button>
	            </div>
			</div>
		</div>
		<hr>
		<div class="text-center">
			<button type="button" class="btn btn-light">더보기</button>
		</div>
	</div>

<jsp:include page="../footer.jsp"/>