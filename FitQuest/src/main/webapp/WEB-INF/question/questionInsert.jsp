<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<style type="text/css">
	.err{
		color : #E04848;
		font-size: 10pt;
	}
</style>

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
						<i class="bi bi-list toggle-sidebar-btn"></i>문의 작성
					</h1>
				</div>
			</div>

			<div class="tab-content pt-2" id="myTabContent">
				<!-- 리스트보기 -->
				<div class="tab-pane fade show active" id="list" role="tabpanel"
					aria-labelledby="board">
					<div class="row">
						<div class="card" style="width: 70%; margin: auto;">
							<div class="card-body">
								<h5 class="card-title">문의 작성</h5>
								<form:form commandName="questionBean" method="post" class="row g-3" action="questionInsert.qt">
									<input type="hidden" name="id" value="${ sessionScope.loginInfo.id }">
								<div class="col-md-12" align="left">
									<input type="text" name="qsubject" class="form-control" id="qsubject" value="${ questionBean.qsubject }" placeholder="제목">
									<form:errors cssClass="err" path="qsubject" />
								</div>
											
								 <div class="col-md-12" align="left">
			                      	<textarea rows="5" cols="50" name="qcontent" class="form-control" id="qcontent">${ questionBean.qcontent }</textarea>
			                      	<br>
			                      	<form:errors cssClass="err" path="qcontent" />
			                      </div>
								<div class="text-center">
									<button type="submit" id="sub" class="btn btn-warning btn-sm">작성하기</button>
								</div>
							</form:form>
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
