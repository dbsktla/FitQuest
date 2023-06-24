<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css?after"/>
<script type="text/javascript">
	function openPopup(rnum, rstate) {
		// 팝업 창의 URL과 창의 속성을 설정
		var url = "genericCalendarDetail.rv?rnum=" + rnum;
		var width = 700; // 팝업 창의 너비
		var height = 680; // 팝업 창의 높이
		var left = (window.screen.availWidth - width) / 2; // 화면 중앙에 위치하도록 좌표 계산
		var top = (window.screen.availHeight - height) / 2;
		
		var popup = window.open(url, "_blank", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
		
		// 팝업 창이 로드된 후에 닫기 버튼 추가
		popup.onload = function () {
			 var closeButton = popup.document.createElement("button");
			 closeButton.innerText = "닫기";
			 closeButton.classList.add("close-button");
			 closeButton.addEventListener("click", function () {
				popup.close(); // 팝업 창 닫기
			 });
		
			// 예약 상태가 true라면 예약 취소 버튼 추가(예약 확정은 되었지만 운동 완료하지 않은 상태)
			if (rstate == "true") {
				var cancelButton = popup.document.createElement("button");
				cancelButton.innerText = "예약 취소";
				cancelButton.classList.add("close-button");
				cancelButton.addEventListener("click", function () {
					var confirmCancel = popup.confirm("예약을 취소하시겠습니까?");
				
					if (confirmCancel) {
						popup.alert("예약 취소 완료되었습니다.");
						popup.close(); // 팝업 창 닫기
						window.location.href = "genericCancel.rv?rnum=" + rnum;
					}
			  });
			
				// 버튼 간격 조절
				cancelButton.style.marginRight = "10px";
				
				popup.document.body.appendChild(cancelButton);
				closeButton.focus();
			}
			
			popup.document.body.appendChild(closeButton);
			closeButton.focus();
		};
	}
</script>
<body style="background-color: #FEF9E7; text-align: center;"> 
<!-- 타이틀 폰트 -->
<div class="calendarTitle">
	<div class="calendarTitle-font">My PT</div>
</div> 
<div class="calendar-container">
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
<!-- 버튼 -->
<div class="calendar-button-container">
   <div class="calendar-button-div">
  	  <div class="left">
  	  <c:if test="${not empty reviewTname}">
  	  	<input type="button" class="btn btn-warning" onClick="location.href='reviewWrite.pd?id=${reviewTid}'" value="${reviewTname} 트레이너님 리뷰 작성 가능!">
  	  </c:if>
  	  </div> 
      <div class="right">
      <c:if test="${not empty rAList}">
      	<input type="button" class="btn btn-warning" onClick="location.href='genericStateList.rv'" value="예약 내역">
      </c:if>
      <c:if test="${usage >= 1}">
      	<input type="button" class="btn btn-warning" onClick="location.href='genericTChoose.rv'" value="예약하러 가기">
      </c:if>
      </div>
   </div>
</div>
<!-- 달력  -->  
<table class="calendar-body">
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
<c:if test="${empty rList}">
   <tr>
	 <td colspan="7" class="calendar-none">
	   <div>
	    <span>예약 내역이 없습니다.</span>
	   </div>
	 </td>
   </tr>
</c:if>
<c:if test="${not empty rList}">
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
		     <c:set var="nowDay" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}"/>
		        <div class="calendar-margin"><div class="calendar-num sat">${dateList.date}</div></div>
		        <c:if test="${dateList.date <= date_status.last}">
			        <c:if test="${not empty rList}">
                        <c:forEach var="ritem" items="${rList}">
                            <c:if test="${ritem.rdate == nowDay}">
                              <a href="#" onclick="openPopup('${ritem.rnum}','${ritem.rstate}'); return false;">
                      			 <div class="rstate-container-gc">
	                                 <div class="center">
	                                 	<c:if test="${ritem.activity == 'PT'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/PT-icon.png" width="34px" class="icon">
	                                 	</c:if>
	                                 	<c:if test="${ritem.activity == '필라테스'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/Pilates-icon.png" width="35px" class="icon">
	                                    </c:if>
	                                 	<c:if test="${ritem.activity == '요가'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/Yoga-icon.png" width="35px" class="icon">
	                                    </c:if>
	                                  </div> 
	                                  <div>
	                                     <span class="calender-text-s b">${ritem.tname} 트레이너</span>  <span class="calender-text-s">${ritem.rtime}</span>
	                                  </div>
			                      </div>
			                  </a> 
                            </c:if>
                        </c:forEach>
			        </c:if>
			   </c:if>
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
		     <c:set var="nowDay" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}"/>
		        <div class="calendar-margin"><div class="calendar-num sun">${dateList.date}</div></div>
		        <c:if test="${dateList.date <= date_status.last}">
			         <c:if test="${not empty rList}">
                        <c:forEach var="ritem" items="${rList}">
                            <c:if test="${ritem.rdate == nowDay}">
                              <a href="#" onclick="openPopup('${ritem.rnum}','${ritem.rstate}'); return false;">
                      			 <div class="rstate-container-gc">
	                                 <div class="center">
	                                 	<c:if test="${ritem.activity == 'PT'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/PT-icon.png" width="34px" class="icon">
	                                 	</c:if>
	                                 	<c:if test="${ritem.activity == '필라테스'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/Pilates-icon.png" width="35px" class="icon">
	                                    </c:if>
	                                 	<c:if test="${ritem.activity == '요가'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/Yoga-icon.png" width="35px" class="icon">
	                                    </c:if>
	                                  </div> 
	                                  <div>
	                                     <span class="calender-text-s b">${ritem.tname} 트레이너</span>  <span class="calender-text-s">${ritem.rtime}</span>
	                                  </div>
			                      </div>
			                  </a> 
                            </c:if>
                        </c:forEach>
			        </c:if>
			      </c:if>
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
	  <c:set var="nowDay" value="${today_info.search_year}-${today_info.search_month}-${dateList.date}"/>
      	<div> 
           <c:forEach var="dayIndex" items="월,화,수,목,금" varStatus="status">
		  	<c:if test="${date_status.index%7 == status.count}">
		        <div class="calendar-margin"><div class="calendar-num">${dateList.date}</div></div>
		          <c:if test="${dateList.date <= date_status.last}">
			          <c:if test="${not empty rList}">
                        <c:forEach var="ritem" items="${rList}">
                            <c:if test="${ritem.rdate == nowDay}">
                              <a href="#" onclick="openPopup('${ritem.rnum}','${ritem.rstate}'); return false;">
                      			 <div class="rstate-container-gc">
	                                 <div class="center">
	                                 	<c:if test="${ritem.activity == 'PT'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/PT-icon.png" width="34px" class="icon">
	                                 	</c:if>
	                                 	<c:if test="${ritem.activity == '필라테스'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/Pilates-icon.png" width="35px" class="icon">
	                                    </c:if>
	                                 	<c:if test="${ritem.activity == '요가'}">
	                                  		<img src="<%=request.getContextPath()%>/resources/Icon/Yoga-icon.png" width="35px" class="icon">
	                                    </c:if>
	                                  </div> 
	                                  <div>
	                                     <span class="calender-text-s b">${ritem.tname} 트레이너</span>  <span class="calender-text-s">${ritem.rtime}</span>
	                                  </div>
			                      </div>
			                  </a> 
                            </c:if>
                        </c:forEach>
			        </c:if>
			      </c:if>
           	 </c:if>
           	</c:forEach>
	       </div>
	      </td>
         </c:if>
     </c:forEach>
</c:if>


</table>
</div>
</body>

<%@ include file="../common/bottom.jsp" %>