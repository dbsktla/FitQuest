<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<center>
 <body class="detail-body">
	<div class="detail-title">
		<div class="detail-title-font">예약 상세 내역</div>
	</div> 
	<div class="detail-name-box">
		 <span class="calender-text">${reservationDetailBean.name} 트레이너님</span><span class="calender-text-id">(${reservationDetailBean.id})</span>
	</div>
		<div class="detail-container">
			<table width="100%" align="center" border="0">
				<tr class="tr">
					<td class="sub-title">예약 날짜</td>
					<td class="sub-text"><span>${reservationDetailBean.rdate}</span></td>
				</tr>
				<tr class="tr">
					<td class="sub-title">예약 시간</td>
					<td class="sub-text"><span>${reservationDetailBean.rtime}</span></td>
				</tr>
				<tr class="tr">
					<td class="sub-title">전화번호</td>
					<td class="sub-text"><span>${birthday}</span></td>
				</tr>
				<tr class="tr">
					<td class="sub-title">운동 종류</td>
					<td class="sub-text"><span>${mphone}</span></td>
				</tr>
				<tr class="tr">
					<td class="sub-title">헬스장</td>
					<td class="sub-text"><span>${mphone}</span></td>
				</tr>
				<tr class="tr">
					<td class="sub-title">헬스장 번호</td>
					<td class="sub-text"><span>${mphone}</span></td>
				</tr>
				<tr class="tr">
					<td class="sub-title-last">헬스장 주소</td>
					<td class="sub-text-last"><span>${reservationDetailBean.email}</span></td>
				</tr>
			
			</table>
		</div>
 </body>
</center>