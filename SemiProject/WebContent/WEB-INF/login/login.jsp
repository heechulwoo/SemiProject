<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/WEB-INF/header.jsp"/>


<div class="container"  style="max-width:1000px">
<!-- 상단 컨텐츠 시작 -->
 <div class="row custom-topcontents">
	<div class="col-md-3 px-4">
		<h2 ><b>로그인</b></h2>
		<p style="font-size: 9pt;  margin-top:40px">IKEA 계정이 없으신가요?<br> 지금 바로 만들어보세요</p>
		<span class="card-text"><i class="fa fa-pen"></i></span>
		<a href="memberRegister.html" style="font-size:14px"><b>회원가입</b></a> 
	</div>
	<div class="col-md-9">
		<img src="<%= ctxPath%>/images/loginpage.jpg" class="img-fluid"	alt="반응형 로그인 이미지" width="750" height="300">
 	</div>
 </div>
<!-- 상단 컨텐츠 끝 -->



<!-- 중앙 컨텐츠 시작 -->
<div class="row custom-topcontents">
 <div class="col-md-3"></div>
		
 <div class="col-md-9" style="font-size:12px">
		
	<!-- 경고 메시지 시작 -->
	<div class="alert alert-warning alert-dismissible fade show" role="alert">
           공용으로 사용하는 PC에서는 &quot;아이디 기억하기&quot;를 체크하면 개인정보 유출의 위험이있습니다.
	  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
	    <span aria-hidden="true">&times;</span>
	  </button>
	</div>  
	<!-- 경고 메시지 끝 -->
		
	<!-- 로그인 폼 시작 -->
	<form action="login.do" method="post"  class="font-weight-bolder">
	<fieldset>
	   <div class="row pt-4">
		<div class="col-md-9">
			
			<div class="form-group row"  style="margin-left:10px" >	
				<div class="col-md-3">
					<label for="email">아이디</label>
				</div>
				<div class="col-md-9">
					<input class="form-control" type="email" style="font-size:12px" id="email" name="email" placeholder="아이디" autocomplete="off" required /> 
				</div>
			</div>
			
			<div class="form-group row"  style="margin-left:10px">
				<div class="col-md-3">
					<label for="pwd">비밀번호</label>
				</div>
				<div class="col-md-9">
					<input class="form-control" type="password" style="font-size:12px" id="pwd" name="pwd"	placeholder="비밀번호" required />
				</div>
			</div>
			
			<div class="form-group"  style="margin-left:24px">
				<label for="user_remember_me">아이디 기억하기</label>
				<input type="checkbox" id="user_remember_me" name="remember" value="1" />
			
	
		<!-- 아이디 찾기 시작 -->
		<a style="cursor: pointer; margin-left:18px" data-toggle="modal" data-target="#modalid" data-dismiss="modal">아이디찾기</a> /
		          
		<!-- Modal 시작-->
		<div class="modal fade" id="modalid">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal header -->
		      <div class="modal-header">
		        <h5 class="modal-title">아이디 찾기</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal body -->
		      <div class="modal-body">
		        <h6>아이디 찾기 모달</h6>
		  	  </div>
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				<button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- modal 끝-->
		<!-- 아이디 찾기 끝-->
	
		<!--비밀번호 찾기 시작-->
		<a style="cursor: pointer;" data-toggle="modal" data-target="#modalpwd" data-dismiss="modal">비밀번호 찾기</a> 
		          
		<!-- Modal 시작-->
		<div class="modal fade" id="modalpwd">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      
		      <!-- Modal header -->
		      <div class="modal-header">
		        <h5 class="modal-title">비밀번호 찾기</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      
		      <!-- Modal body -->
		      <div class="modal-body">
		        <h6>비밀번호 찾기 모달</h6>
		  		  </div>
		      
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				<button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- modal 끝-->
		<!-- 비밀번호 찾기 끝 -->
	</div>
	</div>
	
	<div class="col-md-3">
       <input class="btn btn-primary" type="submit" value="로그인" style="height: 85px;" />
    </div>
 </div>
 </fieldset>
</form>
<!-- 로그인 폼 끝 -->
	</div>
</div>
<!-- row 끝 -->
<!-- 중앙 컨텐츠 끝 -->
</div><hr>



<!-- Optional JavaScript -->
<script src="../js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
	
	
<!-- 사이드바 function -->    
<script>
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}
</script>	

</body>
</html>

<jsp:include page="/WEB-INF/footer.jsp"/>
