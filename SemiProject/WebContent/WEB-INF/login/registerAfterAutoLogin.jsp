<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
	// / MyMVC 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	window.onload = function(){
		
		alert("IKEA 계정이 생성되었습니다. 가입을 축하드립니다!!");
		var frm = document.loginFrm;
		frm.action = "<%= ctxPath%>/login/loginstart.one";
		frm.method = "post";
		frm.submit();
	}// end of window.onload = function(){})-------------


</script>



</head>
<body>

	<form name="loginFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}"/>
		<input type="hidden" name="pwd" value="${requestScope.pwd}"/>
	</form>

</body>
</html>