<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<style type = "text/css">
	.tr, .td{
		text-align: center !important;
		margin: auto !important;
	}
</style>
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
         <header class="section-header" style = "margin-top:60px;">
	          <h2>FitQuest</h2>
	          <p>장바구니</p>
	        </header>
          <div class="col-lg-12 entries">
   			<article class="entry entry-single">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			            <form action = "cartCalculate.pd">
			            <div class="table-responsive">
			                <table class="table table-bordered tbl-cart">
			                    <thead>
			                        <tr class = "table-warning">
			                        	<td>선택</td>
			                            <td colspan = "2">트레이너</td>
			                            <td>헬스장</td>
			                            <td>수업</td>
			                            <td>회원권</td>
			                            <td class="td-qty">가격</td>
			                            <td>리뷰 평균</td>
			                            <td>삭제</td>
			                        </tr>
			                    </thead>
			                    <tbody>
						   			<c:forEach var= "item" items = "${sList }">
			                        <tr style = "height: 80px;">
			                        	<td>
										<input class="form-check-input" type="checkbox" value="${item.pnum }" name = "pnum">
										</td>
			                            <td class="hidden-xs" style = "width : 120px;">
			                                <a href="trainerDetail.pd?id=${item.tid }&hasReview=${item.hasReview}">
			                                    <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${item.timage}" width="100" height="100">
			                                </a>
			                            </td>
			                            <td style = "width:75px;"><a href="trainerDetail.pd?id=${item.tid }&hasReview=${item.hasReview}">${item.tname}</a>
			                            </td>
			                            <td>
			                               ${ item.gname } - ${item.gaddr1 } ${item.gaddr2 }
			                            </td>
			                            <td>${item.ptype }(${ item.people}명) ${item.activity }수업</td>
			                            <td>
			                            	${item.months }개월 : ${item.ptime }시간 레슨 ${item.pcount }회
			                            </td>
			                            <td class="price"><b>&#8361;${item.price }만원</b></td>
			                            <td>${item.rating } / 5</td>
			                            <td class="text-center">
			                                <a href="cartDelete.pd?pnum=${item.pnum }" class="remove_cart" rel="2">
			                                    <i class="fa bi-trash"></i>
			                                </a>
			                            </td>
			                        </tr>
									</c:forEach>
			                        <tr>
			                            <td colspan="6" align="right">Total</td>
			                            <td class="total" colspan="2"><b>&#8361;${totalAmount }만원</b>
			                            </td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
			            <div class="btn-group btns-cart">
			                <button type="button" class="btn btn-warning" onClick = "location.href='trainerList.pd'"><i class="fa fa-arrow-circle-left"></i>트레이너 목록보기</button>
			                <button type="submit" class="btn btn-warning"><i class="fa fa-arrow-circle-right"></i>결제하기</button>
			            </div>
			            </form>
			
			        </div>
			    </div>
   			
   			
   			</article>
   		  </div>
   		  </div>
   		</div>
</section>
   	  


<%@ include file="../common/bottom.jsp" %>