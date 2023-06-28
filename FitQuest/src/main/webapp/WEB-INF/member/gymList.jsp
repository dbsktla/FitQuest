<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<style>
	.err{
		color : #E04848;
		font-size: 10pt;
	}
	.card{
		width: 80% !important;
		text-align: center;
	}
	.btn{
		width: 70% !important;
		margin: 5px !important;
	}
</style>

<script type="text/javascript">
	function clickGym(gnum,gname){
		opener.document.getElementById("gnum").value = gnum;
		opener.document.getElementById("gname").value = gname;
		
		window.close();
	}
</script>

<body style="background-color : #FEF9E7;">
 <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="card mb-12">
                <div class="card-body">
				
                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">헬스장 선택</h5>
                  </div>
                  
                  	<c:forEach var="gym" items="${ glist }" varStatus="status">
                     <input type="button" class="btn btn-outline-warning w-100" value="${ gym.gname }" onclick="clickGym('${ gym.gnum }','${ gym.gname }')">
                    </c:forEach>
                     <input type="button" class="btn btn-warning w-100" value="등록" onclick="location.href='gymInsert.mb'">
                </div>
              </div>


            </div>
          </div>
        </div>

      </section>

    </div>
  </main>
</body>
