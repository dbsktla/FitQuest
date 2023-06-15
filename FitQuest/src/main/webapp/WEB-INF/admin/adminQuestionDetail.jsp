<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/adminTop.jsp"%>

<style>
	.err{
		color:red;
	}
</style>

<script>
	function qcommentInsert(){
		document.getElementById('qcommentTable').innerHTML += 
			'<tr>' +
			'<td colspan="4">' +
			'<input type="hidden" name="qnum" value="${ questionBean.qnum }">' +
			'<input type="text" placeholder="답변" name="qcomment" id="qcomment" class="form-control" value="${ qcommentBean.qcomment }">' +
			'<form:errors cssClass="err" path="qcomment"/>' +
			'</td>' +
			'<td align="right">' +
			'<input type="submit" value="작성" class="btn btn-primary btn-sm">' +
			'</td>' +
			'</tr>';
		document.getElementById('insertBtn').style.display = 'none';
	}
	function insertSubmit(){
		if(document.getElementById('qcomment').value == ''){
			alert('답변 내용을 입력해 주세요.');
			document.getElementById('qcomment').focus();
			return false;
		}
	}
	
</script>

<main id="main" class="main">
    <div class="pagetitle">
      <h1>문의 상세 보기</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="adminMain.ad">Home</a></li>
          <li class="breadcrumb-item active">문의 상세 보기</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->
    
		<div class="tab-pane fade show active" id="list" role="tabpanel"
			aria-labelledby="board">
			<div class="row">
				<div class="card" style="width: 70%; margin: auto;">
					<div class="card-body" align="center">
						<h5 class="card-title">${ questionBean.qsubject }</h5>
						<div align="right">
							<input type="button" value="목록보기" class="btn btn-primary btn-sm" onclick="history.go(-1)">
						</div>
						<br>
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
				</td></tr>
		</table>
		
		
		<form action="bcommentInsert.co" method="post">
			<table class="table" id="bcommentTable">
				<tr align="left" style="border: white;">
					<th>관리자 답변</th>
					<c:if test="${ count == 0 }">
						<c:if test="${ sessionScope.loginInfo.id eq 'admin' }">
							<td colspan="3" align="right">
								<input type="button" value="추가" id="insertBtn" class="btn btn-primary btn-sm" onclick="qcommentInsert()">
							</td>
						</c:if>
					</c:if>
				</tr>
				<c:if test="${ not empty qcommentBean }">
					<tr align="left">
						<td colspan="2" width="70%">
							${ qcommentBean.qcomment }
						</td>
						<td>
							<fmt:parseDate var="parseDate" value="${ qcommentBean.qcdate }" pattern="yyyy-MM-dd HH:mm" />
							<fmt:formatDate value="${ parseDate }" pattern="MM-dd HH:mm"/>
						</td>
						<c:if test="${ sessionScope.loginInfo.id eq 'admin' }">
							<td align="right">
								<a href="adfminQcommentDelete.ad?qcnum=${qcommentBean.qcnum}&qnum=${ questionBean.qnum }">삭제</a>
							</td>
						</c:if>	
					</tr>
				</c:if>
			</table>
		</form>
		
		<form action="adfminQcommentInsert.ad" method="post" onsubmit="return insertSubmit()">
			<table class="table" id="qcommentTable">
				
			</table>
		</form>
		
				</div>
			</div>
		</div>
	</div>
    
</main>


<%@ include file="../common/adminBottom.jsp"%>
