<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>
<style type = "text/css">
	.tr, .td, th{
		text-align: center !important;
		margin: auto !important;
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
	<div class="title-container">
		<div class="title-text">장바구니</div>
	</div>
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">
        <div class="row" style = "justify-contents: center;">
          <div class="col-lg-12 entries" style = "padding: 0px;background-color: white;">
   			<article class="entry entry-single" style = "margin:0px;">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			            <form action = "cartOrder.od" name = "myform">
			            <div class="table-responsive">
			                <table class="table table-bordered tbl-cart">
			                    <thead>
			                        <tr class = "table-warning">
			                        	<th valign = "middle" align = "center">선택</th>
			                            <th valign = "middle" align = "center">삭제</th>
			                            <th colspan = "2" valign = "middle" align = "center">트레이너</th>
			                            <th valign = "middle" align = "center">헬스장</th>
			                            <th valign = "middle" align = "center">수업</th>
			                            <th valign = "middle" align = "center">회원권</th>
			                            <th valign = "middle" align = "center">리뷰 평균</th>
			                            <th valign = "middle" align = "center">가격</th>
			                        </tr>
			                    </thead>
			                    <tbody>
						   			<c:forEach var= "item" items = "${sList }">
			                        <tr style = "height: 80px;">
			                        	<td valign = "middle" align = "center">
										<input class="form-check-input checkItem" type="checkbox" value="${item.pnum }" name = "pnum">
										</td>
			                            <td class="text-center" valign = "middle" align = "center">
			                                <a href="cartDelete.od?pnum=${item.pnum }" class="remove_cart" rel="2">
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
				                            <c:if test="${item.pnum == minpnum}">
				                            <span style = "color:red; font-style:italic;">최저가!(회당 ${minPrice}원)</span><br>
				                            </c:if>
				                            <c:if test="${item.pnum == maxpnum}">
				                            <span style = "color:red; font-style:italic;">최대가!(회당 ${maxPrice}원)</span><br>
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
			            <div style="display:flex; justify-content: center !important;">
			                <button type="button" class="btn btn-warning" id = "checkAll" style = "width: 180px;">전체상품 선택하기</button>
			                <button type="button" class="btn btn-warning" onClick = "location.href='trainerList.pd'">트레이너 목록보기</button>
			                <button type="submit" class="btn btn-warning" onClick = "return cartCheck()">주문하기</button>
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