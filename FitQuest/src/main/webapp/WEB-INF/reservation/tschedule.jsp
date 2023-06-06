<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css">
<style>
	body{
		background-color: #FEF9E7;
		color : black;
	}
	.err{
		color : #E04848;
		font-size: 10pt;
		text-align: right;
	}
	input[type=checkbox]{
		accent-color : #FAC710;
	}
	input[type=radio]{
		accent-color : #FAC710;
	}
}
</style>
<%
String [] tstimeArr = {"05:00~06:00","06:00~07:00","07:00~08:00","08:00~09:00","10:00~11:00","12:00~13:00","13:00~14:00","15:00~16:00","16:00~17:00","18:00~19:00",
		"19:00~20:00","20:00~21:00","21:00~22:00"}; 
String [] dayArr = {"일","월","화","수","목","금","토"}; 
%> 

<body style="background-color : #FEF9E7;">
 <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">스케줄 설정</h5>
                  </div>
                  
                  <form:form commandName="tscheduleBean" action="tschedule.rv" method="post" class="row g-3 needs-validation" novalidate="novalidate">
                    <div class="col-12">
                      <label for="yourDay" class="form-label">요일
                      <form:errors cssClass="err" path="tsday" /></label>
                      <br>
                      	<div class="center form-control">
                        <c:forEach var="tsd" items="<%=dayArr%>">
                      	<label for="${tsd}" class="margin5">
                      	<input type="checkbox" name="tsday" id="${tsd}" value="${tsd}" <c:if test="${tscheduleBean.tsday.contains(tsd)}">checked</c:if>>
                      	${tsd} 
                        </label>
                        </c:forEach>
                        </div>
                    </div>
                    
                     <div class="col-12">
                      <label for="yourTstime" class="form-label">시간
                      <form:errors cssClass="err" path="tstime"/>
                      </label> <br>
                      <div class="center form-control">
                        <c:forEach var="tst" items="<%=tstimeArr%>">
                      	<label for="${tst}" class="margin5 form-control">
                      	<input type="checkbox" name="tstime" id="${tst}" value="${tst}" <c:if test="${tscheduleBean.tstime.contains(tst)}">checked</c:if>>
                      	${tst} 
                        </label>
                        </c:forEach>
                       </div>
                      </div>
                    
                    <div class="col-12">
                      <label for="yourTsdate" class="form-label">불가능한 날짜</label>
                      <input type="date" name="tsdate" class="form-control" id="yourTsdate" value="${tscheduleBean.tsdate}"><br>
                    </div>
                    
                    <div class="col-12 center">
                    	<!-- 처음 스케줄 등록할때 -->
                    	<c:if test="${flag == false}">
	                    	<button type="submit" id="inertSub" class="btn btn-warning m-size" onClick="location.href='tschedule.rv'">새로 등록</button>
                    	</c:if>
                    	<c:if test="${flag == true}">
                    	<button type="submit" id="updateSub" class="btn btn-warning m-size">수정</button>
                   		</c:if>
                    </div>
                  </form:form> 

                </div> 
              </div>

              <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main>
</body>  












<%@ include file="../common/adminBootBottom.jsp" %>  
<%@ include file="../common/bottom.jsp" %>