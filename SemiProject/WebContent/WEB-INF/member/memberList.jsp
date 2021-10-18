<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/WEB-INF/header.jsp"/>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<style type="text/css"> 

 tr.memberInfo:hover {
		background-color: #3385ff;
        cursor: pointer;
        color: white;
        
	 }



</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		
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
		
		
		$("tr.memberInfo").bind("click", function(){
			
				var $target = $(event.target);	
		//		console.log( $target.parent().find(".userid").html());
		
				var userid =  $target.parent().find(".userid").html();		
				
				 goDetail(userid);	 
				
			/* 
				var frmd = document.memberDetail;
				frmd.action = "memberOneDetail.one"
				frmd.method = "GET";
				frmd.submit(); */
				
			<%-- location.href="<%= ctxPath%>/member/memberOneDetail.one?userid="+userid --%>

		});
		
		
	});// end of $(document).ready(function(){})------------------
	
	
	// Function Declaration
	
	function goSearch(){  // sizePerPage가 넘어간다.
		var frm = document.memberFrm;
		frm.action = "memberList.one"
		frm.method = "GET";
		frm.submit();
	}

	function goDetail(userid){
		
		location.href="<%= ctxPath%>/member/memberOneDetail.one?userid="+userid;

	}
	

</script>

<div  style="height: 850px;">
<div class="container" style="max-width:1300px; margin-top:40px">
<h2 style="margin: 20px;">회원전체 목록</h2>

	<form name="memberFrm">
	  <select id="searchType" name="searchType">
         <option value="name">회원명</option>
         <option value="userid">아이디</option>
         <option value="email">이메일</option>
      </select>
      <input type="text" id="searchWord" name="searchWord" />
	  
	  <button type="button" class="btn btn-dark" onclick="goSearch();" style="margin-right: 30px; margin-bottom: 8px; border-radius: 12px">검색</button>
	  
	  <span style="color: black; font-weight: bold; font-size: 12pt;">페이지당 회원명수</span>
      <select id="sizePerPage" name="sizePerPage">
         <option value="10">10</option>
         <option value="5">5</option>
         <option value="3">3</option>
      </select>
	</form>
	
	
	<table id="memberTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
        <thead>
           <tr >
              <th>아이디</th>
              <th>회원명</th>
              <th>이메일</th>
              <th>성별</th>
           </tr>
        </thead>
        
        <tbody>
    		<c:forEach var="mvo" items="${requestScope.memberList}">
    			<tr class="memberInfo" data-toggle="modal" data-target="#userInfo">
    				<td class="userid">${mvo.userid}</td>
    				<td>${mvo.name}</td>
    				<td>${mvo.email}</td>
    				<td>
    					<c:choose>
    						<c:when test="${mvo.gender eq '1'}">
    							남
    						</c:when>
    						<c:otherwise>
    							여
    						</c:otherwise>
    					</c:choose>
    				</td>
    			</tr>
    		</c:forEach>    
		</tbody>
	</table>

	<nav>
		<div style="display: flex; width:80;">
			<ul class="pagination" style="margin: auto;">${requestScope.pageBar}</ul>
		</div>
	</nav>
</div>
</div>


<jsp:include page="/WEB-INF/footer.jsp"/> 





