<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css">
<style>
	body{
		background-color: #FEF9E7;
		color : black;
	}
	.err{
		color : #E04848;
		font-size: 10pt;
		text-align: right;
	}
	input[type=checkbox]{
		accent-color : #FAC710;
	}
}
</style>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	//날짜 추가
	var classcount
	function inputScope() {
		document.getElementById('healthScope').innerHTML += '<div class="col-md-12 healthScopePlus margin-bottom">'
		+ '<div class="col-md-12"><input type="date" name="tsdate" class="form-control" id="tsdate"></div>'
		+ '</div>';
	}
	
	function deleteScope() {
		var slen = $('.healthScopePlus').length;
		$('.healthScopePlus').eq(slen-1).remove();
	}

	$(document).ready(function() {
		
	  //그룹/개인에 따라 인원수 다르게 보이기
	  $('input[name="tstype"]').change(function() {
	    if ($(this).val() === '그룹') {
	      $('input[name="tspeople"]').each(function() {
	        if ($(this).val() !== '1') {
	          $(this).closest('label').show();
	        } else {
	          $(this).closest('label').hide();
	        }
	      });
	    } else {
	      $('input[name="tspeople"]').each(function() {
	        if ($(this).val() === '1') {
	          $(this).closest('label').show();
	        } else {
	          $(this).closest('label').hide();
	        }
	      });
	    }
	  });
	  
	  //선택한 요일에 따라 감추고 보이게 하기
	  var selectedDay = null;
	  $('.day-button').click(function() {
	      var day = $(this).val();
	      
	      if (selectedDay !== day) {// 이미 선택된 요일과 현재 클릭한 요일이 다른 경우에만 실행
	        if (selectedDay) { //숨기기
	          $('#time-section-' + selectedDay).hide();
	        }
	        $('#time-section-' + day).show(); //보이기
	        selectedDay = day; //선택된 요일로
	      }
	    });
	  
	  
	  // 다른 요일에서 선택한 시간 선택 못하게 막기
	  
	  
	  
	  
	  
	// 시간별로 선택한 요일을 저장할 객체
	  var selectedDaysByTime = {};

	  // 체크박스 클릭 이벤트
	  $('input[type="checkbox"]').click(function(event) {
	    var selectedDay = $(this).attr('name');
	    var selectedTime = $(this).val();
	    var checkBox = $(this);

	    if (checkBox.is(':checked')) {
	      // 다른 요일에서 해당 시간을 선택한 경우, 선택을 해제하고 이전에 선택한 시간을 사용자에게 알림
	      if (selectedDaysByTime[selectedTime]) {
	        checkBox.prop('checked', false);
	        alert('이미 다른 요일에서 해당 시간이 선택되어 있습니다.');
	        return;
	      }

	      // 선택된 시간을 해당 요일로 설정
	      selectedDaysByTime[selectedTime] = selectedDay;
	    } else {
	      // 선택이 해제된 경우
	      delete selectedDaysByTime[selectedTime];
	    }

	    // 다른 요일에서 해당 시간을 선택하지 못하도록 처리
	    $('input[type="checkbox"]').not(checkBox).each(function() {
	      var day = $(this).attr('name');
	      if ($(this).val() === selectedTime) {
	        if (selectedDaysByTime[selectedTime] && selectedDaysByTime[selectedTime] !== day) {
	          $(this).prop('disabled', true);
	        } else {
	          $(this).prop('disabled', false);
	        }
	      }
	    });
	  });

	  
	  
	  
	  
	  
	  
	  
	  
	});//ready
	
	
</script>

<%
String [] tstimeArr = {"05:00~06:00","06:00~07:00","07:00~08:00","08:00~09:00","10:00~11:00","12:00~13:00","13:00~14:00","15:00~16:00","16:00~17:00","18:00~19:00",
		"19:00~20:00","20:00~21:00","21:00~22:00"}; 
String [] dayArr = {"일","월","화","수","목","금","토"}; 
%> 

