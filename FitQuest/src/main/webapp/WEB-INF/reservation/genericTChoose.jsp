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
		/* position: absolute;
		transform: translate(-50%, -50%);
		bottom: 20px; */
	}
	.box {
		color: #444444;
		font-size: 15px;
		font-weight: 600;
	}
	.team{
		margin: 150px 0px;
	}
	.margin{
		margin: 20px 0px;
	}
	.text{
		color: #444444 !important;
		font-weight: 600 !important;
		font-size: 16px !important;
		background-color: #FEF9E7; 
		border-radius: 50px;
		padding: 10px; 
	}
</style>


<section id="team" class="team">
      <div class="container" data-aos="fade-up">
        <div class="row gy-4 justify-content-center">
		  <c:forEach var = "trainer" items = "${tList}">
          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
                <a href = "trainerDetail.pd">
             	 <div class="member-img">
               	 <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainer.timage}" class="img-fluid" alt="text"/>
            	 </div>
                </a>
              <div class="member-info">
                <div><h4 style = "margin-top:10px;">${trainer.name }</h4></div>
                <div><span class="margin text">${trainer.activity}</span></div>
                <div><span class="margin">${trainer.purpose}</span></div> 
                <div class="position">
                <input type="button" value="선택" class="btn btn-warning" onclick="location.href='genericReservation.rv">
                </div>
              </div>
            </div>
          </div>	
		  </c:forEach>
        </div>	
      </div>
</section>

<%@ include file="../common/bottom.jsp" %>