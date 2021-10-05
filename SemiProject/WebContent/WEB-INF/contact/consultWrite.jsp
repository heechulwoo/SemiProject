<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>   

<jsp:include page="../header.jsp"/>


<style>

div#consultWrite {
  padding-top: 50px;
  margin-bottom: 50px;
  border-bottom: solid 1px gray;
}
table#tblConsultWrite {
  width: 93%;
  border: solid 1px gray;
  margin: 10px;
}
tr {
  margin-bottom: 10px;
}
td#bor {
  background-color: #f5f5f5;
  text-align: center;
}
td#detail {
  padding-left: 15px;
}
table#tblConsultWrite #th {
  height: 40px;
  text-align: center;
  background-color: #99c2ff;
  font-size: 14pt;
}
table#tblConsultWrite td {
  line-height: 30px;
  padding-top: 8px;
  padding-bottom: 8px;
}
.star {
  color: red;
  font-weight: bold;
  font-size: 13pt;
}
a#writeBtn,
a#backBtn {
  width: 8em;
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
a#writeBtn:hover,
a#backBtn:hover {
  opacity: 0.8;
  text-decoration: none;
}
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		
		// --- 뒤로 가기 버튼 클릭 시 --- //
		$("a#backBtn").click(function(){
			
			location.href="javascript:history.back();"; // 이전 페이지로 이동 
			
		});// end of $("a#backBtn").click(function(){})---------------------------
		
	});// end of $(document).ready(function(){})-------------------------------------------
	
	
</script>


	
    <div class="container">
    
     <!-- 이케아 상담 글쓰기 시작 -->
      <div id="consultWrite" class="col-md-auto">
        <h1 style="font-weight: bold">문의글 작성</h1>
        <br>
        <p>
		          궁금한 점이 있으세요?<br>
			 신청서를 통해 IKEA에 대한 궁금한 점을 문의해주세요.
        </p>
        <br>
      </div>
      <!-- 이케아 상담 글쓰기 끝 -->
    
      <!-- 상담 글쓰기 폼 시작 -->
      <div class="row justify-content-center" id="divConsultFrm">
        <div class="col-md-12" align="center">
          <form name="consultFrm">
          
            <table id="tblConsultWrite">
              <thead>
                <tr>
                  <th class="bg-dark text-white" colspan="2" id="th">
			                      문의글 작성 (
			          <span style="font-size: 10pt; font-weight: bold" ><span class="star">*</span>표시는 필수입력사항입니다.</span>
			          )
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td
                    colspan="2"
                    style="text-align: center; vertical-align: middle">
                    <iframe src="../iframeAgree/agree.html" width="85%" height="200px" class="box"></iframe>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="border-bottom: solid 1px gray">
                    <label for="agree" style="width: 20%">이용약관에 동의합니다</label>&nbsp;&nbsp;
                    <input type="checkbox" id="agree" />
                  </td>
                </tr>
                <tr>
                  <td
                    colspan="2"
                    style="border-bottom: solid 1px gray; color: red">
                    &nbsp;&nbsp;※ 문의 카테고리에서 해당 되는 사항을 1개 선택해주세요.
                  </td>
                </tr>
				
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold; background-color: #d9d9d9;" >
                    	문의 카테고리<span class="star">*</span>
                  </td>
                  <td style="width: 80%; text-align: left">
                    <select id="askDetail" name="askDetail" style="margin-left: 2%; width: 70%; padding: 8px">
                      <option selected>해당하는 것을 선택해주세요.</option>
                      <option id="ask1">상품 정보</option>
                      <option id="ask2">상품 추천</option>
                      <option id="ask3">배송/방문설치</option>
                      <option id="ask4">사용 상 문의</option>
                      <option id="ask5">A/S 접수</option>
                      <option id="ask6">납품확인서 발급</option>
                      <option id="ask7">제안/칭찬/불만족</option>
                      <option id="ask8">기타</option>
                    </select>
                  </td>
                </tr>

                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">성명&nbsp;<span class="star">*</span></td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" name="name" id="name" class="requiredInfo" placeholder="이름을 입력해주세요."/>
                    <span class="error">이름은 필수입력 사항입니다.</span>
                  </td>
                </tr>
                <tr>
		         <td id="bor" style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
		         <td id="detail" style="width: 80%; text-align: left;">
		             <input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp;
		             <!-- 아이디중복체크 -->
		             <img id="idcheck" src="<%= ctxPath%>/images/b_id_check.gif" style="vertical-align: middle;" />
		             <span id="idcheckResult"></span>
		             <span class="error">아이디는 필수입력 사항입니다.</span>
		         </td> 
		       </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	이메일&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" />
                    <span class="error">이메일 형식에 맞지 않습니다. 다시 입력해주세요!</span>
                    
                    <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span>
                    <span id="emailCheckResult"></span>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	휴대전화&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly/>&nbsp;-&nbsp;
                    <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
                    <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
                    <span class="error">휴대폰 형식이 아닙니다.</span>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="font-weight: bold; width: 20%;">
                    <label class="title" for="registerComment">제목&nbsp;
                    	<span class="star">*</span>
                    </label>
                  </td>
                  <td id="detail" style="width: 80%;">
                    <textarea rows="1" cols="50" id="registerComment" placeholder="제목을 입력해주세요."></textarea>
                  </td>
                </tr>
                <tr>
                  <td id="bor">
                    <label class="title" style="width: 40%" for="addFile">파일 첨부</label>
                  </td>
                  <td id="detail" style="width: 60%">
                    	파일첨부 <input type="file" id="addFile" />
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="font-weight: bold; width: 20%;">
                    <label class="title" for="registerComment">내용&nbsp;
                    	<span class="star">*</span>
                    </label>
                  </td>
                  <td id="detail" style="width: 80%;">
                    <textarea rows="7" cols="50" id="registerComment"></textarea>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="line-height: 90px;" class="text-center">
                    <a href="consultList.html" role="button" class="btn" id="writeBtn" style="margin-top: 2vw; margin-bottom: 4vw">작성하기</a>
                    <a role="button" class="btn" id="backBtn" style="margin-top: 2vw; margin-bottom: 4vw">뒤로가기</a>
                  </td>
                </tr>
                
              </tbody>
            </table>
            
          </form>
        </div>
      </div>
      <!-- 상담 글쓰기 폼 시작 -->

      <hr />

    </div>
    <!-- .container 끝 -->
    
    
    
<jsp:include page="../footer.jsp"/>
