<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<style>
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
	.ps-3{
		margin: 30px 0px !important;
	}
	.col-xxl-3{
		 background-color: #F7F7F8 !important;
		 margin: 10px !important;
		 padding: 20px !important;
		 border-radius: 10px;
		 width: 23% !important;
		 text-align: center;
	}
	.row{
		justify-content: center;
		width: 100%;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	$(document).ready(function(){
		//alert(1);
		getHealthTime();
		getGraphAll();
	});
	
	// 신체정보 그래프
	function getGraphAll(){
		
		var weightData = [];
		var skmuscleData = [];
		var bodyfatperData = [];
		var Date = [];
		
		
		$.ajax({
			url : "myPhysiqueGraph.ht",
			type : "GET",
			dataType : "json",
			success : function (data) {
				
				if(data == ""){
					$('#lineChart').empty();
					$('#lineChart').append("등록된 신체 정보가 없습니다.");
				} else {
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
				}
				
			} //success
		}); //ajax
		
	} //getGraphAll
	
	
	// 주별 운동시간 그래프
	function getHealthTime() {
		//alert(2);
		var weekdate = [];
		
		$.ajax({
			url : "health.ht",
			type : "POST",
			dataType : "json",
			success : function (data) {
				//alert(data);
				
				for(i=0; i<data.length-1; i++){
					weekdate.push(data[i].playtime);
					//alert(data[i].playtime);
				} //for
				
					new Chart(document.querySelector('#barChart'), {
						type: 'bar',
						data: {
							labels: ['월', '화', '수', '목', '금', '토', '일'],
							datasets: [{
								label: '운동 시간(분)',
								data: weekdate,
								backgroundColor: [
									'rgba(255, 99, 132, 0.2)',
									'rgba(255, 159, 64, 0.2)',
									'rgba(255, 205, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)',
									'rgba(54, 162, 235, 0.2)',
									'rgba(153, 102, 255, 0.2)',
									'rgba(201, 203, 207, 0.2)'
								],
								borderColor: [
									'rgb(255, 99, 132)',
									'rgb(255, 159, 64)',
									'rgb(255, 205, 86)',
									'rgb(75, 192, 192)',
									'rgb(54, 162, 235)',
									'rgb(153, 102, 255)',
									'rgb(201, 203, 207)'
								],
								borderWidth: 1
							}]
						},
						options: {
							scales: {
								y: {
									beginAtZero: true
								}
							}
						}
				}); 
			} //success
		}); // ajax
	}

</script>


<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 내 건강 정보
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item active">내 건강 정보</li>
			</ol>
		</nav>
	</div>

	<div class="col-lg-12">
		<div class="row">
			
			<!-- 오늘의 운동 -->
			<div class="col-xxl-4 col-md-6">
				<div class="card info-card revenue-card">
					<div class="card-body">
						<h5 class="card-title">오늘의 운동</h5>
						<div class="ps-3" style="text-align: center">
							<c:if test="${empty hblist}">
								오늘의 운동 내역이 없습니다.<br><br>
							<div class="text-center">
								<button type="button" class="btn btn-warning scrollto btn-sm" onclick="location.href='myHealthList.ht'">운동 등록하러 가기</button>
							</div>
							</c:if>
							<c:if test="${not empty hblist}">
								<table align="center">
									<c:forEach var="hblist" items="${hblist}">
									<c:if test="${hblist.tid == 'notrainer'}">
										<tr>
											<td>
												<b>${loginInfo.name} 님</b>의 오늘(${fn:substring(hblist.hdate,0,10)})의<br>
												총 <b style="color: orange">개인 운동시간은 ${hblist.playtime}분</b> 입니다.<br><br>
											</td>
										</tr>
									</c:if>
									<c:if test="${hblist.tid != 'notrainer'}">
										<tr>
											<td>
												<b>${loginInfo.name} 님 ${hblist.tname} 트레이너</b>와의 오늘(${fn:substring(hblist.hdate,0,10)})의<br>
												총 <b style="color: blue">${hblist.tactivity}시간은 ${hblist.playtime}분</b> 입니다.<br><br>
											</td>
										</tr>
									</c:if>
									</c:forEach>
								</table>
							<div class="text-center">
								<button type="button" class="btn btn-warning scrollto btn-sm" onclick="location.href='myHealthList.ht'">운동 상세정보 보러가기</button>
							</div>
							</c:if>
						</div><!-- ps-3 -->
					</div><!-- card-body -->
				</div>
			</div>
			
			<!-- 오늘의 식단 -->
			<div class="col-xxl-4 col-md-6">
				<div class="card info-card revenue-card">
					<div class="card-body">
					<h5 class="card-title">오늘의 식단</h5>
						<div class="ps-3" style="text-align: center">
							<c:if test="${empty foodBean}">
								오늘의 식단 정보가 없습니다.<br><br>
							<div class="text-center">
								<button type="button" class="btn btn-warning scrollto btn-sm" onclick="location.href='myNutritionList.ht'">식단 등록하러 가기</button>
							</div>
							</c:if>
							<c:if test="${not empty foodBean}">
								<table style="width: 100%;" align="center">
									<tr>
										<td colspan="4">오늘의 종합 영양섭취 정보</td>
									</tr>
									<tr>
										<td colspan="1" style="width: 25%;"><font style="color: gray; font-size: 16px">음식명</font></td>
										<td colspan="3">${foodBean.fname}</td>
									</tr>
									<tr>
										<td style="width: 25%;"><font style="color: gray; font-size: 16px">칼로리</font></td>
										<td>${foodBean.calories}kcal</td>
										<td style="width: 25%;"><font style="color: gray; font-size: 16px">탄수화물</font></td>
										<td>${foodBean.carbohydrate}g</td>
									</tr>
									<tr>
										<td style="width: 25%;"><font style="color: gray; font-size: 16px">단백질</font></td>
										<td>${foodBean.protein}g</td>
										<td style="width: 25%;"><font style="color: gray; font-size: 16px">지방</font></td>
										<td>${foodBean.fat}g</td>
									</tr>
									<tr>
										<td style="width: 25%;"><font style="color: gray; font-size: 16px">설탕</font></td>
										<td>${foodBean.sugar}g</td>
										<td style="width: 25%;"><font style="color: gray; font-size: 16px">나트륨</font></td>
										<td>${foodBean.sodium}g</td>
									</tr>
								</table>
							<div class="text-center">
								<button type="button" class="btn btn-warning scrollto btn-sm" onclick="location.href='myNutritionList.ht'">식단 정보 보러가기</button>
							</div>
							</c:if>
						</div><!-- ps-3 -->
					 </div><!-- card-body -->
				</div>
			</div>
			
			<!-- 함께하는 트레이너 -->
			<div class="col-xxl-4 col-md-6">
				<div class="card info-card revenue-card">
					<div class="card-body">
					<h5 class="card-title">함께하는 트레이너</h5>
						<div class="ps-3">
							<c:if test="${empty mainHealthList}">
								함께하는 트레이너 정보가 없습니다.
							</c:if>
							<!-- 선택한 날짜, 00 트레이너와 00일쨰 00중 -->
							<c:if test="${not empty mainHealthList}">
								<c:forEach var="hlist" items="${mainHealthList}">
									<b>${hlist.tname}</b> 트레이너와 <b>${hlist.hdate}</b>일째 <b>${hlist.ptype} ${hlist.tactivity}</b> 중<br>
								</c:forEach>
							</c:if>
						</div><!-- ps-3 -->
					 </div><!-- card-body -->
				</div>
			</div>
			
			<!-- 목표체중 -->
			<div class="col-12">
				<div class="card info-card revenue-card">
					<div class="card-body">
						<h5 class="card-title">나의 목표</h5>
						<div class="ps-3">
						<div class="row">
							<div class="col-xxl-3"style="padding-left: 0;">
								<font style="font-size: 18px; color: #FAC710;"><b>현재 체중</b></font><br><br>
								<table align="center">
									<c:if test="${empty phsiqueBean}">
										<tr>
											<td colspan="2">등록된 신체정보가 없습니다.</td>
										</tr>
									</c:if>
									
									<c:if test="${not empty phsiqueBean}">
										<tr>
											<td style="width: 80%;"><font style="color: gray; font-size: 16px">체중(kg)</font></td>
											<td>${phsiqueBean.weight}</td>
										</tr>
										<tr>
											<td style="width: 80%;"><font style="color: gray; font-size: 16px">BMI</font></td>
											<td>${phsiqueBean.bmi}</td>
										</tr>
										<tr>
											<td style="width: 80%;"><font style="color: gray; font-size: 16px">골격근량(kg)</font></td>
											<td>${phsiqueBean.skeletalmuscle}</td>
										</tr>
										<tr>
											<td style="width: 80%;"><font style="color: gray; font-size: 16px">체지방률(%)</font></td>
											<td>${phsiqueBean.bodyfatper}</td>
										</tr>
									</c:if>
								</table>
								<div class="text-center" style="padding-top: 10%">
									<button type="button" class="btn btn-warning scrollto btn-sm" onclick="location.href='myPhysiqueList.ht'">신체정보 등록하기</button>
								</div>
							</div><!-- col-xxl-3 -->
							
							<div class="col-xxl-3">
								<font style="font-size: 18px; color: #FAC710;"><b>목표 체중</b></font><br><br>
								<table align="center">
									<c:if test="${empty goalBean}">
										<tr>
											<td colspan="2">등록된 목표체중이 없습니다.</td>
										</tr>
									</c:if>
									
									<c:if test="${not empty goalBean}">
										<tr>
											<td style="width: 60%;"><font style="color: gray; font-size: 16px">목표일자</font></td>
											<td>${fn:substring(goalBean.gpdate,0,10)}</td>
										</tr>
										<tr>
											<td style="width: 60%;"><font style="color: gray; font-size: 16px">체중(kg)</font></td>
											<td>
												<fmt:formatNumber var="w" value="${goalBean.weight - phsiqueBean.weight}" pattern=".00"/>
												${goalBean.weight} (${w})
												
											</td>
										</tr>
										<tr>
											<td style="width: 60%;"><font style="color: gray; font-size: 16px">체지방률(%)</font></td>
											<td>
												<fmt:formatNumber var="b" value="${goalBean.bodyfatper - phsiqueBean.bodyfatper}" pattern=".00"/>
												${goalBean.bodyfatper} (${b})
												
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<fmt:parseDate var="gpdate" value="${goalBean.gpdate}" pattern="yyyy-MM-dd"/>
												<jsp:useBean id="now" class="java.util.Date" />
												<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="nowTime" scope="request"/>
												<fmt:parseNumber value="${gpdate.time / (1000*60*60*24)}" integerOnly="true" var="gpdateTime" scope="request"/>
												<font style="font-size: 13px">목표일까지 <b>${gpdateTime - nowTime}일</b> 남았습니다.</font>
											</td>
										</tr>
									</c:if>
								</table>
								<div class="text-center" style="padding-top: 10%">
									<button type="button" class="btn btn-warning scrollto btn-sm" onclick="location.href='myPhysiqueGoal.ht'">목표체중 등록하기</button>
								</div>
							</div><!-- col-xxl-3 -->
							
							<div class="col-xxl-3">
								<font style="font-size: 18px; color: #FAC710;"><b>이번주 운동시간</b></font><br><br>
								<canvas id="barChart" style="max-height: 400px;"></canvas>
								
							</div><!-- col-xxl-3 -->
							
							<div class="col-xxl-3" style="text-align: center;">
								<font style="font-size: 18px; color: #FAC710;"><b>목표 운동 시간 (달성 여부)</b></font><br><br>
								<c:set var="wtime" value="${weekPlaytime / 60}"/>
								<c:set var="per" value="${(wtime / goalBean.goaltime) * 100 }"/>
								<font style="color: gray; font-size: 16px">이번주 총 운동 시간 </font> ${weekPlaytime} 분<br>
								<font style="color: gray; font-size: 16px">이번주 총 목표 시간 </font> ${goalBean.goaltime * 60} 분<br>
								
								<c:if test="${empty goalBean}">
									등록된 운동 목표 시간이 없습니다.
								</c:if>
								<c:if test="${not empty goalBean}">
									<font style="font-size: 18px;"><b><fmt:formatNumber value="${per}" pattern=".00"/> % 달성!</b></font>
									
									<canvas id="doughnutChart" style="max-height: 180px;"></canvas>
						              <script>
						              	var p = ${per};
						              	var mp = 100 - p;
						              	if(mp<0){
						              		mp = 0;
						              	}
						              	
						                document.addEventListener("DOMContentLoaded", () => {
						                  new Chart(document.querySelector('#doughnutChart'), {
						                    type: 'doughnut',
						                    data: {
					                    	  labels: [
					                            '달성',
					                            '미달성'
					                          ],
						                      datasets: [{
						                        data: [p, mp],
						                        backgroundColor: [
						                          'rgb(255, 205, 86)',
						                          'rgb(255, 99, 132)'
						                        ],
						                        hoverOffset: 4
						                      }]
						                    }
						                  });
						                });
						              </script>
						              <!-- End Doughnut CHart -->
									<c:if test="${per >= 100}">
										<font style="color: green;">목표를 달성했습니다.</font>
									</c:if>
									<c:if test="${per < 100 and per >=80}">
										<font style="color: blue;">거의 다왔어요!</font>
									</c:if>
									<c:if test="${per < 80 and per >=50}">
										<font style="color: blue;">이제 절반!</font>
									</c:if>
									<c:if test="${per < 50 and per > 0}">
										<font style="color: red;">조금만 더 노력해볼까요?</font>
									</c:if>
									<!-- - 30% 조금만 더 노력 50% 이제절반! 80% 고지가 코앞! 100% 달성! -->
									
								</c:if> 
							</div><!-- col-xxl-3 -->
							
						</div><!-- row -->
						</div><!-- ps-3 -->
					 </div><!-- card-body -->
				</div>
			</div>
			
			<!-- 이번달 신체 변화 -->
            <div class="col-12">
              <div class="card">

                <div class="card-body">
                  <h5 class="card-title">이번달 신체 변화 <span>/Today</span></h5>

                  <!-- Line Chart -->
                  <div id="lineChart"></div>

                </div>

              </div>
            </div><!-- End Reports -->
			
		</div>
	</div>


</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>