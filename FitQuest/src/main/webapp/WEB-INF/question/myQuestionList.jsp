<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<aside id="sidebar" class="sidebar">
	<ul class="sidebar-nav" id="sidebar-nav" style="padding-top: 20px;">
		<c:if test="${ sessionScope.loginInfo.mtype == 'trainer' }">
			<li class="nav-item"><a class="nav-link collapsed"
				href="trainerDetail.mb"> <i
					class="bi bi-layout-text-window-reverse"></i><span>마이페이지</span>
			</a></li>

			<li class="nav-item"><a class="nav-link collapsed"
				href="trainerReviewList.mb"> <i
					class="bi bi-layout-text-window-reverse"></i><span>리뷰관리</span>
			</a></li>

			<li class="nav-item"><a class="nav-link collapsed"
				href="viewProductList.pd"> <i
					class="bi bi-layout-text-window-reverse"></i><span>상품관리</span>
			</a></li>

			<li class="nav-item"><a class="nav-link collapsed"
				href="productSalesDetail.pd"> <i
					class="bi bi-layout-text-window-reverse"></i><span>수익보기</span>
			</a></li>
			
		</c:if>

		<c:if test="${ sessionScope.loginInfo.mtype == 'generic' }">
			<li class="nav-item"><a class="nav-link collapsed"
				href="genericMemberDetail.mb"> <i
					class="bi bi-layout-text-window-reverse"></i><span>마이페이지</span>
			</a></li>

			<li class="nav-item"><a class="nav-link collapsed"
				href="viewMyReviewList.mb"> <i
					class="bi bi-layout-text-window-reverse"></i><span>리뷰관리</span>
			</a></li>

			<li class="nav-item"><a class="nav-link collapsed" href="">
					<i class="bi bi-layout-text-window-reverse"></i><span>구매관리</span>
			</a></li>
		</c:if>

		<li class="nav-item"><a class="nav-link collapsed" href="myBoardList.co">
				<i class="bi bi-layout-text-window-reverse"></i><span>내 글보기</span> <!-- <i class="bi bi-chevron-down ms-auto"></i> -->
		</a></li>
		<li class="nav-item"><a class="nav-link" href="myQuestionList.qt">
				<i class="bi bi-layout-text-window-reverse"></i><span>문의 내역</span> <!-- <i class="bi bi-chevron-down ms-auto"></i> -->
		</a></li>
	</ul>
</aside>

<body style="background-color: #FEF9E7; text-align: center;">
	<main id="main" class="main" style="margin-top: 5px">
		<main>
			<div class="col-lg-12">
				<div class="pagetitle" style="text-align: left;">
					<h1>
						<i class="bi bi-list toggle-sidebar-btn"></i>문의 내역
					</h1>
				</div>
			</div>

			<div class="tab-content pt-2" id="myTabContent">
				<div class="tab-pane fade show active" id="list" role="tabpanel"
					aria-labelledby="board">
					<div class="row">
						<div class="card" style="width: 70%; margin: auto;">
							<div class="card-body">
								<div align="right">
									<c:if test="${ sessionScope.loginInfo.id != null }">
										<input type="button" value="문의하기" class="btn btn-warning btn-sm" onclick="location.href='questionInsert.qt'">
									</c:if>
								</div>
								<h5 class="card-title">문의 내역</h5>
								<div class="col-md-5" align="left"></div>
								<table class="table table-hover">
									<tr align="center">
										<th scope="col">번호</th>
										<th scope="col" width="40%">문의 제목</th>
										<th scope="col">문의 날짜</th>
										<th scope="col">상태</th>
									</tr>
									<c:if test="${ empty myQuestionList }">
										<tr align="center">
											<td colspan="4">문의 내역이 없습니다.</td>
										</tr>
									</c:if>

									<c:if test="${ !empty myQuestionList }">
										<c:forEach var="question" items="${ myQuestionList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ totalCount - (param.pageNumber-1)*(param.pageSize) - status.index }</th>
												<td>
													<a style="color: #FAC710;"href="questionDetail.qt?qnum=${ question.qnum }">${ question.qsubject }</a></td>
												<td>
													<fmt:parseDate var="parseDate" value="${ question.qdate }" pattern="yyyy-MM-dd HH:mm" />
													<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm" />
												</td>
												<td>${ question.qstatus }</td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>



							<div style="display: inline-block; margin: auto;">
								<nav aria-label="Page navigation example">
									<ul class="pagination">
										<c:if test="${ pageInfo.beginPage != 1 }">
											<li class="page-item"><a style="color: #FAC710;"
												class="page-link"
												href="${ pageInfo.url }?pageNumber=${ pageInfo.beginPage - 1 }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>

										<c:forEach begin="${ pageInfo.beginPage }"
											end="${ pageInfo.endPage }" var="page">
											<c:if test="${ page == pageNumber }">
												<li class="page-item disabled"><a class="page-link"
													href="#">${ page }</a></li>
											</c:if>
											<c:if test="${ page != pageNumber }">
												<li class="page-item"><a style="color: #FAC710;"
													class="page-link"
													href="${ pageInfo.url }?pageNumber=${ page }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }">${ page }</a></li>
											</c:if>
										</c:forEach>

										<c:if test="${ pageInfo.endPage != pageInfo.totalPage }">
											<li class="page-item"><a style="color: #FAC710;"
												class="page-link"
												href="${ pageInfo.url }?pageNumber=${ pageInfo.endPage + 1 }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</main>
</body>
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
