<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css">
<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	$(document).ready(function() {
	    // 페이지 로드 시 스크롤 위치 복원
	    var storedScrollPosition = sessionStorage.getItem('scrollPosition');
	    if (storedScrollPosition) {
	        window.scrollTo(0, storedScrollPosition);
	        sessionStorage.removeItem('scrollPosition');
	    }
	});
	
	function reservationCheck(date, time, year, month, tid, tname, usageNum, people) {
		// 스크롤 위치 기억
	    var scrollPosition = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
		
		if(usageNum > 0){
			
			if (confirm(
					'날짜 : '+year+'-'+month+'-'+date+'\n'
				   +'시간 : '+time+'\n'
				   +'예약 하시겠습니까?'
							)) { // 확인
				location.href = 'reservationInsert.rv?date=' + date + '&time=' + time + '&year=' + year + '&month=' + month + '&tid=' + tid + '&tname=' + tname + '&usageNum=' + usageNum + '&people=' + people;
				
				if (confirm('계속 예약 하시겠습니까?')) { // 확인
					// 스크롤 위치 저장
				    sessionStorage.setItem('scrollPosition', scrollPosition);
					location.href = 'genericReservation.rv?tid='+tid+'&tname='+tname+'&people=' + people; // 예약 페이지
				} else { // 취소
					location.href = 'genericCalendar.rv'; // My PT 페이지
				}
			} else { // 취소
				// 스크롤 위치 설정
	            window.scrollTo(0, scrollPosition);
			    alert('예약 신청이 취소되었습니다.');
			}
		}else{
			alert('사용권이 모두 소진되었습니다.');
		}
	}
	
	function impossibleCheck(){
		alert('예약 마감되었습니다.');
	}
	
	function alreadyCheck(){
		alert('이미 예약 신청되었습니다.');
	}
</script>
<br><br>
<center>
<!-- 타이틀 폰트 -->
<div class="calendarTitle">  
	<div class="calendarTitle-font">예약</div>
	<div class="calendarSubtitle-font"><span><span>${tname}</span> 트레이너님 스케줄</span></div>
</div> 
<div>
   <!-- 년/월 바꾸기 -->
   <div class="changeCalendar">
      <!-- 이전년 -->
      <a class="calendar_year" href="genericReservation.rv?year=${today_info.search_year-1}&month=${today_info.search_month-1}&tid=${tid}&tname=${tname}&people=${people}">
         &lt;&lt;
      </a> 
      <!-- 이전달 -->
      <a class="calendar_month" href="genericReservation.rv?year=${today_info.before_year}&month=${today_info.before_month}&tid=${tid}&tname=${tname}&people=${people}">
         &lt;
      </a> 
      <span class="this_month">
         &nbsp;${today_info.search_year}. 
         <c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
      </span>
      <!-- 다음달 -->
      <a class="calendar_month" href="genericReservation.rv?year=${today_info.after_year}&month=${today_info.after_month}&tid=${tid}&tname=${tname}&people=${people}">
         &gt;
      </a> 
         <!-- 다음년 -->
      <a class="calendar_year" href="genericReservation.rv?year=${today_info.search_year+1}&month=${today_info.search_month-1}&tid=${tid}&tname=${tname}&people=${people}">
         &gt;&gt;
      </a>
   </div>
   
<!-- 버튼 -->
   <div class="calendar-button-div">
      <div class="left">
      	<span class="usage-area">남은 사용권 횟수 : ${usageNum}번</span>
      </div>
      <div class="right">
      	<input type="button" class="btn btn-warning" onClick="location.href='genericCalendar.rv'" value="My PT">
      	<input type="button" class="btn btn-warning" onClick="location.href='genericStateList.rv'" value="예약 내역">
      	<c:if test="${usageCount >= 2}">
	      	<input type="button" class="btn btn-warning" onClick="location.href='genericTChoose.rv'" value="트레이너 선택">
      	</c:if>
      </div>
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
<c:if test="${empty tsList}">
   <tr>
	 <td colspan="7" class="calendar-none">
	   <div>
	    <span>죄송합니다. 트레이너님의 스케줄이 설정되지 않았습니다.</span>
	   </div>
	 </td>
   </tr>
