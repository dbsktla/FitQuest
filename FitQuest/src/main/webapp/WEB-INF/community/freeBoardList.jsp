<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<%
	session.setAttribute("freeBoardListFlag", "true");
%>

<script type="text/javascript">
	function writerInfo(id){
		var openWin = window.open("memberInfoPopup.co?" + "id=" + id, "_blank", "width=550, height=500, left=500");
	}
</script>

<body style="background-color: #FEF9E7; text-align: center;">
	<main>
		<div class="card" style="width: 70%; margin: auto;">
			<div class="card-body">
				<div align="right">
					<c:if test="${ sessionScope.loginInfo.id != null }">
						<input type="button" value="작성하기" class="btn btn-warning btn-sm" onclick="location.href='freeBoardInsert.co'">
					</c:if>
				</div>
				<h5 class="card-title">자유 게시판</h5>
				<c:if test="${ not empty freeBoardList }">
				<div class="col-md-12" align="right">
					<a style="color : #FAC710;" href="freeBoardList.co?&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }">전체</a>
					<font color="#FAC710"> | </font>
					<a style="color : #FAC710;" href="freeBoardList.co?bcategory=일반&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }">일반</a>
					<font color="#FAC710"> | </font>
					<a style="color : #FAC710;" href="freeBoardList.co?bcategory=운동인증&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }">운동인증</a>
				 </div>
				 </c:if>
				 <div class="col-md-5" align="left">
				 	
				 </div>
				<table class="table table-hover">
						<tr align="center">
							<th scope="col">번호</th>
							<th scope="col" width="50%">제목</th>
							<th scope="col">카테고리</th>
							<th scope="col">작성자</th>
							<th scope="col">조회수</th>
							<th scope="col">작성일</th>
						</tr>
						<c:if test="${ empty freeBoardList }">
							<tr align="center">
								<td colspan="6">
									작성된 게시글이 없습니다.
								</td>
							</tr>
						</c:if>
						<c:if test="${ not empty freeBoardList }">
						<c:forEach var="board" items="${ hotFreeBoardList }" varStatus="status">
							<tr align="center" >
								<th scope="row" style="background-color: #FEF9E7">인기</th>
								<td align="left" style="background-color: #FEF9E7">
									<c:if test="${ board.brelevel > 0 }">
										<c:forEach var="i" begin="0" end="${ board.brelevel }">
											&emsp;
										</c:forEach>
										<i style="color : #FAC710;" class="bi bi-arrow-return-right"></i>
									</c:if>
									<a style="color : #FAC710;" href="freeBoardDetail.co?bnum=${ board.bnum }">${ board.bsubject }</a>
								</td>
								<td style="background-color: #FEF9E7">${ board.bcategory }</td>
								<td style="background-color: #FEF9E7"><a style="color : #FAC710;" href="javascript:writerInfo('${ board.id }')">${ board.name }</a></td>
								<td style="background-color: #FEF9E7">${ board.breadcount }</td>
								<td style="background-color: #FEF9E7">
									<fmt:parseDate var="parseDate" value="${ board.bregdate }" pattern="yyyy-MM-dd HH:mm" />
									<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
								</td>
							</tr>
						</c:forEach>
						<tr><td height="30" style="border: white;"></td><tr>
						<c:forEach var="board" items="${ freeBoardList }" varStatus="status">
							<tr align="center">
								<th scope="row">${ totalCount - (param.pageNumber-1)*(param.pageSize) - status.index }</th>
								<td align="left">
									<c:if test="${ board.brelevel > 0 }">
										<c:forEach var="i" begin="0" end="${ board.brelevel }">
											&emsp;
										</c:forEach>
										<i style="color : #FAC710;" class="bi bi-arrow-return-right"></i>
									</c:if>
									<a style="color : #FAC710;" href="freeBoardDetail.co?bnum=${ board.bnum }">${ board.bsubject }</a>
								</td>
								<td>${ board.bcategory }</td>
								<td><a style="color : #FAC710;" href="javascript:writerInfo('${ board.id }')">${ board.name }</a></td>
								<td>${ board.breadcount }</td>
								<td>
									<fmt:parseDate var="parseDate" value="${ board.bregdate }" pattern="yyyy-MM-dd HH:mm" />
									<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
								</td>
							</tr>
						</c:forEach>
						</c:if>
				</table>
				
			<c:if test="${ not empty freeBoardList }">
				<div class="col-md-6">
			      <form method="get" class="search-form d-flex align-items-center" action="freeBoardList.co">
				      <c:if test="${ bcategory != '' }">
				      	<input type="hidden" name="bcategory" value="${ bcategory }">
				      	<input type="hidden" name="pageNumber" value="1">
				      </c:if>
				      <div class="col-md-3">
				      <select name="whatColumn" class="form-select">
	                    <option value="">전체</option>
	                    <option value="bsubject">제목</option>
						<option value="name">작성자</option>
	                  </select>
	                  </div>
			        <input type="text" name="keyword" class="form-control" placeholder="Search">
			        &nbsp;<button type="submit" class="btn btn-warning">
			        	<i class="bi bi-search"></i>
			        </button>
			      </form>
			    </div>
			</c:if>
			</div>
			
			
			<div style=" display: inline-block; margin: auto;">
				<nav aria-label="Page navigation example">
	                <ul class="pagination">
	                <c:if test="${ pageInfo.beginPage != 1 }">
	                  <li class="page-item">
	                    <a style="color : #FAC710;" class="page-link" href="${ pageInfo.url }?pageNumber=${ pageInfo.beginPage - 1 }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }" aria-label="Previous">
	                      <span aria-hidden="true">&laquo;</span>
	                    </a>
	                  </li>
	                 </c:if> 
	                 
	                <c:forEach begin="${ pageInfo.beginPage }" end="${ pageInfo.endPage }" var="page">
	                	<c:if test="${ page == pageNumber }">
	                		<li class="page-item disabled"><a class="page-link" href="#">${ page }</a></li>
	                	</c:if>
	                	<c:if test="${ page != pageNumber }">
	                		<li class="page-item"><a style="color : #FAC710;" class="page-link" href="${ pageInfo.url }?pageNumber=${ page }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }">${ page }</a></li>
	                	</c:if>
	                </c:forEach>
	                
	                <c:if test="${ pageInfo.endPage != pageInfo.totalPage }">
	                  <li class="page-item">
	                    <a style="color : #FAC710;" class="page-link" href="${ pageInfo.url }?pageNumber=${ pageInfo.endPage + 1 }&pageSize=${ pageInfo.pageSize }&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }&bcategory=${ bcategory }" aria-label="Next">
	                      <span aria-hidden="true">&raquo;</span>
	                    </a>
	                  </li>
	                </c:if> 
	                </ul>
	              </nav>
			</div>    
		</div>
	</main>
	
</body>
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
