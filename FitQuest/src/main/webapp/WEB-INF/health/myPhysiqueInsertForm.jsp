<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPhysiqueInsertForm.jsp -->
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>
	.errmsg{
		color: red;
	}
</style>

<!-- <script type="text/javascript" src="resources/js/jquery.js" ></script> -->
<script src="http://code.jquery.com/jquery-1.7.min.js" type="text/javascript"></script>
<script>

	var dataCheck = false;

	function inputCheck() {
		$('.errmsg').empty();
		
		var dataCheck2 = false;
		
		if($('#height').val() == "" || $('#height').val() == 0.0){
			dataCheck = false;
			$('.herrmsg').append("키를 입력하세요");
			dataCheck2 = true;
		}
		if($('#weight').val() == "" || $('#weight').val() == 0.0){
			dataCheck = false;
			$('.werrmsg').append("몸무게를 입력하세요");
			dataCheck2 = true;
		}
		if($('#phdate').val() == ""){
			$('.pherrmsg').append("측정 일자를 선택하세요");
			dataCheck2 = true;
		}
		
		// 측정일 데이터 체크
		if(!dataCheck){
			alert('입력값을 확인하세요');
			return false;
		}
		if(dataCheck2){
			return false;
		}
		
		if($('#skeletalmuscle').val() != ""){
			$('#skeletalmuscle').attr("value", (bmi).toFixed(2));
		}
		if($('#bodyfatper').val() != ""){
			$('#bodyfatper').attr("value", (bmi).toFixed(2));
		}
		if($('#bmr').val() != ""){
			$('#bmr').attr("value", (bmi).toFixed(2));
		}
		
		
	}
	
	function calbmi() {
		dataCheck = true;
		$('.errmsg').empty();
		
		var h = $('#height').val();
		var w = $('#weight').val();
		var bmi = 0;
		//alert(h + "," + w);
		
		if(!($.isNumeric(h))){
			dataCheck = false;
			$('.herrmsg').append("숫자만 입력 가능");
			$('#height').attr("value", h.replace(h.charAt(h.length - 1), ""));
		}
		
		if(!($.isNumeric(w))){
			dataCheck = false;
			$('.werrmsg').append("숫자만 입력 가능");
			$('#weight').attr("value", w.replace(w.charAt(w.length - 1), ""));
		}
		
		if(h!="" && w!=""){
			var hmeter = h/100;
			bmi = w / (hmeter * hmeter);
			//alert(bmi);
			
			$('#bmi').attr("value", (bmi).toFixed(2));
		}
	}
	
	function inputValid() {
		dataCheck = true;
		$('.errmsg').empty();
		
		var sk = $('#skeletalmuscle').val();
		var bf = $('#bodyfatper').val();
		var b = $('#bmr').val();
		
		
		if(!($.isNumeric(sk))){
			dataCheck = false;
			$('.skerrmsg').append("숫자만 입력 가능");
			$('#skeletalmuscle').attr("value", sk.replace(sk.charAt(sk.length - 1), ""));
		}
		if($('#skeletalmuscle').val() == ""){
			$('.errmsg').empty();
			dataCheck = true;
			$('#skeletalmuscle').attr("value", 0.0);
		}
		
		if(!($.isNumeric(bf))){
			dataCheck = false;
			$('.bferrmsg').append("숫자만 입력 가능");
			$('#bodyfatper').attr("value", bf.replace(bf.charAt(bf.length - 1), ""));
		}
		if($('#bodyfatper').val() == ""){
			$('.errmsg').empty();
			dataCheck = true;
			$('#bodyfatper').attr("value", 0.0);
		}
		
		if(!($.isNumeric(b))){
			dataCheck = false;
			$('.berrmsg').append("숫자만 입력 가능");
			$('#bmr').attr("value", b.replace(b.charAt(b.length - 1), ""));
		}
		if($('#bmr').val() == ""){
			$('.errmsg').empty();
			dataCheck = true;
			$('#bmr').attr("value", 0);
		}
	}

</script>


<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 신체정보
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item"><a href="myPhysiqueList.ht">신체정보</a></li>
				<li class="breadcrumb-item active">신체정보 추가</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">신체정보 추가</h5>
					
					<form name="phyForm" action="myPhysiqueInsert.ht" method="post" enctype="multipart/form-data">
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="inbodyImage" class="col-form-label col-md-3 col-lg-2 col-form-label">인바디 이미지</label>
								<div class="col-md-8 col-lg-4">
									<input type="file" class="form-control" id="inbodyImage" name="upload" style="width: 100%;">
								</div>
								
								<label for="phdate" class="col-form-label col-md-3 col-lg-2 col-form-label">측정일</label>
								<div class="col-md-8 col-lg-4">
									<fmt:parseDate value="${phdate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
									<input name="phdate" type="date" class="form-control" id="phdate" value="<fmt:formatDate value='${day}' pattern='yyyy-MM-dd'/>" >
									<span class="errmsg pherrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="height" class="col-form-label col-md-3 col-lg-2 col-form-label">*신장(cm)</label>
								<div class="col-md-8 col-lg-4">
									<input name="height" type="text" class="form-control" id="height" value="0.0"  style="width: 100%;" onkeyup="calbmi()">
									<span class="errmsg herrmsg"></span>
								</div>
							
								<label for="weight" class="col-form-label col-md-3 col-lg-2 col-form-label">*체중(kg)</label>
								<div class="col-md-8 col-lg-4">
									<input name="weight" type="text" class="form-control" id="weight" value="0.0"  onkeyup="calbmi()">
									<span class="errmsg werrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="bmi" class="col-form-label col-md-3 col-lg-2 col-form-label">BMI</label>
								<div class="col-md-8 col-lg-4">
									<input name="bmi" type="text" class="form-control" id="bmi" value="0.0" readonly="readonly">
									<br><font style="color: gray; font-size: 12px">*BMI는 신장과 체중을 입력하면 자동계산됩니다.</font>
								</div>
							
								<label for="skeletalmuscle" class="col-form-label col-md-3 col-lg-2 col-form-label">골격근량(kg)</label>
								<div class="col-md-8 col-lg-4">
									<input name="skeletalmuscle" type="text" class="form-control" id="skeletalmuscle" value="0.0" onkeyup="inputValid()">
									<span class="errmsg skerrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="bodyfatper" class="col-form-label col-md-3 col-lg-2 col-form-label">체지방률(%)</label>
								<div class="col-md-8 col-lg-4">
									<input name="bodyfatper" type="text" class="form-control" id="bodyfatper" value="0.0" onkeyup="inputValid()">
									<span class="errmsg bferrmsg"></span>
								</div>
							
								<label for="bmr" class="col-form-label col-md-3 col-lg-2 col-form-label">기초대사량(kcal)</label>
								<div class="col-md-8 col-lg-4">
									<input name="bmr" type="text" class="form-control" id="bmr" value="0" onkeyup="inputValid()">
									<span class="errmsg berrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="text-center">
							<input type="submit" value="추가하기" class="btn btn-warning" onclick="return inputCheck()">
							<span class="errmsg"></span>
						</div>
					</form>
					
				</div><!-- card-body -->
			</div> <!-- card -->
		</div><!-- col 12 -->
	</div><!-- row -->
	

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>