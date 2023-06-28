<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<style type = "text/css">
	h4 {
    	color: #FAC710;
	}
		.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
</style>
<body style="background-color : #FEF9E7;">
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">
        <div class="row" style = "justify-contents: center;">
         <header class="section-header" style = "margin-top:60px;">
	          <h2>FitQuest</h2>
	          <p>주문 완료</p>
	        </header>
          <div class="col-lg-12 entries" style = "padding: 0px;background-color: white;">
          	<article class="entry entry-single" style = "margin:0px;">

   			 <div class="col-lg-12">
   			 		 <div class="col-lg-12 col-sm-12 hero-feature">
			        <h4>주문 번호 : #${orderNum }</h4>
   			 		</div>
			        <div class="col-lg-12 col-sm-12 hero-feature">
			           <div class="table-responsive">
			       		 <table class = "table table-striped table-warning">
			        	<tr>
			        		<td colspan = "2"><b>주문한 상품 : </b></td>
			        	</tr>
			        	<c:forEach var = "product" items = "${sList}">
			        	<tr>
			        		<td valign = "middle" align = "left">
			        		${ product.tname} 선생님의 ${product.ptype } ${ product.activity } 수업 : ${ product.months}개월 (${product.pcount }회) 
			        		</td>
			        		<td valign = "middle" align = "right">
								<b>&#8361;${product.price }만원</b>
			        		</td>
			        	<tr>
			        	</c:forEach>
			        	<tr>
			        		<td colspan = "2" valign = "middle" align = "right">
			        			<b>구매한 상품 개수: x ${ orderCount }</b>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td colspan = "2" valign = "middle" align = "right">
			        			<b>총 금액 : &#8361;${totalAmount }만원</b>
			        		</td>
			        	</tr>
			        </table>
			        </div>
					</div>
					<div class="btn-group btns-cart">
		                <button type="button" class="btn btn-warning" onClick = "location.href='main.go'"><i class="fa fa-arrow-circle-left">홈페이지</i></button>
		                <button type="button" class="btn btn-warning" onClick = "location.href='viewMyOrderList.od'"><i class="fa fa-arrow-circle-left"></i>구매관리</button>
		            </div>
			</div>
			</article>
		  </div>
	    </div>
	</div>
</section>
</body>
<%@ include file="../common/bottom.jsp" %>