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
	.card-title{
		border: none !important;
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
	  
	// 선택한 요일에 따라 감추고 보이게 하기 및 선택한 체크박스 저장
	  var selectedDay = null;
	  var selectedCheckboxes = {}; // 요일별로 선택한 체크박스를 저장하는 객체

	  $('.day-button').click(function() {
		  //버튼 클릭하면 배경색 변경
		  $('.day-button').removeClass('selected');
	      $(this).addClass('selected');
	      
	    var day = $(this).val();
	    
	    if (selectedDay !== day) { // 이미 선택된 요일과 현재 클릭한 요일이 다른 경우에만 실행
	      if (selectedDay) { // 숨기기
	        $('#time-section-' + selectedDay).hide();
	        saveSelectedCheckboxes(selectedDay); // 저장하기
	      }
	      $('#time-section-' + day).show(); // 보이기
	      selectedDay = day; // 선택된 요일로
	      restoreSelectedCheckboxes(selectedDay); // 복원하기
	    }
	  });

	  // 체크박스 저장
	  function saveSelectedCheckboxes(day) {
	    var checkboxes = $('#time-section-' + day + ' .time-checkbox');
	    selectedCheckboxes[day] = checkboxes.filter(':checked').map(function() {
	      return this.value;
	    }).get();
	 // 선택한 버튼에 클래스 추가
	    if (checkboxes.is(':checked')) {
	      $('.day-button[value="' + day + '"]').addClass('used');
	    } else {
	      $('.day-button[value="' + day + '"]').removeClass('used');
	    }
	  }

	  // 체크박스 복원
	  function restoreSelectedCheckboxes(day) {
	    var checkboxes = $('#time-section-' + day + ' .time-checkbox');
	    var selectedValues = selectedCheckboxes[day];
	    if (selectedValues && selectedValues.length > 0) {
	      checkboxes.prop('checked', false);
	      checkboxes.filter(function() {
	        return selectedValues.includes(this.value);
	      }).prop('checked', true);
	    }
	  }

	// 선택한 요일 담아가기
	  $('.time-checkbox').change(function() {
	    var selectedDays = []; // 선택된 요일을 저장할 배열

	    // 모든 요일에 대해서 반복
	    $('[id^="time-section-"]').each(function() {
	      var dayId = $(this).attr('id'); // 요일 섹션의 ID
	      var day = dayId.substring(13); // 요일 값 (예: sun, mon, tue, ...)

	      // 해당 요일의 체크박스를 확인하고 선택된 경우 배열에 추가
	      var selectedTimes = $(this).find('input[type="checkbox"]:checked').map(function() {
	        return $(this).val();
	      }).get();

	      if (selectedTimes.length > 0) {
	        selectedDays.push(day);
	      }
	    });

	    // 선택된 요일 배열을 숨겨진 입력란에 설정
	    $('#selectedDays').val(selectedDays.join(',')); // 쉼표로 구분하여 문자열로 변환
	  });
	  
	});//ready
	
	//유효성 검사
	 function validateForm() {
			var radiosType = document.getElementsByName("tstype");
	        var radiosPeople = document.getElementsByName("tspeople");
	        var isCheckedType = false;
	        var isCheckedPeople = false;

	        for (var i = 0; i < radiosType.length; i++) {
	            if (radiosType[i].checked) {
	                isCheckedType = true;
	                break;
	            }
	        }
	        
	        for (var j = 0; j < radiosPeople.length; j++) {
	            if (radiosPeople[j].checked) {
	                isCheckedPeople = true;
	                break;
	            }
	        }

	        if (!isCheckedType) {
	            alert("유형을 선택해주세요.");
	            return false;
	        }
	        
	        if (!isCheckedPeople) {
	            alert("인원수를 선택해주세요.");
	            return false;
	        }

	        
	    }
	
</script>

<%
String [] tstimeArr = {"05:00~06:00","06:00~07:00","07:00~08:00","08:00~09:00","09:00~10:00","10:00~11:00","11:00~12:00",
		"12:00~13:00","13:00~14:00","14:00~15:00","15:00~16:00","16:00~17:00","17:00~18:00","18:00~19:00",
		"19:00~20:00","20:00~21:00","21:00~22:00"}; 
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
                  
                  <form action="tScheduleInsert.rv" method="post" class="row g-3 needs-validation" id="yourForm">
                    <input type="hidden" name="selectedDays" id="selectedDays" />
                    <div class="col-12">
                      <label for="yourDay" class="form-label b margin-bottom">유형</label>
                      <br>
                      	<div class="center form-control">
	                        <c:forEach var="type" items="${typeArray}">
	                      	<label for="${type}" class="margin5">
		                      	<input type="radio" name="tstype" id="${type}" value="${type}"<c:if test="${tscheduleBean.tspeople.contains(people)}">checked</c:if>>
		                      	${type} 
	                        </label>
	                        </c:forEach>
                        </div>
                    </div>
                    
                    <div class="col-12">
                      <label for="yourDay" class="form-label b margin-bottom">인원수</label>
                      <br>
                      	<div class="center form-control">
	                        <c:forEach var="people" items="${peopleArray}">
	                      	<label for="${people}" class="margin5">
		                      	<input type="radio" name="tspeople" id="${people}" value="${people}"<c:if test="${tscheduleBean.tspeople.contains(people)}">checked</c:if>>
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
		                        <input type="checkbox" name="suntime" value="${tst}" class="time-checkbox"<c:if test="${existSun.contains(tst)}">disabled</c:if>>
		                        ${tst}
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
		                        <input type="checkbox" name="montime" value="${tst}" class="time-checkbox"<c:if test="${existMon.contains(tst)}">disabled</c:if>>
		                        ${tst}
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
		                        <input type="checkbox" name="tuetime" value="${tst}" class="time-checkbox"<c:if test="${existTue.contains(tst)}">disabled</c:if>>
		                        ${tst}
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
		                        <input type="checkbox" name="wedtime" value="${tst}" class="time-checkbox"<c:if test="${existWed.contains(tst)}">disabled</c:if>>
		                        ${tst}
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
		                        <input type="checkbox" name="thutime" value="${tst}" class="time-checkbox"<c:if test="${existThu.contains(tst)}">disabled</c:if>>
		                        ${tst}
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
		                        <input type="checkbox" name="fritime" value="${tst}" class="time-checkbox"<c:if test="${existFri.contains(tst)}">disabled</c:if>>
		                        ${tst}
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
		                        <input type="checkbox" name="sattime" value="${tst}" class="time-checkbox"<c:if test="${existSat.contains(tst)}">disabled</c:if>>
		                        ${tst}
		                    </label>
		                </c:forEach>
                   	 </div>
                    </div>
                    
                    <div class="col-12 margin-top">
                      <div class="margin-top"></div>
                      <label for="yourTsdate" class="form-label b">불가능한 날짜</label>
                      <button type="button" onclick="deleteScope()" class="btn btn-warning rounded-pill btn-sm" style="float: right;">날짜 삭제</button> 
					  <button type="button" onclick="inputScope()" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10;">날짜 추가</button><br><br>
						
                      <input type="date" name="tsdate" class="form-control" id="tsdate">
                    </div>
                    
                    <!-- 추가영역 -->
					<div id="healthScope"></div>
						
                    <div class="col-12 center">
                    	<button type="button" class="btn btn-warning m-size" onClick="javascript:history.go(-1)">취소</button>
                    	<button type="submit" id="insertSub" class="btn btn-warning m-size" onClick="return validateForm()">등록</button>
                    </div>
                  </form> 

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