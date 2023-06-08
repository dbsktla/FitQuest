<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<script>
	function freeBoardDelete(){
		var check = confirm('삭제하시겠습니까?');
		if(check){
			location.href='freeBoardDelete.co?bnum=${ boardBean.bnum }&id=${ boardBean.id }';
		}
	}
</script>

<body style="background-color: #FEF9E7; text-align: center;">
	<main>
		<div class="card" style="width: 70%; margin: auto;">
			<div class="card-body">
				<div align="right">
					<input type="button" value="목록보기" class="btn btn-warning btn-sm" onclick="location.href='freeBoardList.co'">
					<c:if test="${ sessionScope.loginInfo.id eq boardBean.id }">
						<input type="button" value="수정하기" class="btn btn-warning btn-sm" onclick="location.href='#">
						<input type="button" value="삭제하기" class="btn btn-warning btn-sm" onclick="freeBoardDelete()">
					</c:if>
					<input type="button" value="답글작성" class="btn btn-warning btn-sm" onclick="location.href='#'">
				</div>
			
				<h2 class="card-title">${ boardBean.bsubject }</h2>
				
				<table class="table">
						<tr align="center">
							<th>번호</th>
							<td>${ boardBean.bnum }</td>
							<th>작성자</th>
							<td>${ boardBean.name }</td>
						</tr>
						<tr align="center">
							<th width="10%">카테고리</th>
							<td>${ boardBean.bcategory }</td>
							<th>작성일</th>
							<td>
								<fmt:parseDate var="parseDate" value="${ boardBean.bregdate }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="yyyy-MM-dd HH:mm"/>
							</td>
						</tr>
						<tr align="left">
							<td></td>
							<td  colspan="3" align="justify">${ boardBean.bcontent }</td>
						</tr>
						<tr height="50" style="border:white;"><td></td></tr>
				</table>
				<table class="table">
					<tr align="left" style="border: white;">
						<th>댓글</th>
					</tr>
					<tr align="left">
						<td colspan="2" width="70%">댓글 내용</td>
						<td>${ boardBean.name }</td>
						<td>
							<fmt:parseDate var="parseDate" value="${ boardBean.bregdate }" pattern="yyyy-MM-dd HH:mm" />
							<fmt:formatDate value="${ parseDate }" pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
				</table>
			</div>	
		</div>
	</main>
	
</body>	
	
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
