<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<center>
 <body class="detail-body">
	<div class="detail-title">
		<div class="detail-title-font">예약 상세 내역</div>
	</div> 
<c:forEach var="ritem" items="${rList}">
    <div class="detail-name-box">
        <span class="calender-text">${ritem.name}님</span>
        <span class="calender-text-id">(${ritem.id})</span>
    </div>
    <div class="detail-container">
        <table width="100%" align="center" border="0">
            <tr class="tr">
                <td class="sub-title">예약 날짜</td>
                <td class="sub-text"><span>${ritem.rdate}</span></td>
            </tr>
            <tr class="tr">
                <td class="sub-title">예약 시간</td>
                <td class="sub-text"><span>${ritem.rtime}</span></td>
            </tr>
            <tr class="tr">
                <td class="sub-title">생년월일</td>
                <td class="sub-text"><span>${ritem.birth}</span></td>
            </tr>
            <tr class="tr">
                <td class="sub-title">전화번호</td>
                <td class="sub-text"><span>${ritem.mphone}</span></td>
            </tr>
            <tr class="tr">
                <td class="sub-title-last">메일</td>
                <td class="sub-text-last"><span>${ritem.email}</span></td>
            </tr>
        </table>
    </div>
</c:forEach>
 </body>
</center>