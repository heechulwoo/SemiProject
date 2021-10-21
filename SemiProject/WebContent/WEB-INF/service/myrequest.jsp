<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>


<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/myrequest.css" />

<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 제이쿼리 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<jsp:include page="../header.jsp" />

<title>나의 문의·신청 간편조회</title>

<body>
	<div class="mycontainer">
		<h2 class="menu-title">
			<b>나의 문의 및 신청 간편조회</b>
		</h2>
		<div class="accordion js-accordion">
			<div class="accordion__item js-accordion-item active">
				<div class="accordion-header js-accordion-header"
					style="font-size: large">나의 문의</div>	
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
					
						<div class="accordion__item js-accordion-item">
						<c:set var="asklist" value="${requestScope.askList}"></c:set>
						<c:choose>	
							<c:when test="${empty asklist}">
							<div style="padding:3%; color:#484848;"><b>문의 내역이 없습니다.</b></div>
							</c:when>
							<c:otherwise>
							
							<c:forEach var="ask" items="${requestScope.askList}">

								<div class="accordion-header js-accordion-header" style="color:#484848; padding-left: 5%;">
								${ask.asktitle}
								</div>
							
								<div class="accordion-body js-accordion-body" style="padding-left: 4%;">
									
									<div class="accordion-body__contents" style="padding: 5%;">
										
												${ask.askcontent}<br><br>
												<small>${ask.askdate}</small>
																			
						
										<hr style="border-top: 1px solid black; margin: 40px 0px;" >
										
										<c:choose>
											<c:when test="${not fn:contains(ask.answertitle, 0)}">
														<div>
															<div style="margin-bottom: 2%;"><b>${ask.answertitle}</b></div>
															<div style="margin-bottom: 2%;">${ask.answercontent}</div>
															<div style="margin-bottom: 2%;"><small>${ask.answerdate}</small></div>
														</div>
											</c:when>
										
											<c:otherwise>
												<div><b>아직 답변이 등록되지 않았습니다. 조금만 기다려주세요.</b></div><br>
												<div style="margin-bottom: 5%;"><small>${ask.answerdate}</small></div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>	
							</c:forEach>	
						</c:otherwise>
					</c:choose>	
				
					</div>
					<!-- end of sub accordion item -->
				</div>
				<!-- end of sub accordion -->
			</div>
			<!-- end of accordion body -->	
		</div>
		<!-- end of accordion item -->
			
			<div class="accordion__item js-accordion-item">
				<div class="accordion-header js-accordion-header"
					style="font-size: large">나의 환불신청</div>	
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
					
						<div class="accordion__item js-accordion-item">
						<c:set var="returnlist" value="${requestScope.returnList}"></c:set>
						
						<c:choose>	
							<c:when test="${empty returnlist}">
							<div style="padding:3%; color:#484848;"><b>신청 내역이 없습니다.</b></div>
							</c:when>
							<c:otherwise>
							
							<c:forEach var="self" items="${requestScope.returnList}">

								<div class="accordion-body__contents" style="color:#484848; padding-left:3%; background-color: white;">
									
									<div><b>주문번호:&nbsp; ${self.fk_odrcode}</b></div><br>
									<span>구입처:&nbsp; ${self.wherebuy}&nbsp;</span>&nbsp;&nbsp;
									<span>반품신청일:&nbsp;${self.returndate}&nbsp;<span>&nbsp;&nbsp;
									
									<c:choose>
										<c:when test ="${self.status eq 0}">
											<span>진행상태:&nbsp; <b><span>신청완료</span></b> &nbsp;</span>&nbsp;&nbsp;
										</c:when>
										<c:when test ="${self.status eq 1}">
											<span>진행상태:&nbsp; <b><span style="color:red;">반품취소</span></b> &nbsp;</span>&nbsp;&nbsp;
										</c:when>
										<c:when test ="${self.status eq 2}">
											<span>진행상태:&nbsp; <b><span style="color: #0058AB;">반품완료</span></b> &nbsp;</span>&nbsp;&nbsp;
										</c:when>
									</c:choose>
									
									<hr style="border-top: 1px solid black; margin: 20px 0px;" >
								</div>

							</c:forEach>	
						</c:otherwise>
					</c:choose>	
				
					</div>
					<!-- end of sub accordion item -->
					</div>
					<!-- end of sub accordion -->
				</div>
				<!-- end of accordion body -->
				
			</div>
			<!-- end of accordion item -->
			<div class="accordion__item js-accordion-item">
				<div class="accordion-header js-accordion-header"
					style="font-size: large">나의 조립서비스 신청</div>	
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
					
						<div class="accordion__item js-accordion-item">
						<c:set var="assemblelist" value="${requestScope.assembleList}"></c:set>
						
						<c:choose>	
							<c:when test="${empty assemblelist}">
							<div style="padding:3%; color:#484848;"><b>신청 내역이 없습니다.</b></div>
							</c:when>
							<c:otherwise>
							
							<c:forEach var="assemble" items="${requestScope.assembleList}">
								<div class="accordion-body__contents" style="color:#484848; padding-left:3%; background-color: white;">
									
									<div><b>주문번호:&nbsp; ${assemble.fk_odrcode}</b></div>
									<span>신청일자:&nbsp; ${assemble.assembledate}</span><br><br>
									
									<span>연락처:&nbsp; ${fn:substring(assemble.mobile, 0,3)} - ${fn:substring(assemble.mobile, 3,7)} - ${fn:substring(assemble.mobile, 7,11)}&nbsp;</span><br>
									<span>주소:&nbsp;&nbsp;[${assemble.postcode}]&nbsp;${assemble.address}&nbsp;${assemble.detailaddress}
										<c:if test="${not empty assemble.extraaddress}">
										&nbsp;${assemble.extraaddress}
										</c:if></span><br>
									<span>희망일자:&nbsp; ${assemble.hopedate}&nbsp;
									<c:if test="${not empty assemble.hopehour}">
										&nbsp;${assemble.hopehour}
										</c:if></span><br><br>
									<c:choose>
										<c:when test ="${assemble.progress eq 0}">
											<span>진행상태:&nbsp; <b><span>접수완료</span></b> &nbsp;</span>&nbsp;&nbsp;
										</c:when>
										<c:when test ="${assemble.progress eq 1}">
											<span>진행상태:&nbsp; <b><span style="color:red;">신청취소</span></b> &nbsp;</span>&nbsp;&nbsp;
										</c:when>
										<c:when test ="${assemble.progress eq 2}">
											<span><b>진행상태:&nbsp;<span style="color: #0058AB;">완료</span></b> &nbsp;</span>&nbsp;&nbsp;
										</c:when>
									</c:choose>
									
									<hr style="border-top: 1px solid black; margin: 20px 0px;" >
								</div>

							</c:forEach>	
						</c:otherwise>
					</c:choose>	
						</div>
						<!-- end of sub accordion item -->
					</div>
					<!-- end of sub accordion -->
				</div>
				<!-- end of accordion body -->
				
			</div>
			<!-- end of accordion item -->
			
			
			
			
		</div>
		<!-- end of accordion -->
	</div>
