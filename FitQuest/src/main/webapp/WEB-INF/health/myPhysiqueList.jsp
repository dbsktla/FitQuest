<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- myPhysiqueList -->
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>
	table{
		text-align: center;
	}
	td, tr{
		height: 40px;
		width: 40px;
	}
	.daySun{
		color: red;
	}
	.daySat{
		color: blue;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	function calenderLookup() {
		var sYear = $('#selectYear option:selected').val();
		var sMon = $('#selectMon option:selected').val();
		
		//alert(sYear);
		//alert(sMon);
		
		$.ajax({
			type : "POST",
			url : "myPhysiqueList.ht",
			data : ({'selectYear' : sYear, 'selectMon' : sMon}),
			dataType : "json",
			success : function (data) {
				$('#calenderTable').empty(); // calenderTable div 내용 비우기
				var msg = '<table><tr><td class="daySun">일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td class="daySat">토</td></tr>';
				
				//alert(data[0].date);
				for(var i=0; i<data.length; i++){
					if(i == 0){
						for(var j=0; j<data[i].date; j++){
							msg += '<td> </td>';
						}
					}
					
					//alert(data[i].i);
					if(data[i].date == 0){
						msg += '</tr><tr>';
					}
					
					
					if(data[i].date == 0){
						msg += "<td class='daySun'>" + (i+1) + "</td>";
					}else if(data[i].date == 6){
						msg += "<td class='daySat'>" + (i+1) + "</td>";
					}else{
						msg += "<td>" + (i+1) + "</td>";
					}
					
				}// for
				
				msg += '</tr></table>';
				
				
				$("#calenderTable").append(msg);
			}
		}); // ajax
	}
</script>

<%
	Date now = new Date();
%>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 신체정보
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item active">신체정보</li>
			</ol>
		</nav>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">신체정보</h5>

					<div class="col-lg-5">
						
						<div>
							<select name="selectYear" id="selectYear">
								<c:forEach var="i" begin="<%=now.getYear() + 1890%>" end="<%=now.getYear() + 1900%>">
									<option value="${i}" <c:if test="${i == selectYear}">selected</c:if>>${i}</option>
								</c:forEach>
							</select> 년
							
							<select name="selectMon" id="selectMon">
								<c:forEach var="i" begin="1" end="12">
									<option value="${i}" <c:if test="${i == selectMon}">selected</c:if>>${i}</option>
								</c:forEach>
							</select> 월
							
							<input type="button" value="조회" onclick="calenderLookup()">
						</div>
						
						<div id="calenderTable">
							<table>
								<tr>
									<td class="daySun">일</td>
									<td>월</td>
									<td>화</td>
									<td>수</td>
									<td>목</td>
									<td>금</td>
									<td class="daySat">토</td>
								</tr>
								<tr>
									<c:forEach var="i" items="${dateMap}" varStatus="status">
										<c:if test="${status.index == 0}">
											<c:forEach var="j" begin="0" end="${i.value - 1}">
												<td></td>
											</c:forEach>
										</c:if>
										<c:if test="${i.value == 0}">
											</tr>
											<tr>
										</c:if>
										
										<c:if test="${i.value == 0}">
											<td class="daySun">${i.key}</td>
										</c:if>
										<c:if test="${i.value == 6}">
											<td class="daySat">${i.key}</td>
										</c:if>
										<c:if test="${i.value != 0 and i.value != 6}">
											<td>${i.key}</td>
										</c:if>
										
									</c:forEach>
								</tr>
							</table>
						</div>
						
					</div>

					<div class="col-lg-7"></div>
				</div>
			</div>
		</div>

		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">이번달 체중 변화</h5>
				</div>
			</div>
		</div>

		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">이번달 골격근량 변화</h5>
				</div>
			</div>
		</div>

		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">이번달 체지방률 변화</h5>
				</div>
			</div>
		</div>
	</div>
	<!-- row -->

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>