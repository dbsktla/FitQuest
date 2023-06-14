<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<br><br>
<center>
<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<div class="calendarTitle-font">예약 내역</div>
	<div class="calendarSubtitle-font"><span>승인 완료</span></div>
</div> 
<div>
	<table border="1">
		<tr>
			<td>날짜</td>
			<td>시간</td>
			<td>트레이너</td>
			<td>상태</td>
		</tr>
		<c:forEach var="tList" items="${tList}">
		  <tr>
			<td>${tList.rdate}</td>
			<td>${tList.rtime}</td>
			<td>${tList.tname}</td>
			<td>	
			</td>
		  </tr>
		</c:forEach>
	</table>
</div>
</center>
<%@ include file="../common/bottom.jsp" %>












