<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
$(document).ready(function(){
	graphA();
});
	function graphA() {
		$('#my-graph').empty();
		$('#my-graph').html('<h5 class="card-title">회원권 구매 갯수(최근 7일)</h5><div id="lineChart3"></div>');
		getGraphDays();
	}
	
	function graphB() {
		$('#my-graph').empty();
		$('#my-graph').html('<h5 class="card-title">회원권 구매 갯수(최근 6개월)</h5><div id="lineChart3"></div>');
		getGraphMonthly();
	}
function getGraphDays(){
		
		var salesData = [];
		var Date = [];
		
		$.ajax({
			url : "mySalesGraph.pd",
			type : "GET",
			dataType : "json",
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					salesData.push(data[i].count);
					Date.push(data[i].date);
				}

				
				new ApexCharts(document.querySelector("#lineChart3"), {
					series: [{
						name: "회원권 구매 수",
						data: salesData
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
	
	function getGraphMonthly(){
		var monthData = [];
		var Date = [];
		
		$.ajax({
			url : "mySalesGraph2.pd",
			type : "GET",
			dataType : "json",
			success : function (data) {
				
				for(i=0; i<data.length; i++){
					monthData.push(data[i].mcount);
					Date.push(data[i].mdate);
				}
				
				new ApexCharts(document.querySelector("#lineChart3"), {
					series: [{
						name: "회원권 구매 수",
						data: monthData
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
					},
					yaxis: {
						min: 0
					}
				}).render();
			} //success
		}); //ajax
	} // getGraphSkmuscle
</script>
<style>
section{
	padding: 0px !important;
}
.btn:checked{
	background-color: #ffc107 !important;
}
.btn:hover {
		background-color:#FAC710 !important;
	}
.btn-check{
	border-radius:20px !important;
}
.btn-check + &:hover {
    // override for the checkbox/radio buttons
    background-color: #ffc107 !important;
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
    <section class="section">
	
    <div class="pagetitle">
      <h1 style = "margin: 50px 0px;">수익보기</h1>
    </div><!-- End Page Title -->
      <div class="row">
			<div class="col-12">
			<!-- Default Card -->
			<div class="card">
			
				<!-- 버튼 -->
				 
				<div class="filter fe" style = "margin:15px;">
					<a class="icon ie" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
					<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
						<li class="dropdown-header text-start">
							<h6>필터선택</h6>
						</li>
						<li><a class="dropdown-item" href="javascript:graphA()">회원권 구매 갯수(최근 7일)</a></li>
						<li><a class="dropdown-item" href="javascript:graphB()">회원권 구매 갯수(최근 6개월)</a></li>
					</ul>
				</div>
				
				
				<div class="card-body" id="my-graph">
					<h5 class="card-title"></h5>
					<!-- chart -->
					<div id="lineChart"></div>
				</div>
			</div>
		</div>
	</div>
      <div class="row">
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            <h5 class="card-title">최근 7일 수익</h5>
              <!-- Line Chart -->
              <canvas id="lineChart" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#lineChart'), {
                    type: 'line',
                    data: {
                      labels: [<c:forEach var = "day" items = "${days}" varStatus = "status">'${day}'<c:if test = "${!status.last}">,</c:if></c:forEach>],
                      datasets: [{
                        label: '수익 금액 (만원)',
                        data:[<c:forEach var = "sale" items = "${weeklySales}" varStatus = "status">${sale}<c:if test = "${!status.last}">,</c:if></c:forEach>],
                        fill: false,
                        borderColor: 'rgb(67, 116, 217)',
                        tension: 0.1
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
                });
              </script>
              <!-- End Line CHart -->
            </div>
          </div>
      </div>
      
       <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            <h5 class="card-title">최근 6개월 수익</h5>
              <!-- Line Chart -->
              <canvas id="lineChart2" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#lineChart2'), {
                    type: 'line',
                    data: {
                      labels: [<c:forEach var = "month" items = "${months}" varStatus = "status">'${month}'<c:if test = "${!status.last}">,</c:if></c:forEach>],
                      datasets: [{
                        label: '수익 금액 (만원)',
                        data:[<c:forEach var = "mSale" items = "${monthlySales}" varStatus = "status">${mSale}<c:if test = "${!status.last}">,</c:if></c:forEach>],
                        fill: false,
                        borderColor: 'rgb(29, 219, 22)',
                        tension: 0.1
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
                });
              </script>
              <!-- End Line CHart -->
            </div>
          </div>
      </div>
      
      
        <div class="col-lg-4">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">상품 별 수익</h5>

              <!-- Pie Chart -->
              <canvas id="pieChart" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#pieChart'), {
                    type: 'pie',
                    data: {
                      labels: [<c:forEach var = "product" items = "${products}" varStatus = "status">'${product}'<c:if test = "${!status.last}">,</c:if></c:forEach>],
                      datasets: [{
                        label: '수익(만원)',
                        data: [<c:forEach var = "pSale" items = "${productSales}" varStatus = "status">${pSale}<c:if test = "${!status.last}">,</c:if></c:forEach>],
                        backgroundColor: [
                          'rgb(255, 99, 132)',
                          'rgb(54, 162, 235)',
                          'rgb(255, 205, 86)'
                        ],
                        hoverOffset: 4
                      }]
                    }
                  });
                });
              </script>
              <!-- End Pie CHart -->

            </div>
          </div>
        </div>
      
      
      	 <div class="col-lg-8">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">총 수익 금액</h5>

              <!-- Bar Chart -->
              <canvas id="barChart" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#barChart'), {
                    type: 'bar',
                    data: {
                      labels: ['총 금액 수수료', '수수료 재외 총 수익','총 수익'],
                      datasets: [{
                        label: '수익(만원)',
                        data: [${totalAmount * 0.1}, ${totalAmount - (totalAmount * 0.1)}, ${totalAmount}],
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
                });
              </script>
              <!-- End Bar CHart -->

            </div>
          </div>
        </div>
	</div>
      
      
    </section>

<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>