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


<body style="background-color: #FEF9E7;">

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
					<h2 class="card-title">${ tquestionBean.tqsubject }</h2>

					<table class="table">
						<tr align="center">
							<th>문의번호</th>
							<td>${ tquestionBean.tqnum }</td>
							<th>문의 이메일</th>
							<td>${ tquestionBean.tqemail }</td>
						</tr>
						<tr align="center">
							<th>문의날짜</th>
							<td>
								<fmt:parseDate var="parseDate" value="${ tquestionBean.tqdate }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm" />
							</td>
							<th>회신 연락처</th>
							<td>${ tquestionBean.tqanswer }</td>
						</tr>
						<tr style="border: white;">
							<td height="30"></td>
						</tr>
						<tr align="left" style="border: white;">
							<td style="padding-left: 1em;" colspan="4" align="justify">${ tquestionBean.tqcontent }</td>
						</tr>
						<tr>
							<td colspan="4"><font color="gray" size="2">* 문의 내역은 30일간 보관되며 별도 삭제 불가능합니다.</font></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	
</body>


<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
