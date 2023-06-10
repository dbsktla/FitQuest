<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	function stateYes(rnum){
		if (confirm('예약 승인 하시겠습니까?')) { //확인
			location.href='reservationState.rv?rnum='+rnum+'&rstate=true';
		    alert('예약 승인 완료되었습니다.');
		} else { //취소
		    alert('예약 승인 취소되었습니다.');
		}
	}
	function stateNo(rnum){
		if (confirm('예약 거절 하시겠습니까?')) { //확인
			location.href='reservationState.rv?rnum='+rnum+'&rstate=reject';
		    alert('예약 거절 완료되었습니다.');
		} else { //취소
		    alert('예약 거절 취소되었습니다.');
		}
	}
</script>
<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<div class="calendarTitle-font">예약 신청 내역</div>
</div> 
<center>
<div class="calendar" >
   <!-- 년/월 바꾸기 -->
   <div class="changeCalendar">
      <!-- 이전년 -->
      <a class="calendar_year" href="trainerReservation.rv?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
         &lt;&lt;
      </a> 
      <!-- 이전달 -->
      <a class="calendar_month" href="trainerReservation.rv?year=${today_info.before_year}&month=${today_info.before_month}">
         &lt;
      </a> 
      <span class="this_month">
         &nbsp;${today_info.search_year}. 
         <c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
      </span>
      <!-- 다음달 -->
      <a class="calendar_month" href="trainerReservation.rv?year=${today_info.after_year}&month=${today_info.after_month}">
         &gt;
      </a> 
         <!-- 다음년 -->
      <a class="calendar_year" href="trainerReservation.rv?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
         &gt;&gt;
      </a>
   </div>
<!-- 달력  -->  
<table class="calendar_body">
<thead>
   <tr class="day-area">
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
<c:choose>
<c:when test="${empty rList}">
   <tr>
	 <td colspan="7" class="calendar-none">
	   <div>
	    <span>예약 신청 내역이 없습니다.</span>
	   </div>
	 </td>
   </tr>
</c:when>
<c:otherwise>
<tbody>
   <tr>
	<c:forEach var="dateList" items="${dateList}" varStatus="date_status">
         <c:choose>
            
           <c:when test="${date_status.index % 7 == 6}">
			    <td class="calendar-box">
			        <div class="calendar-margin"><div class="calendar-num sat">${dateList.date}</div></div>
			        <c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty rList}">
			            
			            
	                        <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="stateYes('${reservation.rnum}')">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="stateNo('${reservation.rnum}')">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
			    </td>
			</c:when>
            
            <c:when test="${date_status.index%7==0}">
    </tr>
    <tr>
		      <td class="calendar-box">
			        <div class="calendar-margin">
			            <div class="calendar-num sun">${dateList.date}</div>
			        </div>
			        <c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty ryear}">
			            
			            
			                <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
			    </td>
            </c:when>
            
      <c:otherwise>
	  <td class="calendar-box">
      	<div> 
		<c:choose>
           <c:when test="${date_status.index%7==1}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty ryear}">
			            
			            
			                <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
           </c:when>
           <c:when test="${date_status.index%7==2}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty ryear}">
			            
			            
			                <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
           </c:when>
           <c:when test="${date_status.index%7==3}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty ryear}">
			            
			            
			                <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
           </c:when>
           <c:when test="${date_status.index%7==4}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty ryear}">
			            
			            
			                <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
           </c:when>
           <c:when test="${date_status.index%7==5}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:if test="${dateList.date <= date_status.last}">
			            <c:if test="${not empty ryear}">
			            
			            
			                <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
			                        	
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
						                        <div class="rstate-area">
				                                    <div class="rstate-y">
				                                        <span class="calender-text">${reservation.mname}</span><span class="calender-text-id">(${reservation.mid})</span>
				                                    </div>
				                                    <div class="rstate-g">
				                                        <span class="calender-text">${reservation.rtime}</span>
				                                    </div>
				                                    <div class="rstate-btn-area">
				                                    	<div class="left-btn"><button class="rstate-btn-blue" onClick="">승인</button></div>
				                                    	<div class="right-btn"><button class="rstate-btn-red" onClick="">거절</button></div>
				                                    </div>
						                        </div>
			                                </c:if>
			                            </c:forEach>
		                              </c:if>
			                        
			                    </c:if>
			                </c:forEach>
			                
			                
			            </c:if>
			        </c:if>
           </c:when>
     	</c:choose>
     	
     	
       </div>
      </td>
      </c:otherwise>
      </c:choose>
	</c:forEach>
</tbody>
</c:otherwise>
</c:choose>
</table>
</div>
</center>

<%@ include file="../common/bottom.jsp" %>