<body style="background-color : #FEF9E7;">
 <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">스케줄 설정</h5>
                  </div>
                  
                  <form:form commandName="tscheduleBean" action="tScheduleInsert.rv" method="post" class="row g-3 needs-validation" novalidate="novalidate">
                    <div class="col-12">
                      <label for="yourDay" class="form-label b margin-bottom">유형
                      <form:errors cssClass="err" path="tsday" /></label>
                      <br>
                      	<div class="center form-control">
                        <c:forEach var="type" items="${typeArray}">
	                      	<label for="${type}" class="margin5">
	                      	<input type="radio" name="tstype" id="${type}" value="${type}">
	                      	${type} 
	                        </label>
                        </c:forEach>
                        </div>
                    </div>
                    
                    <div class="col-12">
                      <label for="yourDay" class="form-label b margin-bottom">인원수
                      <form:errors cssClass="err" path="tsday" /></label>
                      <br>
                      	<div class="center form-control">
                        <c:forEach var="people" items="${peopleArray}">
	                      	<label for="${people}" class="margin5">
	                      	<input type="radio" name="tspeople" id="${people}" value="${people}" <c:if test="${tscheduleBean.tspeople.contains(people)}">checked</c:if>>
	                      	${people} 
	                        </label>
                        </c:forEach>
                        </div>
                    </div>
                    
                    <div class="col-12">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">요일</label>
                      <br>
                      	<div class="center form-control">
                      		
						    <button type="button" name="tsday" class="day-button" value="sun">일</button>
						    <button type="button" name="tsday" class="day-button" value="mon">월</button>
						    <button type="button" name="tsday" class="day-button" value="tue">화</button>
						    <button type="button" name="tsday" class="day-button" value="wed">수</button>
						    <button type="button" name="tsday" class="day-button" value="thu">목</button>
						    <button type="button" name="tsday" class="day-button" value="fri">금</button>
						    <button type="button" name="tsday" class="day-button" value="sat">토</button>
                        </div>
                    </div>
                    
                    <div class="col-12" id="time-section-sun" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="suntime" id="${tst}" value="${tst}">
		                        ${tst}일
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12" id="time-section-mon" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="montime" id="${tst}" value="${tst}">
		                        ${tst}월
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12" id="time-section-tue" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="tuetime" id="${tst}" value="${tst}">
		                        ${tst}화
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12" id="time-section-wed" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="wedtime" id="${tst}" value="${tst}">
		                        ${tst}수
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12" id="time-section-thu" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="thutime" id="${tst}" value="${tst}">
		                        ${tst}목
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12" id="time-section-fri" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="fritime" id="${tst}" value="${tst}">
		                        ${tst}금
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12" id="time-section-sat" style="display: none;">
                      <div class="margin-top"></div>
                      <label for="yourDay" class="form-label b margin-bottom">시간</label>
                      <br>
                      	<div class="center form-control">
		                <c:forEach var="tst" items="<%=tstimeArr%>">
		                    <label for="${tst}" class="margin5 form-control">
		                        <input type="checkbox" name="sattime" id="${tst}" value="${tst}">
		                        ${tst}토
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12 margin-top">
                      <div class="margin-top"></div>
                      <label for="yourTsdate" class="form-label b">불가능한 날짜</label>
                      <button type="button" onclick="deleteScope()" class="btn btn-warning rounded-pill btn-sm" style="float: right;">날짜 삭제</button> 
						<button type="button" onclick="inputScope()" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10;">날짜 추가</button><br><br>
						
                      <input type="date" name="tsdate" class="form-control" id="tsdate" value="${tscheduleBean.tsdate}">
                    </div>
                    
                    <!-- 추가영역 -->
					<div id="healthScope"></div>
						
                    <div class="col-12 center">
                    	<button type="button" class="btn btn-warning m-size" onClick="javascript:history.go(-1)">취소</button>
                    	<button type="submit" id="inertSub" class="btn btn-warning m-size" onClick="location.href='tScheduleInsert.rv'">등록</button>
                    </div>
                  </form:form> 

                </div> 
              </div>

              <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main>
</body>  
<%@ include file="../common/adminBootBottom.jsp" %>  
<%@ include file="../common/bottom.jsp" %>