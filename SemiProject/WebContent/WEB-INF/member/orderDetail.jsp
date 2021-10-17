<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <!-- jstl을 사용하기 위함  -->    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	
</script>

	<!-- 상단 컨텐츠 시작 -->
	<div class="container" style="max-width:950px; margin-top:40px; height: 1300px;">
	<div class="row custom-topcontents">
		
	
		<div id="head">
			<span style="font-size: 26pt"><b>&nbsp;계정 관리</b></span><br>
			<span class="mt-1"style="font-size: 10pt; margin-left:9px;">로그아웃을 하고 싶으신가요?</span>
			<a href="<%= ctxPath %>/login/logout.one"><button type="button" class="btn btn-link btn-sm text-body" style="text-decoration:underline">  
		  		로그아웃
			  </button></a>
		</div>
			<img class="w3-image" width="900" height="300" src="<%= ctxPath%>/images/제목 없음.png" style="margin-top:40px">	
		</div>
		
		
		<thead>
           <tr >
              <th>주문번호</th>
              <th>주문일자</th>
              <th>주문총액</th>
           </tr>
        </thead>
    	<c:forEach var="odrDetail" items="${requestScope.odrDetail}">
    			<tr class="orderInfo" >
    				<td class="odrcode">${odrDetail.pvo.pname}</td>
    				<td>${odrDetail.pvo.price}</td>
    				<td>${odrDetail.oqty}</td>
    			    <td>${odrDetail.odrprice}</td>
    				<td>${odrDetail.deliverstatus}</td>
    				<td>${odrDetail.fk_odrcode}</td>
    				<td>${odrDetail.deliverdate}</td>
    				<td>${odrDetail.povo.odrtotalprice}</td>
    			</tr>
    		</c:forEach>   
		
		

		<table id="tblMemberUpdate" class="table my-4" style="font-size: 10pt; border-collapse:separate; border-spacing:40px 30px">
		  <tbody>
		    
		    <tr>
		      <th>이름&nbsp;</th>	  
		   	<c:forEach var="odrDetail" items="${requestScope.odrDetail}">
    			<tr class="orderInfo" >
    				<td class="odrcode">${odrDetail.pvo.pname}</td>
    		</c:forEach>
			  </tr>
		 	     	   
		 	 <tr>
		 	 	<th>금액</th>	  
		 	 <c:forEach var="odrDetail" items="${requestScope.odrDetail}">
    			<tr class="orderInfo" >
    				<td class="odrcode">${odrDetail.pvo.price}</td>
    		</c:forEach>
			 </tr>

		 	  <tr>
		 	   <th>이름&nbsp;</th>	  
		   		<td> <span>${sessionScope.loginuser.name}</span>  
           	   </td>
			 </tr>

		 	  <tr>
		 	   <th>이름&nbsp;</th>	  
		   		<td> <span>${sessionScope.loginuser.name}</span>  
           	   </td>
			 </tr>
		 	 
		 	  <tr>
		 	   <th>이름&nbsp;</th>	  
		   		<td> <span>${sessionScope.loginuser.name}</span>  
           	   </td>
			 </tr>
		 	 
		 	 
		 	  <tr>
		 	   <th>이름&nbsp;</th>	  
		   		<td> <span>${sessionScope.loginuser.name}</span>  
           	   </td>
			 </tr>
		 	 
 	 
		    	      

		    <tr>     
		      <td>
		      <td><button type="button" id="btnUpdate"class="btn btn-dark mt-3 mr-3" onClick="goEdit()" style="border-radius: 40px; margin-left:400px; font-size: 10pt">  
		  		<b>수정하기</b>
			  </button>
		     
		      <!-- Modal -->
		      <button type="button" id="btnUpdate" class="btn btn-outline-dark mt-3 " data-toggle="modal" style="border-radius: 40px; font-size: 10pt" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		<b>계정 탈퇴</b>
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">회원탈퇴창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				        <button type="button" class="btn btn-primary" >계정 탈퇴</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		    </tr>

		  </tbody>
		</table>

	</div>
	<!-- row 끝 -->
	<!-- 중앙 컨텐츠 끝 -->

	<hr>


</body>
</html>


<jsp:include page="/WEB-INF/footer.jsp"/>