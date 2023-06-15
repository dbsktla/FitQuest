<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- searchInputFood.jsp -->
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<style>
	.errmsg{
		color: red;
	}
</style>


<body style="background-color: #FEF9E7">
	<div class="col-10" style="margin: auto;margin-top: 5%; ">
		<h3><b>${foodBean.fname}</b></h3>
		<input type="hidden" id="fname" value="${foodBean.fname}">
		1인분 기준 ${foodBean.fweight}g <br>
		<input type="hidden" id="originalWeight" value="${foodBean.fweight}">
		
		<div class="row mb-3">
			<div class="row mb-3">
				<label for="fweight" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>먹은양</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="fweight" value="${foodBean.fweight}" onkeyup="calfood()" class="form-control" style="width: 70%;display: unset;">  
					 g 
				<br><span class="errmsg"></span>
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>칼로리</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="calories" value="${foodBean.calories}" readonly  class="form-control" style="width: 70%;display: unset;"> 
					 kcal
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>탄수화물</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="carbohydrate" value="${foodBean.carbohydrate}" readonly class="form-control" style="width: 70%;display: unset;"> 
					 g 
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>단백질</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="protein" value="${foodBean.protein}"readonly class="form-control" style="width: 70%;display: unset;"> 
					 g 
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>지방</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="fat" value="${foodBean.fat}" class="form-control" readonly style="width: 70%;display: unset;"> 
					 g 
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>당</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="sugar" value="${foodBean.sugar}" class="form-control" readonly style="width: 70%;display: unset;"> 
					 g 
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="fimage" class="col-form-label col-md-3 col-lg-2 col-form-label" style="color: gray;width: 25%;">
					<b>나트륨</b>
				</label>
				<div class="col-md-8 col-lg-4" style="width: 70%;">
					<input type="text" id="sodium" value="${foodBean.sodium}" class="form-control" readonly style="width: 70%;display: unset;"> 
					 g 
				</div>
			</div>
			
			<input type="button" value="추가하기" onclick="sendToParent()">
			
		</div><!-- row -->
		
	</div>
</body>

<script src="http://code.jquery.com/jquery-1.7.min.js" type="text/javascript"></script>
<script>
	var o = $('#originalWeight').val();
	
	var c = $('#calories').val() / o;
	var b = $('#carbohydrate').val() / o;
	var p = $('#protein').val() / o;
	var f = $('#fat').val() / o;
	var sg = $('#sugar').val() / o;
	var sd = $('#sodium').val() / o;
	
	// 음식 영양성분 구하기
	function calfood() {
		//alert(1);
		var w = $('#fweight').val();
		
		$('.errmsg').empty();
		
		if(!($.isNumeric(w))){
			$('.errmsg').append("숫자만 입력 가능");
			$('#fweight').attr("value", w.replace(w.charAt(w.length - 1), ""));
		}
		if(w!=""){
			$('#calories').attr("value", (c * w).toFixed(2));
			$('#carbohydrate').attr("value",( b * w).toFixed(2));
			$('#protein').attr("value", (p * w).toFixed(2));
			$('#fat').attr("value", (f * w).toFixed(2));
			$('#sugar').attr("value", (sg * w).toFixed(2));
			$('#sodium').attr("value", (sd * w).toFixed(2));
		}
		
		w = $('#fweight').val();
	}
	
	// 식단등록폼으로 해당 값 이동하기.
	function sendToParent() {
		var pamsg = '';
		var i = <%=(Integer)session.getAttribute("foodscope")%>;
		
		pamsg += '<div id="foodplus'+i+'" style="margin-top: 2%; margin-bottom: 2%;">';
		pamsg += '<a href="javascript:delFood('+i+')"><i class="ri-delete-bin-6-fill" style="color: gray; margin-right: 5%;"></i></a>';
		pamsg += '<font style="font-size: 17;"><b>'+ $('#fname').val() +'</b></font> ';
		pamsg += '<font style="font-size: 14;">'+$('#calories').val()+' kcal, '+$('#fweight').val()+'g | '
		pamsg += '탄수화물 '+$('#carbohydrate').val()+'g, 단백질 '+$('#protein').val()+'g, 지방 '+$('#fat').val()+'g, 당 '+$('#sugar').val()+'g, 나트륨 '+$('#sodium').val()+'g</font>';
		pamsg += '<input type="hidden" name="fnum" value="-1">';
		pamsg += '<input type="hidden" name="fname" value="'+ $('#fname').val() +'">';
		pamsg += '<input type="hidden" name="fweight" value="'+ $('#fweight').val() +'">';
		pamsg += '<input type="hidden" name="calories" value="'+ $('#calories').val() +'">';
		pamsg += '<input type="hidden" name="carbohydrate" value="'+ $('#carbohydrate').val() +'">';
		pamsg += '<input type="hidden" name="protein" value="'+ $('#protein').val() +'">';
		pamsg += '<input type="hidden" name="fat" value="'+ $('#fat').val() +'">';
		pamsg += '<input type="hidden" name="sugar" value="'+ $('#sugar').val() +'">';
		pamsg += '<input type="hidden" name="sodium" value="'+ $('#sodium').val() +'">';
		pamsg += '</div>';
		
		//opener.document.getElementById("foodInfo").innerHTML = (pamsg);
		opener.document.getElementById("foodplus").insertAdjacentHTML('afterend', pamsg);
		
		<%session.setAttribute("foodscope", ((Integer)session.getAttribute("foodscope"))+1);%>
		
		window.close();
	}
</script>


<%@ include file="../common/adminBootBottom.jsp" %>