<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>
<style>
	.card-title{
		border: none !important;
	}
</style>
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
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">아이디 찾기</h5>
                  </div>

                  <form action="memberFindId.mb" method="post" class="row g-3 needs-validation">

                    <div class="col-12">
                      <label for="name" class="form-label">이름</label>
                      <div class="input-group has-validation">
                        <input type="text" name="name" class="form-control" id="name" required>
                        <div class="invalid-feedback">이름을 입력하세요.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="email" class="form-label">이메일</label>
                      <input type="email" name="email" class="form-control" id="email" required>
                      <div class="invalid-feedback">이메일을 입력하세요.</div>
                    </div>
					
					<div class="col-12">
                      <button type="submit" class="btn btn-warning w-100">아이디 찾기</button>
                    </div>
                    
                  </form>
                  
                </div>
              </div>


            </div>
          </div>
		</div>
      </section>

    </div>
  </main>
</body>
