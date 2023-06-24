<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<script type="text/javascript">
	function openPopup(rnum, rstate) {
		// 팝업 창의 URL과 창의 속성을 설정
		var url = "genericCalendarDetail.rv?rnum=" + rnum;
		var width = 700; // 팝업 창의 너비
		var height = 620; // 팝업 창의 높이
		var left = (window.screen.availWidth - width) / 2; // 화면 중앙에 위치하도록 좌표 계산
		var top = (window.screen.availHeight - height) / 2;
		
		var popup = window.open(url, "_blank", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
		
		// 팝업 창이 로드된 후에 닫기 버튼 추가
		popup.onload = function () {
			 var closeButton = popup.document.createElement("button");
			 closeButton.innerText = "닫기";
			 closeButton.classList.add("close-button");
			 closeButton.addEventListener("click", function () {
				popup.close(); // 팝업 창 닫기
			 });
		
			// 예약 상태가 true라면 예약 취소 버튼 추가(예약 확정은 되었지만 운동 완료하지 않은 상태)
			if (rstate == "true") {
				var cancelButton = popup.document.createElement("button");
				cancelButton.innerText = "예약 취소";
				cancelButton.classList.add("close-button");
				cancelButton.addEventListener("click", function () {
					var confirmCancel = popup.confirm("예약을 취소하시겠습니까?");
				
					if (confirmCancel) {
						popup.alert("예약 취소 완료되었습니다.");
						popup.close(); // 팝업 창 닫기
						window.location.href = "reservationCancel.rv?rnum=" + rnum;
					}
			  });
			
				// 버튼 간격 조절
				cancelButton.style.marginRight = "10px";
				
				popup.document.body.appendChild(cancelButton);
				closeButton.focus();
			}
			
			popup.document.body.appendChild(closeButton);
			closeButton.focus();
		};
	}
</script>
<style>
	.card{
		box-shadow: 0 1px 7px rgba(0, 0, 0, 0.2);
		border: none !important;
	}
	tr.clickable-row:hover {
        cursor: pointer;
        cursor: hand;
    }
</style>
<body style="background-color: #FEF9E7;">
<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<div class="calendarTitle-font">예약 내역</div>
</div> 
<div class="container">
	<div class="stateList-title"><span>예정된 예약</span></div>
	<div class="card" style="width: 68%; margin: auto;">
		<div class="card-body">
			<table class="table table-hover">
				<tr align="center">
					<th scope="col">날짜</th>
					<th scope="col">시간</th>
					<th scope="col">트레이너</th>
				</tr>
				<c:forEach var="aitem" items="${aList}">
					<c:if test="${aitem.rstate == 'true'}">
						<tr align="center" onclick="openPopup('${aitem.rnum}','${aitem.rstate}'); return false;" class="clickable-row">
							<td>${aitem.rdate}</td>
							<td>${aitem.rtime}</td>
							<td>${aitem.tname}</td>
						</tr>
						<c:set var="tdata" value="true" />
					</c:if>
				</c:forEach>		
				<c:if test="${not tdata}">
					<tr align="center">
						<td colspan="4">예정된 예약이 없습니다.</td>
					</tr>
				</c:if>
			</table>
			
		</div>
	</div>
</div>
<div class="container m-top">
	<div class="stateList-title"><span>승인전 예약</span></div>
	<div class="card" style="width: 68%; margin: auto;">
		<div class="card-body">
			<table  class="table table-hover">
				<tr align="center">
					<th scope="col">날짜</th>
					<th scope="col">시간</th>
					<th scope="col">트레이너</th>
				</tr>
				<c:forEach var="aitem" items="${aList}">
					<c:if test="${aitem.rstate == 'false'}">
						<tr align="center" onclick="openPopup('${aitem.rnum}','${aitem.rstate}'); return false;" class="clickable-row">
							<td>${aitem.rdate}</td>
							<td>${aitem.rtime}</td>
							<td>${aitem.tname}</td>
						</tr>
						<c:set var="fdata" value="true" />
					</c:if>
				</c:forEach>		
				<c:if test="${not fdata}">
					<tr align="center">
						<td colspan="4">미승인된 예약이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
<div class="container m-top">
	<div class="stateList-title"><span>거절된 예약</span></div>
	<div class="card" style="width: 68%; margin: auto;">
		<div class="card-body">
			<table  class="table table-hover">
				<tr align="center">
					<th scope="col">날짜</th>
					<th scope="col">시간</th>
					<th scope="col">트레이너</th>
				</tr>
				<c:forEach var="aitem" items="${aList}">
					<c:if test="${aitem.rstate == 'reject'}">
						<tr align="center" onclick="openPopup('${aitem.rnum}','${aitem.rstate}'); return false;" class="clickable-row">
							<td>${aitem.rdate}</td>
							<td>${aitem.rtime}</td>
							<td>${aitem.tname}</td>
						</tr>
						<c:set var="jdata" value="true" />
					</c:if>
				</c:forEach>		
				<c:if test="${not jdata}">
					<tr align="center">
						<td colspan="4">거절된 예약이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
<div class="container m-top">
	<div class="stateList-title"><span>취소된 예약</span></div>
	<div class="card" style="width: 68%; margin: auto;">
		<div class="card-body">
			<table  class="table table-hover">
				<tr align="center">
					<th scope="col">날짜</th>
					<th scope="col">시간</th>
					<th scope="col">트레이너</th>
				</tr>
				<c:forEach var="aitem" items="${aList}">
					<c:if test="${aitem.rstate == 'cancel'}">
						<tr align="center" onclick="openPopup('${aitem.rnum}','${aitem.rstate}'); return false;" class="clickable-row">
							<td>${aitem.rdate}</td>
							<td>${aitem.rtime}</td>
							<td>${aitem.tname}</td>
						</tr>
						<c:set var="cdata" value="true" />
					</c:if>
				</c:forEach>		
				<c:if test="${not cdata}">
					<tr align="center">
						<td colspan="4">취소된 예약이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
<div class="container m-top">
	<div class="stateList-title"><span>완료된 예약</span></div>
	<div class="card" style="width: 68%; margin: auto;">
		<div class="card-body">
			<table  class="table table-hover">
				<tr align="center">
					<th scope="col">날짜</th>
					<th scope="col">시간</th>
					<th scope="col">트레이너</th>
				</tr>
				<c:forEach var="aitem" items="${aList}">
					<c:if test="${aitem.rstate == 'complete'}">
						<tr align="center" onclick="openPopup('${aitem.rnum}','${aitem.rstate}'); return false;" class="clickable-row">
							<td>${aitem.rdate}</td>
							<td>${aitem.rtime}</td>
							<td>${aitem.tname}</td>
						</tr>
						<c:set var="mdata" value="true" />
					</c:if>
				</c:forEach>		
				<c:if test="${not mdata}">
					<tr align="center">
						<td colspan="4">완료된 예약이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
</body>
<%@ include file="../common/bottom.jsp" %>