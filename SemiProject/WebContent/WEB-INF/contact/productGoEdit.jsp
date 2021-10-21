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
	
	div#goEditDetail {
	  padding-top: 70px;
	  padding-bottom: 50px;
	  border-bottom: solid 1px gray;
	}
	
	div#detail {
	  padding-top: 70px;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	}
	
	div#ovoInfo {
	  padding-top: 30px;
	}
	
	table#tblProductOrder {
	  border: solid #d9d9d9 2px;
	  border-left: hidden; 
	  border-right: hidden;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	  border-collapse: separate;
  	  border-spacing: 0 20px;
	}
	
	.oDetail {
	  border-right: solid #d9d9d9 2px;
	  font-weight: bold;
	}
	
	.detailcontent {
	  padding-left: 30px;
	}
	
	button#backBtn,
	button#firstBtn,
	button#changeBtn {
	  width: 13em;
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
	button#firstBtn:hover,
	button#changeBtn:hover {
	  opacity: 0.8;
	  text-decoration: none;
	}
	
</style>


<script type="text/javascript">
	
	
	var goBackURL = "";
	
	$(document).ready(function() {
		
		goBackURL = "${requestScope.goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&"); // 공백을 다시 &로 바꿔주기
		
		
		
		<%-- DB status 값을 가져다가  해당 값 checked시키기 --%>
		$("select#deliverstatus option").each(function(){

		    if($(this).val()=="${requestScope.ovo.deliverstatus}"){

		      $(this).attr("selected","selected"); // attr적용안될경우 prop으로 
				
		    }

		  });
		
	}); // end of $(document).ready(function(){})--------------------------
	
	
	
	// === Function Declaration === //
	
	
	// 주문내역 목록으로 가기(검색 조건이 남아있는)
	function goOrderDetailList() {
		location.href = "/SemiProject"+goBackURL;
	}// end of function goOrderDetailList(){}----------------------------------
	
	
	
	// 배송 상태 변경하기
	function goChange() {
		
		
		var result = confirm('회원의 배송 상태를 수정하시겠습니까?'); 
		
		if(result) { 
			// 수정한다.(YES)
			
			<%-- 배송 상태 변경하기 --%>
			var frm = document.goEditDetailFrm;
			frm.action = "<%= ctxPath%>/contact/productOrderEdit.one";
			frm.method = "post";
			frm.submit();
			
		}
		else { 
		// 수정 안한다. (NO)
		
		}
		
	
	}// end of function goChange(){}---------------------------------------
	
	
	
	
</script>

<!--  -->

