<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<style type = "text/css">
	.tr, .td{
		text-align: center !important;
		margin: auto !important;
	}
	.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
</style>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
	var clicked = false;
	$(document).ready(function() {
		$('#checkAll').click(function(){
			$(".checkItem").prop("checked", !clicked);
			clicked = !clicked;
			this.innerHTML = clicked ? '전체상품 선택안하기' : '전체상품 선택하기';
			})
	}) //ready
	function cartCheck(){
		var chkObj = document.getElementsByName("pnum");
		var flag = false;
		for(i = 0; i < chkObj.length; i++){
			if(chkObj[i].checked == true){
				flag = true;
			}
		}
		if(flag == false){
			alert("주문할 선택을 하나라도 선택하세요.");
			return false; //밑에 submit호출을 못 만나게 한다.
		}
		document.myform.submit();
	}//selectDelete
</script>
<body style="background-color : #FEF9E7;">
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
         <header class="section-header" style = "margin-top:60px;">
	          <h2>FitQuest</h2>
	          <p>장바구니</p>
	        </header>
          <div class="col-lg-12 entries" style = "padding: 0px;background-color: white;">
   			<article class="entry entry-single" style = "margin:0px;">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			            <form action = "cartOrder.od" name = "myform">
			            <div class="table-responsive">
			                <table class="table table-bordered tbl-cart">
			                    <thead>
			                        <tr class = "table-warning">
			                        	<td valign = "middle" align = "center">선택</td>
			                            <td valign = "middle" align = "center">삭제</td>
			                            <td colspan = "2" valign = "middle" align = "center">트레이너</td>
			                            <td valign = "middle" align = "center">헬스장</td>
			                            <td valign = "middle" align = "center">수업</td>
			                            <td valign = "middle" align = "center">회원권</td>
			                            <td valign = "middle" align = "center">리뷰 평균</td>
			                            <td valign = "middle" align = "center">가격</td>
			                        </tr>
			                    </thead>
			                    <tbody>
						   			<c:forEach var= "item" items = "${sList }">
			                        <tr style = "height: 80px;">
			                        	<td valign = "middle" align = "center">
										<input class="form-check-input checkItem" type="checkbox" value="${item.pnum }" name = "pnum">
										</td>
			                            <td class="text-center" valign = "middle" align = "center">
			                                <a href="cartDelete.pd?pnum=${item.pnum }" class="remove_cart" rel="2">
			                                    <i class="fa bi-trash"></i>
			                                </a>
			                            </td>
			                            <td class="hidden-xs" style = "width : 120px;" valign = "middle" align = "center">
			                                <a href="trainerDetail.pd?id=${item.tid }&hasReview=${item.hasReview}">
			                                    <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${item.timage}" width="100" height="100">
			                                </a>
			                            </td>
			                            <td style = "width:75px;" valign = "middle" align = "center"><a href="trainerDetail.pd?id=${item.tid }&hasReview=${item.hasReview}">${item.tname}</a>
			                            </td>
			                            <td valign = "middle" align = "center">
			                               ${ item.gname } - ${item.gaddr1 } ${item.gaddr2 }
			                            </td>
			                            <td valign = "middle" align = "center"> ${item.ptype }(${ item.people}명) ${item.activity }수업</td>
			                            <td valign = "middle" align = "center">
			                            	${item.months }개월 : 레슨 ${item.pcount }회
			                            </td>
			                            <td valign = "middle" align = "center">
			                            	<c:if test = "${item.hasReview eq 'Y'}">
			                            	<fmt:formatNumber var = "avgScore1" value="${item.rating  }" type="number" pattern="#.0"/>
			                            	${avgScore1 } / 5
			                            	</c:if>
			                            	<c:if test = "${item.hasReview eq 'N' }">
			                            	리뷰 없습니다
			                            	</c:if>
			                            </td>
			                            <td class="price" valign = "middle" align = "center">
			                            <c:if test = "${minPrice != maxPrice }">
				                            <c:if test="${item.price == minPrice}">
				                            <span style = "color:red; font-style:italic;">최저가!</span><br>
				                            </c:if>
				                            <c:if test="${item.price == maxPrice}">
				                            <span style = "color:red; font-style:italic;">최대가!</span><br>
				                            </c:if>
			                            </c:if>
			                            <b>&#8361;${item.price }만원</b>
			                            </td>
			                        </tr>
									</c:forEach>
			                        <tr>
			                            <td colspan="8" valign = "middle" align="right">총 가격</td>
			                            <td class="total" colspan="2" valign = "middle" align = "center"><b>&#8361;${totalAmount }만원</b>
			                            </td>
			                        </tr>
			                    </tbody>
			                </table>
			            </div>
			            <div class="btn-group btns-cart">
			                <button type="button" class="btn btn-warning" id = "checkAll" style = "width: 180px;"><i class="fa fa-arrow-circle-left"></i>전체상품 선택하기</button>
			                <button type="button" class="btn btn-warning" onClick = "location.href='trainerList.pd'"><i class="fa fa-arrow-circle-left"></i>트레이너 목록보기</button>
			                <button type="submit" class="btn btn-warning" onClick = "return cartCheck()"><i class="fa fa-arrow-circle-right"></i>주문하기</button>
			            </div>
			            </form>
			        </div>
			    </div>
   			</article>
   		  </div>
   		  </div>
   		</div>
</section>
</body>


<%@ include file="../common/bottom.jsp" %>