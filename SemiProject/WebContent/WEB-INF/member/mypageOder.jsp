<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/WEB-INF/header.jsp"/>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<style type="text/css"> 

 tr.orderInfo:hover {
		background-color: #ffff99;
        cursor: pointer;
        color: black;
        
	 }



</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		/*
		if("${requestScope.searchWord}" != "") {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		} 
	
		// *** select 태그에 대한 이벤트는  click 이 아니라 change 이다. *** // 
		$("select#sizePerPage").bind("change", function(){
			goSearch();
		});
	
		if("${requestScope.sizePerPage}" != "") {
			$("select#sizePerPage").val("${requestScope.sizePerPage}"); // 값에 넘겨받은 값을 그대로 넣어준다
		}
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13){ // 검색어에서 엔터를 하면 검색하러 가도록 한다.
				goSearch();
			}
			
		});
*/
		
		$("tr.orderInfo").bind("click", function(){
			
				var $target = $(event.target);	
				console.log( $target.parent().find(".odrcode").html());
		
				var odrcode =  $target.parent().find(".odrcode").html();		
				
				 goDetail(odrcode);	 
				
			/* 
				var frmd = document.memberDetail;
				frmd.action = "memberOneDetail.one"
				frmd.method = "GET";
				frmd.submit(); */
				
			<%-- location.href="<%= ctxPath%>/member/memberOneDetail.one?userid="+userid --%>

		});
		
		
	});// end of $(document).ready(function(){})------------------
	
	
	// Function Declaration
	
/*
	function goSearch(){  // sizePerPage가 넘어간다.
		var frm = document.memberFrm;
		frm.action = "memberList.one"
		frm.method = "GET";
		frm.submit();
	}
*/


	function goDetail(odrcode){
		
		location.href="<%= ctxPath%>/member/mypageOderDetail.one?odrcode="+odrcode;

	}
	

</script>

<div  style="height: 850px;">
<div class="container" style="max-width:1300px; margin-top:80px">
<h2 style="margin: 2px; font-size: 26pt">주문목록</h2>
	<img class="w1-image" width="1140" height="20" src="<%= ctxPath%>/images/yellow.PNG" style="margin-top:20px">	

	<table id="orderTbl" class="table table-bordered" style="width: 90%; margin-top: 40px;">
        <thead>
           <tr >
              <th>주문번호</th>
              <th>주문일자</th>
              <th>주문총액</th>
           </tr>
        </thead>
        
        <tbody>
    		<c:forEach var="pvo" items="${requestScope.ProductList}">
    			<tr class="orderInfo" >
    				<td class="odrcode">${pvo.odrcode}</td>
    				<td>${pvo.odrdate}</td>
    				<td>${pvo.odrtotalprice}원</td>
    			</tr>
    		</c:forEach>    
		</tbody>
	</table>
<%-- 
	<nav>
		<div style="display: flex; width:80;">
			<ul class="pagination" style="margin: auto;">${requestScope.pageBar}</ul>
		</div>
	</nav>
	 --%>
</div>
</div>


<jsp:include page="/WEB-INF/footer.jsp"/> 





