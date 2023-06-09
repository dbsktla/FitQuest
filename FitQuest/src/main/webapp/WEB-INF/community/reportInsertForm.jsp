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
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">신고 내용</h5>
                  </div>

					 <form id="myform" action="reportInsert.co" class="row g-3 needs-validation" novalidate>
				    	 <input type="hidden" name="bcnum" id="bcnum" value="${ param.bcnum }">
				    	 <input type="hidden" name="bnum" id="bnum" value="${ param.bnum }">
				    	 <input type="hidden" name="rtype" id="rtype" value="${ param.rtype }">
				    	 <div class="col-12">
	                      <div class="input-group has-validation">
	                      	<textarea rows="5" cols="50" name="rcontent" class="form-control" id="rcontent"></textarea>
	                      </div>
	                    </div>
				    	<div class="col-12">
	                      <button type="submit" id="sub" class="btn btn-warning w-100">신고</button>
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
