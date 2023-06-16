<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- myPhysiqueGoalForm.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>
	.errmsg{
		color: red;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	function validCheck() {
		$('.errmsg').empty();
		flag = false;
		
		var str = "필수입력사항";
		
		if($('#gpdate').val() == ""){
			$('#derr').html(str);
			flag = true;
		}
		if($('#weight').val() == ""){
			$('#werr').html(str);
			flag = true;
		}
		if($('#bodyfatper').val() == ""){
			$('#berr').html(str);
			flag = true;
		}
		if($('#goaltime').val() == ""){
			$('#terr').html(str);
			flag = true;
		}
		
		if(flag){
			return false;
		}
	}
</script>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 목표관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item active">목표관리</li>
			</ol>
		</nav>
	</div>
	
	<div class="row justify-content-center">
		<form action="myPhysiqueGoal.ht" method="post" style="width: 70%;margin-top: 5%;margin-bottom: 5%;">
			
			
			<fmt:parseDate value="${goalphysiqueBean.gpdate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
			
			<div class="row mb-3">
				<label for="gpdate" class="col-md-4 col-lg-3 col-form-label"><b>목표일</b></label>
				<div class="col-md-8 col-lg-9">
					<input name="gpdate" type="date" class="form-control" id="gpdate" value="<fmt:formatDate value='${day}' pattern='yyyy-MM-dd'/>">
					<div class="errmsg" id="derr"></div>
				</div>
			</div>
	
			<div class="row mb-3">
				<label for="weight" class="col-md-4 col-lg-3 col-form-label"><b>목표 체중<br>(단위 : kg)</b></label>
				<div class="col-md-8 col-lg-9">
					<input name="weight" type="number" step="0.01" class="form-control" id="weight" value="${goalphysiqueBean.weight}">
					<div class="errmsg" id="werr"></div>
				</div>
			</div>
	
			<div class="row mb-3">
				<label for="bodyfatper" class="col-md-4 col-lg-3 col-form-label"><b>목표 체지방률<br>(단위 : %)</b></label>
				<div class="col-md-8 col-lg-9">
					<input name="bodyfatper" type="number" step="0.01" class="form-control" id="bodyfatper" value="${goalphysiqueBean.bodyfatper}">
					<div class="errmsg" id="berr"></div>
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="goaltime" class="col-md-4 col-lg-3 col-form-label"><b>이번주 목표 운동시간<br>(단위 : 시간)</b></label>
				<div class="col-md-8 col-lg-9">
					<input name="goaltime" type="number" step="0.01" class="form-control" id="goaltime" value="${goalphysiqueBean.goaltime}">
					<div class="errmsg" id="terr"></div>
				</div>
			</div>
	
			<div class="text-center">
				<button type="submit" class="btn btn-warning scrollto" onclick="return validCheck()">저장하기</button>
			</div>
		</form>
		<!-- End Profile Edit Form -->
	</div>



</body>


<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>
