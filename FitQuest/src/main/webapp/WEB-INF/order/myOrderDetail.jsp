<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myMemberTop.jsp"%>
<body style="background-color : #FEF9E7;">
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
	      
	      <div class ="col-lg-1"></div>  	
          <div class="col-lg-10 entries" style = "padding: 0px;background-color: white;">
   			<article class="entry entry-single" style = "margin:0px;">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			        
			        	<div class="reply-form">
		                <h4>주문 #${orderBean.onum } 자세히 보기 :</h4>
		              </div>
		              
		            <div class="table-responsive">
			       		 <table class = "table table-striped table-warning">
			        	<tr>
			        		<td colspan = "2"><b>주문한 상품 : </b></td>
			        	</tr>
			        	<c:forEach var = "product" items = "${msList}">
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
			        			<b>구매한 상품 갯수: x ${ orderCount }</b>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td colspan = "2" valign = "middle" align = "right">
			        			<b>총 금액 : &#8361;${totalAmount }만원</b>
			        		</td>
			        	</tr>
			        </table>
			        <input type = "button" value = "구매관리" class = "btn btn-warning" onclick = "location.href='viewMyOrderList.od'">
			        </div>
			        </div>
			 </div>
			</article>
		 </div>
		 <div class ="col-lg-1"></div>
		</div>
	</div>
</section>
</body>
<%@ include file="../common/myMemberBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>