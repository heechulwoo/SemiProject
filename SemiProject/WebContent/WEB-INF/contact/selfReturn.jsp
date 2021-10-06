<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
	// /SemiProject
%>   

<jsp:include page="../header.jsp"/>

<style>
	
div#selfReturn {
  padding-top: 50px;
  padding-bottom: 50px;
  border-bottom: solid 1px gray;
}
div#selfReturnFrm {
  padding-top: 70px;
  padding-bottom: 70px;
}
table#tblSelfReturn {
  width: 93%;
  border: solid 1px gray;
  margin: 10px;
}
tr {
  margin-bottom: 10px;
}
td#bor {
  border: none;
  background-color: #f5f5f5;
  text-align: center;
  margin: 1px;
}
td#detail {
  padding-left: 20px;
}
table#tblSelfReturn #th {
  height: 40px;
  text-align: center;
  background-color: #f5f5f5;
  font-size: 14pt;
}
table#tblSelfReturn td {
  /* border: solid 1px gray;  */
  line-height: 30px;
  padding-top: 8px;
  padding-bottom: 8px;
}
.star {
  color: red;
  font-weight: bold;
  font-size: 13pt;
}
a#returnBtn,
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
a#returnBtn:hover,
a#backBtn:hover {
  opacity: 0.8;
  text-decoration: none;
}
	
</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("span.error").hide();
				
	});
	
</script>



	<div class="container">
      <!-- 이케아 셀프반품 시작 -->
      <div id="selfReturn" class="col-md-auto">
        <h1 style="font-weight: bold">셀프 반품</h1>
        <br>
        <p>
		          셀프 반품 접수 후 매장 내 교환환불 코너에 제품을 가져오시면 됩니다.<br>
		          플래닝 스튜디오, 이케아 랩에서는 반품할 수 없습니다.<br>
		          셀프 반품은 단순 변심 사유에 한하여 접수 가능합니다.
        </p>
        <br>
      </div>
      <!-- 이케아 셀프반품 끝 -->

      <!-- 상담 글쓰기 폼 시작 -->
      <div class="row justify-content-center" id="selfReturnFrm">
        <div class="col-md-12" align="center">
          <form name="returnFrm">
          
            <table id="tblSelfReturn">
              <thead>
                <tr>
                  <th class="bg-dark text-white" colspan="2" id="th">
                    	셀프 반품 (
                    	<span style="font-size: 10pt; font-weight: bold">
                    		<span class="star">*</span>
                    	표시는 필수입력사항입니다.</span>)
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td colspan="2" style="text-align: center; vertical-align: middle">
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
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	제품번호&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" name="odrcode" id="odrcode" class="requiredInfo" />
                    <span class="error">제품번호는 필수입력 사항입니다.</span>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	반품사유<span class="star">*</span>
                  </td>
                  <td style="width: 80%; text-align: left">
                    <select id="whyreturn" name="whyreturn" style="margin-left: 2%; width: 70%; padding: 8px">
                      <option>원하는 스타일, 색상 또는 크기가 아닙니다.</option>
                      <option>필요한 것보다 더 많이 구입했습니다.</option>
                      <option>다른 곳에서 더 낮은 가격의 제품을 찾았습니다.</option>
                      <option>제가 찾는 제품이 아닙니다.</option>
                      <option>제품 정보가 제품과 다르게 안내되었습니다.</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	성명&nbsp;<span class="star">*</span>
                  </td>
                  <td id="detail" style="width: 80%; text-align: left">
                    <input type="text" name="name" id="name" class="requiredInfo" />
                    <span class="error">성명은 필수입력 사항입니다.</span>
                  </td>
                </tr>
                <tr>
		         <td id="bor" style="width: 20%; font-weight: bold;">
		         	아이디&nbsp;<span class="star">*</span>
		         </td>
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
                  <td id="bor" style="width: 20%; font-weight: bold">
                    	구입처<span class="star">*</span>
                  </td>
                  <td style="width: 80%; text-align: left">
                    <select id="wherebuy" name="wherebuy" style="margin-left: 2%; width: 200px; padding: 8px" >
                      <option>IKEA 광명</option>
                      <option>IKEA 기흥</option>
                      <option>IKEA 고양</option>
                      <option>IKEA 쌍용</option>
                      <option>IKEA 동부산</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td colspan="2" style="line-height: 90px" class="text-center">
                    <a href="consultList.html" role="button" class="btn" id="returnBtn" style="margin-top: 2vw; margin-bottom: 4vw">작성하기</a>
                    <a href="javascript:history.back()" role="button" class="btn" id="backBtn" style="margin-top: 2vw; margin-bottom: 4vw">뒤로가기</a>
                  </td>
                </tr>
              </tbody>
              
            </table>
          </form>
        </div>
      </div>
      <!-- 상담 글쓰기 폼 끝 -->

      <hr>

      
    </div>
    <!-- .container 끝 -->
    
	<!-- 줄 띄우기 용 -->
    <br><br><br><br><br> 
    
<jsp:include page="../footer.jsp"/>    