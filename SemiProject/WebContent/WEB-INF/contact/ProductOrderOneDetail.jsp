<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>

<jsp:include page="../header.jsp"/>

<style>
	
	div#consultDetail {
	  padding-top: 70px;
	  padding-bottom: 50px;
	  border-bottom: solid 1px #d9d9d9;
	}

	div#viewDetail {
	  padding-top: 70px;
	  width:100%; 
	  text-align:center; 
	  margin:0px auto;
	  padding-bottom: 50px;
	}
	
	table#tblViewOrder,
	table#tblViewAddress {
	  width:100%;
	  text-align:center;
	  margin:0px auto;
	}
	
	tr.orderDetailInfo:hover {
	  background-color: #f2f2f2;
	  cursor: pointer;
	}
	
	button#backBtn,
	button#firstBtn {
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
	
	button#backBtn:hover,
	button#firstBtn:hover {
	  opacity: 0.8;
	  text-decoration: none;
	}
	
	
	
</style>


<script type="text/javascript">
	
	
	var goBackURL = "";
	
	$(document).ready(function() {
		
		goBackURL = "${requestScope.goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&"); // 공백을 다시 &로 바꿔주기
		
		
		
		<%-- DB status 값을 가져다가  해당 option 값 checked시키기 --%>
		$("select#deliverstatus option").each(function(){

		    if($(this).val()=="${requestScope.dvo.deliverstatus}"){

		      $(this).attr("selected","selected"); // attr적용안될경우 prop으로 
				
		    }

		  });// end of $("select#deliverstatus option").each(function(){})--------------------------------
		
		  
		  
		  
		// 특정 주문상세내역목록을 클릭하면 그 글의 상세내용을 보여주기
		$("tr.orderDetailInfo").click(function() {
			
			
			var odrseqnum = $(this).children(".odrseqnum").text();
			var fk_odrcode = $(this).children(".fk_odrcode").text();
			
			location.href="<%= ctxPath%>/contact/productGoEdit.one?odrseqnum="+odrseqnum+"&fk_odrcode="+fk_odrcode+"&goBackURL=${requestScope.goBackURL}";
			
		});  
		  
		
		
	}); // end of $(document).ready(function(){})--------------------------
	
	
	
	// === Function Declaration === //
	
	
	// 주문 상세 내역 목록으로 가기(검색결과, 페이지 관련 정보 남아있는 것)
	function productOrderList() {
		location.href = "/SemiProject"+goBackURL;
	}// end of function goConsultList(){}----------------------------------
	
	
	
	
	
</script>

<!--  -->

