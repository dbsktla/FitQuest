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


<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 식단관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item"><a href="myNutritionList.ht">식단관리</a></li>
				<li class="breadcrumb-item active">식단수정</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12" >
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">식단등록 </h5>
					
					<form name="phyForm" action="myNutritionUpdate.ht" method="post" enctype="multipart/form-data">
						<input type='hidden' name='delfnum' value='-1'>
						<div id="hiddenDIV">
						</div>
						<input type="hidden" name="nnum" value="${flist[0].nnum}">
						<input type="hidden" name="mnum" value="${flist[0].mnum}">
						<input type="hidden" name="mealtype" value="${flist[0].mealtype}">
						<input type="hidden" name="nudate" value="${flist[0].nudate}">
						
						<div class="row mb-3">
						<img class="imgs" onerror="this.src='/ex/resources/Image/FoodImage/no_img.jpg'" src="/ex/resources/Image/FoodImage/${flist[0].fimage}" style="margin: auto; width: 20%;">
							<div class="modal">
							  <span class="close">&times;</span>
							</div>
						</div>
						
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;"><b>식단 이미지</b></label>
								<div class="col-md-8 col-lg-4">
									<input type="file" class="form-control" id="fimage" name="upload" style="width: 100%;">
									<input type="hidden" name="upload2" value="${flist[0].fimage}">
								</div>
							</div>
						</div><!-- 식단 이미지< -->
						
						<div class="row mb-3">
							<div class="row mb-3">
								<label for="nudate" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;"><b>섭취일</b></label>
								<div class="col-md-8 col-lg-4">
									<fmt:parseDate value="${flist[0].nudate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
									<input name="nudate" type="date" class="form-control" id="nudate" value="<fmt:formatDate value='${day}' pattern='yyyy-MM-dd'/>" disabled>
									<span class="errmsg derrmsg"></span>
								</div><!-- 섭취일 -->
							
								<label class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;"><b>분류</b></label>
								<div class="col-md-8 col-lg-4">
									<div class="d-flex justify-content-center">
									
									<input type="radio" name="mealtype" value="아침" class="btn-check" id="option1" autocomplete="off" disabled 
										<c:if test = "${flist[0].mealtype eq '아침'}">checked</c:if>>
									<label class="btn" for="option1">아침</label>
									
									<input type="radio" name="mealtype" value="점심" class="btn-check" id="option2" autocomplete="off" disabled 
										<c:if test = "${flist[0].mealtype eq '점심'}">checked</c:if>>
									<label class="btn" for="option2">점심</label>
									
									<input type="radio" name="mealtype" value="저녁" class="btn-check" id="option3" autocomplete="off" disabled 
									<c:if test = "${flist[0].mealtype eq '저녁'}">checked</c:if>>
										<label class="btn" for="option3">저녁</label>
									
									<input type="radio" name="mealtype" value="간식" class="btn-check" id="option4" autocomplete="off" disabled 
										<c:if test = "${flist[0].mealtype eq '간식'}">checked</c:if>> 
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
								
								<c:forEach var="flist" items="${flist}">
								
									<div id="foodplus${foodscope}" style="margin-top: 2%; margin-bottom: 2%;">
										<a href="javascript:delFood('${foodscope}','${flist.fnum}')">
											<i class="ri-delete-bin-6-fill" style="color: gray; margin-right: 5%;"></i>
										</a>
										<font style="font-size: 17;"><b>${flist.fname}</b></font>
										<font style="font-size: 14;">
											${flist.calories}kcal, ${flist.fweight}g | 
											탄수화물 ${flist.carbohydrate}g, 단백질 ${flist.protein}g, 지방 ${flist.fat}g, 당 ${flist.sugar}g, 나트륨 ${flist.sodium}g
										</font>
										
										<input type="hidden" name="fnum" value="${flist.fnum}">
										<input type="hidden" name="fname" value="${flist.fname}">
										<input type="hidden" name="fweight" value="${flist.fweight}">
										<input type="hidden" name="calories" value="${flist.calories}">
										<input type="hidden" name="carbohydrate" value="${flist.carbohydrate}">
										<input type="hidden" name="protein" value="${flist.protein}">
										<input type="hidden" name="fat" value="${flist.fat}">
										<input type="hidden" name="sugar" value="${flist.sugar}">
										<input type="hidden" name="sodium" value="${flist.sodium}">
									</div>
									<%session.setAttribute("foodscope", ((Integer)session.getAttribute("foodscope"))+1);%>
								</c:forEach>
								
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
							<input type="submit" value="수정하기" class="btn btn-warning" onclick="return inputCheck()">
							<span class="errmsg"></span>
						</div>
					</form><!-- form -->
					
				</div>
			</div>
		</div>
	</div><!-- row -->

</body>


<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	
	var windowObj;
	var i=0;
	/* 음식등록창 열기 */
	function openFood() {
		//alert(1);
		window.name = "parentForm";
		
		windowObj = window.open("openFoodList.ht", "childForm", "width=500, height=600, resizable");
	}
	
	/* 북마크 열기 */
	function openMark() {
		window.name = "parentForm";
		
		windowObj = window.open("openFoodMark.ht", "childForm", "width=500, height=600, resizable");
	}
	
	/* 추가음식삭제 */
	function delFood(num, fnum) {
		var sel = '#foodplus' + num;
		$(sel).remove();
		
		if(typeof fnum == "undefined"){
			fnum = "-1";
		}
		
		$('#hiddenDIV').append("<input type='hidden' name='delfnum' value='"+fnum+"'>");
	}
	
	/* 유효성검사 */
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
	
	/* 이미지 클릭 이벤트 */
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


<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>