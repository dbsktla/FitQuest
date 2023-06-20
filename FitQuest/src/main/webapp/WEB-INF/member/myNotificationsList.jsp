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
</style>
<body style="background-color : #FEF9E7;">
    <section class="section">
	 <div class="pagetitle" style ="text-align:center; margin-bottom: 50px;">
      <h1>모든 알림</h1>
    </div><!-- End Page Title -->
      <div class="row">
      	<div class = "col-xl-3"></div>
        <div class="col-xl-6">
		
          	<div class="row" style = "height:100%;">
	          <ul class="list-group" style = "height:100%;">
	          <c:forEach var = "notif" items = "${notifList }">
          		<fmt:parseDate value="${notif.notifDate }" var = "date" pattern="YYYY-mm-dd"/>
          		<fmt:formatDate value="${date }" var = "date" pattern = "YYYY-mm-dd"/>
	          	<a href = "${notif.request }" class = "notif-link">
				  <li class="list-group-item notif-link" style = "display: flex; justify-content:space-between; color:black !important;">${notif.notifContent } (${date})
                  <a href = "clearNotification.mb?nonum=${notif.nonum }" style = "padding: 0px 5px; color: red;" class = "notif-del"><i class="bi bi-x" style = "font-size: 25px;"></i></a>
				  </li>
	          	</a>
	          </c:forEach>
			  </ul>
	            
          	</div>
        </div>
      	<div class = "col-xl-3"></div>
      </div>
      
      <div style = "margin-top: 30px; text-align:center;">
      <input type = "button" onclick = "location.href='clearMyNotifications.mb'" class = "btn btn-warning" value = "모든 알림삭제">
      </div>
      
</section>

<%@ include file="../common/bottom.jsp" %>