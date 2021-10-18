<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>

<jsp:include page="../header.jsp"/>

<style>
	
	div#consultDetail {
	  padding-top: 70px;
	  padding-bottom: 50px;
	  border-bottom: solid 1px #d9d9d9;
	}
	
	div#detail {
	  padding-top: 70px;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto 50px auto;
	}
	
	div#aDetail {
	  padding-top: 70px;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	  border-top: solid 1px #d9d9d9;
	}
	
	div#viewDetail {
	  padding-top: 70px;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	  padding-bottom: 50px;
	}
	
	table#tblViewAnswer {
	  width:80%;
	  text-align:center;
	  margin:0px auto;
	}
	
	div#cvoInfo {
	  padding-top: 30px;
	}
	
	div#ansInfo{
	  padding-top: 30px;
	}
	
	table#tblDetailConsult {
	  border: solid #d9d9d9 2px;
	  border-left: hidden; 
	  border-right: hidden;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	  border-collapse: separate;
  	  border-spacing: 0 20px;
	}
	
	table#tblAnswer {
	  border: solid #d9d9d9 2px;
	  border-left: hidden; 
	  border-right: hidden;
	  width:80%; 
	  text-align:center; 
	  margin:0px auto;
	  border-collapse: separate;
  	  border-spacing: 0 20px;
	}
	
	
	.cDetail {
	  border-right: solid #d9d9d9 2px;
	  font-weight: bold;
	}
	
	.detailcontent {
	  padding-left: 30px;
	}
	
	button#backBtn,
	button#firstBtn,
	button#changeBtn,
	button#deleteBtn,
	button#answerBtn {
	  width: 12em;
	  text-align: center;
	  display: inline-block;
	  font-weight: bold;
	  padding: 0.7rem 1.3rem;
	  font-size: 0.75rem;
	  border-radius: 30px;
	  background-color: black;
	  color: white;
	  justify-content: center;
	}
	button#backBtn:hover,
	button#firstBtn:hover,
	button#changeBtn:hover,
	button#deleteBtn:hover,
	button#answerBtn:hover {
	  opacity: 0.8;
	  text-decoration: none;
	}
	
	tr.answerInfo:hover{
	  background-color: #f2f2f2;
	  cursor: pointer;
	}
	
	a#deleteA:hover {
		color: #ff1a1a;
		font-weight: bold;
	}
	
</style>


