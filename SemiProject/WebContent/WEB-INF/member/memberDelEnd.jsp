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
		
		alert("IKEA 계정 탈퇴를 하셨습니다. 언제든 다시 가입하실 수 있습니다!");
		var frm = document.logoutFrm;
		frm.action = "<%= ctxPath%>/login/logout.one";
		frm.method = "post";
		frm.submit();
	}// end of window.onload = function(){})-------------


</script>



</head>
<body>

	<form name="logoutFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}"/>
	</form>

</body>
</html>