<div class="container">

	<!-- 이케아 주문 상세 내역 보기 시작 -->
	<div id="consultDetail" class="col-md-auto">
	  <h1 style="font-weight: bold">주문 상세 내역 보기</h1>
	    <br>
	    <p>
	    	주문한 회원의 주문 상세 내역입니다.<br>
	    	주문상세번호 클릭 시 , 회원의 배송 상태을 변경할 수 있습니다.<br>
	    </p>
	    <br>
	</div>
	<!-- 이케아 주문 상세 내역 보기 끝 -->
	
	
	
	<%-- ==== 주문 상세 내역 목록 시작 ==== --%>
	<c:if test="${ sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin' }">
    
	    <form name="viewDetailForm" class="col-md-auto">
			<div id="viewDetail" class="col-md-auto">
			
			
				<c:if test="${ empty requestScope.orderDetailList }"> 
					[&nbsp;주문번호&nbsp;:&nbsp;
						<span style="color: #80ccff;">${requestScope.odrcode}</span>
					]&nbsp;&nbsp;주문 상세 내역이 존재하지 않습니다.
				</c:if>
				
				<c:if test="${ not empty requestScope.orderDetailList }">
					<h4 class="col-md-auto" style="font-weight: bold; margin-bottom: 0px;">[&nbsp;주문번호&nbsp;:&nbsp;
						<span style="color: #80ccff;">${requestScope.odrcode}</span>
					]&nbsp;&nbsp;주문 상세 내역&nbsp;<i class="fas fa-clipboard-list"></i></h4>
					
					
					<%-- 주문상세내역 테이블 시작 --%>
					<table id="tblViewOrder" class="table table-bordered col-md-auto" style="width: 90%; margin-top: 35px;">
				        <thead>
				           <tr>
				           	  <th>주문상세번호</th>
				           	  <th>주문번호</th>
				           	  <th>제품코드</th>
				              <th>주문수량</th>
				              <th>주문총액</th>
				              <th>배송상태</th>
				              <th>배송일자</th>
				           </tr>
				        </thead>
				        
				        <%-- 반복문으로 주문상세내역 뽑아오기 --%>
				        <tbody>
				        	<c:forEach var="dvo" items="${requestScope.orderDetailList}">
				        		<tr class="orderDetailInfo">
				        			<td class="odrseqnum">${dvo.odrseqnum}</td>
				        			<td class="fk_odrcode">${dvo.fk_odrcode}</td>
				        			<td class="fk_pnum">${dvo.fk_pnum}</td>
				        			<td class="oqty">${dvo.oqty}</td>
				        			<td class="odrprice">${dvo.odrprice}</td>
				        			
				        			<%-- 만약 배송상태가 1이면 주문접수 / 3이면 배송완료이므로 배송일자 안보여주기 --%>
				        			<c:if test="${dvo.deliverstatus == 1}">
				        				<td class="deliverdate" style="color: #80ccff; font-weight: bold;">주문접수</td>
			        				</c:if>
			        				<c:if test="${dvo.deliverstatus == 2}">
				        				<td class="deliverdate" style="color: #ffcc80; font-weight: bold;">배송중</td>
			        				</c:if>
			        				<c:if test="${dvo.deliverstatus == 3}">
				        				<td class="deliverdate" style="color: #ff9980; font-weight: bold;">배송완료</td>
			        				</c:if>
				        			
				        			<%-- 만약 배송상태가 1이면 주문접수 / 3이면 배송완료이므로 배송일자 안보여주기 --%>
				        			<c:if test="${dvo.deliverstatus == 1}">
				        				<td class="deliverdate">주문접수<%-- ${dvo.deliverdate} --%></td>
			        				</c:if>
			        				<c:if test="${dvo.deliverstatus == 2}">
				        				<td class="deliverdate">배송중<%-- ${dvo.deliverdate} --%></td>
			        				</c:if>
			        				<c:if test="${dvo.deliverstatus == 3}">
				        				<td class="deliverdate">배송완료일&nbsp;:&nbsp;${dvo.deliverdate}</td>
			        				</c:if>
				        		</tr>
				        	</c:forEach>
				        </tbody>
				    </table>
				</c:if>
		    </div>
	    </form>
	    <%-- ==== 주문 상세 내역 목록 끝 ==== --%>
	    
	    <%-- ==== 주문 내역 배송지 테이블 시작  ==== --%>
	    <form name="viewAddressForm" class="col-md-auto">
			<div id="viewDetail" class="col-md-auto">
			
			
				<c:if test="${ empty requestScope.addressOneDetail }"> 
					[&nbsp;주문번호&nbsp;:&nbsp;
						<span style="color: #80ccff;">${requestScope.odrcode}</span>
					]&nbsp;&nbsp;배송 정보가 존재하지 않습니다.
					<br><br><br>
					<div id="buttons" class="col-md-auto">
						<button style="margin-top: 50px;" type="button" id="backBtn" class="btn" onclick="productOrderList()">주문내역 목록</button>
					   	&nbsp;&nbsp;
					   	<button style="margin-top: 50px;" type="button" id="firstBtn" class="btn" onclick="javascript:location.href='productOrderList.one'">처음으로</button>
					</div>
				</c:if>
				
				<c:if test="${ not empty requestScope.addressOneDetail }">
					<h4 class="col-md-auto" style="font-weight: bold; margin-bottom: 0px;">[&nbsp;주문번호&nbsp;:&nbsp;
						<span style="color: #80ccff;">${requestScope.odrcode}</span>
					]&nbsp;&nbsp;<span style="color: #ffcc80;">배송 정보&nbsp;<i class="fas fa-truck"></i></span></h4>
					
					
					<%-- 배송정보내역 테이블 시작 --%>
					<table id="tblViewAddress" class="table table-bordered col-md-auto" style="width: 100%; margin-top: 35px;">
				        <thead>
				           <tr>
				           	  <th>배송지번호</th>
				           	  <th>주문번호</th>
				           	  <th>받는분 성명</th>
				              <th>연락처</th>
				              <th>우편번호</th>
				              <th>주소</th>
				              <th>상세주소</th>
				              <th>주소참고항목</th>
				           </tr>
				        </thead>
				        
				        <%-- 반복문으로 배송정보내역 뽑아오기 --%>
				        <tbody>
				        		<tr class="addressInfo">
				        			<td class="odrseqnum">${requestScope.addressOneDetail.addrno}</td>
				        			<td class="fk_odrcode">${requestScope.addressOneDetail.fk_odrcode}</td>
				        			<td class="fk_pnum">${requestScope.addressOneDetail.name}</td>
				        			<td class="oqty">${requestScope.addressOneDetail.mobile}</td>
				        			<td class="odrprice">${requestScope.addressOneDetail.postcode}</td>
				        			<td class="odrprice">${requestScope.addressOneDetail.address}</td>
				        			<td class="odrprice">${requestScope.addressOneDetail.detailaddress}</td>
				        			<td class="odrprice">${requestScope.addressOneDetail.extraaddress}</td>
				        		</tr>
				        </tbody>
				    </table>
				    
				    <div id="buttons" class="col-md-auto">
						<button style="margin-top: 50px;" type="button" id="backBtn" class="btn" onclick="productOrderList()">주문내역 목록</button>
					   	&nbsp;&nbsp;
					   	<button style="margin-top: 50px;" type="button" id="firstBtn" class="btn" onclick="javascript:location.href='productOrderList.one'">처음으로</button>
					</div>
				    
				    
				</c:if>
		    </div>
	    </form>
	    <%-- ==== 주문 내역 배송지 테이블 끝  ==== --%>
	    
    </c:if>
    
</div>
<!-- .container 끝 -->

<!-- 줄 띄우기 용 -->
<br><br><br><br><br> 

<jsp:include page="../footer.jsp"/>