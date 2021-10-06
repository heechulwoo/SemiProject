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
          <a href="https://map.kakao.com/link/search/이케아 기흥점">
          	<img class="service-img d-block w-100" src="../images/giheung.png" alt="IKEA 기흥점" />
          </a>
          <br>
          <h4>IKEA 기흥점</h4>
          <p>경기도 용인시 기흥구 신고매로 62</p>
          <br />
          <p id="boldft">
                           매장
          </p>
          <br>
          <ul>
          	<li>10 : 00 ~ 22 : 00</li>
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
          	<li>월요일 - 일요일 10 : 00 ~ 21 : 00</li>
          </ul>
          <br>
          <p id="boldft">
                           레스토랑
          </p>
          <br>
          <ul>
          	<li>월요일 - 일요일 09 : 30 ~ 20 : 30<br>
				(마지막 주문 20 : 00)</li>
          </ul>
          <a href="https://map.kakao.com/link/search/이케아 기흥점" role="button" class="btnWhere" style="margin-top: 2vw; margin-bottom: 4vw">
          	지도 확인하기
          </a>
        </div>
        <!-- 이케아 기흥점 끝 -->
        
        <!-- 이케아 광명점 시작 -->
        <div id="whereStore1" class="col-md-6">
          <a href="https://map.kakao.com/link/search/이케아 광명점">
          	<img class="service-img d-block w-100" src="../images/gwangmyeong.png" alt="IKEA 광명점" />
          </a>
          <br>
          <h4>IKEA 광명점</h4>
          <p>경기도 광명시 일직로 17</p>
          <br />
          <p id="boldft">
                           매장
          </p>
          <br>
          <ul>
          	<li>10 : 00 ~ 22 : 00</li>
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
          	<li>월요일 - 일요일 10 : 00 ~ 21 : 00</li>
          </ul>
          <br>
          <p id="boldft">
                           레스토랑
          </p>
          <br>
          <ul>
          	<li>월요일 - 일요일 09 : 30 ~ 20 : 30<br>
				(마지막 주문 20 : 00)</li>
          </ul>
          <a href="https://map.kakao.com/link/search/이케아 광명점" role="button" class="btnWhere" style="margin-top: 2vw; margin-bottom: 4vw" >
          	지도 확인하기
          </a>
        </div>
        <!-- 이케아 광명점 끝 -->
      </div>
      <!-- 이케아 매장 안내1 끝 -->
      
      <!-- 이케아 매장 안내2 시작 -->
      <div class="row">
        <!-- 이케아 고양점 시작 -->
        <div id="whereStore2" class="col-md-6">
          <a href="https://map.kakao.com/link/search/이케아 고양점">
          	<img class="service-img d-block w-100" src="../images/goyang.png" alt="IKEA 고양점" />
          </a>
          <br>
          <h4>IKEA 고양점</h4>
          <p>경기도 고양시 덕양구 권율대로 420</p>
          <br />
          <p id="boldft">
                           매장
          </p>
          <br>
          <ul>
          	<li>10 : 00 ~ 22 : 00</li>
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
          	<li>월요일 - 일요일 10 : 00 ~ 21 : 00</li>
          </ul>
          <br>
          <p id="boldft">
                           레스토랑
          </p>
          <br>
          <ul>
          	<li>월요일 - 일요일 09 : 30 ~ 20 : 30<br>
				(마지막 주문 20 : 00)</li>
          </ul>
          <a href="https://map.kakao.com/link/search/이케아 고양점" role="button" class="btnWhere" style="margin-top: 2vw; margin-bottom: 4vw" >
          	지도 확인하기
          </a>
        </div>
        <!-- 이케아 고양점 끝 -->
        
        <!-- 이케아 동부산점 시작 -->
        <div id="whereStore2" class="col-md-6">
          <a href="https://map.kakao.com/link/search/이케아 동부산점">
          	<img class="service-img d-block w-100" src="../images/dong-busan.png" alt="IKEA 동부산점" />
          </a>
          <br>
          <h4>IKEA 동부산점</h4>
          <p>부산광역시 기장군 기장읍 동부산관광3로 17</p>
          <br />
          <p id="boldft">
                           매장
          </p>
          <br>
          <ul>
          	<li>10 : 00 ~ 22 : 00</li>
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
          	<li>월요일 - 일요일 10 : 00 ~ 21 : 00</li>
          </ul>
          <br>
          <p id="boldft">
                           레스토랑
          </p>
          <br>
          <ul>
          	<li>월요일 - 일요일 09 : 30 ~ 20 : 30<br>
				(마지막 주문 20 : 00)</li>
          </ul>
          <a href="https://map.kakao.com/link/search/이케아 동부산점" role="button" class="btnWhere" style="margin-top: 2vw; margin-bottom: 4vw">
          	지도 확인하기
          </a>
        </div>
        <!-- 이케아 동부산점 끝 -->
      </div>
      <!-- 이케아 매장 안내2 끝 -->
      
      <!-- 이케아 매장 안내3 시작 -->
      <div class="row">
        <!-- 이케아 LAB 시작 -->
        <div id="whereStore3" class="col-md-6">
          <a href="https://map.kakao.com/link/search/이케아 랩">
          	<img class="service-img d-block w-100" src="../images/ikeaLab.png" alt="IKEA Lab" />
          </a>
          <br>
          <h4>IKEA Lab</h4>
          <p>서울 성동구 아차산로 17길 48</p>
          <br />
          <p id="boldft">
                           운영시간
          </p>
          <br>
          <ul>
          	<li>11 : 00 ~ 20 : 00</li>
          </ul>
          <br>
          <p id="boldft">
            IKEA Food Lab
          </p>
          <br>
          <ul>
          	<li>(주중) 10 : 00 ~ 19 : 00</li>
          	<li>(주말) 11 : 00 ~ 20 : 00</li>
          </ul>
          <br>
          <p id="boldft">
                           주차안내
          </p>
          <br>
          <ul>
          	<li>IKEA Lab은 성수낙낙 건물의 B동에 위치하고 있습니다. B동 건물 주차장에 주차해주세요.</li>
          	<li>30분 무료 주차, 그 이후 10분당 500원</li>
          </ul>
          <br>
          <a href="https://map.kakao.com/link/search/이케아 랩" role="button" class="btnWhere" style="margin-top: 2vw; margin-bottom: 4vw">
          	지도 확인하기
          </a>
        </div>
        <!-- 이케아 LAB 끝 -->
        
        <!-- 빈칸 시작 -->
        <div id="whereStore3" class="col-md-6">
        </div>
        <!-- 빈칸 끝 -->
      </div>
      <!-- 이케아 매장 안내3 끝 -->
	
	</div>
	<!-- container 끝 -->
	
	<!-- 줄 띄우기 용 -->
    <br><br><br><br><br>
	
<jsp:include page="../footer.jsp"/>	