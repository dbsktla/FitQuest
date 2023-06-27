<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- memberHealthCareMain.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>


<%
	Date now = new Date();
%>

<c:set var="sye" value=""/>
<c:set var="smo" value=""/>

<style>
	tr:hover {
		background-color: #f4f4f4;
	}
	
	.draggable {
		-webkit-user-select: all;
		-moz-user-select: all;
		-ms-user-select: all;
		user-select: all
	}
	
	.v-line{
		border-left: solid 3px #adb5bd;
		height:100%;
	}
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
	.topMar{
		margin-top: 20px;
	}
	.inbodyBtnDiv{
		float: right;
	}
	.fe {
	    position: absolute;
	    right: 0px;
	    top: 15px;
	}
	.ie {
	    color: #aab7cf;
	    padding-right: 20px;
	    padding-bottom: 5px;
	    transition: 0.3s;
	    font-size: 16px;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	$(document).ready(function(){
	   $('.datatable-search').css('display','none');

	});
	
	function btnCheckOff() {
	   $('input:radio(name="whatGender")').prop('checked',false);
	   $('input:radio(name="whatStatus")').prop('checked',false);
	   $('input:radio(name="whatAge")').prop('checked',false);
	   $('#whatName').attr("value","");
	}
	
	function memberDetail(mid) {
		$('html, body').animate({scrollTop: 0}, 200);
		//alert(mid);
		
		//(멤버리스트 보는 목록으로 가는 버튼 만들기)
		//닫기버튼 생성하기
		
		$.ajax({
			url : 'memberHealthDetail.ht',
			type : 'POST',
			data : {"mid": mid},
			dataType : "json",
			success : function(data) {
				// 회원상세정보
				// 운동정보 - hdlist
				$('#memberDetail').empty();
				
				var msg = '<div class="card">';
				msg += '<div class="card-body">';
				msg += '<div class="row">';
				msg += '<div class="col-lg-6">'; // start left
				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">이름</label>';
				msg += '<div class="col-sm-7 col-form-label">'+data.hclist.name+'</div>';
				msg += '<input type="hidden" name="mid" id="selectMid" value="'+data.hclist.mid+'">';
				msg += '</div>';
				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">성별</label>';
				msg += '<div class="col-sm-7 col-form-label">'+data.hclist.gender+'</div>';
				msg += '</div>';
				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">생년월일</label>';
				msg += '<div class="col-sm-7 col-form-label">'+data.hclist.birth +'(만 '+ data.hclist.age +'세)</div>';
				msg += '</div>';
				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">이메일</label>';
				msg += '<div class="col-sm-7 col-form-label">'+data.hclist.email+'</div>';
				msg += '</div>';
				msg += '</div>'; // end left
				msg += '<div class="col-lg-6 v-line">'; // start right
				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">최초등록일</label>';
				msg += '<div class="col-sm-7 col-form-label">'+data.hclist.odate+'</div>';
				msg += '</div>';

				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">진도율</label>';
				msg += '<div class="col-sm-7 col-form-label">'+data.hclist.usage+'회 남음</div>';
				msg += '</div>';
				msg += '<div class="row mb-3">';
				msg += '<label class="col-sm-5 col-form-label">상태</label>';
				msg += '<div class="col-sm-7 col-form-label">'
				if(data.hclist.ustate == 'unavailable'){
					msg += '만료';
				}else{
					msg += '유효';
				}
				msg += '</div>';
				msg += '</div>';
				msg += '</div>'; // end right
				msg += '<div class="col-lg-12" style="margin-top: 40px;">'; // start 조회 center
				msg += '<ul class="nav nav-tabs nav-tabs-bordered">';
				msg += '<li class="nav-item">';
				msg += '<button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview" onclick="healthDetail()">운동조회</button>';
				msg += '</li>';
				msg += '<li class="nav-item">';
				msg += '<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit" onclick="nutritionDetail()">식단조회</button>';
				msg += '</li>';
				msg += '<li class="nav-item">';
				msg += '<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings" onclick="physiqueDetail()">신체조회</button>';
				msg += '</li>';
				msg += '</ul>';
				msg += '<div class="tab-content pt-2">';
				msg += '<div class="tab-pane fade show active profile-overview" id="profile-overview">';
				msg += '<div class="row" id="hDetail">';
				msg += '<div class="col-lg-4" style="color: black;">';
				msg += '<h5 class="card-title">운동 목록</h5>';
				msg += '';
				msg += '<table class="table">'; // 운동목록
				msg += '<thead>';
				msg += '<tr class="table-warning">';
				msg += '<th scope="col" align="center">NO</th>';
				msg += '<th scope="col" align="center">트레이너</th>';
				msg += '<th scope="col" align="center">날짜</th>';
				msg += '<th scope="col" align="center">운동시간</th>';
				msg += '</tr>';
				msg += '</thead>';
				msg += '<tbody id="healthList">';
				if(data.hdlist.length == 0){
					msg += '<tr>';
					msg += '<td colspan="4" align="center">등록 된 운동내역이 없습니다.</td>';
					msg += '</tr>';
					
				}else{
					for(var i=0; i < data.hdlist.length; i++){
						msg += '<tr>';
						msg += '<td>'+(i+1)+'</td>';
						msg += '<td>' +data.hdlist[i].tname +'('+data.hdlist[i].tactivity+ ')</td>';
						msg += '<td><button type="button" class="btn btn-link" id="hdetailbtn" onclick="btnclick('+"'"+ data.hdlist[i].hnum+"'"+')">'+data.hdlist[i].hdate+'</button></td>';
						msg += '<td>'+ data.hdlist[i].playtime +'분</td>';
						msg += '</tr>';
						
					}
					
				}
				msg += '</tbody>';
				msg += '</table>';
				msg += '</div>';  // end 운동목록
				msg += '<div class="col-lg-8" style="color: black;">'; // start 상세조회
				msg += '<h5 class="card-title">상세 정보</h5>';
				msg += '<div id="healthDetail">';
				msg += '<span style="margin: auto;">좌측 운동 목록에서 날짜를 클릭하세요.</span>';
				msg += '</div>';
				msg += '</div>';// end 상세조회
				msg += '</div>';
				msg += '</div>'; // end row
				
				msg += '<div class="tab-pane fade profile-edit pt-3" id="profile-edit">'; // start 식단정보
				msg += '</div>'; // end 식단정보
				msg += '<div class="tab-pane fade pt-3" id="profile-settings">'; // start 신체정보
				msg += '</div>'; // end 신체정보
				
				
				msg += '</div>'; // end 조회 center
				msg += '</div>';
				msg += '</div>';
				msg += '</div>';
				
				$('#memberDetail').append(msg);
				
			},
			error: function (request, status, error) {
		        console.log("code: " + request.status)
		        console.log("message: " + request.responseText)
		        console.log("error: " + error);
		    }
			
		});
	}
	
	// 운동상세정보
	function btnclick(hnum) {
		//alert(hnum);
		clickHnum = hnum;
		$('#showbutton').show();
		
		$.ajax({	
			type : "POST", // 요청타입
			url : "myHealthDetail.ht", // 요청 url
			data : ({'hnum' : hnum}), // url로 넘길 데이터 설정
			dataType : "json", // 받아올 데이터 타입설정
			success : function (data) {
				
				$('#healthDetail').empty(); // healthDetail div 내용 비우기
				var msg = "<table class='table'><tr class='table-warning'>";
				msg += "<th scope='col'>운동명</th><th scope='col'>시작시간</th><th scope='col'>종료시간</th><th scope='col'>세트</th></tr>";
				
				// 현재 jsonArray 형태로 값이 넘어와서 data에 담긴상태	
				for(var i=0; i<data.length; i++){
					msg += "<tr>";
					msg += "<td>"+data[i].hname+"</td>";
					msg += "<td>"+(data[i].starttime).substring(0,16)+"</td>";
					msg += "<td>"+(data[i].endtime).substring(0,16)+"</td>";
					msg += "<td>"+data[i].hset+"세트 "+data[i].hcount+"회</td></tr>";
				}
				
				msg += "</table>";
				
				// string값을 healthDetail div에 추가함!!
				$("#healthDetail").append(msg);
			},
			error : function () {
				alert("fail"); // 실패
			}
		}); // ajax
	}
	
	// 식단상세정보
	function calenderLookup() {
		
		var sYear = $('#selectYear option:selected').val();
		var sMon = $('#selectMon option:selected').val();
		var mid = $('#selectMid').val();
		
		$.ajax({
			type : "POST",
			url : "myNutritionList.ht",
			data : ({'selectYear' : sYear, 'selectMon' : sMon, 'mid' : mid}),
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
		var mid = $('#selectMid').val();
		
		var allSumCal = 0.0;
		var allSumBo = 0.0;
		var allSumPro = 0.0;
		var allSumFat = 0.0;
		var allSumSu = 0.0;
		var allSumSo = 0.0;
		
		$.ajax({
			url : "myNutritionDetail.ht",
			type : "POST",
			data : {"selectDate" : selectDate, "mid": mid},
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
						msg += '</div>';
						msg += '<h5><b>'+ data[i].flist.mealtype +'</b></h5><div>먹은 음식</div><hr style="width: 100%;">';
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
	
	
	// 신체 상세 날짜
	function calenderLookup2() {
		var sYear = $('#selectYear option:selected').val();
		var sMon = $('#selectMon option:selected').val();
		var mid = $('#selectMid').val();
		
		//alert(sYear);
		//alert(sMon);
		
		$.ajax({
			type : "POST",
			url : "myPhysiqueList.ht",
			data : ({'selectYear' : sYear, 'selectMon' : sMon, 'mid' : mid}),
			dataType : "json",
			success : function (data) {
				$('#calenderTable2').empty(); // calenderTable div 내용 비우기

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
							msg += "<td class='daySun dayOn ' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
						}else if(data[i].date == 6){
							msg += "<td class='daySat dayOn ' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
						}else{
							msg += "<td class='dayOn ' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
						}
					}else{
						
						if(dateL.indexOf(strDate) != -1){
							if(data[i].date == 0){
								msg += "<td class='daySun dayOn dayCheck' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
							}else if(data[i].date == 6){
								msg += "<td class='daySat dayOn dayCheck' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
							}else{
								msg += "<td class='dayOn dayCheck' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
							}
						}else{
							if(data[i].date == 0){
								msg += "<td class='daySun dayOn ' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
							}else if(data[i].date == 6){
								msg += "<td class='daySat dayOn ' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
							}else{
								msg += "<td class='dayOn ' onclick='dateClick2("+(i+1)+")'>" + (i+1) + "</td>";
							}
						}
					}
					
				}// for
				
				msg += '</tr></table>';
				
				$("#calenderTable2").append(msg);
			}
		}); // ajax
	}
	
	
	/* 신체 날짜 상세 정보*/
	function dateClick2(day){
		
		//alert(day);
		var sYear = $('#selectYear option:selected').val();
		var sMon = $('#selectMon option:selected').val();
		var mid = $('#selectMid').val();
		//var sday = day;
		
		$.ajax({
			type : "POST",
			url : "myPhysiqueDetail.ht",
			data : ({"selectDay" : day, "selectYear" : sYear, "selectMon" : sMon, 'mid' : mid}),
			dataType : "json",
			success : function (data) {
				// alert(data);
				
				var msg = "";
				var phdate = "";
				//alert(sYear + "-" + sMon+ "-" day);
				
				if(data.returnData == 'idNull'){
					$('#detailDiv2').empty();
					alert('로그인이 필요합니다.');
					location.href='login.mb';
				}else if(data.returnData == 'BeanNull'){
					$('#detailDiv2').empty();
					msg = "<h5 align='center'>등록된 신체 정보가 없습니다.</h5>";
				}else{
					$('#detailDiv2').empty();
					msg += "<h5>" + data.phdate + "</h5>";
					msg += '<div class="row" style="margin-top: 20px;">';
					msg += '<div class="col-lg-3 col-md-4 label ">이름</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.name + ' 님</div>';
					msg += '</div>';
					msg += '<div class="row" style="margin-top: 20px;">';
					msg += '<div class="col-lg-3 col-md-4 label ">신장</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.height + ' cm</div>';
					msg += '<div class="col-lg-3 col-md-4 label ">체중</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.weight + ' kg</div>';
					msg += '</div>';
					msg += '<div class="row" style="margin-top: 20px;">';
					msg += '<div class="col-lg-3 col-md-4 label ">BMI</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.bmi + '</div>';
					msg += '<div class="col-lg-3 col-md-4 label ">골격근량</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.skeletalmuscle + ' kg</div>';
					msg += '</div>';
					msg += '<div class="row" style="margin-top: 20px;">';
					msg += '<div class="col-lg-3 col-md-4 label ">체지방률</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.bodyfatper + ' %</div>';
					msg += '<div class="col-lg-3 col-md-4 label ">기초대사량</div>';
					msg += '<div class="col-lg-3 col-md-4">' + data.bmr + ' kcal</div>';
					msg += '</div><div class="topMar"><input type="hidden" id="phimage" name="phimage" value="'+data.phimage+'">';
					msg += '<input type="button" value="인바디 정보" onclick="showImg()" class="btn btn-outline-warning rounded-pill btn-sm inbodyBtnDiv"></div>';
				}
				
				$("#detailDiv2").append(msg);
			}
			
		}); // ajax
	}
	
	function showImg() {
		var phimage = $('#phimage').val();
		//alert(phimage);
		
		// undefined
		window.open('pop.ht?phimage=' + phimage,'팝업','width=500,height=700');
	}
	
	function getGraphAll(){
		
		var weightData = [];
		var skmuscleData = [];
		var bodyfatperData = [];
		var Date = [];
		
		var mid = $('#selectMid').val();
		
		$.ajax({
			url : "myPhysiqueGraph.ht",
			type : "GET",
			data : {'mid' : mid},
			dataType : "json",
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					weightData.push(data[i].weight);
					skmuscleData.push(data[i].skeletalmuscle);
					bodyfatperData.push(data[i].bodyfatper);
					Date.push(data[i].phdate);
				}
				
				new ApexCharts(document.querySelector("#lineChart"), {
					series: [{
						name: "체중(kg)",
						data: weightData
					}, {
						name: "골격근량(kg)",
						data: skmuscleData
					}, {
						name: "체지방률(%)",
						data: bodyfatperData
					}],
					chart: {
						height: 350,
						type: 'area',
						toolbar: {
							show: false
						},
					},
					markers: {
						size: 4
					},
					colors: ['#4154f1', '#2eca6a', '#ff771d'],
					fill: {
						type: "gradient",
						gradient: {
							shadeIntensity: 1,
							opacityFrom: 0.3,
							opacityTo: 0.4,
							stops: [0, 90, 100]
						}
					},
					dataLabels: {
						enabled: false
					},
					stroke: {
						curve: 'smooth',
						width: 2
					},
					xaxis: {
						categories: Date,
					}
				}).render();
			} //success
		}); //ajax
		
	} //getGraphAll
	
	function getGraphWeight(){
		
		var weightData = [];
		var Date = [];
		var mid = $('#selectMid').val();
		
		$.ajax({
			url : "myPhysiqueGraph.ht",
			type : "GET",
			data : {'mid' : mid},
			dataType : "json",
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					weightData.push(data[i].weight);
					Date.push(data[i].phdate);
				}

				
				new ApexCharts(document.querySelector("#lineChart"), {
					series: [{
						name: "체중(kg)",
						data: weightData
					}],
					chart: {
						height: 350,
						type: 'area',
						toolbar: {
							show: false
						},
					},
					markers: {
						size: 4
					},
					colors: ['#4154f1', '#2eca6a', '#ff771d'],
					fill: {
						type: "gradient",
						gradient: {
							shadeIntensity: 1,
							opacityFrom: 0.3,
							opacityTo: 0.4,
							stops: [0, 90, 100]
						}
					},
					dataLabels: {
						enabled: false
					},
					stroke: {
						curve: 'smooth',
						width: 2
					},
					xaxis: {
						categories: Date,
					}
				}).render();
			} //success
		}); //ajax
	} // getGraphWeight
	
	function getGraphSkmuscle(){
		var skmuscleData = [];
		var Date = [];
		var mid = $('#selectMid').val();
		
		$.ajax({
			url : "myPhysiqueGraph.ht",
			type : "GET",
			data : {'mid' : mid},
			dataType : "json",
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					skmuscleData.push(data[i].skeletalmuscle);
					Date.push(data[i].phdate);
				}
				
				new ApexCharts(document.querySelector("#lineChart"), {
					series: [{
						name: "골격근량(kg)",
						data: skmuscleData
					}],
					chart: {
						height: 350,
						type: 'area',
						toolbar: {
							show: false
						},
					},
					markers: {
						size: 4
					},
					colors: ['#4154f1', '#2eca6a', '#ff771d'],
					fill: {
						type: "gradient",
						gradient: {
							shadeIntensity: 1,
							opacityFrom: 0.3,
							opacityTo: 0.4,
							stops: [0, 90, 100]
						}
					},
					dataLabels: {
						enabled: false
					},
					stroke: {
						curve: 'smooth',
						width: 2
					},
					xaxis: {
						categories: Date,
					}
				}).render();
			} //success
		}); //ajax
	} // getGraphSkmuscle
	
	function getGraphBodyfatper(){
		var bodyfatperData = [];
		var Date = [];
		var mid = $('#selectMid').val();
		
		$.ajax({
			url : "myPhysiqueGraph.ht",
			type : "GET",
			data : {'mid' : mid},
			dataType : "json",
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					bodyfatperData.push(data[i].bodyfatper);
					Date.push(data[i].phdate);
				}
				
				new ApexCharts(document.querySelector("#lineChart"), {
					series: [{
						name: "체지방률(%)",
						data: bodyfatperData
					}],
					chart: {
						height: 350,
						type: 'area',
						toolbar: {
							show: false
						},
					},
					markers: {
						size: 4
					},
					colors: ['#4154f1', '#2eca6a', '#ff771d'],
					fill: {
						type: "gradient",
						gradient: {
							shadeIntensity: 1,
							opacityFrom: 0.3,
							opacityTo: 0.4,
							stops: [0, 90, 100]
						}
					},
					dataLabels: {
						enabled: false
					},
					stroke: {
						curve: 'smooth',
						width: 2
					},
					xaxis: {
						categories: Date,
					}
				}).render();
			} //success
		}); //ajax
	} // getGraphBodyfatper
	
	
	function graphAll() {
		//alert(1);
		$('#my-graph').empty();
		$('#my-graph').html('<h5 class="card-title">전체보기</h5><div id="lineChart"></div>');
		getGraphAll();
	}
	
	function graphW() {
		$('#my-graph').empty();
		$('#my-graph').html('<h5 class="card-title">체중 변화</h5><div id="lineChart"></div>');
		getGraphWeight();
	}
	
	function graphS() {
		$('#my-graph').empty();
		$('#my-graph').html('<h5 class="card-title">골격근량 변화</h5><div id="lineChart"></div>');
		getGraphSkmuscle();
	}
	
	function graphB() {
		$('#my-graph').empty();
		$('#my-graph').html('<h5 class="card-title">체지방률 변화</h5><div id="lineChart"></div>');
		getGraphBodyfatper();
	}
	
	function healthDetail() {
		
	}
	function nutritionDetail() {
		$('#profile-edit').empty();
		
		var msg = "";
		msg += '<div class="row">';
		msg += '<h5 class="card-title">식단조회</h5>';
		msg += '<div class="row">';
		msg += '<div class="col-lg-4" >';
		msg += '<div class="card">'; // start card
		msg += '<div class="card-body">';
		msg += '<h5 style="padding-bottom: 20;">오늘의 총 섭취 영양정보</h5>';
		msg += '<div id="today-all-sum" style="margin: auto; text-align: center; min-height: 40;">조회할 날짜를 클릭하세요</div>';
		msg += '</div>';
		msg += '</div>'; // end card
		msg += '<div class="card">'; // start card
		msg += '<div class="card-body">';
		msg += '<h5 class="card-title">일자 선택 </h5>';
		msg += '<div style="margin: auto; text-align: center;">';
		
		msg += '<select name="selectYear" id="selectYear">';
		<c:forEach var="i" begin="<%=now.getYear() + 1890%>" end="<%=now.getYear() + 1900%>">
			msg += '<option value="' + ${i} + '" ';
			<c:if test="${i == selectYear}"> 
				msg += 'selected';
			</c:if>
			msg += '>' + ${i} + '</option>';
		</c:forEach>
		
		msg += '</select> 년';
		msg += '<select name="selectMon" id="selectMon">';
		<c:forEach var="i" begin="1" end="12">
			msg += '<option value="' + ${i} + '" ';
			<c:if test="${i == selectMon}"> 
				msg += 'selected';
			</c:if>
			msg += '>' + ${i} + '</option>';
		</c:forEach>
		msg += '</select> 월';
		
		msg += '<input type="button" value="조회" onclick="calenderLookup()" class="btn btn-warning rounded-pill btn-sm">';
		msg += '</div>';
		msg += '<div id="calenderTable"></div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';

		msg += '<div class="col-lg-8">';
		msg += '<div class="card">';
		msg += '<div class="card-body">';
		msg += '<h5 class="card-title">식단 상세 정보 </h5>';
		msg += '<div id="detailDiv">'; // start detailDiv
		msg += '<div style="text-align: center; min-height: 60;">';
		msg += '조회할 날짜를 클릭하세요';
		msg += '</div>';
		msg += '</div>'; //end detailDiv
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		
		
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		
		
		$('#profile-edit').append(msg);
		calenderLookup();
	}
	
	function physiqueDetail() {
		$('#profile-settings').empty();
		
		var msg = "";
		msg += '<div class="row">';
		msg += '<div class="col-lg-12">';
		msg += '<div class="card">';
		msg += '<div class="card-body">';
		msg += '<h5 class="card-title">신체정보</h5>';
		msg += '<div class="row">';
		msg += '<div class="col-lg-5">';
		
		msg += '<div style="margin: auto; text-align: center;">';
		
		msg += '<select name="selectYear" id="selectYear">';
		<c:forEach var="i" begin="<%=now.getYear() + 1890%>" end="<%=now.getYear() + 1900%>">
			msg += '<option value="' + ${i} + '" ';
			<c:if test="${i == selectYear}"> 
				msg += 'selected';
			</c:if>
			msg += '>' + ${i} + '</option>';
		</c:forEach>
		
		msg += '</select> 년';
		msg += '<select name="selectMon" id="selectMon">';
		<c:forEach var="i" begin="1" end="12">
			msg += '<option value="' + ${i} + '" ';
			<c:if test="${i == selectMon}"> 
				msg += 'selected';
			</c:if>
			msg += '>' + ${i} + '</option>';
		</c:forEach>
		msg += '</select> 월';
		
		msg += '<input type="button" value="조회" onclick="calenderLookup2()" class="btn btn-warning rounded-pill btn-sm">';
		msg += '</div>';
		
		msg += '<div id="calenderTable2">';
		msg += '</div>';
		msg += '</div>';
		
		msg += '<div class="col-lg-7">';//start 상세정보
		msg += '<div id="detailDiv2">';
		msg += '<div  style="text-align: center;">조회할 날짜를 클릭하세요</div>';
		msg += '</div>';
		msg += '</div>';//end 상세정보
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		
		msg += '<div class="col-12">';
		msg += '<div class="card">';
		msg += '<div class="filter fe">';
		msg += '<a class="icon ie" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>';
		msg += '<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">';
		msg += '<li class="dropdown-header text-start">';
		msg += '<h6>필터선택</h6>';
		msg += '</li>';
		msg += '<li><a class="dropdown-item" href="javascript:graphAll()">전체보기</a></li>';
		msg += '<li><a class="dropdown-item" href="javascript:graphW()">체중 변화</a></li>';
		msg += '<li><a class="dropdown-item" href="javascript:graphS()">골격근량 변화</a></li>';
		msg += '<li><a class="dropdown-item" href="javascript:graphB()">체지방률 변화</a></li>';
		msg += '</ul>';
		msg += '</div>';
		
		msg += '<div class="card-body" id="my-graph">';
		msg += '<h5 class="card-title">전체보기</h5>';
		msg += '<div id="lineChart"></div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		msg += '</div>';
		
		$('#profile-settings').append(msg);
		
 	   calenderLookup2();
 	   getGraphAll();
	}
