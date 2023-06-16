<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- healthManegeList.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>

	body {
	  margin: 40px 10px;
	  padding: 0;
	  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	  font-size: 14px;
	}
	
	#calendar {
	  max-width: 1100px;
	  margin: 0 auto;
	}
	
	.fc-event-time{
		display: none;
	}
	a[class="fc-col-header-cell-cushion"], a[class="fc-daygrid-day-number"]{
		color : gray;
	}
	.fc-daygrid-event-dot{
		border-color : #ffc107 !important;
	}
	.fc-event-title{
		color : #000000;
	}
	.fc .fc-button-primary {
		background-color : #ffc107;
		border-color : #ffc107;
	}
	.fc-toolbar-title{
		color: #494949 !important;
	}
	
	
	.modal {
	  display: none; /* 모달창 숨겨 놓기 */
	  position: fixed; 
	  z-index: 1; /* 모달창을 제일 앞에 두기 */
	  padding-top: 100px;
	  left: 0; top: 0;
	  width: 100%; height: 100%;
	  overflow: auto; /* 스크롤 허용 auto */
	  cursor: pointer; /* 마우스 손가락모양 */
	  background-color: rgba(210, 210, 210, 0.4);
	}
	/* 모달창 애니메이션 추가 */
	@keyframes zoom {
	  from {transform: scale(0)}
	  to {transform: scale(1)}
	}
	/* 모달창 이미지 */
	.modal_content {
	  margin: auto;
	  width: 50%; height: auto;
	  max-width: 1000px;
	  border-radius: 10px;
	  animation-name: zoom;
	  animation-duration: 0.8s;
	  background: white;
	}
	/* 닫기 버튼 꾸미기 */
	.close {
	  position: absolute;
	  top: 15px;
	  right: 35px;
	  color: #f1f1f1;
	  font-size: 40px;
	  font-weight: bold;
	  transition: 0.3s;
	}
	.close:hover, .close:focus{
	  color: #bbb;
	  text-decoration: none;
	  cursor: pointer;
</style>

<script type="text/javascript" src="resources/dist/index.global.js" ></script>
<script type="text/javascript" src="resources/dist/index.global.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">

	var clickHnum = 0;
	const modal = document.querySelector(".modal");
	const modal_img = document.querySelector(".modal_content");
	const span = document.querySelector(".close");
	
	$(document).ready(function(){
		$('#showbutton').css("display","none");
		
		
		
		// 모달
		
		$('.close').click(function () {
			$('.modal').css('display', "none");
		});
		
		$('.modal').click(function () {
			$('.modal').css('display', "none");
		});
	});
	
	
	// 상세정보
	function btnclick(hnum) {
		//alert(hnum);
		clickHnum = hnum;
		$('#showbutton').show();
		
		$.ajax({	
			type : "POST", // 요청타입
			url : "myHealthDetail.ht", // 요청 url
			data : ({'hnum' : hnum}), // url로 넘길 데이터 설정
			dataType : "json", // 받아올 데이터 타입설정
			success : function (data) {
				
				$('#healthDetail').empty(); // healthDetail div 내용 비우기
				var msg = "<table class='table'><tr class='table-warning'>";
				msg += "<th><input type='checkbox' name='allchk' class='form-check-input' onclick='allcheck()'></th>";
				msg += "<th scope='col'>운동명</th><th scope='col'>시작시간</th><th scope='col'>종료시간</th><th scope='col'>세트</th></tr>";
				
				// 현재 jsonArray 형태로 값이 넘어와서 data에 담긴상태	
				for(var i=0; i<data.length; i++){
					msg += "<tr><td><input type='checkbox' name='rowchk' class='form-check-input' value='"+data[i].hname + "@" + data[i].starttime + "@" + clickHnum + "'></td>";
					msg += "<td>"+data[i].hname+"</td>";
					msg += "<td>"+(data[i].starttime).substring(0,16)+"</td>";
					msg += "<td>"+(data[i].endtime).substring(0,16)+"</td>";
					msg += "<td>"+data[i].hset+"세트 "+data[i].hcount+"회</td></tr>";
				}
				
				msg += "</table>";
				
				// string값을 healthDetail div에 추가함!!
				$("#healthDetail").append(msg);
			},
			error : function () {
				alert("fail"); // 실패
			}
		}); // ajax
	}
	
	// 선택 삭제
	function deleteHnum() {
		flag = false;
		var chkObj = document.getElementsByName("rowchk");
		for(i=0; i<chkObj.length; i++){
			if(chkObj[i].checked){
				flag = true;
				break;
			}
		}
		
		if(!flag){
			alert('삭제 할 체크박스를 하나 이상 선택하세요');
			return;
		}
		
		document.hdform.submit();
	}
	
	// 수정버튼 클릭
	function updateHnum() {
		//alert("u " + clickHnum);
		location.href='myHealthUpdate.ht?hnum=' + clickHnum;
	}
	
	// 체크박스 선택
	function allcheck() {
		//alert(1);
		
		var check = document.hdform.allchk.checked;
		
		var rowschk = document.getElementsByName("rowchk");
		if(check){
			for(var i=0; i<rowschk.length; i++){
				rowschk[i].checked = true;
			}
		}else{
			for(var i=0; i<rowschk.length; i++){
				rowschk[i].checked = false;
			}
		}
	}
	
	// 헬스 목록 리스트
	function listup() {
		$('#showbutton').css("display","none");
		$("#healthDetail").empty();
		$("#healthDetail").append('<span style="margin: auto;">좌측 운동 목록에서 날짜를 클릭하세요.</span>');
		
		var tid = $('#tid').val();
		//alert(tid);
		
		$.ajax({
			url : "myHealthList.ht",
			type : "POST",
			data : {'tid' : tid},
			dataType : "json",
			success : function (data) {
				$('#healthList').empty();
				
				var msg = "";
				if(data.length == 0){
					msg += '<tr><td colspan="4" align="center">등록 된 운동내역이 없습니다.</td></tr>';
				}else{
					for(var i=0; i<data.length; i++){
						msg += '<tr>';
						msg += '<td>'+ (i+1) +'</td>';
						
						if(data[i].tid != "notrainer"){
							msg += '<td>'+ data[i].tname +'(' + data[i].tactivity +')</td>';
						}else{
							msg += '<td>없음</td>';
						}
						
						msg += '<td>';
						msg += '<button type="button" class="btn btn-link" id="hdetailbtn" onclick="btnclick(' + data[i].hnum + ')">' + (data[i].hdate).substring(0,10) + '</button>';
						msg += '</td>';
						msg += '<td>' + data[i].playtime + '  분</td>';
						msg += '</tr>';
					}
				}
				$("#healthList").append(msg);
			}//success
		});//ajax
		
	}
	
		
	
	
</script>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 운동관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item active">운동관리</li>
			</ol>
		</nav>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<!-- Default Tabs -->
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="list-tab" data-bs-toggle="tab" data-bs-target="#list" 
					type="button" role="tab" aria-controls="list" aria-selected="true">리스트보기</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="cal-tab" data-bs-toggle="tab" data-bs-target="#cal" 
					type="button" role="tab" aria-controls="cal" aria-selected="false" onclick="cal_lookup()">캘린더보기</button>
				</li>
			</ul>
			<div class="tab-content pt-2" id="myTabContent">
				<!-- 리스트보기 -->
				<div class="tab-pane fade show active" id="list" role="tabpanel" aria-labelledby="list-tab">
					<div class="row">
						
						<div class="col-lg-4">
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">운동 목록 <button type="button" onclick="location.href='myHealthInsert.ht'" class="btn btn-warning rounded-pill btn-sm" style="float: right;">추가</button></h5>
									
									<select name="tid" id="tid" onchange="listup()" class="form-select" aria-label="Default select example" style="margin-bottom: 20">
										<option value="all">전체보기</option>
										<c:forEach var="tlist" items="${tlist}">
											<option value="${tlist.id}">${tlist.name}(${tlist.activity})</option>
										</c:forEach>
									</select>
									
									<table class="table">
										<thead>
											<tr class="table-warning">
												<th scope="col" align="center">NO</th>
												<th scope="col" align="center">트레이너</th>
												<th scope="col" align="center">날짜</th>
												<th scope="col" align="center">운동시간</th>
											</tr>
										</thead>

										<tbody id="healthList">
											<c:if test="${empty hdlist}">
												<tr>
													<td colspan="4" align="center">등록 된 운동내역이 없습니다.</td>
												</tr>
											</c:if>
											<c:if test="${not empty hdlist}">
											<c:forEach var="hdlist" items="${hdlist}" varStatus="status">
												<tr>
													<td>${status.index +1}</td>
													<td>
														<c:if test="${not empty hdlist.tname}">
															${hdlist.tname}(${hdlist.tactivity})
														</c:if>
														<c:if test="${empty hdlist.tname}">
															없음
														</c:if>
													</td>
													<td>
														<fmt:parseDate value="${hdlist.hdate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
														<button type="button" class="btn btn-link" id="hdetailbtn" onclick="btnclick('${hdlist.hnum}')"><fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/></button>
													</td>
													<td>${hdlist.playtime} 분</td>
												</tr>
											</c:forEach>
											</c:if>
										</tbody>
									</table>


								</div><!-- card body -->
							</div>
						</div><!-- col-lg-4 -->

						<div class="col-lg-8">
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
									<form action='myHealthDelete.ht' name="hdform">
									
									<h5 class="card-title">상세 정보 
										<span id="showbutton">
										<button type="button" onclick="deleteHnum()" class="btn btn-warning rounded-pill btn-sm" style="float: right;">삭제</button> 
										<button type="button" onclick="updateHnum()" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10;">수정</button>
										</span>
									</h5>
									<div id="healthDetail"><span style="margin: auto;">좌측 운동 목록에서 날짜를 클릭하세요.</span></div>
									
									</form>
								</div><!-- card body -->
							</div>
						</div><!-- col-lg-8 -->
					</div><!-- row -->
				</div><!-- list -->
				
				<!-- 캘린더보기 -->
				<div class="row justify-content-center">
				<div class="tab-pane fade" id="cal" role="tabpanel"	aria-labelledby="cal-tab" style="width: 70%;">
					<div class="row">
						<!-- 캘린더 -->
						<div class="col-lg-9">
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
						
									<div id='calendar'></div>
									
									<div class="modal card-body col-lg-5">
									  <span class="close">&times;</span>
									</div>
									
								</div>
							</div>
						</div>
						
						
					</div><!-- row -->	
				</div>
				</div>
				<!-- End 캘린더 -->
			</div>
			
		</div>
	</div><!-- row -->

</body>


<script src='./lib/main.js'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script>

	function cal_lookup() {
		//alert('test');
		
		var calendarEl = document.getElementById('calendar');
	
		   var calendar = new FullCalendar.Calendar(calendarEl, {
		     //initialDate: '2023-01-12',
		     editable: true,
		     selectable: true,
		     businessHours: true,
		     dayMaxEvents: true, // allow "more" link when too many events
		     events: [
		    	 <c:forEach var="hdlist" items="${hdlist}" varStatus="status">
		    		{
		    		  title: <c:if test="${hdlist.tname != null}">'${hdlist.tname}(${hdlist.tactivity}-${hdlist.hnum})'</c:if><c:if test="${hdlist.tname == null}">'개인운동-${hdlist.hnum}'</c:if>
		    		 ,start: '${hdlist.hdate}'
		    		, textColor : "#000000"
		    		  
		    		}
		    		<c:if test="${!status.last}">,</c:if>
		    	</c:forEach>
	
		     ],
		     eventClick : function (info) {
		    	 healthModal(info.event.title);
		    	 
		  	 }
		   	 
		   });
	
		   calendar.render();
	}
	
	function healthModal(info) {
		
		$.ajax({
			url : "myHealthModal.ht",
			type : "POST",
			data : {'info' : info},
			dataType : "json",
			success : function (data) {
				var msg = "";
				
				var msg = "<table class='table modal_content' style='width: 50%;margin-top: 20%; vertical-align:middle;' ><tr class='table-warning'>";
				msg += "<th scope='col'>운동명</th><th scope='col'>시작시간</th><th scope='col'>종료시간</th><th scope='col'>세트</th></tr>";
				for(var i=0; i<data.length; i++){
					msg += "<td>"+data[i].hname+"</td>";
					msg += "<td>"+(data[i].starttime).substring(0,16)+"</td>";
					msg += "<td>"+(data[i].endtime).substring(0,16)+"</td>";
					msg += "<td>"+data[i].hset+"세트 "+data[i].hcount+"회</td></tr>";
				}
				
				msg += "</table>";
				$(".modal").html(msg);
				$('.modal').css('display', "block");
			}
		});
		
	}
	
</script>

<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>