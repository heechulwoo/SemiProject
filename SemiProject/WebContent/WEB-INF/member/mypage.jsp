<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  <!-- jstl을 사용하기 위함  -->    



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
   
   .star { color: red;
           font-weight: bold;
           font-size: 12pt;
   }
   
   
   
</style>


<!-- 사이드바 function -->    
<script>

	function w3_open() {
	  document.getElementById("mySidebar").style.display = "block";
	}
	 
	function w3_close() {
	  document.getElementById("mySidebar").style.display = "none";
	}
	
</script>



	<!-- 상단 컨텐츠 시작 -->
	<div class="container" style="max-width:950px; margin-top:40px">
	<div class="row custom-topcontents">
		
			<h2><b>&nbsp;계정 관리</b></h2>
	
			<img class="w3-image" width="1000" height="300" src="<%= ctxPath%>/images/제목 없음.png" style="margin-top:40px">	
		</div>

		<table class="table my-4" style="font-size: 10pt">
		  <thead>
		  <tr>
		      <th class="table-light w3-border-light-grey">나의 정보</th>
		      <td></td>
		      <td></td>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <th>아이디(이메일)</th>
		      <td>leess@naver.com</td>
		      <td></td>
		    </tr>
		    <tr>
		      <th>이름</th>
		      <td>이순신</td>
		      <td>
		      <!-- Modal 시작-->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">이름 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    <tr>
		      <th>휴대폰번호</th>
		      <td>010-5556-5456</td>
		      <td>
		      
		      <!-- Modal 시작-->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModalphon">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModalphon">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">휴대폰번호 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    
		    <tr>
		      <th >배송지</th>
		      <td>서울특별시 마포구 쌍용아파트</td>
		      <td>
		     <!-- Modal -->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">배송지 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    
		    <tr>
		      <th style="font-size: 10pt">마지막 비밀번호 변경일자</th>
		      <td>2021/09/08</td>
		      <td>
		      <!-- Modal -->
		      <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		수정
			  </button>
				<!-- Modal 구성 요소 -->
				<div class="modal fade" id="exampleModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      
				      <!-- Modal header -->
				      <div class="modal-header">
				        <h5 class="modal-title">비밀번호 변경창</h5>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				      
				      <!-- Modal body -->
				      <div class="modal-body">
				        Modal body....
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-light" data-dismiss="modal" style="border-radius: 50px">취소</button>
				        <button type="button" class="btn btn-dark" style="border-radius: 50px">저장</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- Modal 끝 -->
		      </td>
		    </tr>
		    
		    <tr>
		      <th></th>
		      <td></td>
		      <td>
		      <!-- Modal -->
		      <button type="button" class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#exampleModal">  <!--  data-toggle="modal"를 넣어주면 되는것이다. -->  
		  		회원 탈퇴
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
				        <button type="button" class="btn btn-primary">탈퇴</button>
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