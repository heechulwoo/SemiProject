<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>   

<jsp:include page="../header.jsp"/>

<style>
	
div#warrantyTitle {
  padding-top: 70px;
  padding-bottom: 70px;
  border-bottom: solid 1px gray;
}
div#warrantyDetail {
  padding-top: 70px;
  padding-bottom: 50px;
  border-bottom: solid 1px gray;
}
h1,
h3 {
  font-weight: bold;
  color: black;
}
img.warrantyDetail {
	max-width: 90%;
	height: auto;
}
#bold {
	font-weight: bold;
}
div#detail {
  padding-top: 50px;
  padding-bottom: 70px;
}
div#seeDetail {
  padding-top: 50px;
  padding-bottom: 50px;
  border-bottom: solid 1px gray;
}
button#btnDetail{
	border: 0;
	outline: 0;
	display: block;
	font-weight: bold;
	background-color: white;
}
button#btnDetail:hover{
	border: 0;
	outline: 0;
	display: block;
	font-weight: bold;
	text-decoration: underline;
	background-color: white;
}
a#bold {
	font-weight: bold;
}
a#bold:hover {
	opacity: 0.8;
  	color: #808080;
  	font-weight: bold;
}
	
</style>


<script type="text/javascript">
	
	$(function (){
		$("#btnDetail").click(function (){
	  	$("#seeDetail").toggle();
	  });
	});
	
</script>


	<div class="container">
	<!-- 이케아 품질 보증 제목 시작 -->
      <div id="warrantyTitle">
        <h1>품질 보증</h1>
        <br /><br />
        <p>
          IKEA는 품질에 자신감이 있기에, 대부분 제품에 품질보증을 제공하고 있습니다.<br>
		     아래의 제품별 품질보증 내용을 확인해보세요.
        </p>
        <p>
	      IKEA 품질보증은 제품을 구매한 날부터 유효하며, 구입 증빙 자료로 영수증 원본이 필요합니다.
        </p>
      </div>
     <!-- 이케아 품질 보증 제목 끝 -->
     
     <!-- 이케아 품질보증 설명 시작 -->
      <div id="warrantyDetail" class="col-md-auto">
        <h3>사무용 의자</h3>
        <br><br>
        <img class="warrantyDetail" alt="사무용 의자 품질보증" src="../images/warranty.png">
        <br><br><br>
        <p>
          IKEA 사무용 의자들은 모두 엄격한 업무용 기준에 따라 테스트를 완료하였으며, IKEA의 까다로운 품질 및 안전 기준에 부합합니다.
                       이에 IKEA는 사무용 의자의 움직이는 부품과 프레임에 사용된 소재 및 제조상 결함에 대해 10년 품질 보증을 제공합니다.
        </p>
      </div>
      
      <!-- 자세히 보기 시작 -->
      <div id="detail" class="col-md-auto">	
      	<button id="btnDetail">자세히 보기</button>
		<div id="seeDetail" style="display:none">
			<p id="bold">품질보증 기간</p>
			<p>본 품질 보증은 제품 구입일로부터 10년간 유효합니다. 구입 증빙 자료로 영수증 원본이 필요합니다.</p>
			<br><br>
			<p id="bold">품질보증 범위</p>
			<p>본 품질 보증은 아래 명시된 부품의 소재 및 제조상 결함 시 제공됩니다.</p>
			<ul>
				<li>구조 프레임</li>
				<li>움직이는 부품</li>
			</ul>
			<p>
				움직이는 부품이란 이동 및 길이조절 기능을 갖춘 구성품을 말합니다. 바퀴, 가스 실린더, 기계 장치, 팔걸이 및 등받이 조절 장치 등 구성품의 본래 기능에 대해서만 품질보증이 적용됩니다.
			</p>
			<br><br>
			<p id="bold">품질보증의 적용 예외</p>
			<p>
				조립 실수, IKEA의 설명서를 따르지 않은 잘못된 조립, 잘못된 보관, 부적절한 사용, 오/남용, 개조, 잘못된 세척 방법, 부적합한 세제 사용으로 문제가 발생한 제품에 대해서는 본 품질보증이 적용되지 않습니다. 정상적인 마모와 기타 충격이나 사고에 의한 상처, 금, 흠집에는 본 품질보증이 적용되지 않습니다.
			</p>
			<p>
				제품을 야외 및 욕실과 같은 습한 환경에 방치한 경우 본 품질보증이 적용되지 않습니다. 사용자의 부주의로 인한 손상이나 그에 따른 부수적인 손상에는 품질보증이 적용되지 않습니다.
			</p>
			<br><br>
			
			<!-- 사무용 의자 품질보증 시작 -->
	      	<a id="bold" href="https://www.ikea.com/kr/ko/files/pdf/d2/89/d289a234/workchairs_guarantee_brochure_kr.pdf">
	      	사무용 의자 품질보증<br>
	      	PDF 열기 (298.98 KB)
	      	</a>
	        <!-- 사무용 의자 품질보증 시작 -->
			
		</div>
      </div>	
      <!-- 자세히 보기 끝 -->
      
     <!-- 이케아 품질보증 설명 끝 -->
    	
	</div>
	
	<!-- container 끝 -->
	
	<!-- 줄 띄우기 용 -->
    <br><br><br><br><br> 
	
<jsp:include page="../footer.jsp"/>	