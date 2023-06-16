<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<script>
	function qcommentInsert(){
		document.getElementById('qcommentTable').innerHTML += 
			'<tr>' +
			'<td colspan="4">' +
			'<input type="hidden" name="bnum" value="${ qcommentBean.qnum }">' +
			'<input type="text" placeholder="답변" name="qcontent" class="form-control">' +
			'</td>' +
			'<td align="right">' +
			'<input type="submit" value="작성" class="btn btn-warning btn-sm">' +
			'</td>' +
			'</tr>';
		
		document.getElementById('insertBtn').style.display = 'none';
	}
</script>

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

				<div class="tab-pane fade show active" id="list" role="tabpanel"
					aria-labelledby="board">
					<div class="row">
						<div class="card" style="width: 70%; margin: auto;">
							<div class="card-body">
								<div align="right">
					<input type="button" value="목록보기" class="btn btn-warning btn-sm" onclick="history.go(-1)">
				</div>
				<h2 class="card-title">${ questionBean.qsubject }</h2>
				
				<table class="table">
						<tr align="center">
							<th>번호</th>
							<td>${ questionBean.qnum }</td>
							<th>작성자</th>
							<td>${ questionBean.name }</td>
						</tr>
						<tr align="center">
							<th>작성일</th>
							<td>
								<fmt:parseDate var="parseDate" value="${ questionBean.qdate }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
							</td>
							<th>상태</th>
							<td>${ questionBean.qstatus }</td>
						</tr>
						<tr style="border : white;">
							<td height="30"></td>
						</tr>
						<tr align="left" style="border:white;">
							<td style="padding-left: 1em;" colspan="4" align="justify">${ questionBean.qcontent }</td>
						</tr>
						<tr height="50"><td colspan="4">
							<div align="right">
								<c:if test="${ sessionScope.loginInfo.id eq boardBean.id }">
									<input type="button" value="삭제하기" class="btn btn-warning btn-sm" onclick="location.href='questionDelete.qt?qnum=${qnum}'">
								</c:if>
							</div>
						</td></tr>
				</table>
				
				
				<form action="bcommentInsert.co" method="post">
					<table class="table" id="bcommentTable">
						<tr align="left" style="border: white;">
							<th>관리자 답변</th>
						</tr>
						<c:if test="${ not empty qcommentBean }">
							<tr align="left">
								<td colspan="2" width="70%">
									${ qcommentBean.qcomment }
								</td>
								<td>
									관리자
								</td>
								<td>
									<fmt:parseDate var="parseDate" value="${ qcommentBean.qcdate }" pattern="yyyy-MM-dd HH:mm" />
									<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
								</td>
								<c:if test="${ sessionScope.loginInfo.id eq 'admin' }">
									<td align="right">
										<a style="color : #FAC710;" href="qcommentDelete.co?qcnum=${ qcommentBean.qcnum }">삭제</a>
									</td>
								</c:if>	
							</tr>
						</c:if>
					</table>
				</form>
				
				<form action="adfminQcommentInsert.ad" method="post">
					<table class="table" id="qcommentTable">
						
					</table>
				</form>
			</div>	
					</div>
				</div>
			</div>
		</main>
	</main>
</body>
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
