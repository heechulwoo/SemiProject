<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <!-- jstl을 사용하기 위함  -->    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<jsp:include page="/WEB-INF/header.jsp"/>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 


<style>

   table#tblMemberRegister {
          width: 93%;
          
          /* 선을 숨기는 것 */
          border: hidden;
          
          margin: 10px;
   }  
   
   table#tblMemberRegister#th {
         height: 40px;
         text-align: center;
         background-color: silver;
   }
   
   table#tblMemberRegister td {
         /* border: solid 1px gray;  */
         line-height: 30px;
         padding-top: 18px;
         padding-bottom: 8px;
   }
   
   #tblMemberUpdate input {
   	border:none;
   } 
   
   
   .star { color: red;
           font-weight: bold;
           font-size: 12pt;
   } 
   
   
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
	
function goOderList() {
	window.history.back();
}
	
	
</script>

	<!-- 상단 컨텐츠 시작 -->
	<div class="container" style="max-width:950px; margin-top:40px; height: 600px;">
	<div class="row custom-topcontents">
		
	
		<div id="head">
			<span style="font-size: 26pt"><b>&nbsp;주문 상세</b></span><br>
			<span class="mt-1"style="font-size: 13pt; margin-left:12px;">주문번호:&nbsp;${requestScope.odrcode}</span>

		</div>
				<img class="w1-image" width="1100" height="10" src="<%= ctxPath%>/images/yellow.PNG" style="margin-top:20px">	
		</div>

  
  
  <table id="orderTbl" class="table table-bordered" style="width:100%; margin-top: 40px;">
        <thead>
           <tr >
              <th>제품명</th>
              <th>제품금액</th>
              <th>주문개수</th>
              <th>배송상태</th>
              <th>배송완료일자</th>
           </tr>
        </thead>
        
        <tbody>
    		<c:forEach var="odrDetail" items="${requestScope.odrDetail}">
    			<tr class="orderInfo" >
    				<td class="odrcode">${odrDetail.pvo.pname}</td>
    				<td><fmt:formatNumber value="${odrDetail.pvo.price}" pattern="###,###" />원</td>
    				<td>${odrDetail.oqty}개</td>
    				<td>
    				<c:choose>
    					<c:when test="${odrDetail.deliverstatus eq '1'}">
    							주문완료
    					</c:when>
    					<c:when test="${odrDetail.deliverstatus eq '2'}">
    							배송중
    					</c:when>
    						<c:otherwise>
    							배송완료
    						</c:otherwise>
    					</c:choose>
					</td>
    				<td>
    				<c:choose>
    					<c:when test="${odrDetail.deliverstatus eq ''}">
    							-
    					</c:when>
    						<c:otherwise>
    							${odrDetail.deliverdate}
    						</c:otherwise>
    					</c:choose>
    				</td>
				</tr>
    		</c:forEach>    
		</tbody>
	</table>

	     

<button type="button" class="btn btn-warning" onclick="goOderList();" style="margin-left: 390px; margin-top: 50px;  font-weight:bolder;">목록으로</button>    
		  	
			

</div>



<jsp:include page="/WEB-INF/footer.jsp"/>