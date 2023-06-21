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
	.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
	#kakaopay:hover{
		cursor: pointer;
	}
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#kakaopay').click(function (){
		var IMP = window.IMP; // 생략가능
		IMP.init('imp46655364'); 
		window.IMP.request_pay({
			pg: 'kakaopay.TC0ONETIME',
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			name: '사용권',
			// 결제창에서 보여질 이름
			
			amount: '${ totalAmount }0000',
			// 가격 
			buyer_name: '${ sessionScope.loginInfo.name }',
			// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
			}, function (rsp) {
				console.log(rsp);
				var msg = '';
			if (rsp.success) {
				//msg += '결제가 완료되었습니다.\n';
				//msg += '결제 금액 : ' + rsp.paid_amount + '원';
				$('#myform').submit();
				// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
				// 자세한 설명은 구글링으로 보시는게 좋습니다.
			} else {
				//msg += '결제에 실패하였습니다.\n';
				msg += rsp.error_msg;
				alert(msg);
			}
		});
		
	});
	
	$('#pay').click(function (){
		var IMP = window.IMP;
		IMP.init('imp46655364'); 
		window.IMP.request_pay({
			pg : 'html5_inicis',
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			name: '사용권',
			// 결제창에서 보여질 이름
			
			//amount: '${ totalAmount }0000',
			amount: '100',
			// 가격 
			buyer_name: '${ sessionScope.loginInfo.name }',
			buyer_email : '${ sessionScope.loginInfo.email }'
			}, function (rsp) {
				console.log(rsp);
				var msg = '';
			if (rsp.success) {
				$('#myform').submit();
			} else {
				//msg += '결제에 실패하였습니다.\n';
				msg += rsp.error_msg;
				alert(msg);
			}
		});
		
	});
});	
</script>

<body style="background-color : #FEF9E7;">
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
         <header class="section-header" style = "margin-top:60px;">
	          <h2>FitQuest</h2>
	          <p>주문 확인</p>
	        </header>
          <div class="col-lg-12 entries" style = "padding: 0px;background-color: white;">
   			<article class="entry entry-single" style = "margin:0px;">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			        <h4>주문하실 상품 확인한 후 결제하세요</h4>
   			 		</div>
   			 		
			        <div class="col-lg-12 col-sm-12 hero-feature">
			            <form action = "cartCalculate.od" name = "myform" id="myform">
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
			                            	${item.months }개월 : 레슨 ${item.pcount }회
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
			                <button type="button" id="pay" class="btn btn-warning"><i class="fa fa-arrow-circle-right"></i>결제하기</button>
			            </div>
			               <%--  <a id="kakaopay">
			                	<img src="<%= request.getContextPath() %>/resources/Image/LoginImage/kakaopay2.png">
			                </a> --%>
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