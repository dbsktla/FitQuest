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
	function openPopup(rnum) { //팝업창 설정
		// 팝업 창의 URL과 창의 속성을 설정
	 	 var url = "trainerCalendarDetail.rv?rnum="+rnum;
		 var width = 700; // 팝업 창의 너비
	 	 var height = 500; // 팝업 창의 높이
 		 var left = (window.screen.availWidth - width) / 2; // 화면 중앙에 위치하도록 좌표 계산
	 	 var top = (window.screen.availHeight - height) / 2;

	 	 var popup = window.open(url, "_blank", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);

	 	  // 팝업 창이 로드된 후에 닫기 버튼 추가
	 	  popup.onload = function() {
	 	    var closeButton = popup.document.createElement("button");
	 	    closeButton.innerText = "닫기";
	 	    closeButton.classList.add("close-button");
	 	    closeButton.addEventListener("click", function() {
	 	      popup.close(); // 팝업 창 닫기
	 	    });

	 	    // 팝업 창에 닫기 버튼 추가한 후에 포커스를 닫기 버튼으로 이동
	 	    popup.document.body.appendChild(closeButton);
	 	    closeButton.focus();
	 	  };
	}
</script>
<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<div class="calendarTitle-font">My PT</div>
</div> 
<center>
<div class="calendar" >
   <!-- 년/월 바꾸기 -->
   <div class="changeCalendar">
      <!-- 이전년 -->
      <a class="calendar_year" href="trainerCalendar.rv?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
         &lt;&lt;
      </a> 
      <!-- 이전달 -->
      <a class="calendar_month" href="trainerCalendar.rv?year=${today_info.before_year}&month=${today_info.before_month}">
         &lt;
      </a> 
      <span class="this_month">
         &nbsp;${today_info.search_year}. 
         <c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
      </span>
      <!-- 다음달 -->
      <a class="calendar_month" href="trainerCalendar.rv?year=${today_info.after_year}&month=${today_info.after_month}">
         &gt;
      </a> 
         <!-- 다음년 -->
      <a class="calendar_year" href="trainerCalendar.rv?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
         &gt;&gt;
      </a>
   </div>
<!-- 버튼 -->
   <div class="calendar-button-div">
      <span>
      	<input type="button" class="btn btn-warning" onClick="location.href='trainerReservation.rv'" value="예약 신청 내역">
      	<c:if test="${flag == 'true'}">
	      	<input type="button" class="btn btn-warning" onClick="location.href='tScheduleUpdate.rv'" value="스케줄 수정">
      	</c:if>
      	<c:if test="${flag == 'false'}">
	      	<input type="button" class="btn btn-warning" onClick="location.href='tScheduleInsert.rv'" value="스케줄 설정">
      	</c:if>
      </span>
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
	    <span>스케줄 내역이 없습니다.</span>
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
			 <c:if test="${dateList.value == 'today'}">
		       <td class="t-calendar-box">
		     </c:if>
		     <c:if test="${dateList.value != 'today'}">  
		       <td class="calendar-box">
		     </c:if>
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
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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
    		<c:if test="${dateList.value == 'today'}">
		       <td class="t-calendar-box">
		     </c:if>
		     <c:if test="${dateList.value != 'today'}">  
		       <td class="calendar-box">
		     </c:if>
		        <div class="calendar-margin"><div class="calendar-num sun">${dateList.date}</div></div>
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
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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
	  <c:if test="${dateList.value == 'today'}">
        <td class="t-calendar-box">
      </c:if>
      <c:if test="${dateList.value != 'today'}">  
        <td class="calendar-box">
	  </c:if>
      	<div> 
		<c:choose>
           <c:when test="${date_status.index%7==1}">
         	 
		        <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
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
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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
			            <c:if test="${not empty rList}">
	                        <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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
			            <c:if test="${not empty rList}">
	                        <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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
			            <c:if test="${not empty rList}">
	                        <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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
			            <c:if test="${not empty rList}">
	                        <c:set var="check" value="출력전"/>
			                <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
			                    <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
			                        <c:set var="reservationDay" value="${ryear[i]}-${rmonth[i]}-${rday[i]}"/>
		                        	  <c:if test="${check == '출력전'}">
			                            <c:forEach var="reservation" items="${rList}">
				                         <c:set var="check" value="출력완료"/>
			                                <c:if test="${reservation.rdate == reservationDay}">
			                                  <a href="#" onclick="openPopup('${reservation.rnum}')">
						                        <div class="rstate-container">
				                                    <div class="rstate-box">
				                                        <span class="calender-text-s b">${reservation.mname}님</span>  <span class="calender-text-s">${reservation.rtime}</span>
				                                    </div>
						                        </div>
						                       </a> 
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