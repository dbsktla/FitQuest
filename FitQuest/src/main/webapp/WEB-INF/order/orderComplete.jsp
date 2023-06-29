<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>
<%@ include file="../common/top.jsp" %>
<style type = "text/css">
	h5 {
    	color: gray;
    	font-weight: bold !important;   
	}
	.header{
	background-color: white !important;
	padding-bottom: 50px;
	}
	.title-container{
		margin-bottom: 0 !important; 
	}
	.btn-warning{
		margin: 2.5px;
	}
</style>
<body style="background-color : #FEF9E7;">
	<div class="title-container">
		<div class="title-text">주문 완료</div>
	</div>
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">
        <div class="row" style = "justify-contents: center;">
          <div class="col-lg-12 entries" style = "padding: 0px;background-color: white;">
          	<article class="entry entry-single" style = "margin:0px;">

   			 <div class="col-lg-12">
   			 		<div class="col-lg-12 col-sm-12 hero-feature">
			        <h5>주문 번호 : #${orderNum }</h5>
   			 		</div>
			        <div class="col-lg-12 col-sm-12 hero-feature">
			           <div class="table-responsive">
			       		 <table class = "table">
			        	<tr style="background-color: #FEF9E7; height: 50px;">
			        		<td colspan = "2" valign = "middle"><b>주문한 상품</b></td>
			        	</tr>
			        	<c:forEach var = "product" items = "${sList}">
			        	<tr style="background-color: #FFFBF0;">
			        		<td valign = "middle" align = "left">
			        		${ product.tname} 선생님의 ${product.ptype } ${ product.activity } 수업 : ${ product.months}개월 (${product.pcount }회) 
			        		</td>
			        		<td valign = "middle" align = "right">
								<b>&#8361;${product.price }만원</b>
			        		</td>
			        	<tr>
			        	</c:forEach>
			        	<tr style="background-color: #FFFBF0;">
			        		<td colspan = "2" valign = "middle" align = "right">
			        			<b>구매한 상품 개수: x ${ orderCount }</b>
			        		</td>
			        	</tr>
			        	<tr style="background-color: #FEF9E7; height: 50px;">
			        		<td colspan = "2" valign = "middle" align = "right">
			        			<b>총 금액 : &#8361;${totalAmount }만원</b>
			        		</td>
			        	</tr>
			        </table>
			        </div>
					</div>
					<div style="display:flex; justify-content: center !important;">
		                <button type="button" class="btn btn-warning" onClick = "location.href='main.go'">홈페이지</button>
		                <button type="button" class="btn btn-warning" onClick = "location.href='viewMyOrderList.od'">구매관리</button>
		            </div>
			</div>
			</article>
		  </div>
	    </div>
	</div>
</section>
</body>
<%@ include file="../common/bottom.jsp" %>