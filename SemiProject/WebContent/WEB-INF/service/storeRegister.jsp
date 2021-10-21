<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../header.jsp" />

<!-- 달력 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>매장 등록</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/assemble_form.css" />

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		
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
				
				
			if(!flag){
				var frm = document.storeInputFrm;
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


<style>
td{
padding: 0 0 0 3%;
border-bottom: 2px solid #F7F7F8;
}

th{
text-align: center;
}

</style>

<!-- 다음 주소 찾기 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {

		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("detailAddress").value = extraAddr;

				} else {
					document.getElementById("detailAddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("extraAddress").focus();
			}
		}).open();
	}
</script>

<body>
	<div class="mycontainer" data-theme="a">
		<h1 class="main-title">IKEA 신매장 등록</h1>
		<hr />
		<div class="wrapper" style="margin-top: 5%;">
		<small style="display:inline-block; margin:auto; padding:1%; color:#0058AB;">※ 모든 필드는 필수 입력입니다.</small>
			<%-- !!!!! ==== 중요 ==== !!!!! --%>
			<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     		enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
			<form name="storeInputFrm"
				action="<%=request.getContextPath()%>/service/storeRegister.one"
				method="POST" enctype="multipart/form-data">

				<table id="tblstoreInput" class="formtable">
					<tbody>
						<tr>
							<th style="border-top: 2px solid #0058AB;" >매장이름</th>
							<td style="border-top: 2px solid lightgray;">
							<input type="text" name="storename" class="forminput requiredInfo" />
							<span class="error">필수입력</span>
							</td>
						</tr>

						<tr>
								<th>매장 주소</th>
							<td>
								<input type="text" id="postcode" name="postcode" class="forminput requiredInfo" readonly> 
								<span class="error">필수입력</span>
								<input type="button" class="mybtn" name="searchpost" onclick="execDaumPostcode()" value="우편번호 찾기";><br>
								<input type="text" id="address" name="address" class="forminput" readonly>
								<span class="error">필수입력</span>
								<small> - 우편번호 찾기로 주소를 입력해주세요. </small> <br>
								<input type="text" id="detailAddress" name="detailAddress" class="forminput" readonly> 
								<input type="text" id="extraAddress"  name="extraAddress" class="forminput">
							</td>
						</tr>

						<tr>
							<th>매장 대표 이미지</th>
							<td>
								<input type="file" name="storeimage" class="forminput requiredInfo " />
								<span class="error">필수입력</span> 
							</td>
						</tr>
						
						<tr>
							<th>매장 운영시간</th>
							<td>
							<input type="time" name="openinghour" class="forminput requiredInfo" />
							<span class="error">필수입력</span>
							</td>
						</tr>
						
						<tr>
							<th>레스토랑 운영시간</th>
							<td><input type="time" name="restaurant" class="forminput requiredInfo" />
								<span class="error">필수입력</span></td>
						</tr>
					</tbody>	
				</table>
				<br><br>
			<div class="updateprogress" style="text-align: center;">
				<div class="submitORnot" style="margin-top: 2vw; display:inline-block; margin:auto;">
					<input type="button" value="매장 등록" id="btnRegister" class="mybtn_black">
					<input type="reset" value=" 취소 " class="mybtn_black">
				</div>
			</div>
			</form>
		</div>
</div>

<!-- 줄 띄우기 용 -->
<br><br><br><br><br>
<jsp:include page="../footer.jsp" />