<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../header.jsp" />


<!-- 달력 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		// 제품 수량에 스피너 달아주기
		$("input#spinnerPqty").spinner({
			spin:function(event,ui){
	            if(ui.value > 50) {
	               $(this).spinner("value", 50);
	               return false;
	            }
	            else if(ui.value < 1) {
	               $(this).spinner("value", 1);
	               return false;
	            }
			}  
		}); // end of $("input#spinnerPqty").spinner()-----------------------
		
		
		// #### 스피너의 이벤트는 click 도 아니고 change 도 아니고 "spinstop" 이다. #### //
		$("input#spinnerImgQty").bind("spinstop", function(){
			
			var html = "";
			var cnt = $(this).val();
			
			// console.log("확인용 cnt : " + cnt);
			// console.log("확인용 typeof cnt : " + typeof cnt); ==> String
			
			for(var i=0; i<parseInt(cnt); i++){
				html += "<br>";
				html += "<input type='file' name='attach"+i+"' class='btn btn-default' />";	
				
				
			}// end of for-------------------
			
			$("div#divfileattach").html(html);
			
			$("input#attachCount").val(cnt);
				
		});
		
		
		// 추가 이미지파일에 스피너 달아주기
		$("input#spinnerImgQty").spinner({
			spin:function(event,ui){
	            if(ui.value > 10) {
	               $(this).spinner("value", 10);
	               return false;
	            }
	            else if(ui.value < 0) {
	               $(this).spinner("value", 0);
	               return false;
	            }
			}  
		}); // end of $("input#spinnerImgQty").spinner()------------------
		
		
	// 등록하기 버튼
	$("input#btnRegister").click(function(){
				
			var flag = false;
				
				$(".requiredInfo").each(function(){
					var val = $(this).val().trim();
					if(val == ""){
						$(this).focus();
						$(this).next().show();
						flag = true;
						return false;
					}
				});
				
				if($("input#attachCount").val() < 2){
					alert("추가 이미지는 2개 이상 필수 첨부해야 합니다.")
					flag = true;
					return false;
				}
				
				
			if(!flag){
				var frm = document.prodInputFrm;
				frm.submit();
				// 파일이 첨부되었으므로 method는 post로 간다.
			}
				
		});

		
	});// end of $(document ).ready(function(){})-------------
	
	

</script>

<script>

$(function() {
	$("#stockdate").datepicker();
});