</script>

<body style="background-color: #FEF9E7;">

	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 회원운동관리
		</h1>
	</div>

	<div class="row">

		<!-- 회원클릭시 상세정보 -->
		<div id="memberDetail" class="col-lg-12">
		</div><!-- 회원클릭시 상세정보 -->

		<!-- 상단 회원 간략 정보 -->
		<div class="col-lg-12" style="margin: 20px 0px;">신규 회원 유효 회원 만료 회원</div>
		<!-- 회원 간략 정보  -->

		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
					<form action="memberHealthCare.ht">

						<!-- 필터 -->
						<div>
							<div class="col-lg-2 btn-group" role="group" aria-label="Basic outlined example" style="padding: 2% 2%;">
								<input type="radio" class="btn-check" value="남자" name="whatGender" id="whatGender1" autocomplete="off"
									<c:if test = "${param.whatGender eq '남자'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatGender1">남자</label>

								<input type="radio" class="btn-check" value="여자" name="whatGender" id="whatGender2" autocomplete="off"
									<c:if test = "${param.whatGender eq '여자'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatGender2">여자</label>
							</div>

							<div class="col-lg-2 btn-group" role="group" aria-label="Basic outlined example">
								<input type="radio" class="btn-check" value="available" name="whatStatus" id="whatStatus1" autocomplete="off"
									<c:if test = "${param.whatStatus eq 'available'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatStatus1">유효</label>

								<input type="radio" class="btn-check" value="unavailable" name="whatStatus" id="whatStatus2" autocomplete="off"
									<c:if test = "${param.whatStatus eq 'unavailable'}">checked</c:if>>
								<label class="btn btn-outline-warning btn-sm" for="whatStatus2">만료</label>
							</div>

							<div class="col-lg-4 btn-group" role="group" aria-label="Basic outlined example" style="padding: 2% 2%;">
								<input type="radio" class="btn-check" value="10" name="whatAge" id="whatAge1" autocomplete="off"
									<c:if test = "${param.whatAge == 10}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge1">10대</label>

								<input type="radio" class="btn-check" value="20" name="whatAge" id="whatAge2" autocomplete="off"
									<c:if test = "${param.whatAge == 20}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge2">20대</label>

								<input type="radio" class="btn-check" value="30" name="whatAge" id="whatAge3" autocomplete="off"
									<c:if test = "${param.whatAge == 30}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge3">30대</label>

								<input type="radio" class="btn-check" value="40" name="whatAge" id="whatAge4" autocomplete="off"
									<c:if test = "${param.whatAge == 40}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge4">40대</label>

								<input type="radio" class="btn-check" value="50" name="whatAge" id="whatAge5" autocomplete="off"
									<c:if test = "${param.whatAge == 50}">checked</c:if>> 
								<label class="btn btn-outline-secondary btn-sm" for="whatAge5">50대</label>
							</div>

							<div class="col-lg-2 btn-group" >
								<input type="text" id="whatName" name="whatName" placeholder="이름검색" value="${param.whatName}" style="width: 80%; margin-right: 10px;" class="search-choose">
								<button type="submit" class="btn btn-warning" style = "background-color: #FAC710; border: none; margin-bottom:3px; border-radius: 5px;">
									<i class="ri-search-line"></i>
								</button>
							</div>
							
							<div class="col-lg-1 btn-group"  style="padding: 2% 2%;">
								<input type="button" onclick="btnCheckOff()" class="btn btn-warning" value="선택해제" style="float: right;">
							</div>
						</div>
						<!-- 필터 -->

					</form>


				</div>
			</div>
		</div>

		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">

					<h5 class="card-title">구매 회원 목록</h5>
					<table class="table datatable">
						<thead>
							<tr>
								<th scope="col">NO.</th>
								<th scope="col">이름</th>
								<th scope="col">성별</th>
								<th>연령</th>
								<th>전화번호</th>
								<th>이메일주소</th>
								<th scope="col">최초구매일</th>
								<th scope="col">남은횟수</th>
								<th scope="col">회원상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty hclist}">
								<tr>
									<td colspan="9" style="text-align: center;">조회 할 정보가 없습니다.</td>
								</tr>
							</c:if>

							<c:if test="${not empty hclist}">
								<c:forEach var="hclist" items="${hclist}" varStatus="status">

									<tr>
										<td scope="row">${status.count}</td>
										<td>
											<a href='javascript:memberDetail("${hclist.mid}")'>${hclist.name}</a>
										</td>
										<td>${hclist.gender}</td>
										<td>만 ${hclist.age}세</td>
										<td>${hclist.mphone}</td>
										<td>${hclist.email}</td>
										<td>
											<fmt:parseDate value="${hclist.odate}" var="day" pattern="yyyy-MM-dd" scope="page" /> 
											<fmt:formatDate value="${day}" pattern="yyyy-MM-dd" /></td>
										<td>${hclist.usage}</td>
										<td>
											<c:if test="${hclist.ustate eq 'available'}"><font color="green">유효</font></c:if> 
											<c:if test="${hclist.ustate eq 'unavailable'}"><font color="red">만료</font></c:if>
										</td>
									</tr>

								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- col 10 -->

	</div>
	<!-- row -->

</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>
