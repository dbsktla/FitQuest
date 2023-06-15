<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPhysiqueUpdateForm.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>
	.errmsg{
		color: red;
	}
	.img{
    width: auto;
    border-radius: 10px;
    cursor: pointer;
    transition: 0.3s;
	}
	/* 이미지 클릭 시, 밝기 조절 */
	.img:hover {opacity: 0.8;}
	
	.modal {
	  display: none; /* 모달창 숨겨 놓기 */
	  position: fixed; 
	  z-index: 1; /* 모달창을 제일 앞에 두기 */
	  padding-top: 100px;
	  left: 0; top: 0;
	  width: 100%; height: 100%;
	  overflow: auto; /* 스크롤 허용 auto */
	  cursor: pointer; /* 마우스 손가락모양 */
	  background-color: rgba(0, 0, 0, 0.8);
	}
	/* 모달창 이미지 */
	.modal_content {
	  margin: auto;
	  display: block;
	  width: 50%; height: auto;
	  max-width: 1000px;
	  border-radius: 10px;
	  animation-name: zoom;
	  animation-duration: 0.8s;
	}
	/* 모달창 애니메이션 추가 */
	@keyframes zoom {
	  from {transform: scale(0)}
	  to {transform: scale(1)}
	}
	/* 닫기 버튼 꾸미기 */
	.close {
	  position: absolute;
	  top: 15px;
	  right: 35px;
	  color: #f1f1f1;
	  font-size: 40px;
	  font-weight: bold;
	  transition: 0.3s;
	}
	.close:hover, .close:focus{
	  color: #bbb;
	  text-decoration: none;
	  cursor: pointer;
	}
</style>

