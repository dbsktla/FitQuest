<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<style>
	.err{
		color : #E04848;
		font-size: 10pt;
	}
	#report:hover{
		cursor: pointer;
	}
</style>

<script>
	function freeBoardDelete(){
		var check = confirm('삭제하시겠습니까?');
		if(check){
			location.href='boardDelete.co?bnum=${ boardBean.bnum }&id=${ boardBean.id }&btype${ boardBean.btype }';
		}
	}
	function freeBoardUpdate(){
		location.href='freeBoardUpdate.co?bnum=${ boardBean.bnum }&id=${ boardBean.id }';
	}
	function bcommentInsert(){
				
		var bcommentTr = document.getElementById('bcommentTable').getElementsByTagName('tr');
		var len = bcommentTr.length - ${ bcommentList.size() } - 1;
		
		if(len == 0){
			document.getElementById('bcommentTable').innerHTML += 
				'<tr>' +
				'<td colspan="7">' +
				'<input type="hidden" name="btype" value="${ boardBean.btype }">' +
				'<input type="hidden" name="bnum" value="${ boardBean.bnum }">' +
				'<input type="text" placeholder="답글" name="ccontent" class="form-control">' +
				'</td>' +
				'<td align="right">' +
				'<input type="submit" value="작성" class="btn btn-warning btn-sm">' +
				'</td>' +
				'</tr>';
		}	
		else{
			alert('이미 댓글창이 추가되었습니다.');
		}
	}
	function bcommentReply(btype,bnum,cref,crestep,crelevel){
		var bcommentTr = document.getElementById('bcommentReply').getElementsByTagName('tr');
		var len = bcommentTr.length;
		
		if(len == 0){
			document.getElementById('bcommentReply').innerHTML += 
				'<tr>' + 
				'<td colspan="7">' +
				'<input type="hidden" name="btype" value="' + btype + '">' +
				'<input type="hidden" name="bnum" value="' + bnum + '">' +
				'<input type="hidden" name="cref" value="' + cref + '">' +
				'<input type="hidden" name="crestep" value="' + crestep + '">' +
				'<input type="hidden" name="crelevel" value="' + crelevel + '">' +
				'<input type="text" name="ccontent" class="form-control">' +
				'</td>' +
				'<td align="right">' +
				'<input type="submit" value="작성" class="btn btn-warning btn-sm">' +
				'</td>' +
				'</tr>';
		}	
		else{
			alert('이미 답글창이 추가되었습니다.');
		}
	}
	function commentReportInsert(cnum,bnum){
		var openWin = window.open("reportInsertForm.co?bcnum=" + cnum + "&rtype=bcomment&bnum=" + bnum, "_blank", "width=500, height=500, left=300");
	}
	function boardReportInsert(bnum){
		var openWin = window.open("reportInsertForm.co?bcnum=" + bnum + "&rtype=board&bnum=" + bnum, "_blank", "width=500, height=500, left=300");
	}
</script>

<body style="background-color: #FEF9E7; text-align: center;">
	<main>
		<div class="card" style="width: 55%; margin: auto;">
			<div class="card-body">
				<div align="right">
					<input type="button" value="목록보기" class="btn btn-warning btn-sm" onclick="location.href='freeBoardList.co'">
					<c:if test="${ sessionScope.loginInfo != null }">
						<input type="button" value="신고하기" class="btn btn-danger btn-sm" onclick="boardReportInsert('${ boardBean.bnum }')">
					</c:if>	
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
							<th width="17%">카테고리</th>
							<td>${ boardBean.bcategory }</td>
							<th>작성일</th>
							<td>
								<fmt:parseDate var="parseDate" value="${ boardBean.bregdate }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
							</td>
						</tr>
						<tr align="left" style="border:white;">
							<td style="padding-left: 3em;" colspan="4" align="justify">${ boardBean.bcontent }</td>
						</tr>
						<tr height="50"><td colspan="4">
							<div align="right">
								<c:if test="${ sessionScope.loginInfo.id eq boardBean.id }">
									<input type="button" value="수정하기" class="btn btn-warning btn-sm" onclick="freeBoardUpdate()">
									<input type="button" value="삭제하기" class="btn btn-warning btn-sm" onclick="freeBoardDelete()">
								</c:if>
								<input type="button" value="답글작성" class="btn btn-warning btn-sm" onclick="location.href='freeBoardReply.co?bref=${ boardBean.bref }&brestep=${ boardBean.brestep }&brelevel=${ boardBean.brelevel }&bcategory=${ boardBean.bcategory }&bnum=${boardBean.bnum }'">
							</div>
						</td></tr>
				</table>
				
				
				<form action="bcommentInsert.co" method="post">
					<table class="table" id="bcommentTable">
						<tr align="left" style="border: white;">
							<th>댓글</th>
							<td colspan="7" align="right">
								<input type="button" value="추가" class="btn btn-outline-warning btn-sm" onclick="bcommentInsert('')">
							</td>
						</tr>
						<c:forEach var="bcomment" items="${ bcommentList }"> 
						<tr align="left">
							<td colspan="3" width="50%">
								<c:if test="${ bcomment.crelevel > 0 }">
									<c:forEach var="i" begin="0" end="${ bcomment.crelevel }">
										&nbsp;
									</c:forEach>
									<i style="color : #FAC710;" class="bi bi-arrow-return-right"></i>
								</c:if>
								${ bcomment.ccontent }
							</td>
							<td>${ bcomment.name }</td>
							<td>
								<fmt:parseDate var="parseDate" value="${ bcomment.cregdate }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
							</td>
							<c:if test="${ sessionScope.loginInfo != null }">
								<td align="right">
									<a style="color : #FAC710;" href="javascript:bcommentReply('${ boardBean.btype }','${ boardBean.bnum }','${ bcomment.cref }','${ bcomment.crestep }','${ bcomment.crelevel }')">답글</a>
								</td>
								<td align="right">
									<a id="report" href="javascript:commentReportInsert('${ bcomment.cnum }','${ boardBean.bnum }')" style="color : red;">신고</a>
								</td>
							</c:if>
							<c:if test="${ sessionScope.loginInfo.id eq bcomment.id }">
								<td align="right">
									<a style="color : #FAC710;" href="bcommentDelete.co?cnum=${ bcomment.cnum }&id=${ bcomment.id }&bnum=${ bcomment.bnum }&btype=${ boardBean.btype }">삭제</a>
								</td>
							</c:if>
						</tr>
						</c:forEach>
					</table>
				</form>
				
				<form action="bcommentReply.co" method="post">
					<table class="table" id="bcommentReply">
						
					</table>
				</form>
			</div>	
		</div>
	</main>
	
</body>	
	
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
