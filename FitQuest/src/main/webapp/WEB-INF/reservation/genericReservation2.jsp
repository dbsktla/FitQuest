<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:when test="${date_status.index%7==2}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
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
										            <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
								                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
                               <span>${time}</span>
                              </a>
                            </div>
                         </c:forEach>
                       </c:if>
			          
			          </c:if>
			        </c:if>
			      </c:if>
			    </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==3}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
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
										            <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
								                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
                               <span>${time}</span>
                              </a>
                            </div>
                         </c:forEach>
                       </c:if>
			          
			          </c:if>
			        </c:if>
			      </c:if>
			    </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==4}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
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
										            <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
								                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
                               <span>${time}</span>
                              </a>
                            </div>
                         </c:forEach>
                       </c:if>
			          
			          </c:if>
			        </c:if>
			      </c:if>
			    </c:forEach>
           </c:when>
           <c:when test="${date_status.index%7==5}">
         	  <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
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
										            <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
								                <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
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
                              <a href="" class="calender-text" onClick="reservationCheck('${dateList.date}','${time}','${today_info.search_year}','${today_info.search_month}','${tid}','${tname}','${usageNum}')">
                               <span>${time}</span>
                              </a>
                            </div>
                         </c:forEach>
                       </c:if>
			          
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
</c:otherwise>
</c:choose>
</table>
</div>
</center>

<%@ include file="../common/bottom.jsp" %>