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
	

	// 수정하기 버튼 클릭시 "이메일 중복확인"을 클릭했는지 안 했는지를 알아보기 위한 용도이다.

	$(document).ready(function(){
		

		
	});// end of $(document).ready(function(){})-----------------
	
	
	function goBack() {	
		window.history.back();
	}
	
	
	
	function goEdit(){
		
	 	var frm = document.editFrm;
		frm.action = "<%= ctxPath%>/member/oderReviewEnd.one";
		frm.method = "post";
		frm.submit(); 
		
	}
	
	
	
	
	
</script>

	<!-- 상단 컨텐츠 시작 -->
	<div class="container" style="max-width:950px; margin-top:40px; height: 900px;">
	<div class="row custom-topcontents">
		
	<form name = "editFrm">
		<div id="head">
			<span style="font-size: 26pt"><b>&nbsp;리뷰 작성</b></span><br>

		</div>
			<img class="w1-image" width="1100" height="10" src="<%= ctxPath%>/images/yellow.PNG" style="margin-top:20px">				  
	

		<table id="tblMemberUpdate" class="table my-4" style="font-size: 10pt; border-collapse:separate; border-spacing:40px 30px">
		 
		  <tbody>
		    
		     <tr>
		 	 	<th>제품코드번호&nbsp;</th>
		 	 	<td style="width: 80%; text-align: left;"><input type="text" name="fk_pnum" value="${requestScope.pnum}"/>
        		</td>
		 	 </tr>
		    
		    <tr>
		      <th>작성자&nbsp;<span class="star"></span></th>	  
		   		<td> <input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}"/> 
             		 <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required/> 
           		</td>
			  </tr>
		 	     	   
		 	 <tr>
		 	 	<th>리뷰 제목&nbsp;</th>
		 	 	<td style="text-align: left; width: 800px; "><input name="title" type="text" id="review" style="width:600px; "/> 
            		
         		</td>
		 	 </tr>
		 	     	  
		     <tr>
		 	 	<th>리뷰 내용&nbsp;</th>
		 	 	<td style=" text-align: left;"> 
            	 <textarea name="content" style="width: 600px; height: 300px; border: none"></textarea>
         		</td>
		 	 </tr>
    
		    <tr>     
		      <td></td>
		      <td><button type="button" id="btnUpdate"class="btn btn-dark mt-3 mr-3" onClick="goEdit()" style="border-radius: 40px; margin-left:400px; font-size: 10pt">  
		  		<b>작성하기</b>
			  </button>
		     
		     
		      <button type="button" id="btnDelete" class="btn btn-outline-dark mt-3 "  onclick="goBack()" style="border-radius: 40px; font-size: 10pt">  
		  		<b>작성취소</b>
			  </button>
				
		    </tr>
		  </tbody>
		</table>
		</form>
	</div>
	</div>
	<!-- row 끝 -->
	<!-- 중앙 컨텐츠 끝 -->





</body>
</html>


<jsp:include page="/WEB-INF/footer.jsp"/>