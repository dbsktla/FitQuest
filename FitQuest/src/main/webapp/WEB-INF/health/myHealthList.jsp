<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- healthManegeList.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
	
	var clickHnum = 0;
	
	/* 상세정보 띄우기 */
	$(document).ready(function(){
		$('#showbutton').css("display","none");
		
		calenderLookup();
	}); // document
	
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
		
	function updateHnum() {
		//alert("u " + clickHnum);
		location.href='myHealthUpdate.ht?hnum=' + clickHnum;
	}
	
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
	
	function calanderLookup() {
		
		// request: 년, 월 정보 . 트레이너 이름, 목록.  
		// 데이터 비교 -> 운동 데이터가 있는날은 따로 체크(이미지 띄우기)
		$.ajax({
			
		});
		
		/* <table>
		<tr>
			<td class="daySun">일</td>
			<td>월</td>
			<td>화</td>
			<td>수</td>
			<td>목</td>
			<td>금</td>
			<td class="daySat">토</td>
		</tr>
		<tr>
			<c:forEach var="i" items="${dateMap}" varStatus="status">
				<c:if test="${status.index == 0}">
					<c:forEach var="j" begin="0" end="${i.value - 1}">
						<td></td>
					</c:forEach>
				</c:if>
				<c:if test="${i.value == 0}">
					</tr>
					<tr>
				</c:if>
				
				<c:if test="${i.value == 0}">
					<td class='daySun dayOn <c:if test="${fn:contains(dateList, i.key)}">dayCheck</c:if>' onclick="dateClick('${i.key}')">${i.key}</td>
				</c:if>
				<c:if test="${i.value == 6}">
					<td class='daySat dayOn <c:if test="${fn:contains(dateList, i.key)}">dayCheck</c:if>' onclick="dateClick('${i.key}')">${i.key}</td>
				</c:if>
				<c:if test="${i.value != 0 and i.value != 6}">
					<td class='dayOn <c:if test="${fn:contains(dateList, i.key)}">dayCheck</c:if>' onclick="dateClick('${i.key}')">${i.key}</td>
				</c:if>
				
			</c:forEach>
		</tr>
	</table> */
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
									<c:forEach var="tlist" items="${tlist}">
										<b>${tlist.name}</b> 트레이너와 <b>${tlist.intro}</b>일 째 <b>${tlist.activity}</b> 중<br>
									</c:forEach>
								</div>
							</div>
						</div>
					
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
				<div class="tab-pane fade" id="cal" role="tabpanel"	aria-labelledby="cal-tab">
					<div id="calenderTable">
						
					</div>
				</div><!-- cal -->
				<!-- End Default Tabs -->
			</div>
			
		</div>
	</div><!-- row -->

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>