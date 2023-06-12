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

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">작성자 정보</h5>
                  </div>
					<table class="table">
						<tr align="center">
							<th>작성자</th>
							<td>${ memberBean.name }</td>
							<th>별명</th>
							<td>${ memberBean.nickname }</td>
						</tr>
						<tr align="center">
							<th>생일</th>
							<td>
								<fmt:parseDate var="parseDate" value="${ memberBean.birth }" pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${ parseDate }" pattern="MM-dd"/>
							</td>
							<th>성별</th>
							<td>${ memberBean.gender }</td>
						</tr>
						<tr align="center">
							<th>이메일</th>
							<td>${ memberBean.email }</td>
							<th>전화번호</th>
							<td>${ memberBean.mphone }</td>
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
