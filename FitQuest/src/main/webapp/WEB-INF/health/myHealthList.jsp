<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- healthManegeList.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>
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
						<div class="col-lg-4">
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">운동 목록</h5>

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
													<td colspan="3">등록된 운동내역이 없습니다.</td>
												</tr>
											</c:if>
											<c:if test="${not empty hdlist}">
											<c:forEach var="hdlist" items="${hdlist}" varStatus="status">
												<tr>
													<td>${status.index +1}</td>
													<td>
														<fmt:parseDate value="${hdlist.hdate}" var="day" pattern="yyyy-MM-dd" scope="page"></fmt:parseDate>
														<fmt:formatDate value="${day}" pattern="yyyy-MM-dd"></fmt:formatDate>
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
									<h5 class="card-title">상세 정보</h5>
								</div>
							</div>
							<!-- Default Card -->
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">상세 정보</h5>
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