<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myNutritionUpdateForm.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<%
	session.setAttribute("foodscope", 0);
%>
<style>
	.errmsg{
		color: red;
	}
</style>


<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 식단관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item"><a href="myNutritionList.ht">식단관리</a></li>
				<li class="breadcrumb-item active">식단등록</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12" >
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">식단등록 </h5>
					
					<form name="phyForm" action="myNutritionInsert.ht" method="post" enctype="multipart/form-data">
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;"><b>식단 이미지</b></label>
								<div class="col-md-8 col-lg-4">
									<input type="file" class="form-control" id="fimage" name="upload" style="width: 100%;">
								</div>
							</div>
						</div><!-- 식단 이미지< -->
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="nudate" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;"><b>섭취일</b></label>
								<div class="col-md-8 col-lg-4">
									<fmt:parseDate value="${param.selectDate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
									<input name="nudate" type="date" class="form-control" id="nudate" value="<fmt:formatDate value='${day}' pattern='yyyy-MM-dd'/>" >
									<span class="errmsg derrmsg"></span>
								</div><!-- 섭취일 -->
							
								<label class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;"><b>분류</b></label>
								<div class="col-md-8 col-lg-4">
									<div class="d-flex justify-content-center">
									
									<input type="radio" name="mealtype" value="아침" class="btn-check" id="option1" autocomplete="off" <c:if test = "${mealtype eq '아침'}">checked</c:if>>
									<label class="btn" for="option1">아침</label>
									
									<input type="radio" name="mealtype" value="점심" class="btn-check" id="option2" autocomplete="off" <c:if test = "${mealtype eq '점심'}">checked</c:if>>
									<label class="btn" for="option2">점심</label>
									
									<input type="radio" name="mealtype" value="저녁" class="btn-check" id="option3" autocomplete="off" <c:if test = "${mealtype eq '저녁'}">checked</c:if>>
									<label class="btn" for="option3">저녁</label>
									
									<input type="radio" name="mealtype" value="간식" class="btn-check" id="option4" autocomplete="off" <c:if test = "${mealtype eq '간식'}">checked</c:if>> 
									<label class="btn" for="option4">간식</label> 
									
									</div>
									<span class="errmsg merrmsg"></span>
								</div><!-- 분류 -->
							</div>
						</div>
						
						<hr>
						
						<div class="col-md-12">
							<label class="form-label" style="color: gray;"><b>추가한 음식</b></label><br>
							<a href="javascript: openFood()">
								<i class="ri-add-circle-fill" style="color : #FAC710;"> <b>음식 추가하기</b></i>
							</a>
							<a href="javascript: openMark()">
								<i class="ri-add-circle-fill" style="color : #6ec5b8;"> <b>저장한 식단 불러오기</b></i>
							</a>
							
							<!-- 추가된 음식 정보 -->
							<div id="foodInfo" style="margin-left: 5%">
								<div id="foodplus" style="margin-top: 2%; margin-bottom: 2%;">
								</div>
								<span class="errmsg ferrmsg"></span>
							</div>
								
						</div><!-- 추가한 음식 -->
						
						<hr>
						<div class="col-md-12">
							<div class="form-check form-switch">
		                      <input name="foodmark" class="form-check-input" type="checkbox" id="flexSwitchCheckChecked">
		                      <label class="form-check-label" for="flexSwitchCheckChecked">현재 식단 북마크에 추가</label>
		                    </div>
						</div>
						
						<div class="text-center">
							<input type="submit" value="등록하기" class="btn btn-warning" onclick="return inputCheck()">
							<span class="errmsg"></span>
						</div>
					</form>
					
				</div>
			</div>
		</div>
	</div><!-- row -->

</body>


<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	var windowObj;
	var i=0;
	// 음식등록창 띄우기
	function openFood() {
		//alert(1);
		window.name = "parentForm";
		
		windowObj = window.open("openFoodList.ht", "childForm", "width=500, height=600, resizable");
	}
	
	function openMark() {
		window.name = "parentForm";
		
		windowObj = window.open("openFoodMark.ht", "childForm", "width=500, height=600, resizable");
	}
	
	function delFood(num) {
		alert(num);
		var sel = '#foodplus' + num;
		$(sel).remove();
	}
	
	function inputCheck() {
		$('.errmsg').empty();
		
		if($('#nudate').val() == ""){
			$('.derrmsg').append('일자를 선택하세요');
			return false;
		}
		
		if($('input[name=mealtype]:checked').length == 0){
			$('.merrmsg').append('분류를 선택하세요');
			return false;
		}
		
		if($('input[name=fname]').val() == undefined){
			$('.ferrmsg').append('음식을 하나 이상 선택하세요');
			return false;
		}
		
	}
</script>


<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>