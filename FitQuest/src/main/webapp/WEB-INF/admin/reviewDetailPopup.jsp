<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container" style="width:80%;">
         <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
              <div class="card mb-10">
                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">리뷰 정보</h5>
                  </div>
					<table class="table">
						<tr align="center">
							<th>트레이너</th>
							<td>${ reviewBean.tid }</td>
							<th>회원</th>
							<td>${ reviewBean.mid }</td>
						</tr>
						<tr align="center">
							<th>제목</th>
							<td>${ reviewBean.rtitle }</td>
							<th>별점</th>
							<td>${ reviewBean.rating }</td>
						</tr>
						<tr align="center">
							<td align="justify" colspan="4">${ reviewBean.rcontent }</td>
						</tr>
						<tr style="border:white;">
							<td height="10"></td>
						</tr>
						<tr style="border:white;">
							<td colspan="4" align="center">
								<input type="button" class="btn btn-primary btn-sm" value="닫기" onclick="javascript:window.close();">
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
