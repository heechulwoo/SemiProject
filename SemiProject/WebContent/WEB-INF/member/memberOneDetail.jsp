<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<%
	String ctxPath = request.getContextPath();
%>


<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>


<style type="text/css">

   body {
    /*   border: solid 1px gray; */
      margin: 0;
      padding: 0; 
      font-family: Arial, "MS Trebuchet", sans-serif;
      word-break: break-all; /* 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
   }
   
   div#container {
    /*   border: solid 1px blue; */
      width: 80%;
      margin: 0 auto;
   }
   
   legend {
      font-size: 20pt;
   }
   
   ul {
    /*   border: solid 1px red; */ 
      list-style-type: none;
      padding: 0;
   }
   
   ul > li {
      line-height: 40px;
   }

   label.title {
    /*   border: solid 1px blue; */
      display: inline-block;
      width: 100px;
      color: navy;
      font-weight: bold;
   }

    input.myinput {
       height: 20px;
    }
	
	button.btn {
      width: 130px;
      height: 50px;
      background-color: #00579c;
      color: #fff;
      font-size: 16pt;
      margin: 20px 0 0 40px;
      border: none;
      border-radius: 12px;
      cursor: pointer;
   }
	
	


</style>


<script>


function goMemberList() {
	window.history.back();
}
	
</script>


<body>

<div class="container" style="max-width:1700px;">
		<!-- <nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none; z-index:2; width:240%; min-width:300px" id="sidebarId"> -->
   <div class="container" style="float:left; color:white; background-color:#00579c; max-width:600px; height:810px; width: 600px "> 
	  <a class="navbar-brand" href="#"><img src="<%= ctxPath%>/images/logo2.jpg" alt="IKEA_logo" width="87" height="36" style="margin-top: 50px; margin-left: 30px"/></a>			  
	  <div style="margin-top:80px; margin-left:90px; margin-right:100px">
		  	<span style="font-size:40px; margin-left:10px; margin-right:10px;"><b>${requestScope.mvo.name}</b></span>
		  	<span style="font-size:30px; margin-left:10px;" >님의 상세정보</span>
		  	
					<table class="table table-borderless" style="font-size:16px; color: white; font-weight: bolder; margin-top: 20px; margin-left: 20px; ">
					  
					  <thead>
					    <tr>
					      <th></th>
					      <th></th>
					      <th></th>
					    </tr>
					  </thead>
					  
					  <tbody>
					   <tr>
					    <th>1</th>
					      <td >아이디 :</td>
					      <td>${requestScope.mvo.userid}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>2</th>
					      <td>회원명 :</td>
					      <td>${requestScope.mvo.name}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>3</th >
					      <td>이메일 :</td>
					      <td>${requestScope.mvo.email}</td>
					    </tr>  
					   <tr style="height: 40px;">
					    <th>4</th>
					      <td>휴대폰 :</td>
					      <td>${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11) }</td>
					    </tr>  
					    <tr style="height: 40px;">
					      <th>5</th>
					      <td >우편번호 :</td>
					      <td>${requestScope.mvo.postcode}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>6</th>
					      <td >주소 : </td>
					      <td>${requestScope.mvo.address}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>7</th>
					      <td >성별 :</td>
					      <td><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>8</th>
					      <td >생년월일 :  </td>
					      <td>${fn:substring(birthday,0,4)}.${fn:substring(birthday,4,6)}.${fn:substring(birthday,6,8) }</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>9</th>
					      <td >나이 :</td>
					      <td>${requestScope.mvo.age}세</td>
					    </tr>
					    <tr style="height: 40px;">
					    <th>10</th>
					      <td style="width: 120px;">가입일자 :</td>
					      <td>${requestScope.mvo.registerday}</td>
					    </tr>

					      
					  </tbody>
					</table>
		  	
		  	
		  	
	  </div>
   </div>
   
	<%--	   
	<div class="container" style=" margin-top: 80px; margin-left:300px">
		<c:if test="${empty requestScope.mvo}">
			존재하지 않는 회원입니다.<br>
		</c:if>
		
		
		<c:if test="${not empty requestScope.mvo}">
			<c:set var="mobile" value="${requestScope.mvo.mobile}" />
			<c:set var="birthday" value="${requestScope.mvo.birthday}" />
			
	
			<div id="mvoInfo" style="padding-left: 450px; padding-top:100px; " >  
			<%-- 
				<ol>
					<li style="font-size:25px; margin-left:100px;"><span  class="myli"><b>아이디 :</b> </span>${requestScope.mvo.userid}</li>
		       		<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>회원명 : </b></span>${requestScope.mvo.name}</li>
		       		<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>이메일 : </b></span>${requestScope.mvo.email}</li>
		       		<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>휴대폰 : </b></span>${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11) }</li>
					<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>우편번호 : </b></span>${requestScope.mvo.postcode}</li>
		      		<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>주소 : </b></span>${requestScope.mvo.address}&nbsp;${requestScope.mvo.detailaddress}&nbsp;${requestScope.mvo.extraaddress}</li>
					<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>성별 : </b></span><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose> </li>
					<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>생년월일 : </b></span>${fn:substring(birthday,0,4)}.${fn:substring(birthday,4,6)}.${fn:substring(birthday,6,8) }</li>
					<li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>나이 : </b></span>${requestScope.mvo.age}세</li>
			        <li style="font-size:25px; margin-left:100px; padding-top:10px"><span  class="myli"><b>가입일자 : </b></span>${requestScope.mvo.registerday}</li>
				</ol>	
				

					<table class="table table-borderless" style="font-size:10px; ">
					  
					  <thead>
					    <tr>
					      <th></th>
					      <th></th>
					      <th></th>
					    </tr>
					  </thead>
					  
					  <tbody>
					   <tr>
					    <th>1</th>
					      <td >아이디 :</td>
					      <td>${requestScope.mvo.userid}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>2</th>
					      <td>회원명 :</td>
					      <td>${requestScope.mvo.name}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>3</th >
					      <td>이메일 :</td>
					      <td>${requestScope.mvo.email}</td>
					    </tr>  
					   <tr style="height: 40px;">
					    <th>4</th>
					      <td>휴대폰 :</td>
					      <td>${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11) }</td>
					    </tr>  
					    <tr style="height: 40px;">
					      <th>5</th>
					      <td >우편번호 :</td>
					      <td>${requestScope.mvo.postcode}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>6</th>
					      <td >주소 : </td>
					      <td>${requestScope.mvo.address}</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>7</th>
					      <td >성별 :</td>
					      <td><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>8</th>
					      <td >생년월일 :  </td>
					      <td>${fn:substring(birthday,0,4)}.${fn:substring(birthday,4,6)}.${fn:substring(birthday,6,8) }</td>
					    </tr>
					    <tr style="height: 40px;">
					      <th>9</th>
					      <td >나이 :</td>
					      <td>${requestScope.mvo.age}세</td>
					    </tr>
					    <tr style="height: 40px;">
					    <th>10</th>
					      <td style="width: 120px;">가입일자 :</td>
					      <td>${requestScope.mvo.registerday}</td>
					    </tr>

					      
					  </tbody>
					</table>
				
				
				
				
					
			</div>
		</c:if>
		 --%>
		
		
</div>

</body>
 

