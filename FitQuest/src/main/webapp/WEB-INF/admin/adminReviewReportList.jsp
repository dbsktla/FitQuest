<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/adminTop.jsp" %>
 <main id="main" class="main">
    <div class="pagetitle">
      <h1>리뷰 삭제 요청</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="adminMain.ad">Home</a></li>
          <li class="breadcrumb-item active">리뷰 삭제 요청</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
			<div class="tab-content pt-2" id="myTabContent">
				<!-- 리스트보기 -->
				<div class="tab-pane fade show active" id="list" role="tabpanel"
					aria-labelledby="board">
					<div class="row">
						<div class="card" style="width: 70%; margin: auto;">
							<div class="card-body">
								<div align="right"></div>
								<h5 class="card-title">리뷰 삭제 요청</h5>
								<div class="col-md-5" align="left"></div>
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
											<td colspan="6">리뷰 삭제 요청이 없습니다.</td>
										</tr>
									</c:if>

									<c:if test="${ !empty reportReviewList }">
										<c:forEach var="report" items="${ reportReviewList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ status.count }</th>
												<td>
													<a href="#">${ report.rtitle }</a>
												</td>
												<td>${ report.name }</td>
												<td>${ report.report }</td>
												<td>
													<c:if test="${ report.report != '신고거절' }">
														<input type="button" value="신고거절" class="btn btn-danger btn-sm" onclick="location.href='adminReviewReportUpdate.ad?renum=${ report.renum }'">
														<input type="button" value="처리완료" class="btn btn-success btn-sm" onclick="location.href='adminReviewReportDelete.ad?renum=${ report.renum }'">
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
							<div style=" display: inline-block; margin: auto;">
													<nav aria-label="Page navigation example">
										                <ul class="pagination">
										                <c:if test="${ pageInfo.beginPage != 1 }">
										                  <li class="page-item">
										                    <a class="page-link" href="${ pageInfo.url }?pageNumber=${ pageInfo.beginPage - 1 }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }" aria-label="Previous">
										                      <span aria-hidden="true">&laquo;</span>
										                    </a>
										                  </li>
										                 </c:if> 
										                 
										                <c:forEach begin="${ pageInfo.beginPage }" end="${ pageInfo.endPage }" var="page">
										                	<c:if test="${ page == pageNumber }">
										                		<li class="page-item disabled"><a class="page-link" href="#">${ page }</a></li>
										                	</c:if>
										                	<c:if test="${ page != pageNumber }">
										                		<li class="page-item"><a class="page-link" href="${ pageInfo.url }?pageNumber=${ page }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }">${ page }</a></li>
										                	</c:if>
										                </c:forEach>
										                
										                <c:if test="${ pageInfo.endPage != pageInfo.totalPage }">
										                  <li class="page-item">
										                    <a class="page-link" href="${ pageInfo.url }?pageNumber=${ pageInfo.endPage + 1 }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }" aria-label="Next">
										                      <span aria-hidden="true">&raquo;</span>
										                    </a>
										                  </li>
										                </c:if> 
										                </ul>
										              </nav>
												</div>
						</div>
					</div>
				</div>
			</div>
    
</main>
<%@ include file="../common/adminBottom.jsp" %>
