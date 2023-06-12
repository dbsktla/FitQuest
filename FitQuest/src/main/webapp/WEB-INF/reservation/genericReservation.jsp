<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css">

<script type="text/javascript">
	function reservationCheck(date,time,year,month,tid,tname){
		if (confirm('예약 하시겠습니까?')) { //확인
			location.href='reservationInsert.rv?date='+date+'&time='+time+'&year='+year+'&month='+month+'&tid='+tid+'&tname='+tname;
		    alert('예약 신청 완료되었습니다.');
		} else { //취소
		    alert('예약 신청 취소되었습니다.');
		}
	}
</script>

<br><br>
<center>
<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<div class="calendarTitle-font">예약</div>
	<div class="calendarSubtitle-font"><span><span>${tname}</span> 트레이너님 스케줄</span></div>
</div> 


<div class="calendar" >
   <!-- 년/월 바꾸기 -->
   <div class="changeCalendar">
      <!-- 이전년 -->
      <a class="calendar_year" href="genericReservation.rv?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
         &lt;&lt;
      </a> 
      <!-- 이전달 -->
      <a class="calendar_month" href="genericReservation.rv?year=${today_info.before_year}&month=${today_info.before_month}">
         &lt;
      </a> 
      <span class="this_month">
         &nbsp;${today_info.search_year}. 
         <c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
      </span>
      <!-- 다음달 -->
      <a class="calendar_month" href="genericReservation.rv?year=${today_info.after_year}&month=${today_info.after_month}">
         &gt;
      </a> 
         <!-- 다음년 -->
      <a class="calendar_year" href="genericReservation.rv?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
         &gt;&gt;
      </a>
   </div>
