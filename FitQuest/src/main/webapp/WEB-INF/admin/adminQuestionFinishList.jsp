<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/adminTop.jsp" %>
 <main id="main" class="main">
    <div class="pagetitle">
      <h1>완료 내역</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="adminMain.ad">Home</a></li>
          <li class="breadcrumb-item active">완료 내역</li>
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
								<h5 class="card-title">완료 내역</h5>
								<div class="col-md-5" align="left"></div>
								<table class="table table-hover">
									<tr align="center">
										<th scope="col">번호</th>
										<th scope="col">리뷰 제목</th>
										<th scope="col">문의한 회원</th>
										<th scope="col">상태</th>
										<th scope="col">내용</th>
									</tr>
									<c:if test="${ empty QueFinList }">
										<tr align="center">
											<td colspan="6">완료 내역이 없습니다.</td>
										</tr>
									</c:if>

									<c:if test="${ !empty QueFinList }">
										<c:forEach var="question" items="${ QueFinList }"
											varStatus="status">
											<tr align="center">
												<th scope="row">${ totalCount - (param.pageNumber-1)*(param.pageSize) - status.index }</th>
												<td>
													${ question.qsubject }
												</td>
												<td>${ question.name }</td>
												<td>${ question.qstatus }</td>
												<td>
													<input type="button" value="내용보기" class="btn btn-primary btn-sm" onclick="location.href='#'">
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
