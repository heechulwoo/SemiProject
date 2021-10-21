<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%> 

<jsp:include page="../header.jsp"/>

<style>
	
div#storesMain {
  padding-top: 70px;
  padding-bottom: 50px;
}

div#whereStore1,
div#whereStore2,
div#whereStore3 {
  padding-top: 50px;
  padding-bottom: 50px;
}

h1,
h2,
h3,
h4,
h5 {
  font-weight: bold;
  color: black;
}

p#boldft {
	font-weight: bold;
}

span#where {
	font-weight: bold;
}

.btnWhere {
  width: 10em;
  text-align: center;
  display: inline-block;
  font-weight: bold;
  padding: 0.7rem 1.3rem;
  font-size: 0.75rem;
  border-radius: 30px;
  background-color: white;
  color: black;
  justify-content: center;
  border: solid 1px gray;
}

.btnWhere:hover {
  width: 10em;
  text-align: center;
  display: inline-block;
  font-weight: bold;
  padding: 0.7rem 1.3rem;
  font-size: 0.75rem;
  border-radius: 30px;
  background-color: white;
  color: black;
  justify-content: center;
  border: solid 1px black;
}
	
</style>


<script type="text/javascript">


</script>
	
	
	<div class="container">
	   <!-- 이케아 매장 안내 제목 시작 -->
       <div id="storesMain" class="col-md-auto">
        <h1 style="font-weight: bold">매장 안내</h1>
        <br /><br />
        <h5>전국 IKEA 매장</h5>
        <br>
        <p>
          	<span id="where">광명, 고양, 기흥, 동부산</span>에서 만날 수 있는 IKEA 매장!
        </p>
        <p></p>
        <p>
	        IKEA에서 운영하는 매장들입니다.<br>
	                  아래에서 방문을 원하는 매장을 찾아 매장별 위치를 알아보세요.
        </p>
       </div>
      <!-- 이케아 매장 안내 제목 끝 -->
	
	
	
	<!-- 이케아 매장 안내1 시작 -->
      <div class="row">
        <!-- 이케아 기흥점 시작 -->

        <div id="whereStore1" class="col-md-6">
	        <c:if test="${not empty storeList}">
		        <c:forEach var="storeList" items="${requestScope.storeList}">
		          <a href="https://map.kakao.com/link/search/${storeList.storename}">
		          	<img class="service-img d-block w-100" src="<%= ctxPath%>/image_ikea/${storeList.storeimg}" alt="${storeList.storename}" />
		          </a>
		          <br>
		          <h4>${storeList.storename}</h4>
		          <p>${storeList.postcode}&nbsp;${storeList.address}&nbsp;${storeList.detailaddress}&nbsp;${storeList.extraaddress}</p>
		          <br />
		          <p id="boldft">
		                           매장
		          </p>
		          <br>
		          <ul>
		          	<li>${storeList.openhour} ~ 22 : 00</li>
		          </ul>
		          <br><br>
		          <p id="boldft">
		            * 임시 운영 일정 (정부 시행 지침 기간과 동일)
		          </p>
		          <p id="boldft">
		                           매장
		          </p>
		          <br>
		          <ul>
		          	<li>월요일 - 일요일 ${storeList.openhour} ~ ${storeList.closehour}</li>
		          </ul>
		          <br>
		          <p id="boldft">
		                           레스토랑
		          </p>
		          <br>
		          <ul>
		          	<li>월요일 - 일요일  ${storeList.ropenhour} ~  ${storeList.rclosehour}<br>
					</li>
		          </ul>
		          <a href="https://map.kakao.com/link/search/${storeList.storename}" role="button" class="btnWhere" style="margin-top: 2vw; margin-bottom: 4vw">
		          	지도 확인하기
		          </a>
		        </c:forEach>  
	        </c:if>  
        </div>
        <!-- 이케아 기흥점 끝 -->
	</div>
	
	</div>
	<!-- container 끝 -->
	
	<!-- 줄 띄우기 용 -->
    <br><br><br><br><br>
	
<jsp:include page="../footer.jsp"/>	