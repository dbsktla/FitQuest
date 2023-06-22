<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<center>
 <body class="detail-body">
	<div class="detail-title">
		<div class="detail-title-font">아이콘 설명</div>
	</div> 
	<div class="detail-container">
		<table width="100%" align="center" border="0">
			<tr class="tr">
				<td class="sub-title-i">
					<img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="30px" class="icon-i">
					예약 전체 마감
				</td>
				<td class="sub-text">
					예약이 전체 마감 되었습니다. (단체/개인)
				</td>
			</tr>
			<tr class="tr">
				<td class="sub-title-i">
					<img src="<%=request.getContextPath()%>/resources/Icon/impossible-already.png" width="30px" class="icon-i">
					다른 사용권에서 예약
				</td>
				<td class="sub-text">
					다른 사용권에서 해당 날짜/시간에 이미 예약했습니다.
				</td>
			</tr>
			<tr class="tr">
				<td class="sub-title-i">
					<img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="30px" class="icon-i">
					예약 가능
				</td>
				<td class="sub-text">
					예약 가능합니다.
				</td>
			</tr>
			<tr class="tr">
				<td class="sub-title-i">
					<img src="<%=request.getContextPath()%>/resources/Icon/already.png" width="30px" class="icon-i">
					예약 신청
				</td>
				<td class="sub-text">
					예약 신청은 완료되었지만, 아직 승인 전입니다.
				</td>
			</tr>
			<tr class="tr">
				<td class="sub-title-i">
					<img src="<%=request.getContextPath()%>/resources/Icon/notFull.png" width="30px" class="icon-i">
					예약 완료
				</td>
				<td class="sub-text">
					예약은 완료되었지만, 단체 수업의 경우에 전체 마감되진 않았습니다.
				</td>
			</tr>
			
		</table>
	</div>
 </body>
</center>