<script type="text/javascript">
	
	
	var goBackURL = "";
	
	$(document).ready(function() {
		
		goBackURL = "${requestScope.goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&"); // 공백을 다시 &로 바꿔주기
		
	}); // end of $(document).ready(function(){})--------------------------
	
	
	
	// === Function Declaration === //
	
	
	// --- 글내용 글자 수 제한 --- //
	// Byte 수 체크 제한
	function fnChkByte(obj, maxByte)
	{
	    var str = obj.value;
	    var str_len = str.length;
	
	
	    var rbyte = 0;
	    var rlen = 0;
	    var one_char = "";
	    var str2 = "";
	
	
	    for(var i=0; i<str_len; i++)
	    {
	        one_char = str.charAt(i);
	        if(escape(one_char).length > 4) {
	            rbyte += 2;                                         //한글2Byte
	        }else{
	            rbyte++;                                            //영문 등 나머지 1Byte
	        }
	        if(rbyte <= maxByte){
	            rlen = i+1;                                         //return할 문자열 갯수
	        }
	     }
	     if(rbyte > maxByte)
	     {
	        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
	        str2 = str.substr(0,rlen);                              //문자열 자르기
	        obj.value = str2;
	        fnChkByte(obj, maxByte);
	     }
	     else
	     {
	        document.getElementById('byteInfo').innerText = rbyte;
	     }
	}
	
	
	
	
	// 문의글 목록으로 가기(검색결과, 페이지 관련 정보 남아있는 것)
	function goConsultList() {
		location.href = "/SemiProject"+goBackURL;
	}// end of function goConsultList(){}----------------------------------
	
	
	
	// 내 문의글 수정하기
	function goChange() {
		
		
		var result = confirm('내 문의글 수정 시 기존 첨부파일이 없어집니다. 그래도 수정하시겠습니까?'); 
		
		if(result) { 
			// 수정한다.(YES)
		//	location.replace('index.php');
			
			<%-- 문의글 수정하기 --%>
			var frm = document.consultDetailFrm;
			frm.action = "<%= ctxPath%>/contact/editConsult.one";
			frm.method = "post";
			frm.submit();
			
		}
		else { 
		// 수정 안한다. (NO)
		
		}
		
	
	}// end of function goChange(){}---------------------------------------
	
	
	
	// 내 문의글 삭제하기
	function goDelete() {
		
		var result = confirm('삭제 시 해당 문의글이 완전히 삭제됩니다. 이 문의글을 정말로 삭제하시겠습니까?'); 
		
		if(result) {
			
			<%-- 문의글 삭제하기 --%>
			var frm = document.consultDetailFrm;
			frm.action = "<%= ctxPath%>/contact/deleteConsult.one";
			frm.method = "post";
			frm.submit();
			
		}
		else{
			
		}
		
		
	}// end of function goDelete(){}---------------------------------------
	
	
	
	// (관리자) 댓글 쓰기
	function goAnswer() {
		
		
		var form = document.getElementById("writeAnswerForm");
        
        var answertitle   = form.answertitle.value;
        var answercontent = form.answercontent.value;
        
        if(answertitle.trim() == "")
        {
            alert("댓글 제목을 입력해주세요!");
            return false;
        }
        
        else if(answercontent.trim() == ""){
        	alert("댓글 내용을 입력해주세요!");
            return false;
        }
        
        else {
        	
        	<%-- 댓글 등록하기 --%>
    		var frm = document.writeAnswerForm;
    		frm.action = "<%= ctxPath%>/contact/registerAnswer.one";
    		frm.method = "post";
    		frm.submit();
        	
        }
		
		
	}// end of function goAnswer(){}----------------------------------------
	
	
	
	// 댓글 삭제창
    function cmDeleteOpen(answerno){
        var msg = confirm("댓글을 삭제합니다.");    
        if(msg == true){ // 확인을 누를경우
        	deleteAnswer(answerno);
        }
        else{
            return false; // 삭제취소
        }
    }// end of function cmDeleteOpen(answerno){}-------------------------------
	
	
	
	// (관리자) 댓글 삭제
	function deleteAnswer(answerno) {
		
			location.href="<%= ctxPath%>/contact/deleteAnswer.one?answerno="+answerno+"&goBackURL=${requestScope.goBackURL}";
			
	}// end of function goAnswer(){}----------------------------------------
	
	
	
	
</script>

<!--  -->