// === jQuery UI 의 datepicker === //
	$("input#datepicker")
			.datepicker(
					{
						dateFormat : 'yy-mm-dd' //Input Display Format 변경
						,
						showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
						,
						showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
						,
						changeYear : true //콤보박스에서 년 선택 가능
						,
						changeMonth : true //콤보박스에서 월 선택 가능                
						,
						showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
						,
						buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
						,
						buttonImageOnly : true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
						,
						buttonText : "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
						,
						yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
						,
						monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7',
								'8', '9', '10', '11', '12' ] //달력의 월 부분 텍스트
						,
						monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip 텍스트
						,
						dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 부분 텍스트
						,
						dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
								'토요일' ]
					//달력의 요일 부분 Tooltip 텍스트
					//,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
					//,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
					});

	//초기값을 오늘 날짜로 설정
	$('#datepicker').datepicker('setDate', '+7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	/////////////////////////////////////////////////////

	// === 전체 datepicker 옵션 일괄 설정하기 ===  
	//     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
	$(function() {
		//모든 datepicker에 대한 공통 옵션 설정
		$.datepicker.setDefaults({
			dateFormat : 'yy-mm-dd' //Input Display Format 변경
			,
			showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,
			showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
			,
			changeYear : true //콤보박스에서 년 선택 가능
			,
			changeMonth : true //콤보박스에서 월 선택 가능                
			// ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			// ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			// ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			// ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
			,
			yearSuffix : "년" //달력의 년도 부분 뒤에 붙는 텍스트
			,
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9',
					'10', '11', '12' ] //달력의 월 부분 텍스트
			,
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
					'9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip 텍스트
			,
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 부분 텍스트
			,
			dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ]
		//달력의 요일 부분 Tooltip 텍스트
		// ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		// ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
		});

		//input을 datepicker로 선언
		$("input#fromDate").datepicker();
		$("input#toDate").datepicker();

		//From의 초기값을 오늘 날짜로 설정
		$('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

		//To의 초기값을 3일후로 설정
		$('input#toDate').datepicker('setDate', '+3D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	});
</script>


<title>제품 등록</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../../css/assemble_form.css" />

<style>
td{
padding: 0 0 0 3%;
border-bottom: 2px solid #F7F7F8;
}

th{
text-align: center;
}

</style>


<body>
	<div class="mycontainer" data-theme="a">
		<h1 class="main-title">제품 등록</h1>
		<hr />
		<div class="wrapper" style="margin-top: 5%;">
		<small style="display:inline-block; margin:auto; padding:1%; color:#0058AB;">※ 모든 필드는 필수 입력입니다.</small>
			<%-- !!!!! ==== 중요 ==== !!!!! --%>
			<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     		enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
			<form name="prodInputFrm"
				action="<%=request.getContextPath()%>/product/admin/productRegister.one"
				method="POST" enctype="multipart/form-data">

				<table id="tblProdInput" class="formtable">
					<tbody>
						<tr>
							<th style="border-top: 2px solid #0058AB;" >카테고리</th>
							<td style="border-top: 2px solid lightgray;">
								<select name="fk_cnum" class="forminput requiredInfo">
					            <option value="">▽&nbsp;선택하세요&nbsp;▽</option>
					            <c:forEach var="list" items="${requestScope.categoryList}">
					               <option value="${list.cnum}">${list.cname}</option>
					            </c:forEach>
					         </select>
							<span class="error">필수입력</span>
							</td>
						</tr>

						<tr>
							<th>제품명</th>
							<td>
								<input type="text" name="pname" class="forminput requiredInfo" />
	         					<span class="error">필수입력</span>
							</td>
						</tr>

						<tr>
							<th>제품 대표 이미지</th>
							<td>
								<input type="file" name="pimage1" class="forminput requiredInfo " />
								<span class="error">필수입력</span> 
							</td>
						</tr>

						<tr>
							<th>가격</th>
							<td><input type="text" name="price" class="forminput requiredInfo" />
								<span class="error">필수입력</span></td>
						</tr>
						
						<tr>
							<th>색상</th>
							<td><input type="text" name="color" class="forminput requiredInfo" />
								<span class="error">필수입력</span></td>
						</tr>
						
						<tr>
							<th>입고일자</th>
							<td><input type="text" name="stockdate"
								class="forminput requiredInfo" id="stockdate" size="33"
								placeholder="클릭해서 입고일자를 입력해주세요"
								style="max-width: 250px; width: 80%;" class="hasDatepicker"
								readonly>
								<span class="error">필수입력</span></td>
						</tr>
						
						<tr>
							<th>재고량</th>
							<td>&nbsp;<input type="text" id="spinnerPqty" name="pqty" value="1" style="width:30px;" class="requiredInfo" />
								<span class="error">필수입력</span></td>
						</tr>
						
						<tr>
							<th>제품 요약</th>
							<td>
								<textarea name="productSummary" class="forminput requiredInfo" cols="60"
								style="width: 80%; height: 40px"></textarea>
								<span class="error">필수입력</span>
							</td>
						</tr>
						
						<tr>
							<th>제품 설명</th>
							<td>
								<textarea name="productInfo" class="forminput requiredInfo" cols="60" 
								style="width: 80%; height: 100px"></textarea>
								<span class="error">필수입력</span>
							</td>
						</tr>
						
						<%-- ==== 첨부파일 타입 추가하기 ==== --%>
						<tr>
							<th>추가 이미지 파일</th>
							<td><label for="spinnerImgQty" style="font-size: 0.9rem; width:70px;">파일수 : </label>
							<input id="spinnerImgQty" value="0" class="forminput requiredInfo" style="display: inline; width: 40px; height: 20px;">
							<div id="divfileattach"></div> 
							<input type="hidden" name="attachCount" id="attachCount" />
							<small style="color:#0058AB;">추가 이미지는 2개 이상 첨부해주세요.</small>
							<span class="error">필수첨부</span>
							</td>
						</tr>
						

					</tbody>
				</table>
				<br><br>
				<div class="updateprogress">
					<div class="submitORnot" style="margin-top: 2vw;">
					<input type="button" value="제품 등록" id="btnRegister" class="mybtn_black"
					style="margin-top: 3%; margin: 3% auto;"></button>
					<input type="reset" value=" 취소 " class="mybtn_black"
					style="margin-top: 3%; margin: 3% auto;"></button>
				</div>
			</div>
			</form>
		</div>
</div>

<!-- 줄 띄우기 용 -->
<br><br><br><br><br>
<jsp:include page="../../footer.jsp" />