<div class="container">

	<!-- 주문상세 세부내용 타이틀 보기 시작 -->
	<div id="goEditDetail" class="col-md-auto">
	  <h1 style="font-weight: bold">주문상세 세부내용 보기</h1>
	    <br>
	    <p>
	    	주문한 회원의 세부내역입니다.<br>
	    	회원의 배송 상태을 변경할 수 있습니다.<br>
	    </p>
	    <br>
	</div>
	<!-- 주문상세 세부내용 타이틀 보기 끝 -->
	
	
	
	<!-- 주문상세 세부내용 시작 -->
	<form name="goEditDetailFrm">
	<div id="detail" class="col-md-auto">
		<c:if test="${ empty requestScope.ovo }"> 
			셀프 리스트가 존재하지 않습니다. 다시 확인해주세요!<br>
		</c:if>	
		
		<c:if test="${ not empty requestScope.ovo }"> 
			
			<h3 class="col-md-auto" style="font-weight: bold;">
				주문번호&nbsp;<span style="color: #80ccff;">${requestScope.ovo.fk_odrcode}</span>&nbsp;-
					<span style="color: #80ccff;">${requestScope.ovo.odrseqnum}</span>&nbsp;&nbsp;
			 	주문 상세 내역</h3>
			
			<div id="ovoInfo" class="col-md-auto"> 
				
				
				<table id="tblProductOrder" style="width: 80%;">
				<tbody>
					<tr>
				      <td width="25%" class="oDetail" style="padding-top: 10px;">주문상세번호</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.ovo.odrseqnum}
				         <input type="hidden" name="odrseqnum" value="${requestScope.ovo.odrseqnum}" />
				         <input type="hidden" name="email" value="${requestScope.map.email}" />
				      </td>   
				   </tr>
				   <tr>
				      <td width="25%" class="oDetail" style="padding-top: 10px;">주문번호</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.ovo.fk_odrcode}
				         <input type="hidden" name="fk_odrcode" value="${requestScope.ovo.fk_odrcode}" />
				      </td>   
				   </tr>
				   
				   <tr>
				      <td width="25%" class="oDetail" style="padding-top: 10px;">제품코드</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.ovo.fk_pnum}
				         <input type="hidden" name="fk_pnum" value="${requestScope.ovo.fk_pnum}" />
				      </td>   
				   </tr>
				   
				   <tr>
				      <td width="25%" class="oDetail" style="padding-top: 10px;">상품명</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.ovo.pvosm.pname}
				         <input type="hidden" name="pname" value="${requestScope.ovo.pvosm.pname}" />
				      </td>   
				   </tr>
				   
				   <tr>
				      <td width="25%" class="oDetail">주문수량</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.ovo.oqty}&nbsp;개
				         <input type="hidden" name="oqty" value="${requestScope.ovo.oqty}" />
				      </td>
				   </tr>
				   
				   <tr>
				      <td width="25%" class="oDetail">주문총액</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${requestScope.ovo.odrprice}&nbsp;원
				         <input type="hidden" name="odrprice" value="${requestScope.ovo.odrprice}" />
				      </td>
				   </tr>
				   
				   <tr>
				      <td width="25%" class="oDetail">배송일자 </td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
	        			
	        			<c:choose>
        					<c:when test="${requestScope.ovo.deliverstatus eq '1'}">
        						<span style="font-weight: bold;"><%-- 주문접수일&nbsp;:&nbsp;&nbsp;${requestScope.ovo.deliverdate}&nbsp;&nbsp;/&nbsp;&nbsp; --%>주문접수만 완료된 상태로, 아직 배송 전 상태입니다.</span>
        					</c:when>
        					<c:when test="${requestScope.ovo.deliverstatus eq '2'}">
        						<span style="font-weight: bold;">배송중<%-- &nbsp;:&nbsp;&nbsp;도착 예정일은&nbsp;${requestScope.ovo.deliverdate}&nbsp;&nbsp;입니다. --%></span>
        					</c:when>
        					<c:otherwise>
        						<span style="font-weight: bold;">배송완료일&nbsp;:&nbsp;&nbsp;${requestScope.ovo.deliverdate}&nbsp;&nbsp;에 배송이 완료된 상태입니다.</span>
        					</c:otherwise>
        				</c:choose>
        				<input type="hidden" name="deliverdate" value="${requestScope.ovo.deliverdate}" />
				      </td>
				   </tr>
				   <%-- 반품상태 체크 --%>
				   <tr>
				      <td width="25%" class="oDetail">배송상태 </td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         <select id="deliverstatus" name="deliverstatus" style="width: 50%; padding: 8px">
	                      <option id="deliverstatus1" value="1">주문접수</option>
	                      <option id="deliverstatus2" value="2">배송중</option>
	                      <option id="deliverstatus3" value="3">배송완료</option>
				         </select>
				      </td>
				   </tr>
				</tbody>
				</table>
				
			</div>
			
		</c:if>
		
		<div id="buttons">
			<button style="margin-top: 50px;" type="button" id="backBtn" class="btn" onclick="goOrderDetailList()">주문 내역 목록</button>
		   	&nbsp;&nbsp;
		   	<button style="margin-top: 50px;" type="button" id="firstBtn" class="btn" onclick="javascript:location.href='productOrderList.one'">처음으로</button>
		   	&nbsp;&nbsp;
		   	<button style="margin-top: 50px;" type="button" id="changeBtn" class="btn" onclick="goChange()">배송상태 변경</button>
		   	&nbsp;&nbsp;
		</div>
	</div>
	</form>
	<!-- 주문상세 세부내용 끝 -->
		
</div>
<!-- .container 끝 -->

<!-- 줄 띄우기 용 -->
<br><br><br><br><br> 

<jsp:include page="../footer.jsp"/>