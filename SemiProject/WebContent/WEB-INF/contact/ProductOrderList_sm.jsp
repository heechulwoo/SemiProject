<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	//     /MyMVC
%>

<jsp:include page="../header.jsp"/>


<style type="text/css">

	div#orderTitle {
	  padding-top: 70px;
	  padding-bottom: 50px;
	  border-bottom: solid 1px gray;
	}
	
	form#orderFrm {
		padding-top: 70px;
		text-align: center;
	}
	
	table#orderTbl {
	  width: 93%;
	  border: solid 1px gray;
	  margin: 10px;
	  text-align: center;
	}

	button#goSearchBtn {
	  width: 10em;
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
	
	button#goSearchBtn:hover {
	  opacity: 0.8;
	  text-decoration: none;
	}
	
	tr.productOrderInfo:hover{
		background-color: #f2f2f2;
		cursor: pointer;
	}
        
    </style>
    
    
<script type="text/javascript">
	
	
	$(document).ready(function() {
		
		if("${requestScope.searchWord}" != "") {
			// ""(공백)이 아닌 경우에만 넣어주겠다, 공백(또는 입력 안 한 경우)인 경우 무시
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
			
			
		
		// *** select 태그에 대한 이벤트는  click 이 아니라 change 이다. *** // 
		$("select#sizePerPage").bind("change", function() {
			goSearch();
		});
		
		if("${requestScope.sizePerPage}" != "") {
			$("select#sizePerPage").val("${requestScope.sizePerPage}");  // select 태그의 회원명수를 받아온 값으로 넣어주자
		}
		
		$("input#searchWord").bind("keyup", function(event) {
			if(event.keyCode == 13){ // 검색어에서 엔터를 하면 검색하러 가도록 한다.
				goSearch();
			}
		});
		
		$("button#goSearchBtn").bind("onClick", function(event) {
			
				goSearch();
			
		});
		
		
		// 특정 주문내역을 클릭하면 그 글의 상세내용을 보여주도록 하자(상세내용에서 배송 상태 바꿀 것)
		$("tr.productOrderInfo").click(function() {
			
			var fk_userid = $(this).children(".fk_userid").text();
			var odrcode = $(this).children(".odrcode").text(); 
			
			location.href="<%= ctxPath%>/contact/productOrderOneDetail.one?fk_userid="+fk_userid+"&odrcode="+odrcode+"&goBackURL=${requestScope.goBackURL}";
			// 위치이동을 의미 (=> location.href)
			
			
		});
		
		
	});// end of $(document).ready(function(){})---------------------------------------
		
	
	// Function Declaration
	
	
	function goSearch() {
		
		// === 필요한 것만 땡겨오기 (폼태그에 있는 벨류를 보내줌) === // 
		
		var frm = document.orderFrm;
		frm.action = "productOrderList.one";
		frm.method = "GET";
		frm.submit();
		
	}// end of function goSearch(){}------------------------------------------
	  
    
</script>

<div class="container">
	
	<!-- 이케아 주문 리스트 시작 -->
		<div id="orderTitle" class="col-md-auto">
		  <h1 style="font-weight: bold">주문내역 리스트</h1>
		  <br>
		  <p>
		   	주문한 회원 목록입니다.<br>
		   	클릭 시 , 주문 상세 내역을 조회할 수 있습니다.
		  </p>
		  <br>
		</div>
	<!-- 이케아 주문 리스트 끝 -->
	
	
		<%-- 주문 리스트 상단 검색 및 페이지 조절 끝 --%>
		
		<form name="orderFrm" id="orderFrm" class="col-md-auto">
			
		  <select id="searchType" name="searchType" style="margin-right: 30px;">  <!-- name이 DB에 들어가는 것과 같은지 꼭 유의 -->
	         <!-- <option value="name">회원명</option> -->
	         <option value="fk_userid">아이디</option>
	         <option value="odrcode">주문번호</option>
	      </select>
	      <input type="text" size="30" id="searchWord" name="searchWord" style="margin-right: 30px;" />
	      
	      <%-- form 태그내에서 전송해야할 input 태그가 만약에 1개 밖에 없을 경우에는 유효성검사가 있더라도 
		                유효성 검사를 거치지 않고 막바로 submit()을 하는 경우가 발생한다.
		                이것을 막아주는 방법은 input 태그를 하나 더 만들어 주면 된다. 
		                그래서 아래와 같이 style="display: none;" 해서 1개 더 만든 것이다. 
	      --%>
	      <input type="text" style="display: none;"/> <%-- 조심할 것은 type="hidden" 이 아니다. --%> 
	      
	      <button type="button" id="goSearchBtn" class="btn" onclick="goSearch();" style="margin-right: 40px;">검색</button>
	      
	      <span style="font-weight: bold; font-size: 10pt;">페이지 당 회원명수 : </span>
	      <select id="sizePerPage" name="sizePerPage"> <!-- name이 DB에 들어가는 것과 같은지 꼭 유의 -->
	         <option value="10">10</option>
	         <option value="5">5</option>
	         <option value="3">3</option>
	      </select>
		</form>
		
		<%-- 주문 리스트 상단 검색 및 페이지 조절 끝 --%>
		
		
		<%-- 주문 리스트 테이블 시작 --%>
		<table id="orderTbl" class="table table-bordered col-md-auto" style="width: 90%; margin-top: 35px;">
	        <thead>
	           <tr>
	           	  <th>주문번호</th>
	           	  <th>아이디</th>
	              <th>주문총액</th>
	              <th>주문일자</th>
	           </tr>
	        </thead>
	        
	        <%-- 반복문으로 주문 리스트 뽑아오기 --%>
	        <tbody>
	        	<c:forEach var="ovo" items="${requestScope.orderList}">
	        		<tr class="productOrderInfo">
	        			<td class="odrcode">${ovo.odrcode}</td>
	        			<td class="fk_userid">${ovo.fk_userid}</td>
	        			<td>${ovo.odrtotalprice}</td>
	        			<td>${ovo.odrdate}</td>
	        		</tr>
	        	</c:forEach>
	        </tbody>
	    </table>    
	    
	    <nav class="my-5">
	    	<div style="display: flex; width: 90%;">  <!--  가운데 맞춤 -->
	    		<ul class="pagination" style="margin: auto;"> ${requestScope.pageBar}</ul>
	    	</div>
	    </nav>
	
	<%-- 셀프 반품 회원 리스트 테이블 시작 --%>

</div>
	
<!-- container 끝 -->



<!-- 줄 띄우기 용 -->
<br><br><br><br><br> 

<jsp:include page="../footer.jsp"/>    