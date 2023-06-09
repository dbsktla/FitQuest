<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/reservationCalendarCSS.css">
<style type = "text/css">
	.btn:hover {
		background-color:#FAC710 !important;
	}
	.btn-check:checked{
		background-color:#FAC710 !important;
		border: #FAC710 !important;
	}
	.btn {
		border-radius: 25px !important;
		color: #444444 !important;
		font-size: 15px !important;
		font-weight: 600 !important;
		padding: 8px 20px 10px 20px !important;
	}
	.box {
		color: #444444;
		font-size: 15px;
		font-weight: 600;
	}
</style>


<section id="team" class="team">
      <div class="container" data-aos="fade-up">
        <div class="row gy-4">
		  <c:forEach var = "trainer" items = "${tList}">
          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
                <a href = "trainerDetail.pd">
             	 <div class="member-img">
               	 <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainer.timage}" class="img-fluid" alt="text"/>
            	 </div>
                </a>
              <div class="member-info">
                <h4 style = "margin-top:10px;">${trainer.name }</h4>
                <span>${trainer.activity} : ${trainer.purpose }</span>
                <p>
                <input type = "button" value = "자세히 보기" class = "btn btn-warning" onclick= "location.href='trainerDetail.pd">
                </p>
              </div>
            </div>
          </div>	
		  </c:forEach>
        </div>	
      </div>
</section>

<%@ include file="../common/bottom.jsp" %>