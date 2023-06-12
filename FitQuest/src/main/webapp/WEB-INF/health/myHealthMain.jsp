<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	$(document).ready(function(){
		//alert(1);
		getHealthTime();
	});
	
	function getHealthTime() {
		//alert(2);
		var weekdate = [];
		
		$.ajax({
			url : 'health.ht',
			type : 'POST',
			datatype : 'json',
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					weekdate.push(data[i].playtime);
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
							<a href="myHealthList.ht">운동 등록하러 가기</a>
							</c:if>
							<c:if test="${not empty hblist}">
								<table>
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
							<a href="myHealthList.ht">운동 상세정보 보러가기</a>
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
						<div class="ps-3">
						
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
							<!-- 선택한 날짜, 00 트레이너와 00일쨰 00중 -->
							<c:forEach var="hlist" items="${mainHealthList}">
								<b>${hlist.tname}</b> 트레이너와 <b>${hlist.hdate}</b>일 째 <b>${hlist.tactivity}</b> 중<br>
							</c:forEach>
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
							<div class="col-xxl-3">
								<font style="font-size: 18px; color: #FAC710;"><b>현재 체중</b></font><br><br>
								<table>
									<c:if test="${empty phsiqueBean}">
										<tr>
											<td colspan="2">등록된 신체정보가 없습니다.</td>
										</tr>
									</c:if>
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
								</table>
							</div>
							<div class="col-xxl-3">
								<font style="font-size: 18px; color: #FAC710;"><b>목표 체중</b></font><br><br>
								<table>
									<c:if test="${empty goalBean}">
										<tr>
											<td colspan="2">등록된 목표체중이 없습니다.</td>
										</tr>
									</c:if>
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
								</table>
							</div>
							<div class="col-xxl-4">
								<font style="font-size: 18px; color: #FAC710;"><b>이번주 운동시간</b></font><br><br>
								<canvas id="barChart" style="max-height: 400px;"></canvas>
								
							</div>
							<div class="col-xxl-2">
								<font style="font-size: 18px; color: #FAC710;"><b>목표 운동 시간 (달성 여부)</b></font><br><br>
								- 30% 조금만 더 노력 50% 이제절반! 80% 고지가 코앞! 100% 달성! 
							</div>
						</div><!-- row -->
						</div><!-- ps-3 -->
					 </div><!-- card-body -->
				</div>
			</div>
			
			<!-- 이번달 체중 변화 -->
            <div class="col-12">
              <div class="card">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">이번달 체중 변화 <span>/Today</span></h5>

                  <!-- Line Chart -->
                  <div id="reportsChart"></div>

                  <script>
                    document.addEventListener("DOMContentLoaded", () => {
                      new ApexCharts(document.querySelector("#reportsChart"), {
                        series: [{
                          name: 'Sales',
                          data: [31, 40, 28, 51, 42, 82, 56],
                        }, {
                          name: 'Revenue',
                          data: [11, 32, 45, 32, 34, 52, 41]
                        }, {
                          name: 'Customers',
                          data: [15, 11, 32, 18, 9, 24, 11]
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
                          type: 'datetime',
                          categories: ["2018-09-19T00:00:00.000Z", "2018-09-19T01:30:00.000Z", "2018-09-19T02:30:00.000Z", "2018-09-19T03:30:00.000Z", "2018-09-19T04:30:00.000Z", "2018-09-19T05:30:00.000Z", "2018-09-19T06:30:00.000Z"]
                        },
                        tooltip: {
                          x: {
                            format: 'dd/MM/yy HH:mm'
                          },
                        }
                      }).render();
                    });
                  </script>
                  <!-- End Line Chart -->

                </div>

              </div>
            </div><!-- End Reports -->
			
			
		</div>
	</div>


</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>