<div class="container">

	<!-- 이케아 문의글 세부내용 보기 시작 -->
	<div id="consultDetail" class="col-md-auto">
	  <h1 style="font-weight: bold">문의글 보기</h1>
	    <br>
	    <p>
	    	도움이 필요하신가요? 궁금한 사항은 저희가 해결해드릴게요.<br>
	                  작성하신 문의글을 확인해보세요!<br>
	    </p>
	    <br>
	</div>
	<!-- 이케아 문의글 세부내용 보기 끝 -->
	
	
	
	<!-- 문의글 내용 시작 -->
	<form name="consultDetailFrm">
	<div id="detail" class="col-md-auto">
		<c:if test="${ empty requestScope.cvo }"> 
			존재하지 않는 문의글입니다. 다시 확인해주세요!<br>
		</c:if>	
		
		<c:if test="${ not empty requestScope.cvo }"> 
			<c:set var="fk_userid" value="${requestScope.cvo.fk_userid}" />
			<c:set var="name" value="${requestScope.cvo.name}" />
			<c:set var="email" value="${requestScope.cvo.email}" />
			<c:set var="mobile" value="${requestScope.cvo.mobile}" />
			<c:set var="asktitle" value="${requestScope.cvo.asktitle}" />
			<c:set var="category" value="${requestScope.cvo.category}" />
			<c:set var="askcontent" value="${requestScope.cvo.askcontent}" />
			<c:set var="askdate" value="${requestScope.cvo.askdate}" />
	   		<c:set var="ask_orginFileName" value="${requestScope.cvo.ask_orginFileName}" />
			
			
			
			<h3 class="col-md-auto" style="font-weight: bold;"><span style="color: #80ccff;">${requestScope.cvo.name}</span>님의 문의글</h3>
			
			<div id="cvoInfo" class="col-md-auto"> 
				
				
				<table id="tblDetailConsult" style="width: 80%;">
				<tbody>
					<tr>
				      <td width="25%" class="cDetail" style="padding-top: 10px;">글번호</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${requestScope.cvo.askno}
				         <input type="hidden" name="askno" value="${requestScope.cvo.askno}" />
				      </td>   
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail" style="padding-top: 10px;">아이디</td>
				      <td width="75%" align="left" class="detailcontent" style="padding-top: 10px;" >
				         ${fk_userid}  <%-- ${requestScope.cvo.fk_userid} --%>
				         <input type="hidden" name="fk_userid" value="${requestScope.cvo.fk_userid}" />
				      </td>   
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">성명</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${name}  <%-- ${requestScope.cvo.name} --%>
				         <input type="hidden" name="name" value="${requestScope.cvo.name}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">이메일</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${email}  <%-- ${requestScope.cvo.email} --%>
				         <input type="hidden" name="email" value="${requestScope.cvo.email}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">휴대폰</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11)}
				         <input type="hidden" name="mobile" value="${requestScope.cvo.mobile}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">글 제목</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${asktitle}  <%-- ${requestScope.cvo.asktitle} --%>
				         <input type="hidden" name="asktitle" value="${requestScope.cvo.asktitle}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">카테고리</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;" >
				         ${category}  <%-- ${requestScope.cvo.category} --%>
				         <input type="hidden" name="category" value="${requestScope.cvo.category}" />
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">글 내용</td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${askcontent}  <%-- ${requestScope.cvo.askcontent} --%>
				         <input type="hidden" name="askcontent" value="${requestScope.cvo.askcontent}" />
				      </td>
				   </tr>
				   
				   <%-- ==== 첨부파일 타입 다운로드 ==== --%>
				   <tr>
				      <td width="25%" class="cDetail">첨부 파일</td>
				      <td width="75%" align="left" class="detailcontent" >
				      	<input type="hidden" name="ask_systemFileName" value="${requestScope.cvo.ask_systemFileName}" /> 
			 		    <input type="hidden" name="ask_orginFileName" value="${requestScope.cvo.ask_orginFileName}" /> 
			
				      	<c:if test="${requestScope.cvo.ask_orginFileName ne '없음'}">
			                 <a style="color: #1aa3ff;" href="<%= ctxPath%>/contact/fileDownload.one?askno=${cvo.askno}">${cvo.ask_orginFileName}</a>
			            </c:if>
			            <c:if test="${requestScope.cvo.ask_orginFileName eq '없음'}">
			                                      첨부파일없음
			            </c:if>
				      </td>
				   </tr>
				   
				   <tr>
				      <td width="25%" class="cDetail">문의글 작성일자 </td>
				      <td width="75%" align="left" class="detailcontent" style="border-top: hidden; border-bottom: hidden;">
				         ${askdate}  <%-- ${requestScope.cvo.askdate} --%>
				         <input type="hidden" name="askdate" value="${requestScope.cvo.askdate}" />
				      </td>
				   </tr>
				   
				</tbody>
				</table>
				
			</div>
			
		</c:if>
		
		<div id="buttons" class="col-md-auto">
			<button style="margin-top: 50px;" type="button" id="backBtn" class="btn" onclick="goConsultList()">문의글목록</button>
		   	&nbsp;&nbsp;
		   	<button style="margin-top: 50px;" type="button" id="firstBtn" class="btn" onclick="javascript:location.href='consultList.one'">처음으로</button>
		   	&nbsp;&nbsp;
		   	
		   	<%-- 만약 로그인한 사용자가 자신의 글을 수정하고자 한다면 수정하기 버튼 보여주기 --%>
		   	<c:set var="fk_userid" value="${requestScope.cvo.fk_userid}" />
		   	<c:if test="${ fk_userid eq sessionScope.loginuser.userid }">
		   		<button style="margin-top: 50px;" type="button" id="changeBtn" class="btn" onclick="goChange()">글 수정하기</button>
		   		&nbsp;&nbsp;
			</c:if>
			<c:if test="${ fk_userid eq sessionScope.loginuser.userid }">
		   		<button style="margin-top: 50px;" type="button" id="deleteBtn" class="btn" onclick="goDelete()">글 삭제하기</button>
			</c:if>
			
		</div>
	</div>
	</form>
	<!-- 문의글 내용 끝 -->
	
	
	
	
	
	<%-- ==== 댓글 목록 시작 ==== --%>
    <!-- 댓글목록은 로그인한 유저는 누구나 볼 수 있다. -->
    <form name="viewAnswerForm" >
		<div id="viewDetail" class="col-md-auto">
		
		
			<c:if test="${ empty requestScope.answerList }"> 
				댓글이 존재하지 않습니다.<br>
			</c:if>
			
			<c:if test="${ not empty requestScope.answerList }">
				<h4 class="col-md-auto" style="font-weight: bold; margin-bottom: 0px;">관리자 댓글</h4>
				
				
				<%-- 댓글 테이블 시작 --%>
				<table id="tblViewAnswer" class="table table-bordered col-md-auto" style="width: 90%; margin-top: 35px;">
			        <thead>
			           <tr style="border-right: hidden; border-left: hidden;">
			           	  <th style="border-right: hidden; border-left: hidden;">댓글 번호</th>
			           	  <th style="border-right: hidden; border-left: hidden;">댓글 제목</th>
			           	  <th style="border-right: hidden; border-left: hidden;">&nbsp;&nbsp;&nbsp;댓글 내용&nbsp;&nbsp;&nbsp;</th>
			              <th style="border-right: hidden; border-left: hidden;">댓글 작성일</th>
			              <c:if test="${ sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin' }">
			              	<th style="border-right: hidden; border-left: hidden;">댓글 삭제</th>
			              </c:if>
			           </tr>
			        </thead>
			        
			        <%-- 반복문으로 댓글 뽑아오기 --%>
			        <tbody>
			        	<c:forEach var="avo" items="${requestScope.answerList}">
			        		<tr class="answerInfo">
			        			<td class="answerno" style="border-right: hidden; border-left: hidden;">${avo.answerno}</td>
			        			<td class="answertitle" style="border-right: hidden; border-left: hidden;">${avo.answertitle}</td>
			        			<td class="answercontent" style="border-right: hidden; border-left: hidden;">${avo.answercontent}</td>
			        			<td class="answerdate" style="border-right: hidden; border-left: hidden;">${avo.answerdate}</td>
		        				<%-- 댓글 삭제 버튼(관리자만 삭제 가능) --%>
		        				<td style="border-right: hidden; border-left: hidden;">
									<c:if test="${ sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin' }">
										<div class="col-md-auto"  style="border-right: hidden; border-left: hidden;">
											<a href="#" id="deleteA" onclick="cmDeleteOpen(${avo.answerno})">삭제</a>
								          <%-- <button type="button" id="answerBtn" class="btn" onclick="deleteAnswer()">댓글 삭제하기</button> --%>   
										</div>
									</c:if>
			        			</td>
			        		</tr>
			        	</c:forEach>
			        </tbody>
			    </table>
			</c:if>
	    </div>
    </form>
    <%-- ==== 댓글 목록 끝 ==== --%>
	
	
	
	<%-- ==== 댓글 작성 시작 ==== --%>
    <!-- 관리자로 로그인 했을 경우만 댓글 작성가능 -->
    <c:if test="${ sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin' }">
    
    <form name="writeAnswerForm" id="writeAnswerForm">
		<div id="aDetail" class="col-md-auto">
		
			<h4 class="col-md-auto" style="font-weight: bold; margin-bottom: 0px;">관리자 댓글 작성하기</h4>
			
			<div id="ansInfo" class="col-md-auto"> 
				<table id="tblAnswer" style="width: 80%;">
				<tbody>
					<tr>
				      <td width="25%" class="cDetail">댓글 제목</td>
				      <td width="75%" align="left" class="writeAnswer" style="border-top: hidden; border-bottom: hidden;">
				         <input type="hidden" name="fk_userid" value="${requestScope.cvo.fk_userid}" /> <%-- fk_userid 값 가져오기 --%>
				         <input type="hidden" name="fk_askno" value="${requestScope.cvo.askno}" /> <%-- fk_askno 값 가져오기 --%>
				         <input type="text" maxlength='25' name="answertitle" id="answertitle" style="width: 100%; height: 100%;"/>
				      </td>
				   </tr>
				   <tr>
				      <td width="25%" class="cDetail">댓글 내용</td>
				      <td width="75%" align="left" class="writeAnswer" style="border-top: hidden; border-bottom: hidden;">
				         <textarea name="answercontent" id="answercontent" style="width: 100%; height: 150px;" onKeyUp="javascript:fnChkByte(this,'1000')" ></textarea>
				      </td>
				   </tr>
				</tbody>
				</table>
			</div>
			
			<%-- 댓글 작성 버튼 --%>
			<div class="col-md-auto" >
	          <button style="margin-top: 30px;" type="button" id="answerBtn" class="btn" onclick="goAnswer()">댓글 등록하기</button>
			</div>
	    	
	    </div>
    </form>
    </c:if>
    <%-- ==== 댓글 작성 끝 ==== --%>
		
	
	
		
</div>
<!-- .container 끝 -->

<!-- 줄 띄우기 용 -->
<br><br><br><br><br> 

<jsp:include page="../footer.jsp"/>