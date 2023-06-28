<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/adminTop.jsp" %>
<style>
	main{
		height: 100%;
	}
	.tab-content{
		margin-top: 50px !important;
	}
</style>
 <main id="main" class="main">
    <div class="pagetitle">
      <h1>게시글 신고</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="adminMain.ad">Home</a></li>
          <li class="breadcrumb-item active">게시글 신고</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
    <div class="col-lg-12">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="list-tab" data-bs-toggle="tab"
							data-bs-target="#list" type="button" role="tab"
							,aria-controls="list" aria-selected="true">게시글 신고</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="cal-tab" data-bs-toggle="tab"
							data-bs-target="#cal" type="button" role="tab"
							aria-controls="cal" aria-selected="false">댓글 신고</button>
					</li>
				</ul>
			</div>

			<div class="tab-content pt-2" id="myTabContent">
				<!-- 리스트보기 -->
				<div class="tab-pane fade show active" id="list" role="tabpanel"
					aria-labelledby="board">
					<div class="row">
						<div class="card" style="width: 70%; margin: auto;">
							<div class="card-body">
								<div align="right"></div>
								<h5 class="card-title">게시글 신고</h5>
								<div class="col-md-5" align="left"></div>
								<table class="table table-hover">
									<tr align="center">
										<th scope="col">번호</th>
										<th scope="col">게시글 제목</th>
										<th scope="col">신고내용</th>
										<th scope="col">신고한 회원</th>
										<th scope="col">상태</th>
										<th scope="col">처리</th>
									</tr>
									<c:if test="${ empty reportBoardList }">
										<tr align="center">
											<td colspan="6">신고된 게시글이 없습니다.</td>
										</tr>
									</c:if>

									<c:if test="${ !empty reportBoardList }">
										<c:forEach var="report" items="${ reportBoardList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ status.count }</th>
												<td>${ report.bsubject }</td>
												<td>${ report.rcontent }</td>
												<td>${ report.name }</td>
												<td>${ report.status }</td>
												<td>
													<c:if test="${ report.status != '처리 완료' && report.status != '신고 거절' }">
														<input type="button" value="신고거절" class="btn btn-danger btn-sm" onclick="location.href='adminCommunityReportUpdate.ad?rpnum=${ report.rpnum }&rtype=${ report.rtype }&bcnum=${ report.bcnum }'">
														<input type="button" value="처리완료" class="btn btn-success btn-sm" onclick="location.href='adminCommunityReportDelete.ad?rpnum=${ report.rpnum }&rtype=${ report.rtype }&bcnum=${ report.bcnum }'">
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="cal" role="tabpanel"
					aria-labelledby="cal-tab">
					<div id="scrap">
						<div class="card" style="width: 70%; margin: auto;">
							<div class="card-body">
								<div align="right"></div>
								<h5 class="card-title">댓글 신고</h5>
								<div class="col-md-5" align="left"></div>
								<table class="table table-hover">
									<tr align="center">
										<th scope="col">번호</th>
										<th scope="col">댓글 내용</th>
										<th scope="col">신고내용</th>
										<th scope="col">신고한 회원</th>
										<th scope="col">상태</th>
										<th scope="col">처리</th>
									</tr>
									<c:if test="${ empty reportBcommentList }">
										<tr align="center">
											<td colspan="6">신고된 댓글이 없습니다.</td>
										</tr>
									</c:if>

									<c:if test="${ !empty reportBcommentList }">
										<c:forEach var="report" items="${ reportBcommentList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ status.count }</th>
												<td>${ report.ccontent }</td>
												<td>${ report.rcontent }</td>
												<td>${ report.name }</td>
												<td>${ report.status }</td>
												<td>
													<input type="button" value="신고거절" class="btn btn-danger btn-sm" onclick="location.href='adminCommunityReportUpdate.ad?rpnum=${ report.rpnum }&rtype=${ report.rtype }&bcnum=${ report.bcnum }'">
													<input type="button" value="처리완료" class="btn btn-success btn-sm" onclick="location.href='adminCommunityReportDelete.ad?rpnum=${ report.rpnum }&rtype=${ report.rtype }&bcnum=${ report.bcnum }'">
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
						</div>
					</div>
					
				</div>
			</div>
    
</main>
<%@ include file="../common/bottom.jsp" %>
