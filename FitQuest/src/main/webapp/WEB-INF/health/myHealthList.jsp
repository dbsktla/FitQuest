<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- healthManegeList.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
	/* 상세정보 띄우기 */
	$(document).ready(function(){
		
	}); // document
	
		
	function btnclick(hnum) {
		//alert(hnum);
		
		$.ajax({
			type : "POST", // 요청타입
			url : "myHealthList.ht", // 요청 url
			data : ({'hnum' : hnum}), // url로 넘길 데이터 설정
			dataType : "json", // 받아올 데이터 타입설정
			success : function (data) {
				
				$('#healthDetail').empty(); // healthDetail div 내용 비우기
				var msg = "<table class='table'><tr class='table-warning'>";
				msg += "<th scope='col'>운동명</th><th scope='col'>시작시간</th><th scope='col'>종료시간</th><th scope='col'>세트</th></tr>";
				
				// 현재 jsonArray 형태로 값이 넘어와서 data에 담긴상태	
				for(var i=0; i<data.length; i++){
					msg += "<tr><td>"+data[i].hname+"<input type='hidden' name='hnum' value='"+data[i].hnum+"'></td>";
					msg += "<td>"+data[i].starttime+"</td>";
					msg += "<td>"+data[i].endtime+"</td>";
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
					type="button" role="tab" ,aria-controls="list" aria-selected="true">리스트보기</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="cal-tab" data-bs-toggle="tab" data-bs-target="#cal" 
					type="button" role="tab" aria-controls="cal" aria-selected="false">캘린더보기</button>
				</li>
			</ul>
			<div class="tab-content pt-2" id="myTabContent">
				<!-- 리스트보기 -->
				<div class="tab-pane fade show active" id="list" role="tabpanel" aria-labelledby="list-tab">
					<div class="row">
						
						<div class="col-lg-12">
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">운동 정보</h5>
									<!-- 선택한 날짜, 00 트레이너와 00일쨰 00중 -->
								</div>
							</div>
						</div>
					
						<div class="col-lg-4">
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">운동 목록 <button type="button" onclick="location.href='myHealthInsert.ht'" class="btn btn-warning rounded-pill btn-sm" style="float: right;">추가</button></h5>
									
									<table class="table">
										<thead>
											<tr class="table-warning">
												<th scope="col" align="center">NO</th>
												<th scope="col" align="center">날짜</th>
												<th scope="col" align="center">운동시간</th>
											</tr>
										</thead>

										<tbody>
											<c:if test="${empty hdlist}">
												<tr>
													<td colspan="3">등록 된 운동내역이 없습니다.</td>
												</tr>
											</c:if>
											<c:if test="${not empty hdlist}">
											<c:forEach var="hdlist" items="${hdlist}" varStatus="status">
												<tr>
													<td>${status.index +1}</td>
													<td>
														<fmt:parseDate value="${hdlist.hdate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
														<button type="button" class="btn btn-link" id="hdetailbtn" onclick="btnclick('${hdlist.hnum}')"><fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/></button>
													</td>
													<td>${hdlist.playtime}</td>
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
									<h5 class="card-title">상세 정보 
										<button type="button" class="btn btn-warning rounded-pill btn-sm" style="float: right;">삭제</button> 
										<button type="button" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10;">수정</button>
									</h5>
									<div id="healthDetail"><span style="margin: auto;">좌측 운동 목록에서 날짜를 클릭하세요.</span></div>
								</div><!-- card body -->
							</div>
						</div><!-- col-lg-8 -->
					</div><!-- row -->
				</div><!-- list -->
				
				<!-- 캘린더보기 -->
				<div class="tab-pane fade" id="cal" role="tabpanel"	aria-labelledby="cal-tab">
					Nesciunt totam et. Consequun
				</div><!-- cal -->
				<!-- End Default Tabs -->
			</div>
			
		</div>
	</div><!-- row -->

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>