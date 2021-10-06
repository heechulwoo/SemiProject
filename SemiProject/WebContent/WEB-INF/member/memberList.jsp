<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	//     /MyMVC
%>

<jsp:include page="/WEB-INF/header.jsp"/>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<style type="text/css"> 


</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		
	});


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
	  
	  <button type="button" class="btn btn-dark" onclick="goSearch();" style="margin-right: 30px; margin-bottom: 8px">검색</button>
	  
	  <span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원명수</span>
      <select id="sizePerPage" name="sizePerPage">
         <option value="10">10</option>
         <option value="5">5</option>
         <option value="3">3</option>
      </select>
	</form>
	
	<table id="memberTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
        <thead>
           <tr>
              <th>아이디</th>
              <th>회원명</th>
              <th>이메일</th>
              <th>성별</th>
           </tr>
        </thead>
        
        <tbody>
    		<c:forEach var="mvo" items="${requestScope.memberList}">
    			<tr>
    				<td>${mvo.userid}</td>
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
	</nav>
</div>

<br>
<br>
<br>
</div>

<jsp:include page="/WEB-INF/footer.jsp"/> 





