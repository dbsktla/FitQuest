<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myNutritionList.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>
	#calenderTable{
		height: 300px;
	}
	table{
		text-align: center;
		margin: auto;
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
	.dayOn:hover{
		background-color: #FAC710 ;
	}
	.dayOn:active{
		background-color: #f9a61a ;
	}
	.dayOn:visited{
		background-color: #FAC710 ;
	}
	.dayCheck{
		background-color: #FEF9E7;
	}
</style>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	
	$(document).ready(function(){
		calenderLookup();
	});
	
	/* 달력 */
	function calenderLookup() {
		
		var sYear = $('#selectYear option:selected').val();
		var sMon = $('#selectMon option:selected').val();
		
		$.ajax({
			type : "POST",
			url : "myNutritionList.ht",
			data : ({'selectYear' : sYear, 'selectMon' : sMon}),
			dataType : "json",
			success : function (data) {
				$('#calenderTable').empty(); // calenderTable div 내용 비우기

				var msg = '<table><tr><td class="daySun">일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td class="daySat">토</td></tr>';
				
				for(var i=0; i<data.length -1; i++){
					if(i == 0){
						for(var j=0; j<data[i].date; j++){
							msg += '<td> </td>';
						}
					}
					
					if(data[i].date == 0){
						msg += '</tr><tr>';
					}
					
					var strDate = "";
					if(i+1 < 10){
						strDate = "0" + (i+1);
					}else{
						strDate = (i+1);
					}
					var dateL = data[data.length -1].dateList;
					
					if(dateL == 'noData'){
						if(data[i].date == 0){
							msg += "<td class='daySun dayOn ' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
						}else if(data[i].date == 6){
							msg += "<td class='daySat dayOn ' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
						}else{
							msg += "<td class='dayOn ' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
						}
					}else{
						
						if(dateL.indexOf(strDate) != -1){
							if(data[i].date == 0){
								msg += "<td class='daySun dayOn dayCheck' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
							}else if(data[i].date == 6){
								msg += "<td class='daySat dayOn dayCheck' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
							}else{
								msg += "<td class='dayOn dayCheck' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
							}
						}else{
							if(data[i].date == 0){
								msg += "<td class='daySun dayOn ' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
							}else if(data[i].date == 6){
								msg += "<td class='daySat dayOn ' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
							}else{
								msg += "<td class='dayOn ' onclick='dateClick("+(i+1)+")'>" + (i+1) + "</td>";
							}
						}
					}
					
				}// for
				
				msg += '</tr></table>';
				
				$("#calenderTable").append(msg);
			}
		}); // ajax
	}
	
	
	/* 날짜 클릭 상세정보 */
	function dateClick(day){
		var sYear = $('#selectYear option:selected').val();
		var sMon = $('#selectMon option:selected').val();
		var selectDate = sYear + "-" + sMon + "-" + day;
		
		var allSumCal = 0.0;
		var allSumBo = 0.0;
		var allSumPro = 0.0;
		var allSumFat = 0.0;
		var allSumSu = 0.0;
		var allSumSo = 0.0;
		
		$.ajax({
			url : "myNutritionDetail.ht",
			type : "POST",
			data : {"selectDate" : selectDate},
			dataType : "json",
			success : function (data) {
				//alert(data);

				var msg = "";
				var msgAll = "";
				$('#today-all-sum').empty();
				$('#detailDiv').empty();
				
				
				// 로그인정보 없을 때
				if(data.returnData == 'idNull'){
					$('#detailDiv').empty();
					alert('로그인이 필요합니다.');
					location.href='login.mb';
				}
				// 데이터정보가 없을 때
				else if(data.returnData == 'BeanNull'){
					$('#detailDiv').empty();
					msg += '<div style="text-align: center; min-height: 60;">';
					msg += '등록된 데이터가 없습니다.';
					msg += '<input type="button" value="추가" onclick="goInsert('+ "'" + selectDate + "'" +')" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10px">';
					msg += '</div>';
				}
				// 데이터정보가 있을 때
				else{
					
					for(var i=0; i<data.length; i++){
						var x = data[i].flist.carbohydrate + data[i].flist.protein + data[i].flist.fat;
						
						msg += '<div class="row"><div class="col-4" style="padding: 10;">';
						msg += '<img class="imgs" onerror="this.src='+ "'/ex/resources/Image/FoodImage/no_img.jpg'" +'" src="/ex/resources/Image/FoodImage/'+data[i].flist.fimage+'" style="margin: auto; width: 100%;">';
						msg += '</div><div class="col-8">';
						msg += '<div style="padding: 10;">';
						msg += '<input type="button" value="식단 삭제" onclick="nu_delete('+"'"+data[i].flist.nnum + "'," + data[i].flist.mnum +')" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10px">';
						msg += '<input type="button" value="수정" onclick="nu_update('+"'"+data[i].flist.mealtype + "'," + data[i].flist.mnum +')" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10px">';
						msg += '</div>';
						msg += '<h5><b>'+ data[i].flist.mealtype +'</b></h5><div>먹은 음식<p style="font-size: 13;color: gray;display: inline;float: right;margin-top: 0;">*상세 삭제는 수정에서 진행해주세요.</p></div><hr style="width: 100%;">';
						msg += '<div>' + data[i].flist.fname + ' ' + data[i].flist.fweight + 'g</div><div>';
						msg += '<ul class="list-group" style="padding-top: 20; padding-bottom: 20;">';
						msg += '<li class="list-group-item list-group-item-warning">';
						msg += '<nav class="navbar"><ul style="width: 100%;text-align: center;">';
						msg += '<li style="width: 25%">칼로리' + data[i].flist.calories + 'kcal</li>';
						msg += '<li style="width: 25%">탄수화물 ' + data[i].flist.carbohydrate + 'g</li>';
						msg += '<li style="width: 25%">단백질 ' + data[i].flist.protein + 'g</li>';
						msg += '<li style="width: 25%">지방 ' + data[i].flist.fat + 'g</li>';
						msg += '</ul></nav><hr><nav class="navbar"><ul style="width: 100%; text-align: center;">';
						msg += '<li style="width: 50%">당 ' + data[i].flist.sugar + 'g</li>';
						msg += '<li style="width: 50%">나트륨 ' + data[i].flist.sodium + 'mg</li>';
						msg += '</ul></nav></li></ul></div>';
						msg += '<div class="progress">';
						msg += '<div class="progress-bar" style="width: '+((data[i].flist.carbohydrate/x)*100)+'%; background-color: #FFD073; color: #6a6a6a;">';
						msg += '탄수화물';
						msg += '</div>';
						msg += '<div class="progress-bar" style="width: '+((data[i].flist.protein/x)*100)+'%; background-color: #FFB54C;">';
						msg += '단백질';
						msg += '</div>';
						msg += '<div class="progress-bar" style="width: '+((data[i].flist.fat/x)*100)+'%; background-color: #FF9326;">';
						msg += '지방';
						msg += '</div></div></div></div><hr>';
						
						
						allSumCal += data[i].flist.calories;
						allSumBo += data[i].flist.carbohydrate;
						allSumPro += data[i].flist.protein;
						allSumFat += data[i].flist.fat;
						allSumSu += data[i].flist.sugar;
						allSumSo += data[i].flist.sodium;
						
					}//for
					
					var x = allSumBo + allSumPro + allSumFat;
					
					msgAll += '<ul class="list-group" style="padding-top: 20; padding-bottom: 20;">';
					msgAll += '<li class="list-group-item list-group-item-secondary">';
					msgAll += '<nav class="navbar"><ul style="width: 100%;text-align: center;">';
					msgAll += '<li style="width: 25%">칼로리' + allSumCal + 'kcal</li>';
					msgAll += '<li style="width: 25%">탄수화물 ' + allSumBo + 'g</li>';
					msgAll += '<li style="width: 25%">단백질 ' + allSumPro + 'g</li>';
					msgAll += '<li style="width: 25%">지방 ' + allSumFat + 'g</li>';
					msgAll += '</ul></nav><hr><nav class="navbar"><ul style="width: 100%; text-align: center;">';
					msgAll += '<li style="width: 50%">당 ' + allSumSu + 'g</li>';
					msgAll += '<li style="width: 50%">나트륨 ' + allSumSo + 'mg</li>';
					msgAll += '</ul></nav></li></ul></div>';
					msgAll += '<div class="progress">';
					msgAll += '<div class="progress-bar" style="width: '+((allSumBo/x)*100)+'%; background-color: #FFD073; color: #6a6a6a;">';
					msgAll += '탄수화물';
					msgAll += '</div>';
					msgAll += '<div class="progress-bar" style="width: '+((allSumPro/x)*100)+'%; background-color: #FFB54C;">';
					msgAll += '단백질';
					msgAll += '</div>';
					msgAll += '<div class="progress-bar" style="width: '+((allSumFat/x)*100)+'%; background-color: #FF9326;">';
					msgAll += '지방';
					msgAll += '</div></div>';
					
				} // if
				
				$('#detailDiv').append(msg);
				$('#today-all-sum').append(msgAll);
			}
		}); // ajax
	} //dateClick()
	
	
	function goInsert(selectDate) {
		location.href="myNutritionInsert.ht?selectDate=" + selectDate;
	}// goInsert
	
	function nu_update(mealtype, mnum) {
		//alert(mealtype + " , " + mnum);
		location.href = "myNutritionUpdate.ht?mealtype=" + mealtype + "&mnum=" + mnum;
	}
	
	function nu_delete(nnum, mnum) {
		location.href = "myNutritionDelete.ht?nnum="+ nnum +"&mnum=" + mnum;
		
	}
</script>
<%
	Date now = new Date();
%>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 식단관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item active">식단관리</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-4" >
			<div class="card">
				<div class="card-body">
					<h5 style="padding-bottom: 20;">
						오늘의 총 섭취 영양정보
						<input type="button" value="추가" onclick="location.href='myNutritionInsert.ht'" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10px">
					</h5>
					<div id="today-all-sum" style="margin: auto; text-align: center; min-height: 40;">조회할 날짜를 클릭하세요</div>
				</div>
			</div>
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">일자 선택 </h5>
					
					<div style="margin: auto; text-align: center;">
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
						
						<input type="button" value="조회" onclick="calenderLookup()" class="btn btn-warning rounded-pill btn-sm">
					</div>
					<div id="calenderTable"></div>
					
					
				</div>
			</div>
		</div>
		
		<div class="col-lg-8">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">식단 상세 정보 </h5>
					<div id="detailDiv">
						<div style="text-align: center; min-height: 60;">
							조회할 날짜를 클릭하세요
						</div>
					</div><!-- detailDiv -->
				</div>
			</div>
		</div><!-- col 8 -->
	</div><!-- row -->

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>