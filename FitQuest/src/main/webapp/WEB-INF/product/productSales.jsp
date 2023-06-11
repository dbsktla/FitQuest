<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../member/myTrainerTop.jsp"%>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
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

</style>
    <section class="section">
	
    <div class="pagetitle">
      <h1 style = "margin: 50px 0px;">수입 보기</h1>
    </div><!-- End Page Title -->

      <div class="row">
      
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            <h5 class="card-title">최근 7일 수입</h5>
              <!-- Line Chart -->
              <canvas id="lineChart" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#lineChart'), {
                    type: 'line',
                    data: {
                      labels: [<c:forEach var = "day" items = "${days}" varStatus = "status">'${day}'<c:if test = "${!status.last}">,</c:if></c:forEach>],
                      datasets: [{
                        label: '수입 금액 (만원)',
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
            <h5 class="card-title">최근 6개월 수입</h5>
              <!-- Line Chart -->
              <canvas id="lineChart2" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#lineChart2'), {
                    type: 'line',
                    data: {
                      labels: [<c:forEach var = "month" items = "${months}" varStatus = "status">'${month}'<c:if test = "${!status.last}">,</c:if></c:forEach>],
                      datasets: [{
                        label: '수입 금액 (만원)',
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
      
      
        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">상품 별 수입</h5>

              <!-- Pie Chart -->
              <canvas id="pieChart" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#pieChart'), {
                    type: 'pie',
                    data: {
                      labels: [<c:forEach var = "product" items = "${products}" varStatus = "status">'${product}'<c:if test = "${!status.last}">,</c:if></c:forEach>],
                      datasets: [{
                        label: '수입(만원)',
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
      
      
      	 <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">총 수입 금액</h5>

              <!-- Bar Chart -->
              <canvas id="barChart" style="max-height: 400px;"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#barChart'), {
                    type: 'bar',
                    data: {
                      labels: ['본인 총 금액', '전체 ${activity}트레이너 평균 총 수입 금액'],
                      datasets: [{
                        label: '수입(만원)',
                        data: [${totalAmount}, ${avgScore}],
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

      
      
    </section>
    
<%@ include file="../member/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>