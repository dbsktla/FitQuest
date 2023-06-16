<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/adminTop.jsp" %>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Main</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="adminMain.ad">Home</a></li>
          <li class="breadcrumb-item active">Main</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-8">
          <div class="row">
            <!-- Recent Sales -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">

                <div class="card-body">
                  <h5 class="card-title">리뷰 삭제 요청</h5>

                  <table class="table table-hover">
						<tr align="center">
							<th scope="col">번호</th>
							<th scope="col">리뷰 제목</th>
							<th scope="col">신고한 회원</th>
							<th scope="col">상태</th>
							<th scope="col">처리</th>
						</tr>
						<c:if test="${ empty reportReviewList }">
							<tr align="center">
								<td colspan="6">삭제 요청된 리뷰가 없습니다.</td>
							</tr>
						</c:if>

						<c:if test="${ !empty reportReviewList }">
							<c:forEach var="report" items="${ reportReviewList }"
								varStatus="status">
								<c:if test="${ status.index < 5 }">
									<tr align="center">
										<th scope="row">${ status.count }</th>
										<td>
											<a href="javascript:reviewDetail('${ report.renum }')">${ report.rtitle }</a>
										</td>
										<td>${ report.name }</td>
										<td>${ report.report }</td>
										<td>
											<input type="button" value="신고거절" class="btn btn-danger btn-sm" onclick="location.href='adminReviewReportUpdate.ad?renum=${ report.renum }'">
											<input type="button" value="처리완료" class="btn btn-success btn-sm" onclick="location.href='adminReviewReportDelete.ad?renum=${ report.renum }'">
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</table>

                </div>

              </div>
            </div><!-- End Recent Sales -->

            <!-- Top Selling -->
            <div class="col-12">
              <div class="card top-selling overflow-auto">

                <div class="card-body pb-0">
                  <h5 class="card-title">게시글 신고</h5>

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
								<td colspan="6">접수된 신고 게시글이 없습니다.</td>
							</tr>
						</c:if>

						<c:if test="${ !empty reportBoardList }">
							<c:forEach var="report" items="${ reportBoardList }"
								varStatus="status">
								<c:if test="${ status.index < 5 }">
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
								</c:if>
							</c:forEach>
						</c:if>
					</table>

                </div>

              </div>
            </div><!-- End Top Selling -->
             <div class="col-12">
              <div class="card top-selling overflow-auto">

                <div class="card-body pb-0">
                  <h5 class="card-title">댓글 신고</h5>

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
								<td colspan="6">접수된 신고 댓글이 없습니다.</td>
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
            </div><!-- End Top Selling -->

          </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-4">

          <!-- Recent Activity -->
          <div class="card">

            <div class="card-body">
              <h5 class="card-title">문의 접수 내역</h5>
				<table class="table table-hover">
					<tr align="center">
						<th scope="col">번호</th>
						<th scope="col">문의 제목</th>
						<th scope="col">문의한 회원</th>
					</tr>
					<c:if test="${ empty QueReqList }">
						<tr align="center">
							<td colspan="6">접수된 문의 내역이 없습니다.</td>
						</tr>
					</c:if>

					<c:if test="${ !empty QueReqList }">
						<c:forEach var="question" items="${ QueReqList }"
							varStatus="status">
							<c:if test="${ status.index < 5 }">
								<tr align="center">
									<th scope="row">${ status.count }</th>
									<td>
										<a href="adminQuestionDetail.ad?qnum=${ question.qnum }">${ question.qsubject }</a>
									</td>
									<td>${ question.name }</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
				</table>

              </div>

            </div>
          </div><!-- End Recent Activity -->




      </div>
    </section>

  </main><!-- End #main -->
<%@ include file="../common/adminBottom.jsp" %>  