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

<style type="text/css">
	.err{
		color : #E04848;
		font-size: 10pt;
	}
</style>

<body style="background-color: #FEF9E7; text-align: center;">
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
</body>
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