<!-- <script type="text/javascript" src="resources/js/jquery.js" ></script> -->
<!-- isNumeric 사용으로 인한 버전 -->
<script src="http://code.jquery.com/jquery-1.7.min.js" type="text/javascript"></script>
<script>

	var dataCheck = true;

	function inputCheck() {
		
		if($('#height').val() == "" || $('#height').val() == 0.0){
			dataCheck = false;
			$('.herrmsg').append("키를 입력하세요");
			return false;
		}
		if($('#weight').val() == "" || $('#weight').val() == 0.0){
			dataCheck = false;
			$('.werrmsg').append("몸무게를 입력하세요");
			return false;
		}
		if($('#phdate').val() == ""){
			$('.pherrmsg').append("측정 일자를 선택하세요");
			return false;
		}
		
		// 측정일 데이터 체크
		if(!dataCheck){
			alert('입력값을 확인하세요');
			return false;
		}
		
		
		var height = parseFloat($('#height').val());
		var weight = parseFloat($('#weight').val());
		var skeletalmuscle = parseFloat($('#skeletalmuscle').val());
		var bodyfatper = parseFloat($('#bodyfatper').val());
		var bmr = Number($('#bmr').val());
		
		if($('#height').val() != ""){
			$('#height').attr("value", (height).toFixed(2));
		}
		if($('#weight').val() != ""){
			$('#weight').attr("value", (weight).toFixed(2));
		}
		if($('#skeletalmuscle').val() != ""){
			$('#skeletalmuscle').attr("value", (skeletalmuscle).toFixed(2));
		}
		if($('#bodyfatper').val() != ""){
			$('#bodyfatper').attr("value", (bodyfatper).toFixed(2));
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
	const modal = document.querySelector(".modal");
	const img = document.querySelector(".img");
	const modal_img = document.querySelector(".modal_content");
	const span = document.querySelector(".close");
	
	$(document).ready(function(){
		
		$('.imgs').click(function () {
			$('.modal').css('display', "block");
			$('.modal').html("<img class='modal_content' src='"+$('.imgs').attr("src")+"'>");
		});
		
		$('.close').click(function () {
			$('.modal').css('display', "none");
		});
		
		$('.modal').click(function () {
			$('.modal').css('display', "none");
		});
	});
	
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
				<li class="breadcrumb-item active">신체정보 수정</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">신체정보 수정</h5>
					
					<form name="phyForm" action="myPhysiqueUpdate.ht" method="post" enctype="multipart/form-data">
						
						<div class="row mb-3">
							<div class="row mb-3">
								<c:if test="${empty physiqueBean.phimage}">
									<div style="text-align: center;">등록된 이미지가 없습니다.</div>
								</c:if>
								<c:if test="${not empty physiqueBean.phimage}">
									<img class="imgs" src="<%=request.getContextPath()%>/resources/Image/InbodyImage/${physiqueBean.phimage}" style="margin: auto; width: 20%;">
									<div class="modal">
									  <span class="close">&times;</span>
									</div>
								</c:if>
							</div>
							
							<div class="row mb-3">
								<label for="inbodyImage" class="col-form-label col-md-3 col-lg-2 col-form-label">인바디 이미지</label>
								<div class="col-md-8 col-lg-4">
									<input type="file" class="form-control" id="inbodyImage" name="upload" style="width: 100%;" value="${physiqueBean.phimage}">
									<input type="hidden" name="upload2" value="${physiqueBean.phimage}">
									<input type="hidden" name="phnum" value="${param.phnum}">
								<span class="errmsg"></span>
								</div>	
								
								<label for="phdate" class="col-form-label col-md-3 col-lg-2 col-form-label">측정일</label>
								<div class="col-md-8 col-lg-4">
									<fmt:parseDate value="${physiqueBean.phdate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
									<input name="phdate" type="date" class="form-control" id="phdate" value="<fmt:formatDate value='${day}' pattern='yyyy-MM-dd'/>" >
									<span class="errmsg pherrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="height" class="col-form-label col-md-3 col-lg-2 col-form-label">신장(cm)</label>
								<div class="col-md-8 col-lg-4">
									<input name="height" type="text" class="form-control" id="height" value="${physiqueBean.height}"  style="width: 100%;" onkeyup="calbmi()">
									<span class="errmsg herrmsg"></span>
								</div>
							
								<label for="weight" class="col-form-label col-md-3 col-lg-2 col-form-label">체중(kg)</label>
								<div class="col-md-8 col-lg-4">
									<input name="weight" type="text" class="form-control" id="weight" value="${physiqueBean.weight}"  onkeyup="calbmi()">
									<span class="errmsg werrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="bmi" class="col-form-label col-md-3 col-lg-2 col-form-label">BMI</label>
								<div class="col-md-8 col-lg-4">
									<input name="bmi" type="text" class="form-control" id="bmi" value="${physiqueBean.bmi}" readonly="readonly">
								</div>
							
								<label for="skeletalmuscle" class="col-form-label col-md-3 col-lg-2 col-form-label">골격근량(kg)</label>
								<div class="col-md-8 col-lg-4">
									<input name="skeletalmuscle" type="text" class="form-control" id="skeletalmuscle" value="${physiqueBean.skeletalmuscle}" onkeyup="inputValid()">
									<span class="errmsg skerrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="bodyfatper" class="col-form-label col-md-3 col-lg-2 col-form-label">체지방률(%)</label>
								<div class="col-md-8 col-lg-4">
									<input name="bodyfatper" type="text" class="form-control" id="bodyfatper" value="${physiqueBean.bodyfatper}" onkeyup="inputValid()">
									<span class="errmsg bferrmsg"></span>
								</div>
							
								<label for="bmr" class="col-form-label col-md-3 col-lg-2 col-form-label">기초대사량(kcal)</label>
								<div class="col-md-8 col-lg-4">
									<input name="bmr" type="text" class="form-control" id="bmr" value="${physiqueBean.bmr}" onkeyup="inputValid()">
									<span class="errmsg berrmsg"></span>
								</div>
							</div>
						</div>
						
						<div class="text-center">
							<input type="submit" value="수정하기" class="btn btn-warning" onclick="return inputCheck()">
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