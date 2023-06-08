<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css">
<!-- 
<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	var usageCount = ${usage};
	
	$('#usageCheck').click(function(){
		alert(2);
		 if (usageCount > 0) {
			// 사용권이 없는 경우
             alert("남은 사용권이 없습니다.");
             return;
         }
	});
	
});
</script>
 -->

<br><br>
<center>
<form action="" method="GET">
<script type="text/javascript">showCalendar(nowd,nowm,nowy);</script>

<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<span class="calendarTitle-font">My PT</span>
</div>

<div class="calendar" >
   <!-- 년/월 바꾸기 -->
   <div class="changeCalendar">
      <!-- 이전년 -->
      <a class="calendar_year" href="genericCalendar.rv?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
         &lt;&lt;
      </a> 
      <!-- 이전달 -->
      <a class="calendar_month" href="genericCalendar.rv?year=${today_info.before_year}&month=${today_info.before_month}">
         &lt;
      </a> 
      <span class="this_month">
         &nbsp;${today_info.search_year}. 
         <c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
      </span>
      <!-- 다음달 -->
      <a class="calendar_month" href="genericCalendar.rv?year=${today_info.after_year}&month=${today_info.after_month}">
         &gt;
      </a> 
         <!-- 다음년 -->
      <a class="calendar_year" href="genericCalendar.rv?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
         &gt;&gt;
      </a>
   </div>
   <!-- 예약 버튼 -->
   <div class="calendar-button-div">
      <span>
      	<input type="button" class="btn btn-warning" id="usageCheck" onClick="location.href='genericTChoose.rv'" value="예약">  
      </span>
   </div>
<!-- 달력  -->  
<table class="calendar_body">
<thead>
   <tr bgcolor="#FEF9E7">
      <td class="day sun" width="14%">
         일
      </td>
      <td class="day" width="14%">
         월
      </td>
      <td class="day" width="14%">
         화
      </td>
      <td class="day" width="14%">
         수
      </td>
      <td class="day" width="14%">
         목
      </td>
      <td class="day" width="14%">
         금
      </td>
      <td class="day sat" width="14%">
         토
      </td>
   </tr>
</thead>
<tbody>
   <tr>
	<c:forEach var="dateList" items="${dateList}" varStatus="date_status">
         <c:choose>
            <c:when test="${dateList.value=='today'}">
               <td class="today calendar-box">
                  <div class="date">
                 	 <div class="calendar-num">${dateList.date}</div>
                     <c:out value="Today"></c:out>
                  </div>
                  <div>
                  </div>
               </td>
            </c:when>
            <c:when test="${date_status.index%7 == 6}">
               <td class="sat_day calendar-box">
                  <div class="sat">
     				<div class="calendar-num">${dateList.date}</div>
     				<a href = "reservationDetail.rv" class="reservation-area">
         		    <c:out value="김려원 트레이너 | 13:30"></c:out>
         		    </a>
                  </div>
                  <div>
                  </div>
               </td>
            </c:when>
            <c:when test="${date_status.index%7==0}">
   </tr>
   <tr>
      <td class="sun_day calendar-box">
         <div class="sun">
                 <div class="calendar-num">${dateList.date}</div>
                 <a href = "reservationDetail.rv">
                 <c:out value=" "></c:out>
                 </a>
         </div>
         <div>
         </div>
      </td>
            </c:when>
      <c:otherwise>
      <td class="normal_day calendar-box">
         <div class="date">
                <div class="calendar-num">${dateList.date}</div>
                <a href = "reservationDetail.rv">
                <c:out value="<br>" escapeXml="false"></c:out>
                </a>
         </div>
         
      <div>
		<c:choose>
           <c:when test="${dateList.month eq 5 and dateList.date eq 12}">
				<span>박새힘 트레이너 | 18:00<span>
           </c:when>
           <c:when test="${dateList.month eq 5 and dateList.date eq 2}">
                <a href = "reservationDetail.rv" class="reservation-area">
         		    <c:out value="김려원 트레이너 | 13:30"></c:out>
         		    </a>
           </c:when>
           <c:when test="${dateList.month eq 5 and dateList.date eq 21}">
                <a href = "reservationDetail.rv" class="reservation-area">
       		    <c:out value="김려원 트레이너 | 13:30"></c:out>
       		    </a>
           </c:when>
           <c:when test="${dateList.month eq 5 and dateList.date eq 4}">
                <span>Test221<span>
           </c:when>
     	</c:choose>
       </div>
      </td>
      </c:otherwise>
      </c:choose>
	</c:forEach>
</tbody>
</table>
</div>
</form>
</center>

<%@ include file="../common/bottom.jsp" %>