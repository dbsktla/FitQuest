<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<c:if test="${loginInfo.mtype eq 'trainer'}">
<%@ include file="../common/myTrainerTop.jsp"%>
</c:if>
<c:if test="${loginInfo.mtype eq 'generic'}">
<%@ include file="../common/myMemberTop.jsp"%>
</c:if>


<body style="background-color: #FEF9E7; ">
<!-- 	<main id="main" class="main" style="margin-top: 5px"> -->
<!-- 		<main> -->
			<div class="col-lg-12">
				<div class="pagetitle" style="text-align: left;">
					<h1>
						<i class="bi bi-list toggle-sidebar-btn"></i>내 글보기
					</h1>
				</div>
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="list-tab" data-bs-toggle="tab"
							data-bs-target="#list" type="button" role="tab"
							,aria-controls="list" aria-selected="true">내 글보기</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="cal-tab" data-bs-toggle="tab"
							data-bs-target="#cal" type="button" role="tab"
							aria-controls="cal" aria-selected="false">스크랩</button>
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
								<h5 class="card-title"  style="text-align: center;">내 글보기</h5>
								<div class="col-md-12" align="right">
									<a style="color: #FAC710;"
										href="myBoardList.co?&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }">전체</a>
									<font color="#FAC710"> | </font> <a style="color: #FAC710;"
										href="myBoardList.co?bcategory=자유&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }">자유</a>
									<font color="#FAC710"> | </font> <a style="color: #FAC710;"
										href="myBoardList.co?bcategory=건강&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }">건강
										정보</a>
								</div>
								<div class="col-md-5" align="left"></div>
								<table class="table table-hover">
									<tr align="center">
										<th scope="col">번호</th>
										<th scope="col" width="40%">제목</th>
										<th scope="col">카테고리</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
										<th scope="col">작성일</th>
									</tr>
									<c:if test="${ empty myBoardList }">
										<tr align="center">
											<td colspan="6">작성한 글이 없습니다.</td>
										</tr>
									</c:if>

									<c:if test="${ !empty myBoardList }">
										<c:forEach var="board" items="${ myBoardList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ totalCount - (param.pageNumber-1)*(param.pageSize) - status.index }</th>
												<td align="left">
													<c:if test="${ board.bstatus eq '신고' }">
														${ board.bsubject }
													</c:if>
													<c:if test="${ board.bstatus != '신고' }">
														<c:if test="${ board.btype == '자유' }">
															<a style="color: #FAC710;"
																href="freeBoardDetail.co?bnum=${ board.bnum }">${ board.bsubject }</a>
														</c:if> <c:if test="${ board.btype == '건강' }">
															<a style="color: #FAC710;"
																href="healthBoardDetail.co?bnum=${ board.bnum }">${ board.bsubject }</a>
														</c:if>
													</c:if>
													</td>
												<td>${ board.bcategory }</td>
												<td>${ board.name }</td>
												<td>${ board.breadcount }</td>
												<td><fmt:parseDate var="parseDate"
														value="${ board.bregdate }" pattern="yyyy-MM-dd HH:mm" />
													<fmt:formatDate value="${ parseDate }"
														pattern="MM-dd HH:mm" /></td>
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
				<div class="tab-pane fade" id="cal" role="tabpanel"
					aria-labelledby="cal-tab">
					<div id="scrap">
						<div class="card" style="width: 60%; margin: auto;">
							<div class="card-body">
								<div align="right"></div>
								<h5 class="card-title" style="text-align: center;">스크랩</h5>
								<div class="col-md-5" align="left"></div>
								<table class="table table-hover">
									<tr align="center">
										<th scope="col">번호</th>
										<th scope="col" width="40%">제목</th>
										<th scope="col">작성자</th>
									</tr>
									<c:if test="${ empty myScrapList }">
										<tr align="center">
											<td colspan="3">스크랩한 글이 없습니다.</td>
										</tr>
									</c:if>
									<c:if test="${ not empty myScrapList }">
										<c:forEach var="scrap" items="${ myScrapList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ status.count }</th>
												<td>
													<c:if test="${ scrap.bstatus == '신고' }">
														${ scrap.bsubject }
													</c:if>
													<c:if test="${ scrap.bstatus != '신고' }">
														<c:if test="${ scrap.btype == '자유' }">
															<a style="color: #FAC710;"
																href="freeBoardDetail.co?bnum=${ scrap.bnum }">${ scrap.bsubject }</a>
														</c:if> <c:if test="${ scrap.btype == '건강' }">
															<a style="color: #FAC710;"
																href="healthBoardDetail.co?bnum=${ scrap.bnum }">${ scrap.bsubject }</a>
														</c:if>
													</c:if>
												</td>
												<td>${ scrap.name }</td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- 		</main> -->
<!-- 	</main> -->
</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>