<!-- 버튼 -->
   <div class="calendar-button-div">
      <span>
      	<input type="button" class="btn btn-warning" onClick="location.href='genericCalendar.rv'" value="My PT">
      	<c:if test="${usageCount >= 2}">
	      	<input type="button" class="btn btn-warning" onClick="location.href='genericTChoose.rv'" value="트레이너 선택">
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
			    <c:forEach var="day" items="${tsdayArr}">
			      <c:if test="${day eq '토'}">  
			        <c:if test="${dateList.date <= date_status.last}">
			        
		         	  <c:set var="check1" value="휴무아님"/>
				      <c:if test="${not empty tsyear}">
				        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
				           <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
				               <div class="reservation-area">
				                  <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
				                  <span class="calender-text">휴무</span>
				                </div>
						        <c:set var="check1" value="휴무"/>
				            </c:if>
				         </c:forEach>
				       </c:if>
				        
			       	   <c:set var="print" value="출력전"/>
			       	   <c:set var="print1" value="출력전"/>
				       <c:if test="${check1 eq '휴무아님'}">    
				       	<c:if test="${not empty ryear}">
						    <c:forEach var="i" begin="0" end="${fn:length(ryear)-1}">
						    
						    	<c:set var="hasReservation" value="false" />
						        <c:if test="${ryear[i] == today_info.search_year && rmonth[i] == today_info.search_month && rday[i] == dateList.date}">
						            <c:set var="hasReservation" value="true" />
						            <c:forEach var="rtime" items="${rtimeArr}">
							            <c:set var="reservedTimes" value="${rtime}" />
						            </c:forEach>
						            
						            <c:if test="${print == '출력전'}">
									<c:set var="reservedTimes" value="" />
										<c:forEach var="rtime" items="${rtimeArr}">
										    <c:set var="reservedTimes" value="${reservedTimes},${rtime}" />
										</c:forEach>
										
										<c:forEach var="time" items="${tstimeArr}">
										    <c:set var="isMatch" value="false" />
										    <c:forEach var="rtime" items="${fn:split(reservedTimes, ',')}">
										        <c:if test="${fn:contains(time, rtime)}">
										            <c:set var="isMatch" value="true" />
										            <div class="reservation-area">
										                <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
										                <span class="calender-text">${rtime}</span>
										            </div>
										        </c:if>
										    </c:forEach>
										
										    <c:if test="${not isMatch}">
										        <div class="reservation-area">
										            <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
										            <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}')">
										                <span>${time}</span>
										            </a>
										        </div>
										    </c:if>
										<c:set var="print" value="출력후"/>
										</c:forEach>
						            </c:if>	
						        </c:if>
						        
						        <c:if test="${hasReservation == 'false'}">
						            <c:if test="${print1 == '출력전'}">
										<c:forEach var="time" items="${tstimeArr}">
								            <div class="reservation-area">
								                <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
								                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}')">
								                    <span>${time}</span>
								                </a>
								            </div>
											<c:set var="print1" value="출력후"/>
										</c:forEach>
						            </c:if>	
						        </c:if>
						        
						    </c:forEach>
						</c:if>
						
				       
			           <c:if test="${empty ryear}"> 
			          	 <c:forEach var="time" items="${tstimeArr}">
                            <div class="reservation-area">
                              <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}')">
                               <span>${time}</span>
                              </a>
                            </div>
                         </c:forEach>
                       </c:if>
			          
			          </c:if>
			          
			          
			        </c:if>
			      </c:if>
			    </c:forEach>
			</td>
		</c:when>
            
            <c:when test="${date_status.index%7==0}">
    </tr>
    <tr>
		      <td class="calendar-box">
     				<div class="calendar-margin"><div class="calendar-num sun">${dateList.date}</div></div>
    				<c:forEach var="day" items="${tsdayArr}">
		               <c:if test="${day eq '일'}">
		               		<c:if test="${dateList.date <= date_status.last}">
		                  
			                  <c:set var="check2" value="없음"/>
							    <c:if test="${not empty tsyear}">
							        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
							                <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
							                    <div class="reservation-area">
							                        <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
							                        <span class="calender-text">휴무</span>
							                    </div>
									             <c:set var="check2" value="휴무"/>
							                </c:if>
							             </c:forEach>
							        </c:if>
							        
							       <c:if test="${check2 eq '없음'}">         
		                            <c:forEach var="time" items="${tstimeArr}">
		                                <div class="reservation-area">
		                                    <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
		                                    <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}')">
		                                        <span>${time}</span>
		                                    </a>
		                                </div>
		                            </c:forEach>
		                           </c:if>
	                     	
	                     	</c:if>
		               </c:if>
		            </c:forEach>
               </td>
            </c:when>
            
      <c:otherwise>
	  <td class="calendar-box">
      	<div> 
		<c:choose>
           <c:when test="${date_status.index%7==1}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:forEach var="day" items="${tsdayArr}">
		               <c:if test="${day eq '월'}">
		                  	<c:if test="${dateList.date <= date_status.last}">
		                  	
		                  	<c:set var="check3" value="없음"/>
							    <c:if test="${not empty tsyear}">
							        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
							                <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
							                    <div class="reservation-area">
							                        <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
							                        <span class="calender-text">휴무</span>
							                    </div>
									             <c:set var="check3" value="휴무"/>
							                </c:if>
							             </c:forEach>
							        </c:if>
							        
							       <c:if test="${check3 eq '없음'}">         
		                            <c:forEach var="time" items="${tstimeArr}">
		                                <div class="reservation-area">
		                                    <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
		                                    <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}')">
		                                        <span>${time}</span>
		                                    </a>
		                                </div>
		                            </c:forEach>
		                           </c:if>
	                     	
	                     	</c:if>
		               </c:if>
		            </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==2}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:forEach var="day" items="${tsdayArr}">
		               <c:if test="${day eq '화'}">
             		 	    <c:if test="${dateList.date <= date_status.last}">
		                  
		                  	<c:set var="check4" value="없음"/>
							    <c:if test="${not empty tsyear}">
							        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
							                <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
							                    <div class="reservation-area">
							                        <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
							                        <span class="calender-text">휴무</span>
							                    </div>
									             <c:set var="check4" value="휴무"/>
							                </c:if>
							             </c:forEach>
							        </c:if>
							        
							       <c:if test="${check4 eq '없음'}">         
		                            <c:forEach var="time" items="${tstimeArr}">
		                                <div class="reservation-area">
		                                    <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
		                                    <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}')">
		                                        <span>${time}</span>
		                                    </a>
		                                </div>
		                            </c:forEach>
		                           </c:if>
	                     	
	                     	</c:if>
		               </c:if>
		            </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==3}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:forEach var="day" items="${tsdayArr}">
		               <c:if test="${day eq '수'}">
		               		<c:if test="${dateList.date <= date_status.last}">
		                  
		                  	<c:set var="check5" value="없음"/>
							    <c:if test="${not empty tsyear}">
							        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
							                <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
							                    <div class="reservation-area">
							                        <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
							                        <span class="calender-text">휴무</span>
							                    </div>
									             <c:set var="check5" value="휴무"/>
							                </c:if>
							             </c:forEach>
							        </c:if>
							        
							       <c:if test="${check5 eq '없음'}">         
		                            <c:forEach var="time" items="${tstimeArr}">
		                                <div class="reservation-area">
		                                    <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
		                                    <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}')">
		                                        <span>${time}</span>
		                                    </a>
		                                </div>
		                            </c:forEach>
		                           </c:if>
	                     	
	                     	</c:if>
		               </c:if>
		            </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==4}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:forEach var="day" items="${tsdayArr}">
		               <c:if test="${day eq '목'}">
		               		<c:if test="${dateList.date <= date_status.last}">
		               		
		                  	<c:set var="check6" value="없음"/>
							    <c:if test="${not empty tsyear}">
							        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
							                <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
							                    <div class="reservation-area">
							                        <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
							                        <span class="calender-text">휴무</span>
							                    </div>
									             <c:set var="check6" value="휴무"/>
							                </c:if>
							             </c:forEach>
							        </c:if>
							        
							       <c:if test="${check6 eq '없음'}">         
		                            <c:forEach var="time" items="${tstimeArr}">
		                                <div class="reservation-area">
		                                    <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
		                                    <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}')">
		                                        <span>${time}</span>
		                                    </a>
		                                </div>
		                            </c:forEach>
		                           </c:if>
		                           
	                     	</c:if>
		               </c:if>
		            </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==5}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
    				<c:forEach var="day" items="${tsdayArr}">
		               <c:if test="${day eq '금'}">
							<c:if test="${dateList.date <= date_status.last}">
									                  	
		                  	<c:set var="check7" value="없음"/>
							    <c:if test="${not empty tsyear}">
							        <c:forEach var="i" begin="0" end="${fn:length(tsyear)-1}">
							                <c:if test="${tsyear[i] == today_info.search_year && tsmonth[i] == today_info.search_month && tsday[i] == dateList.date}">
							                    <div class="reservation-area">
							                        <img src="<%=request.getContextPath()%>/resources/Icon/impossible.png" width="20px">
							                        <span class="calender-text">휴무</span>
							                    </div>
									             <c:set var="check7" value="휴무"/>
							                </c:if>
							             </c:forEach>
							        </c:if>
							        
							       <c:if test="${check7 eq '없음'}">         
		                            <c:forEach var="time" items="${tstimeArr}">
		                                <div class="reservation-area">
		                                    <img src="<%=request.getContextPath()%>/resources/Icon/possible.png" width="20px">
		                                    <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}')">
		                                        <span>${time}</span>
		                                    </a>
		                                </div>
		                            </c:forEach>
		                           </c:if>
	                     	
	                     	</c:if>
		               </c:if>
		            </c:forEach>
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
</center>

<%@ include file="../common/bottom.jsp" %>