</c:if>
<c:if test="${not empty tsList}">
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
		     <div class="calendar-margin">
		       <div class="calendar-num sat">${dateList.date}</div>
		     </div>
		      <c:set var="check1" value="휴무아님"/>
	       	  <c:set var="print1" value="출력전"/>
	       	  <c:set var="print2" value="출력전"/>
	       	  <c:set var="print3" value="출력전"/>
			  <c:set var="hasReservation" value="예약없음"/>
			  <c:set var="reserved" value="false" />
			  <c:set var="reservedf" value="false" />
			  
			  <c:forEach var="tsitem" items="${tsList}">
  				<c:if test="${tyear < today_info.search_year || (tyear == today_info.search_year && tmonth < today_info.search_month) || (tyear == today_info.search_year && tmonth == today_info.search_month && tday < dateList.date)}">
			      <c:if test="${tsitem.tsday eq 'sat'}">
			        <c:if test="${dateList.date <= date_status.last}">
			        
				      <c:if test="${not empty tsitem.tsdate}">
				        <c:forEach var="tsdate" items="${fn:split(tsitem.tsdate, ',')}">
				        <c:set var="restDate" value="${fn:replace(tsdate, '-0', '-')}"/>
                        <c:set var="nowDate" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}" />
				           <c:if test="${nowDate == restDate}">
				               <div class="reservation-area">
				                  <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px" class="icon">
				                  <span class="calender-text">휴무</span>
				                </div>
						        <c:set var="check1" value="휴무"/>
				            </c:if>
				         </c:forEach>
				       </c:if>
				      
				       <c:if test="${check1 eq '휴무아님'}">    
				       	<c:if test="${not empty cList}">
				       	
				       		<c:set var="nowDay" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}"/>
				       		  
				       		  
				       		<c:if test="${print1 == '출력전'}">
				       		   
						      <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
						      <c:set var="reserved" value="false" />
						      <c:set var="reservedf" value="false" />
				       		   <c:forEach var="citem" items="${cList}">
	                       	  	<c:if test="${citem.cpdate == nowDay && citem.cptime == tstime}">
	                       	  		<div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
								       	<a class="calender-text" href="#" onclick="impossibleCheck(); return false;">
								          <span>${tstime}</span>
								     	</a>
								       <c:set var="reserved" value="true" />
								    </div>
	                       	  	</c:if>
				       		   </c:forEach>
				       		   <c:forEach var="rfitem" items="${rfList}">
				       		    <c:if test="${rfitem.rdate == nowDay && rfitem.rtime == tstime}">
	                       	  		<div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/already.png" width="20px">
								       	<a class="calender-text" href="#" onclick="alreadyCheck(); return false;">
								          <span>${tstime}</span>
								     	</a>
								       <c:set var="reservedf" value="true" />
								    </div>
	                       	  	</c:if>
				       		   </c:forEach>
	                       	  	<c:if test="${!reserved && !reservedf}">
								    <div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
								        <a class="calender-text" href="#" onclick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}'); return false;">
								          <span>${tstime}</span>
								       </a>
								    </div>
								</c:if>
								<c:set var="hasReservation" value="예약있음" />
								<c:set var="print1" value="출력후"/>
							 </c:forEach>
	                       	</c:if>
								
	                       	
	                       	<c:if test="${hasReservation == '예약없음'}">
					            <c:if test="${print2 == '출력전'}">
					              <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
					            	<div class="reservation-area">
						                <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
						                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}')">
						                    <span>${tstime.tstime}</span>
						                </a>
						            </div>
						          </c:forEach>
					            </c:if>
					        </c:if>
			            </c:if>
	                       	
                       	<c:if test="${empty cList}">
                       	  <c:if test="${print3 == '출력전'}">
                       	   <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
                       		<div class="reservation-area">
                              <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}')">
                               <span>${tstime}</span>
                              </a>
                            </div>
                           </c:forEach>
                          </c:if>
                       	</c:if>
			          </c:if>
			        </c:if>
			       </c:if>
			     </c:if>
			   </c:forEach>
			</td>
    </tr>
		</c:when>
            
        <c:when test="${date_status.index%7==0}">
    <tr>
		 <c:if test="${dateList.value == 'today'}">
	      	<td class="t-calendar-box">
	   	 </c:if>
	     <c:if test="${dateList.value != 'today'}">  
	      	<td class="calendar-box">
	     </c:if>
		     <div class="calendar-margin">
		       <div class="calendar-num sun">${dateList.date}</div>
		     </div>
		      <c:set var="check1" value="휴무아님"/>
	       	  <c:set var="print1" value="출력전"/>
	       	  <c:set var="print2" value="출력전"/>
	       	  <c:set var="print3" value="출력전"/>
			  <c:set var="hasReservation" value="예약없음"/>
			  <c:set var="reserved" value="false" />
			  <c:set var="reservedf" value="false" />
			  
			  <c:forEach var="tsitem" items="${tsList}">
  				<c:if test="${tyear < today_info.search_year || (tyear == today_info.search_year && tmonth < today_info.search_month) || (tyear == today_info.search_year && tmonth == today_info.search_month && tday < dateList.date)}">
			      <c:if test="${tsitem.tsday eq 'sun'}">
			        <c:if test="${dateList.date <= date_status.last}">
			        
				      <c:if test="${not empty tsitem.tsdate}">
				        <c:forEach var="tsdate" items="${fn:split(tsitem.tsdate, ',')}">
				        <c:set var="restDate" value="${fn:replace(tsdate, '-0', '-')}"/>
                        <c:set var="nowDate" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}" />
				           <c:if test="${nowDate == restDate}">
				               <div class="reservation-area">
				                  <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px" class="icon">
				                  <span class="calender-text">휴무</span>
				                </div>
						        <c:set var="check1" value="휴무"/>
				            </c:if>
				         </c:forEach>
				       </c:if>
				      
				       <c:if test="${check1 eq '휴무아님'}">    
				       	<c:if test="${not empty cList}">
				       	
				       		<c:set var="nowDay" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}"/>
				       		  
				       		  
				       		<c:if test="${print1 == '출력전'}">
				       		   
						      <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
						      <c:set var="reserved" value="false" />
						      <c:set var="reservedf" value="false" />
				       		   <c:forEach var="citem" items="${cList}">
	                       	  	<c:if test="${citem.cpdate == nowDay && citem.cptime == tstime}">
	                       	  		<div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
								       	<a class="calender-text" href="#" onclick="impossibleCheck(); return false;">
								          <span>${tstime}</span>
								     	</a>
								       <c:set var="reserved" value="true" />
								    </div>
	                       	  	</c:if>
				       		   </c:forEach>
				       		   <c:forEach var="rfitem" items="${rfList}">
				       		    <c:if test="${rfitem.rdate == nowDay && rfitem.rtime == tstime}">
	                       	  		<div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/already.png" width="20px">
								       	<a class="calender-text" href="#" onclick="alreadyCheck(); return false;">
								          <span>${tstime}</span>
								     	</a>
								       <c:set var="reservedf" value="true" />
								    </div>
	                       	  	</c:if>
				       		   </c:forEach>
	                       	  	<c:if test="${!reserved && !reservedf}">
								    <div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
								        <a class="calender-text" href="#" onclick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}'); return false;">
								          <span>${tstime}</span>
								       </a>
								    </div>
								</c:if>
								<c:set var="hasReservation" value="예약있음" />
								<c:set var="print1" value="출력후"/>
							 </c:forEach>
	                       	</c:if>
								
	                       	
	                       	<c:if test="${hasReservation == '예약없음'}">
					            <c:if test="${print2 == '출력전'}">
					              <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
					            	<div class="reservation-area">
						                <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
						                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}')">
						                    <span>${tstime.tstime}</span>
						                </a>
						            </div>
						          </c:forEach>
					            </c:if>
					        </c:if>
			            </c:if>
	                       	
                       	<c:if test="${empty cList}">
                       	  <c:if test="${print3 == '출력전'}">
                       	   <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
                       		<div class="reservation-area">
                              <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}')">
                               <span>${tstime}</span>
                              </a>
                            </div>
                           </c:forEach>
                          </c:if>
                       	</c:if>
			          </c:if>
			        </c:if>
			       </c:if>
			     </c:if>
			   </c:forEach>
			   
			</td>
          </c:when>
     </c:choose>       
      <c:if test="${ date_status.index % 7 != 6 && date_status.index % 7 != 0 }">
	  <c:if test="${dateList.value == 'today'}">
      	<td class="t-calendar-box">
   	  </c:if>
      <c:if test="${dateList.value != 'today'}">  
       	<td class="calendar-box">
      </c:if>
      	<div> 
		 <c:forEach var="dayIndex" items="mon,tue,wed,thu,fri" varStatus="status">
		  <c:if test="${date_status.index%7 == status.count}">
			<div class="calendar-margin">
			   <div class="calendar-num">${dateList.date}</div>
			</div>
			<c:set var="check1" value="휴무아님"/>
	       	  <c:set var="print1" value="출력전"/>
	       	  <c:set var="print2" value="출력전"/>
	       	  <c:set var="print3" value="출력전"/>
			  <c:set var="hasReservation" value="예약없음"/>
			  <c:set var="reserved" value="false" />
			  <c:set var="reservedf" value="false" />
			  
			  <c:forEach var="tsitem" items="${tsList}">
  				<c:if test="${tyear < today_info.search_year || (tyear == today_info.search_year && tmonth < today_info.search_month) || (tyear == today_info.search_year && tmonth == today_info.search_month && tday < dateList.date)}">
			      <c:if test="${tsitem.tsday eq dayIndex}">
			        <c:if test="${dateList.date <= date_status.last}">
			        
				      <c:if test="${not empty tsitem.tsdate}">
				        <c:forEach var="tsdate" items="${fn:split(tsitem.tsdate, ',')}">
				        <c:set var="restDate" value="${fn:replace(tsdate, '-0', '-')}"/>
                        <c:set var="nowDate" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}" />
				           <c:if test="${nowDate == restDate}">
				               <div class="reservation-area">
				                  <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px" class="icon">
				                  <span class="calender-text">휴무</span>
				                </div>
						        <c:set var="check1" value="휴무"/>
				            </c:if>
				         </c:forEach>
				       </c:if>
				      
				       <c:if test="${check1 eq '휴무아님'}">    
				       	<c:if test="${not empty cList}">
				       	
				       		<c:set var="nowDay" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}"/>
				       		  
				       		  
				       		<c:if test="${print1 == '출력전'}">
				       		   
						      <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
						      <c:set var="reserved" value="false" />
						      <c:set var="reservedf" value="false" />
				       		   <c:forEach var="citem" items="${cList}">
	                       	  	<c:if test="${citem.cpdate == nowDay && citem.cptime == tstime}">
	                       	  		<div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
								       	<a class="calender-text" href="#" onclick="impossibleCheck(); return false;">
								          <span>${tstime}</span>
								     	</a>
								       <c:set var="reserved" value="true" />
								    </div>
	                       	  	</c:if>
				       		   </c:forEach>
				       		   <c:forEach var="rfitem" items="${rfList}">
				       		    <c:if test="${rfitem.rdate == nowDay && rfitem.rtime == tstime}">
	                       	  		<div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/already.png" width="20px">
								       	<a class="calender-text" href="#" onclick="alreadyCheck(); return false;">
								          <span>${tstime}</span>
								     	</a>
								       <c:set var="reservedf" value="true" />
								    </div>
	                       	  	</c:if>
				       		   </c:forEach>
	                       	  	<c:if test="${!reserved && !reservedf}">
								    <div class="reservation-area">
								       <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
								        <a class="calender-text" href="#" onclick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}'); return false;">
								          <span>${tstime}</span>
								       </a>
								    </div>
								</c:if>
								<c:set var="hasReservation" value="예약있음" />
								<c:set var="print1" value="출력후"/>
							 </c:forEach>
	                       	</c:if>
								
	                       	
	                       	<c:if test="${hasReservation == '예약없음'}">
					            <c:if test="${print2 == '출력전'}">
					              <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
					            	<div class="reservation-area">
						                <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
						                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}')">
						                    <span>${tstime.tstime}</span>
						                </a>
						            </div>
						          </c:forEach>
					            </c:if>
					        </c:if>
			            </c:if>
	                       	
                       	<c:if test="${empty cList}">
                       	  <c:if test="${print3 == '출력전'}">
                       	   <c:forEach var="tstime" items="${fn:split(tsitem.tstime, ',')}">
                       		<div class="reservation-area">
                              <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${tstime}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}','${people}')">
                               <span>${tstime}</span>
                              </a>
                            </div>
                           </c:forEach>
                          </c:if>
                       	</c:if>
			          </c:if>
			        </c:if>
			       </c:if>
			     </c:if>
			   </c:forEach>
			  
			  
			  
          	</c:if>
		  </c:forEach>
        </div>
       </td>
      </c:if>
     </c:forEach>
</tbody>
</c:if>
</table>
</div>
</center>

<%@ include file="../common/bottom.jsp" %>