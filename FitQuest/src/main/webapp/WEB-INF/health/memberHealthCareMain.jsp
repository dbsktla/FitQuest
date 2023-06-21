<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- memberHealthCareMain.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>

<style>
	tr:hover {
		background-color: #f4f4f4;
	}
	
	.draggable {
		-webkit-user-select: all;
		-moz-user-select: all;
		-ms-user-select: all;
		user-select: all
	}
	
	.v-line{
		border-left: solid 3px #adb5bd;
		height:100%;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	$(document).ready(function(){
	   $('.datatable-search').css('display','none');
	});
	
	function btnCheckOff() {
	   $('input:radio(name="whatGender")').prop('checked',false);
	   $('input:radio(name="whatStatus")').prop('checked',false);
	   $('input:radio(name="whatAge")').prop('checked',false);
	   $('#whatName').attr("value","");
	}
	
	function detail(mid) {
		//alert(mid);
		
		//(멤버리스트 보는 목록으로 가는 버튼 만들기)
		//닫기버튼 생성하기
		
// 		$.ajax({
// 			url : 'memberHealthDetail.ht',
// 			type : 'POST',
// 			data : {"mid": mid},
// 			dataType : 'json',
// 			success : function(data) {
				
// 			}
// 		});
	}
</script>
<body style="background-color: #FEF9E7;">

	<div class="pagetitle" style="margin: 40px 0px;">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 회원운동관리
		</h1>
	</div>

	<div class="row">

		<!-- 회원클릭시 상세정보 -->
		<div id="mDetail" class="col-lg-12">
			<div class="card">
				<div class="card-body">
					<div class="row">
						<!-- left -->
						<div class="col-lg-3">
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">이름</label>
								<div class="col-sm-7 col-form-label">ddd</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">성별</label>
								<div class="col-sm-7 col-form-label">여자</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">생년월일</label>
								<div class="col-sm-7 col-form-label">2020.02.03</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">이메일</label>
								<div class="col-sm-7 col-form-label">aaa@aaaa</div>
							</div>
							
						</div><!-- left -->
						
						<!-- right -->
						<div class="col-lg-9 v-line">
							
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">최초등록일</label>
								<div class="col-sm-7 col-form-label">2020.02.03</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">시작일</label>
								<div class="col-sm-7 col-form-label">2020.02.03(재등록)</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">진도율</label>
								<div class="col-sm-7 col-form-label">PT 총 10회중 5회남음</div>
							</div>
							
							<div class="row mb-3">
								<label class="col-sm-5 col-form-label">상태</label>
								<div class="col-sm-7 col-form-label">유효</div>
							</div>
							
						</div><!-- right -->
						
						<!-- center -->
						<div class="col-lg-12">
						
							<div class="row mb-3">
							
								<label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
								
								<div class="col-md-8 col-lg-9">
									<input name="password" type="password" class="form-control" id="currentPassword">
								</div>
							</div>

							<!-- Bordered Tabs -->
							<ul class="nav nav-tabs nav-tabs-bordered">

								<li class="nav-item">
									<button class="nav-link active" data-bs-toggle="tab"
										data-bs-target="#profile-overview">Overview</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-edit">Edit Profile</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-settings">Settings</button>
								</li>

								
								<div class="tab-content pt-2">

					             <div class="tab-pane fade show active profile-overview" id="profile-overview">
					             <h5 class="card-title">About</h5>

							</ul>

						</div><!-- center -->
						
					</div>
				</div>
			</div>
		</div>

		<!-- 상단 회원 간략 정보 -->
		<div class="col-lg-12" style="margin: 20px 0px;">신규 회원 유효 회원 만료
			회원</div>
		<!-- 회원 간략 정보  -->

		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					<form action="memberHealthCare.ht">

						<!-- 필터 -->
						<div>
							<div class="col-lg-2 btn-group" role="group" aria-label="Basic outlined example" style="padding: 2% 2%;">
								<input type="radio" class="btn-check" value="남자" name="whatGender" id="whatGender1" autocomplete="off"
									<c:if test = "${param.whatGender eq '남자'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatGender1">남자</label>

								<input type="radio" class="btn-check" value="여자" name="whatGender" id="whatGender2" autocomplete="off"
									<c:if test = "${param.whatGender eq '여자'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatGender2">여자</label>
							</div>

							<div class="col-lg-2 btn-group" role="group" aria-label="Basic outlined example">
								<input type="radio" class="btn-check" value="available" name="whatStatus" id="whatStatus1" autocomplete="off"
									<c:if test = "${param.whatStatus eq 'available'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatStatus1">유효</label>

								<input type="radio" class="btn-check" value="unavailable" name="whatStatus" id="whatStatus2" autocomplete="off"
									<c:if test = "${param.whatStatus eq 'unavailable'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatStatus2">만료</label>
							</div>

							<div class="col-lg-4 btn-group" role="group" aria-label="Basic outlined example" style="padding: 2% 2%;">
								<input type="radio" class="btn-check" value="10" name="whatAge" id="whatAge1" autocomplete="off"
									<c:if test = "${param.whatAge == 10}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge1">10대</label>

								<input type="radio" class="btn-check" value="20" name="whatAge" id="whatAge2" autocomplete="off"
									<c:if test = "${param.whatAge == 20}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge2">20대</label>

								<input type="radio" class="btn-check" value="30" name="whatAge" id="whatAge3" autocomplete="off"
									<c:if test = "${param.whatAge == 30}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge3">30대</label>

								<input type="radio" class="btn-check" value="40" name="whatAge" id="whatAge4" autocomplete="off"
									<c:if test = "${param.whatAge == 40}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge4">40대</label>

								<input type="radio" class="btn-check" value="50" name="whatAge" id="whatAge5" autocomplete="off"
									<c:if test = "${param.whatAge == 50}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge5">50대</label>
							</div>

							<div class="col-lg-2 btn-group" >
								<input type="text" id="whatName" name="whatName" placeholder="이름검색" value="${param.whatName}" style="width: 80%;">
								<button type="submit" class="btn btn-warning btn-sm">
									<i class="ri-search-line"></i>
								</button>
							</div>
							
							<div class="col-lg-1 btn-group"  style="padding: 2% 2%;">
								<input type="button" onclick="btnCheckOff()" class="btn btn-warning btn-sm" value="선택해제" style="float: right;">
							</div>
						</div>
						<!-- 필터 -->

					</form>


				</div>
			</div>
		</div>

		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">

					<h5 class="card-title">구매 회원 목록</h5>
					<table class="table datatable">
						<thead>
							<tr>
								<th scope="col">NO.</th>
								<th scope="col">이름</th>
								<th scope="col">성별</th>
								<th>연령</th>
								<th>전화번호</th>
								<th>이메일주소</th>
								<th scope="col">최초구매일</th>
								<th scope="col">남은횟수</th>
								<th scope="col">회원상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty hclist}">
								<tr>
									<td colspan="9" style="text-align: center;">조회 할 정보가 없습니다.</td>
								</tr>
							</c:if>

							<c:if test="${not empty hclist}">
								<c:forEach var="hclist" items="${hclist}" varStatus="status">

									<tr>
										<td scope="row">${status.count}</td>
										<td>
											<a href='javascript:detail("${hclist.mid}")'>${hclist.name}</a>
										</td>
										<td>${hclist.gender}</td>
										<td>만 ${hclist.age}세</td>
										<td>${hclist.mphone}</td>
										<td>${hclist.email}</td>
										<td>
											<fmt:parseDate value="${hclist.odate}" var="day" pattern="yyyy-MM-dd" scope="page" /> 
											<fmt:formatDate value="${day}" pattern="yyyy-MM-dd" /></td>
										<td>${hclist.usage}</td>
										<td>
											<c:if test="${hclist.ustate eq 'available'}"><font color="green">유효</font></c:if> 
											<c:if test="${hclist.ustate eq 'unavailable'}"><font color="red">만료</font></c:if>
										</td>
									</tr>

								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- col 10 -->

	</div>
	<!-- row -->

</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>