</body>

<jsp:include page="../footer.jsp"/>

<!-- 아코디언 동작 -->
<script>
	var accordion = (function() {
		var $accordion = $(".js-accordion");
		var $accordion_header = $accordion.find(".js-accordion-header");
		var $accordion_item = $(".js-accordion-item");

		// default settings
		var settings = {
			// animation speed
			speed : 400,

			// close all other accordion items if true
			oneOpen : false,
		};

		return {
			// pass configurable object literal
			init : function($settings) {
				$accordion_header.on("click", function() {
					accordion.toggle($(this));
				});

				$.extend(settings, $settings);

				// ensure only one accordion is active if oneOpen is true
				if (settings.oneOpen
						&& $(".js-accordion-item.active").length > 1) {
					$(".js-accordion-item.active:not(:first)").removeClass(
							"active");
				}

				// reveal the active accordion bodies
				$(".js-accordion-item.active").find("> .js-accordion-body")
						.show();
			},
			toggle : function($this) {
				if (settings.oneOpen
						&& $this[0] != $this
								.closest(".js-accordion")
								.find(
										"> .js-accordion-item.active > .js-accordion-header")[0]) {
					$this.closest(".js-accordion").find("> .js-accordion-item")
							.removeClass("active").find(".js-accordion-body")
							.slideUp();
				}

				// show/hide the clicked accordion item
				$this.closest(".js-accordion-item").toggleClass("active");
				$this.next().stop().slideToggle(settings.speed);
			},
		};
	})();

	$(document).ready(function() {
		accordion.init({
			speed : 300,
			oneOpen : true
		});
	});
</script>


