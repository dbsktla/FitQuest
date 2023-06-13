<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
</script>
<style>
section{
	padding: 0px !important;
}
.btn:checked{
	background-color: #ffc107 !important;
}
.btn:hover {
		background-color:#FAC710 !important;
	}
.btn-check{
	border-radius:20px !important;
}
.btn-check + &:hover {
    // override for the checkbox/radio buttons
    background-color: #ffc107 !important;
  }
.td{
	text-align:center;
}
</style>
    <section class="section"  style = "height: 80%;">
	
    <div class="pagetitle" style = "margin: 40px 0px;">
      <h1>상품관리</h1>
    </div><!-- End Page Title -->

      <div class="row">
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            	<div style = "display:flex; justify-content: space-between;">
            	<h4 class="comments-count">수업 회원권 : </h4><br>
            	<input type = "button" class = "btn btn-warning" value = "상품 등록하기" onClick = "location.href='insertProduct.pd'">
            	</div>
            <c:if test = "${not empty pList  }">
             <table class="table">
                <thead>
                  <tr>
                    <th scope="col">사용기간</th>
                    <th scope="col">사용 갯수</th>
                    <th scope="col">개인 / 그룹</th>
                    <th scope="col">수업 시간길이</th>
                    <th scope="col">자세히 보기</th>
                  </tr>
                </thead>
                <tbody>
				    <c:forEach var = "product" items = "${pList }">
                	<tr>
	                	<td>${product.months}개월</td>
	                	<td>레슨 ${product.pcount }회</td>
	                	<td>${product.ptype }</td>
	                	<td>${product.ptime }시간</td>
	                	<td><a href = "productDetail.pd?pnum=${product.pnum }"><i class="bi bi-bag-plus" style = "font-size: 20px;"></i></a></td>
                	</tr>
                	</c:forEach>
             	</tbody>
              </table>
            </c:if>
            <c:if test = "${ empty pList  }">
            	<div class="blog-author d-flex align-items-center" style = "justify-content: space-between;">
              <div>
                <h5 style = "color: #FAC710">아직 등록된 회원권이 없습니다.</h5>
              </div>
              <div>
            	</div></div>
			</c:if>            
            
            </div>
          </div>
      </div>
      </div>
      
      
    </section>
    
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>