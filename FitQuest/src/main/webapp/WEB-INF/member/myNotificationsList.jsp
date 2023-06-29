<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<style type = "text/css">
	.notif-link:hover{
		background-color: #FEF9E7;
	}
	.notif-link{
		vertical-align: center !important;
		color:black !important;
	}
	.list-group-item:last-child {
		border-bottom-right-radius: 0px !important;
		border-bottom-left-radius: 0px !important;
	}
	.list-group-item{
		height: 60px;
		font-weight: bold;
	}
	main{
		margin-bottom : 360px;
	}
	.member{
		height: 500px !important;
	}
	.empty-text{
		font-size: 15px;
		font-weight: 600;
	}
</style>
<body style="background-color : #FEF9E7; min-height: 500px;">
    <section class="section">
	 <div class="pagetitle" style ="text-align:center; margin-bottom: 50px;">
      <h1>모든 알림<br><br></h1>
    </div><!-- End Page Title -->
      <div class="row">
      	<div class = "col-xl-3"></div>
        <div class="col-xl-6">
		
          	<div class="row" style = "height:100%;">
	          <ul class="list-group" style = "height:100%;">
	          <c:if test = "${ not empty notifList  }">
	          <c:forEach var = "notif" items = "${notifList }">
          		<fmt:parseDate value="${notif.notifDate }" var = "date" pattern="YYYY-mm-dd"/>
          		<fmt:formatDate value="${date }" var = "date" pattern = "YYYY-mm-dd"/>
	          	<a href = "${notif.request }" class = "notif-link">
				  <li class="list-group-item notif-link" style = "display: flex; justify-content:space-between; color:black !important;">${notif.notifContent } (${date})
                  <a href = "clearNotification.mb?nonum=${notif.nonum }" style = "padding: 0px 5px; color: red;" class = "notif-del"><i class="bi bi-x" style = "font-size: 25px;"></i></a>
				  </li>
	          	</a>
	          </c:forEach>
	          </c:if>
			  </ul>
	            
          	</div>
        </div>
      	<div class = "col-xl-3"></div>
      </div>
      <c:if test = "${empty notifList }">
      <section id="team" class="team" style = "background-color: #FEF9E7;">
      <div class="container" data-aos="fade-up">
        <div class="row gy-4 justify-content-center">
      	   <div class="col-lg-3 col-md-6 d-flex align-items-stretch" style = "justify-content: center;" data-aos="fade-up" data-aos-delay="100">
            <div class="member" style="height: 150px !important; display: flex; justify-content: center; align-items: center; padding: 0px 50px; border-radius: 10px;">
            	<span class="empty-text">알림이 없습니다.</span>
            </div>
           </div>
         </div>
        </div>
       </section>  
      </c:if>
      <div style = "margin-top: 30px; text-align:center;">
      	          <c:if test = "${ not empty notifList  }">
      <input type = "button" onclick = "location.href='clearMyNotifications.mb'" class = "btn btn-warning" value = "모든 알림삭제">
      	          </c:if>
      </div>
      
</section>

<%@ include file="../common/bottom.jsp" %>