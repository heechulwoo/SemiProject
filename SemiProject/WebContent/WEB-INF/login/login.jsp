<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String ctxPath = request.getContextPath();
%>


<jsp:include page="/WEB-INF/header.jsp"/>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- id 찾기 사이드바 function -->    
<script>
   function id_open() {
     document.getElementById("sidebarId").style.display = "block";
   }
    
   function id_close() {
     document.getElementById("sidebarId").style.display = "none";
   }
</script>

<!-- 비밀번호 찾기 사이드바 function -->    
<script>
   function pwd_open() {
     document.getElementById("sidebarPwd").style.display = "block";
   }
    
   function pwd_close() {
     document.getElementById("sidebarPwd").style.display = "none";
   }
</script>

<script>

   $(document).ready(function(){
    
      var loginUserid = localStorage.getItem('remember');
      
      if(loginUserid != null ) {
         $("input#loginUserid").val(loginUserid);
         $("input:checkbox[id=remember]").prop("checked",true);
      }
      
      
       $("button#login").click(function(){
          goLogin();
       });
       
       
       $("input#Pwd").bind("keyup",function(event){
         if(event.keyCode == 13) { 
            goLogin(); 
         }
      });
       
      // 현재 페이지를 새로고침 하면서 모달창에 입력한 성명과 이메일의 값을 삭제시킨다.
       $(".myclose").click(function(){
            javascript:history.go(0);
      });
      
    
    });// end of $(document).ready(function(){})------------------------
   


    function goLogin() {
    //   alert("로그인");
   
      var loginUserid = $("input#loginUserid").val().trim();
      var loginPwd = $("input#loginPwd").val().trim();
      

      if(loginUserid == "") {
         alert("아이디를 입력하세요!!");
         $("input#loginUserid").val("");
         $("input#loginUserid").focus();
         return; // goLogin() 종료
      }
      
      if(loginPwd == "") {
         alert("암호를 입력하세요!!");
         $("input#loginPwd").val("");
         $("input#loginPwd").focus();
         return; // goLogin() 종료
      }
       
      // 체크박스에 체크가 되어있으면 true
      if( $("input:checkbox[id=remember]").prop("checked") ) {
      //   alert("아이디저장 체크를 하셨네요");   
         
         console.log($("input#loginUserid").val());
         
         localStorage.setItem('remember', $("input#loginUserid").val());
      
      }
      else{
      //   alert("아이디저장 체크를 해제 하셨네요");
         
         localStorage.removeItem('remember');
      }
      
      var frm = document.loginFrm;
      frm.action = "<%= request.getContextPath()%>/login/loginstart.one"
      frm.method = "post";
      frm.submit();
      
      
    }// end of goLogin();---------------------------
    
 
</script>







<div class="container"  style="max-width:1100px; margin-top: 30px; height:900px" >
<!-- 상단 컨텐츠 시작 -->
 <div class="row custom-topcontents">
   <div class="col-md-3 px-4 mt-5">
      <h1 class="ml-5"><b>로그인</b></h1>
      <p style="font-size: 9pt;  margin-top:40px" class="ml-5">IKEA 계정이 없으신가요?<br> 지금 바로 만들어보세요</p>
      <span class="card-text"><i class="fa fa-pen ml-5"></i></span>
      <a href="<%= ctxPath%>/member/register.one" style="font-size:14px" class="ml-1"><b>회원가입</b></a> 
   </div>
   <div class="col-md-9" >
      <img src="<%= ctxPath%>/images/loginpage.jpg" class="img-fluid ml-5"   alt="반응형 로그인 이미지" width="750" height="300">
    </div>
 </div>
<!-- 상단 컨텐츠 끝 -->



