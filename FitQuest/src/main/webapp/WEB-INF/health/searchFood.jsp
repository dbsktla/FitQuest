<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<style>
	#listOne:hover{
		background-color: #fff3cd ;
	}
	#listOne:active{
		background-color: #ffd073 ;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	// 음식검색
	function searchFood() {
		var foodName = $('#foodName').val();
		//alert(foodName);
		
		$.ajax({
			url : 'searchFood.ht',
			type : 'POST',
			data : {"foodName" : foodName},
			dataType : "json",
			success : function (data) {
				$('#listScope').empty();
				var msg = "";
				
				for(i=0; i<data.length; i++){
					msg += '<form id="form'+i+'" action="searchInputFood.ht">'
					msg += '<div id="listOne" onclick="listOneClick('+i+')">';
					msg += '<font><b>'+ data[i].DESC_KOR +'</b></font><br>';
					msg += '<font size="2">'+ data[i].NUTR_CONT1 +' kcal, '+ data[i].SERVING_WT +' g '+ data[i].ANIMAL_PLANT +'</font>';
					msg += '<input type="hidden" value="'+ data[i].DESC_KOR +'" class="li'+i+'" name="fname">';
					msg += '<input type="hidden" value="'+ data[i].SERVING_WT +'" class="li'+i+'" name="fweight">';
					msg += '<input type="hidden" value="'+ data[i].NUTR_CONT1 +'" class="li'+i+'" name="calories">';
					msg += '<input type="hidden" value="'+ data[i].NUTR_CONT2 +'" class="li'+i+'" name="carbohydrate">';
					msg += '<input type="hidden" value="'+ data[i].NUTR_CONT3 +'" class="li'+i+'" name="protein">';
					msg += '<input type="hidden" value="'+ data[i].NUTR_CONT4 +'" class="li'+i+'" name="fat">';
					msg += '<input type="hidden" value="'+ data[i].NUTR_CONT5 +'" class="li'+i+'" name="sugar">';
					msg += '<input type="hidden" value="'+ data[i].NUTR_CONT6 +'" class="li'+i+'" name="sodium">';
					msg += '<hr>';
					msg += '</div>';
					msg += '</form>'
				}
				
				$('#listScope').append(msg);
				
			} //success
		}); // ajax
		
	}//searchFood()
	
	// 음식 선택하기
	function listOneClick(num) {
		var fn = "form" + num
		document.getElementById(fn).submit();
	}
	
</script>

<body style="background-color: #FEF9E7">
	<div class="col-10" style="margin: auto;margin-top: 5%; ">
	<input type="text" name="foodName" id="foodName" placeholder="음식 이름 입력" onkeyup="searchFood()" style="width: 100%;margin-bottom: 5%;">
	<input type="hidden" id="childText">
		<div id="listScope">
			
		</div>
		<div class="modal">
			<span class="close">&times;</span>
		</div>
	
	</div>
</body>
<%@ include file="../common/adminBootBottom.jsp" %>