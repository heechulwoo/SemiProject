<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
   String ctxPath = request.getContextPath();
    //     /MyMVC
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<script type="text/javascript">
	
		window.onload = function(){
			
			alert("언제든 다시 가입하실 수 있습니다! 감사합니다.");
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