<!-- 중앙 컨텐츠 시작 -->
<div class="row custom-topcontents">
 <div class="col-md-3"></div>
      
 <div class="col-md-9" style="font-size:12px">
      
   <!-- 경고 메시지 시작 -->
   <div class="alert alert-warning alert-dismissible fade show ml-5" role="alert" style="width:750px">
           공용으로 사용하는 PC에서는 &quot;아이디 기억하기&quot;를 체크하면 개인정보 유출의 위험이있습니다.
     <button type="button" class="close" data-dismiss="alert" aria-label="Close">
       <span aria-hidden="true">&times;</span>
     </button>
   </div>  
   <!-- 경고 메시지 끝 -->
      
   <!-- 로그인 폼 시작 -->
   <form name="loginFrm"  class="font-weight-bolder ml-5" style="font-size:13px"> 
   <fieldset>
      <div class="row pt-4">
      <div class="col-md-9">
         
         <div class="form-group row"  style="margin-left:10px" >   
            <div class="col-md-3">
               <label for="email">아이디</label>
            </div>
            <div class="col-md-9">
               <input class="form-control" type="text" style="font-size:13px" id="loginUserid" name="userid" placeholder="아이디" autocomplete="off" required /> 
            </div>
         </div>
         
         <div class="form-group row"  style="margin-left:10px">
            <div class="col-md-3">
               <label for="pwd">비밀번호</label>
            </div>
            <div class="col-md-9">
               <input class="form-control" type="password" style="font-size:13px" id="loginPwd" name="pwd"   placeholder="비밀번호" required />
            </div>
         </div>
         
         <div class="form-group mt-4"  style="margin-left:24px">
            <label for="remember" style="width: 20%">아이디 기억하기</label>
            <input type="checkbox" id="remember" name="remember" />

            <!-- 아이디 찾기 버튼 -->
            <div class="w3-button " style="border-radius: 70px; margin-left:18px" onclick="id_open()">아이디 찾기</div>         
            
      
      
   
      <!--비밀번호 찾기 시작
      <a style="cursor: pointer;" data-toggle="modal" data-target="#modalpwd" data-dismiss="modal">비밀번호 찾기</a> 
      기존 모달 방식 -->
      <div class="w3-button " style="border-radius: 70px" onclick="pwd_open()">비밀번호 찾기</div>         
                
      
      <!-- 비밀번호 찾기 끝 -->
   </div>
   </div>
   
   <div class="col-md-3">
       <button class="btn" type="button" id="login" value="로그인" style="height: 85px; font-size:13px; background-color:#00579c; color:white; border-radius: 10px"><b>로그인</b></button>
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


   <!-- 아이디찾기 Sidebar 시작 -->
   <nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none; z-index:2; width:200%; max-width:2000px" id="sidebarId">
      <div class="container" style="float:left; color:white; background-color:#00579c; max-width:492px; height:900px"> 
        <a href="javascript:void(0)" onclick="id_close()"class=" w3-button myclose" style="border-radius: 70px; margin:30px; color:white"><i class="fas fa-times"></i></a>
        <a class="navbar-brand" href="<%= ctxPath%>/index.one" style="margin-left:29px"><img src="<%= ctxPath%>/images/logo2.jpg" alt="IKEA_logo" width="87" height="36"/></a>           
        <div style="margin-top:105px; margin-left:140px">
              <span style="font-size:37px"><b>아이디 찾기</b></span><br>
              <span style="font-size:15px">가입하셨던 성명과 이메일을 입력해 주세요.</span>
        </div>
       </div>
          <div id="idFind"><iframe style="border: none; margin:45px 0 0 60px; width:1000px; height: 650px;" src="<%= request.getContextPath()%>/login/idFind.one">
                </iframe>
          </div>
   </nav>
   <!-- 아이디찾기 Sidebar 끝-->
   
   <!-- 비밀번호찾기 Sidebar 시작 -->
   <nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left w3-light" style="display:none; z-index:2; width:200%; max-width:2000px" id="sidebarPwd">
      <div class="container" style="float:left; color:white; background-color:#00579c; max-width:492px; height:900px"> 
        <a href="javascript:void(0)" onclick="pwd_close()"class=" w3-button myclose" style="border-radius: 70px; margin:30px; color:white"><i class="fas fa-times"></i></a>
        <a class="navbar-brand" href="<%= ctxPath%>/index.one" style="margin-left:29px"><img src="<%= ctxPath%>/images/logo2.jpg" alt="IKEA_logo" width="87" height="36"/></a>           
        <div style="margin-top:93px; margin-left:140px">
              <span style="font-size:37px"><b>비밀번호 찾기</b></span><br>
              <span style="font-size:15px">이메일을 통해 비밀번호를 재설정해 주세요.</span>
        </div>
       </div>
          <div id="pwdFind"><iframe style="border: none; margin:55px 0 0 18px; width:800px; height: 650px;" src="<%= request.getContextPath()%>/login/pwdFind.one">
                </iframe>
          </div>
   </nav>
   <!-- 아이디찾기 Sidebar 끝-->
   

</body>
</html>

<jsp:include page="/WEB-INF/footer.jsp"/>