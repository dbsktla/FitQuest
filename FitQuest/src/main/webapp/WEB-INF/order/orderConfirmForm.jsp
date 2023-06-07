<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<%
	session.setAttribute("flag2", true); 
%>

<style type = "text/css">
	h4 {
    	color: #FAC710;
	}
</style>
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
         <header class="section-header" style = "margin-top:60px;">
	          <h2>FitQuest</h2>
	          <p>주문 확인</p>
	        </header>
          <div class="col-lg-12 entries">
   			<article class="entry entry-single">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			        <h4>주문하실 상품 확인한 후 결제하세요</h4>
   			 		</div>
   			 		
			        <div class="col-lg-12 col-sm-12 hero-feature">
			            <form action = "cartCalculate.od" name = "myform">
			            <div class="table-responsive">
			                <table class="table table-bordered tbl-cart">
			                    <thead>
			                        <tr class = "table-warning">
			                            <td colspan = "2" valign = "middle" align = "center">트레이너</td>
			                            <td valign = "middle" align = "center">헬스장</td>
			                            <td valign = "middle" align = "center">수업</td>
			                            <td valign = "middle" align = "center">회원권</td>
			                            <td valign = "middle" align = "center">가격</td>
			                        </tr>
			                    </thead>
			                    <tbody>
						   			<c:forEach var= "item" items = "${sList }">
			                        <tr style = "height: 80px;">
			                            <td class="hidden-xs" style = "width : 120px;" valign = "middle" align = "center">
							            <input type = "hidden" value = "${item.pnum }" name = "pnum">
			                                <a href="trainerDetail.pd?id=${item.tid }&hasReview=${item.hasReview}">
			                                    <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${item.timage}" width="100" height="100">
			                                </a>
			                            </td>
			                            <td style = "width:75px;" valign = "middle" align = "center"><a href="trainerDetail.pd?id=${item.tid }&hasReview=${item.hasReview}">${item.tname}</a>
			                            </td>
			                            <td valign = "middle" align = "center">
			                               ${ item.gname } - ${item.gaddr1 } ${item.gaddr2 }
			                            </td>
			                            <td valign = "middle" align = "center">${item.ptype }(${ item.people}명) ${item.activity }수업</td>
			                            <td valign = "middle" align = "center">
			                            	${item.months }개월 : ${item.ptime }시간 레슨 ${item.pcount }회
			                            </td>
			                            <td class="price" valign = "middle" align = "center">
			                            <b>&#8361;${item.price }만원</b>
			                            </td>
			                        </tr>
									</c:forEach>
			                        <tr>
			                            <td colspan="5" align="right" valign = "middle">총 금액</td>
			                            <td class="total" colspan="2" valign = "middle" align = "center"><b>&#8361;${totalAmount }만원</b>
			                            </td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
			            <div class="btn-group btns-cart">
			                <button type="button" class="btn btn-warning" onClick = "location.href='trainerList.pd'"><i class="fa fa-arrow-circle-left">트레이너 목록보기</i></button>
			                <button type="button" class="btn btn-warning" onClick = "location.href='cartList.od'"><i class="fa fa-arrow-circle-left"></i>장바구니 보기</button>
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