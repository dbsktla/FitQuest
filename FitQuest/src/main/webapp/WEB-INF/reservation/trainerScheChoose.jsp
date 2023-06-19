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
		  <c:forEach var = "tspeople" items = "${peopleArr}">
          <div class="col-lg-2 col-md-4 d-flex align-items-stretch mx-auto" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
              <div class="member-info">
              	<form action="tScheduleUpdate.rv" method="get">
              	<input type="hidden" name="tspeople" value="${tspeople}">
	                <div><h4 style = "margin-top:10px;">
	                	<c:if test="${tspeople != 1}">
	                		그룹
	                	</c:if>
                		<c:if test="${tspeople == 1}">
	                		개인
	                	</c:if>
	                </h4></div>
	                <div><span class="margin text">${tspeople}인</span></div>
	                <div class="position">
	                 <input type="submit" value="수정하기" class="btn btn-warning">
               		</div>
                </form>
              </div>
            </div>
          </div>	
		  </c:forEach>
        </div>	
      </div>
</section>

<%@ include file="../common/bottom.jsp" %>