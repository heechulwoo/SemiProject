<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<title>자주 묻는 질문</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" href="../css/faq.css" />

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

<body>
	<div class="mycontainer">
		<h2 class="menu-title">
			<b>자주 묻는 질문</b>
		</h2>
		<div class="accordion js-accordion">
			<div class="accordion__item js-accordion-item">
				<div class="accordion-header js-accordion-header"
					style="font-size: large">결제</div>
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인 구매 시
								어떤 결제수단을 쓸 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									온라인 구매 가능한 결제수단: <br /> -신용카드<br /> -체크카드<br /> -카카오페이 외
									간편결제 수단<br />
									<br /> *해외 발행 카드의 경우 VISA, MASTER 카드를 사용하실 수 있습니다. <br />
									<br />
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인 구매 시
								신용카드의 할부 결제가 가능한가요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									온라인 구매 시 신용카드 할부 거래가 가능합니다. 단, 해외 발행 카드는 할부 거래가 되지 않아요.<br />
									신용카드 할부 거래 안내는 이니시스 결제화면에서 확인하실 수 있습니다.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인 구매 시
								여러 가지 결제수단을 복합하여 결제할 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">온라인 구매 시 복합결제는 지원되지
									않습니다.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">이미 주문을
								완료했는데, 결제 수단을 변경할 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">이미 주문이 완료된 경우 결제 수단
									변경이 어렵습니다. 결제 수단을 변경하시려면 주문을 취소하신 후 재결제를 하셔야 합니다.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">세금계산서 등
								사업자용으로 별도의 서류를 받을 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">저희는 세금계산서를 발행해 드리지
									않고 있습니다. 온라인 결제 후 메일로 카드 매출 전표와 주문서를 전송받을 수 있습니다.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">결제할 때
								공인인증서가 필요한가요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									일정 금액 이상 결제 시 공인인증서가 필요할 수 있으나, 일반적으로 카드사에서 제공하는 결제수단(앱카드, ISP
									결제 등)을 통해 결제하시는 경우에는 공인인증서가 필요하지 않습니다.<br /> 결제 창에서 사용하고자 하는
									카드를 선택하신 후에 결제가 잘 진행되지 않는다면 해당 카드사에 문의해주시기 바랍니다.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인 구매 시
								신용카드의 할부 결제가 가능한가요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									온라인 구매 시 신용카드 할부 거래가 가능합니다. 단, 해외 발행 카드는 할부 거래가 되지 않아요.<br />
									신용카드 할부 거래 안내는 이니시스 결제화면에서 확인하실 수 있습니다.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">신용카드 결제 후
								주문 취소했는데, 언제 환불되나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">주문을 취소하신 날로부터 3일 이내에
									승인 취소가 진행되며, 승인 취소 후 카드사 매출 취소까지는 이용하시는 카드사에 따라 최대 7일 정도 소요됩니다.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
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
					style="font-size: large">계정</div>
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">개인정보,
								연락처, 비밀번호, 주소를 변경할 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									웹사이트에 로그인하여 회원 정보를 변경할 수 있어요. 변경이 어려우시다면, 이케아 고객지원센터에서 회원정보 변경을
									도와드릴 수 있습니다. (단, 비밀번호 변경 제외)<br />
									<br /> <a href="<%= ctxPath%>/member/mypage.one" class="adeco">내 프로필 바로가기</a>
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">비밀번호를
								잃어버렸어요.</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									로그인 화면에서 '비밀번호 찾기' 기능을 이용해 보세요. 가입하신 이메일 계정으로 인증 메일이 발송되며 재설정하실
									수 있습니다.<br /> 만약, 메일 수신이 어렵거나, 비밀번호 재설정 방법이 어려우시다면 고객지원센터로
									문의해주세요.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">회원 탈퇴 방법이
								궁금해요.</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									로그인 후 [내 프로필] - [설정] 탭의 회원 탈퇴 항목에서 계정 삭제가 가능합니다. 탈퇴 후에는 계정의
									개인정보가 모두 삭제 됩니다. <br />
									<br /> 그러나 언제든지 다시 가입하실 수 있어요!
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">비회원으로도
								온라인 구매를 할 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">비회원은 온라인 구매가 불가능합니다.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">나의 온라인
								주문내역은 어디에서 확인할 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">웹사이트에 로그인 하신 후, '마이페이지'에 들어가면 
								'주문조회'메뉴가 있습니다. 또는, 웹사이트의 '고객지원 - '배송조회 및 관리' 페이지에서
									온라인 주문내역을 확인하실 수 있습니다.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">계정이 삭제되기도
								하나요? 삭제되는 기준이 있다면 알려주세요.</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">1년간 미 로그인시 휴면계정으로
									전환됩니다. 휴면 계정 사용을 원하시면 로그인 화면에서 비밀번호 찾기 기능을 이용해주세요.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
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
					style="font-size: large">배송</div>
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인 구매 시
								배송이 가능한 지역과 배송비를 알고 싶어요.</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									온라인 구매시 제주도를 포함한 전국으로 배송을 해드립니다. 다만, 육로로 연결되어 있지 않은 섬 지역으로의 배송은
									어렵습니다.<br /> 배송비는 주문하실 때 확인하실 수 있어요.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">배송업체를 제가
								지정할 수 있나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">아니요, 배송업체 지정은
									불가능합니다. 지정된 배송업체를 통해 배송해 드립니다.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">결제자와 배송받는
								사람이 달라도 괜찮나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">결제자와 배송받는 사람이 달라도
									주문하실 수 있어요. 배송지 입력란에 배송받으실 분의 이름과 연락처, 주소를 입력하시면 됩니다.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->

						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">택배 주문의
								운송장 번호를 알고 싶어요.</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									웹사이트의 '고객지원' - '배송조회' 페이지에서 주문 정보를 입력하신 후 '배송 상태 확인하기'를 통해 운송장
									번호를 확인하실 수 있습니다.<br /> 운송장 번호는 제품이 배송사로 인계된 이후부터 확인됨을 참고해 주세요.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
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
					style="font-size: large">쇼핑방법</div>
				<div class="accordion-body js-accordion-body">
					<div class="accordion js-accordion">
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인과 매장에서
								같은 가격으로 판매되나요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									매장별 이벤트에 따라 제품의 할인 여부가 달라지기에 온라인과 가격이 다를 수 있습니다.<br /> 운영하는
									매장들은 매장별로 이벤트나 프로모션을 운영하고 있습니다.<br /> 아래에서 방문을 원하는 매장을 찾아 다양한
									매장별 프로모션 및 이벤트 정보를 만나보세요.<br />
									<br /> <a href="<%= ctxPath%>/contact/stores.one" class="adeco">매장 안내</a><br />
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end o>온라인 프로모션accordion item body contents -->
						</div>
						<!-- end of sub accordion item body -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">재고가 없는
								제품에 대한 주문이 가능할까요?</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">재고가 없는 제품은 온라인 구매가 
								비활성화되어  구매하실 수 없습니다. 관련해서 문의신청서를 작성해주시면 재입고 여부를 알려드릴게요.</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
						</div>
						<!-- end of sub accordion item -->
						<div class="accordion__item js-accordion-item">
							<div class="accordion-header js-accordion-header">온라인 쇼핑 이용
								중 인터넷 익스플로러에서 오류가 발생해요.</div>
							<div class="accordion-body js-accordion-body">
								<div class="accordion-body__contents">
									만약 "인터넷 익스플로러(Internet Explorer)" 웹브라우저에서 오류가 발생한다면, 모바일 및 PC에서
									"크롬(Chrome)"혹은 "사파리(Safari)"웹브라우저를 설치해 이용해 보세요.<br /> 또는, 이용
									중인 웹브라우저의 데이터와 캐시를 삭제 후 재시도 해보시기 바랍니다.
								</div>
								<!-- end of sub accordion item body contents -->
							</div>
							<!-- end of sub accordion item body -->
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


