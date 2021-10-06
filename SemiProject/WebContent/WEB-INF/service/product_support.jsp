<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<title>제품 지원</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/product_support.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />


<jsp:include page="../header.jsp" />

<body>
	<div class="mycontainer">
	<div class="wrapper">
		<h1 class="main-title">제품 지원</h1>
			<a class="my_a" href="<%= ctxPath%>/service/assembly_guides.one"> 
				<img class="my_img" src="../images/guide_thumbnail.jpg" alt="조립가이드"  />
				<h3 class="menu-title">이렇게 조립하세요!</h3> 
				<i class="fas fa-arrow-right fa-2x"></i>
			</a>
		</div>	
	</div>
	<!-- end of container  -->	
	
	<div class="push"></div>
</body>



<jsp:include page="../footer.jsp"/>
