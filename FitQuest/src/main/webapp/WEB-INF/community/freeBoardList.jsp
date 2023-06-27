<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>

<%
	session.setAttribute("freeBoardListFlag", "true");
%>

<script type="text/javascript">
	function writerInfo(id){
		var openWin = window.open("memberInfoPopup.co?" + "id=" + id, "_blank", "width=550, height=500, left=500");
	}
	document.addEventListener("DOMContentLoaded", function() {
		  var buttons = document.querySelectorAll(".title-button");
		  var selectedButtonId = localStorage.getItem("selectedButtonId");

		  buttons.forEach(function(button) {
		    button.addEventListener("click", function() {
		      buttons.forEach(function(btn) {
		        btn.classList.remove("selected-board");
		      });
		      this.classList.add("selected-board");
		      selectedButtonId = this.id;
		      localStorage.setItem("selectedButtonId", selectedButtonId);
		    });
		  });

		  // 페이지 로드 시 전체 버튼 선택
		  var defaultButton = document.getElementById("button1");
		  defaultButton.classList.add("selected-board");
		  localStorage.setItem("selectedButtonId", "button1");

		  // 다른 페이지에서 돌아왔을 때 전체 버튼 선택
		  if (selectedButtonId && document.getElementById(selectedButtonId)) {
		    var selectedButton = document.getElementById(selectedButtonId);
		    selectedButton.classList.add("selected-board");
		    defaultButton.classList.remove("selected-board"); // 전체 버튼에서 클래스 제거
		  } else {
		    defaultButton.classList.add("selected-board");
		  }
		});
</script>

<body style="background-color: #FEF9E7; text-align: center;">
	<div class="title-container">
		<div class="title-text">자유 게시판</div>
	</div>
	<main>
		<div class="card" style="width: 70%; margin: auto;">
			<div class="card-body">
				<div align="right">
					<c:if test="${ sessionScope.loginInfo.id != null }">
						<input type="button" value="작성하기" class="btn btn-warning btn-sm" onclick="location.href='freeBoardInsert.co'">
					</c:if>
				</div>
				<div class="col-md-12" align="center" style="margin-bottom: 20px; border-bottom: 1px solid lightgray; padding-bottom: 15px;">  
					<button id="button1" onClick="window.location.href='freeBoardList.co?&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" class="title-button">
						전체
					</button>
					<button id="button2" onClick="window.location.href='freeBoardList.co?bcategory=일반&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" class="title-button">
						일반
					</button>
					<button id="button3" onClick="window.location.href='freeBoardList.co?bcategory=운동인증&pageNumber=1&whatColumn=${ param.whatColumn }&keyword=${ param.keyword }'" class="title-button" style="margin-right: 0;">
						운동인증
					</button>
				 </div>
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
									<a style="color : black; font-weight: bold;" href="freeBoardDetail.co?bnum=${ board.bnum }">${ board.bsubject }</a>
								</td>
								<td style="background-color: #FEF9E7">${ board.bcategory }</td>
								<td style="background-color: #FEF9E7"><a style="color : black;" href="javascript:writerInfo('${ board.id }')">${ board.name }</a></td>
								<td style="background-color: #FEF9E7">${ board.breadcount }</td>
								<td style="background-color: #FEF9E7">
									<fmt:parseDate var="parseDate" value="${ board.bregdate }" pattern="yyyy-MM-dd HH:mm" />
									<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${ empty freeBoardList }">
							<tr align="center">
								<td colspan="6">
									작성된 게시글이 없습니다.
								</td>
							</tr>
						</c:if>
						<c:if test="${ not empty freeBoardList }">
						<tr><td height="30" style="border: white;"></td><tr>
						<c:forEach var="board" items="${ freeBoardList }" varStatus="status">
							<tr align="center">
								<td scope="row">${ totalCount - (param.pageNumber-1)*(param.pageSize) - status.index }</td>
								<td align="left">
									<c:if test="${ board.brelevel > 0 }">
										<c:forEach var="i" begin="0" end="${ board.brelevel }">
											&emsp;
										</c:forEach>
										<i style="color : gray;" class="bi bi-arrow-return-right"></i>
									</c:if>
									<c:if test="${ board.bstatus eq '신고' }">
										${ board.bsubject }
									</c:if>
									<c:if test="${ board.bstatus != '신고' }">
										<a style="color : black; font-weight: bold;" href="freeBoardDetail.co?bnum=${ board.bnum }">${ board.bsubject }</a>
									</c:if>
								</td>
								<td>${ board.bcategory }</td>
								<td><a style="color : black;" href="javascript:writerInfo('${ board.id }')">${ board.name }</a></td>
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
				<div class="col-md-6" style="width: 100%; margin-top: 50px;">
			      <form method="get" class="search-form d-flex align-items-center" action="freeBoardList.co" style="justify-content: center;">
				      <c:if test="${ bcategory != '' }">
				      	<input type="hidden" name="bcategory" value="${ bcategory }">
				      	<input type="hidden" name="pageNumber" value="1">
				      </c:if>
				      <div class="col-md-3" style="width: 10%;">
					      <select name="whatColumn" class="form-select">
		                    <option value="">전체</option>
		                    <option value="bsubject">제목</option>
							<option value="name">작성자</option>
		                  </select>
	                  </div>
	                  <div style="display: flex; margin-left: 15px; width: 30%;">
				          <input type="text" name="keyword" class="form-control" placeholder="Search" style="margin-right: 10px; width: 100%;">&nbsp;
				          <button type="submit" class="btn btn-warning">
				          <i class="bi bi-search"></i>
				      	  </button>
			          </div>
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
