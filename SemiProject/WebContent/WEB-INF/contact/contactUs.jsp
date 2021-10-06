<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>

<jsp:include page="/WEB-INF/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 제이쿼리 -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->


<style>
	
	div#supportMain,
	div#callMain,
	div#frmMain,
	div#returnMain {
		padding-top: 70px;
		padding-bottom: 70px;
		border-bottom: solid 1px gray;
	}
	div#supportMain > a{
		text-decoration: none;
		font-weight: bold;
		color: gray;
	}
	div#supportMain > a:hover{
		text-decoration: none;
		font-weight: bold;
		color: black;
	}
	div#callMain > p > a{
		text-decoration: underline;
		font-weight: bold;
		color: black;
	}
	div#frmMain > p > a{
		text-decoration: underline;
		font-weight: bold;
		color: black;
	}
	.contactDetail,
	.returnDetail {
	  text-align: center;
	}
	.mbtn {
		border: 0;
		outline: 0;
		background-color: white;
		font-weight: bold;
		color: gray;
	}
	.mbtn:hover {
		border: 0;
		outline: 0;
		background-color: white;
		font-weight: bold;
		color: black;
	}
	a#contactBtn {
	    width: 12em;
	    text-align: center;
	    display: inline-block;
	    font-weight: bold;
	    padding: 0.7rem 1.3rem;
	    font-size: 0.75rem;
	    border-radius: 30px;
	    background-color: black;
	    color: white;
	    justify-content: center;
	}
	a#contactBtn:hover {
	    opacity: 0.8;
	    text-decoration: none;
	}
	a#faq:hover {
		opacity: 0.8;
  		color: #808080;
  		font-weight: bold;
	}
	
</style>


<script type="text/javascript">
	
	$(document).ready(function () {
	    /* 버튼 클릭 시 해당 위치로 스크롤 */
	    $("#btn1").click(function () {
	      var offset = $("#callMain").offset(); //선택한 태그의 위치를 반환
	      $("html").animate({ scrollTop: offset.top }, 400);
	    });
	
	    $("#btn2").click(function () {
	      var offset = $("#frmMain").offset(); //선택한 태그의 위치를 반환
	      $("html").animate({ scrollTop: offset.top }, 400);
	    });
	
	    $("#btn3").click(function () {
	      var offset = $("#returnMain").offset(); //선택한 태그의 위치를 반환
	      $("html").animate({ scrollTop: offset.top }, 400);
	    });
	  });
	
</script>





	<!-- container 시작 -->
	<div class="container">
      <!-- 이케아 고객지원센터 시작 -->
      <div id="supportMain">
        <h1 style="font-weight: bold">IKEA 고객지원센터</h1>
        <br /><br />
        <p style="font-weight: bold">
		          코로나 19로 인해 사회적 거리두기 수준이 4단계로 격상됨에 따라 고객센터
		          운영시간이 단축됩니다.<br>
		          시행기간: 정부 시행 지침 기간과 동일<br>
		          운영시간: (월요일 - 일요일) 10:00 - 21:00<br>
        </p>

        <p></p>
        <p style="color: gray">
		          궁금한 점이 있으세요?<br>
		          전화, 이메일, 신청서 등 다양한 방법으로 IKEA에 대한 궁금한 점을
		          문의해주세요.<br>
          	IKEA 배송, 택배 서비스를 이용하셨다면 배송 조회도 가능합니다.<br />
        </p>
        <br><br>
        <button class="mbtn" id="btn1">전화 문의&nbsp;&nbsp;|</button>
        <button class="mbtn" id="btn2">신청서 문의&nbsp;&nbsp;|</button>
        <button class="mbtn" id="btn3">교환 환불&nbsp;&nbsp;|</button>
      </div>
      <!-- 이케아 고객지원센터 끝 -->

      <!-- 이케아 전화 문의 시작 -->
      <div id="callMain">
        <h3 style="font-weight: bold">전화 문의</h3>
        <br>
        <p style="font-weight: bold">고객지원센터: 1670-4532<br /></p>

        <p></p>
        <p>
		          빠른 해결책을 원하는 경우에는 <a id="faq" href="#">자주 묻는 질문</a>을
		          확인하세요.<br>
        </p>
        <br>
        <p>
		          자주 묻는 질문에 원하는 내용이 없는 경우에는 성함, 연락처,
		          구매정보(영수증/주문번호)를 준비하시어<br>
		          전화 문의 또는 채팅 문의를 이용해 주세요.
        </p>
      </div>
      <!-- 이케아 전화 문의 끝 -->

      <!-- 이케아 신청서 문의 시작 -->
      <div id="frmMain">
        <h3 style="font-weight: bold">신청서 문의</h3>
        <br />
        <p style="font-weight: bold">
          	온라인 답변이 필요하시다면 IKEA 직원과 대화할 수 있는 편리한
          <a href="consultWrite.html">신청서 서비스</a>를 이용해보세요.<br />
        </p>

        <p>
          <br />
        </p>

        <p>
		          자주 묻는 질문에 원하는 내용이 없는 경우에는 성함, 연락처,
		          구매정보(영수증/주문번호)를 준비하시어<br />
		          전화 문의 또는 채팅 문의를 이용해 주세요.
        </p>
        <div class="contactDetail" style="margin-top: 2vw">
          <a href="<%= ctxPath %>/contact/consultWrite.one" role="button" class="contactBtn" id="contactBtn" style="margin-top: 2vw; margin-bottom: 4vw">
            	신청서 작성
          </a>
        </div>
      </div>
      <!-- 이케아 신청서 문의 끝 -->

      <!-- 이케아 교환 환불 제목 시작 -->
      <div id="returnMain">
        <h3 style="font-weight: bold">교환 환불</h3>
        <br><br>
        <p>
          	IKEA에서 구매한 제품이 마음에 들지 않으면 365일 이내에 가져오세요.<br />
          	구매 영수증과 사용하지 않은 제품을 가져오면 환불해 드립니다.<br />
        </p>

        <p></p>
        <p style="color: gray">
		          다만, 조건에 맞지 않으면, IKEA는 교환 및 환불 요청을 거절할 수 있습니다.
        </p>
        <div class="returnDetail" style="margin-top: 2vw">
          <a href="<%= ctxPath %>/contact/returnClaim.one" role="button" class="contactBtn" id="contactBtn" style="margin-top: 2vw; margin-bottom: 4vw">
            	교환 환불하기
          </a>
        </div>
      </div>
      <!-- 이케아 교환환불 제목 끝 -->
    </div>

    <!-- container 끝 -->
    
<jsp:include page="../footer.jsp"/>
    
    