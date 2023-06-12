<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<body style="background-color : #FEF9E7;">
<main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
         <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
              <div class="card mb-10">
                <div class="card-body">

                  <div class="pt-4 pb-2" style="text-align: center;">
                   <img class="rounded-circle" width="70%" src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerBean.timage }">
                  </div>
					<table class="table">
						<tr align="center">
							<th>트레이너</th>
							<td>${ trainerBean.name }</td>
							<th>별명</th>
							<td>${ trainerBean.nickname }</td>
						</tr>
						<tr align="center">
							<th>생일</th>
							<td>
								<fmt:parseDate var="parseDate" value="${ trainerBean.birth }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="MM-dd"/>
							</td>
							<th>성별</th>
							<td>${ trainerBean.gender }</td>
						</tr>
						<tr align="center">
							<th>이메일</th>
							<td>${ trainerBean.email }</td>
							<th>전화번호</th>
							<td>${ trainerBean.mphone }</td>
						</tr>
						<tr style="border:white;">
							<td height="10"></td>
						</tr>
						<tr style="border:white;">
							<td colspan="4" align="center">
								<input type="button" class="btn btn-warning btn-sm" value="닫기" onclick="javascript:window.close();">
							</td>
						</tr>
				</table>
                </div>
              </div>
				

            </div>
          </div>
		</div>
      </section>

    </div>
  </main>
</body>
