<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
function numCheck(){
	if($('select[name=ptype]').val() == '개인' && $('input[name=people]').val() != '1'){
		alert("개인 수업은 1명으로 입력하세요.");
		$('input[name=people]').focus(function(){
			$(this).val('');
		});
	}
	if($('select[name=ptype]').val() == '그룹' && $('input[name=people]').val() == '1'){
		alert("그룹 수업은 2명 이상으로 입력하세요.");
		$('input[name=people]').focus(function(){
			$(this).val('');
		});
	}
}
function checkData(){
	if($('input[name=months]').val() == ""){
		alert("사용기간을 입력하세요");
		$('input[name=months]').focus();
		return false;
	}
	if(isNaN($('input[name=months]').val())){
		alert("사용기간을 숫자로 입력하세요");
		$('input[name=months]').select();
		return false;
	}
	if($('input[name=pcount]').val() == ""){
		alert("회원권 사용갯수를 입력하세요");
		$('input[name=pcount]').focus();
		return false;
	}
	if(isNaN($('input[name=pcount]').val())){
		alert("사용갯수를 숫자로 입력하세요");
		$('input[name=pcount]').select();
		return false;
	}
	if($('select[name=ptype]').val() == ""){
		alert("개인/그룹 수업중 하나를 선택하세요.");
		return false;
	}
	if($('input[name=people]').val() == ""){
		alert("수업참여 회원 갯수를 입력하세요");
		$('input[name=people]').focus();
		return false;
	}
	if(isNaN($('input[name=people]').val())){
		alert("수업참여 회원 갯수는 숫자로 입력하세요");
		$('input[name=people]').select();
		return false;
	}
	if($('input[name=price]').val() == ""){
		alert("가격을 입력하세요");
		$('input[name=price]').focus();
		return false;
	}
	if(isNaN($('input[name=price]').val())){
		alert("가격을 숫자로 입력하세요");
		$('input[name=price]').select();
		return false;
	}
}
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
.header{
		background-color: white !important;
		padding-bottom: 50px;
}
<% 
	session.setAttribute("insertFlag", true);
%>
</style>
<body style="background-color : #FEF9E7;">
    <section class="section"  style = "height: 80%;">
	
    <div class="pagetitle">
      <h1>상품관리</h1>
    </div><!-- End Page Title -->

      <div class="row">
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
             <h5 class="card-title">상품 등록하기</h5>
				<div class="reply-form">
               			
               			
               	<form action="insertProduct.pd" method = "post">
               		<div class="row" style = "margin-bottom:20px;">
	                    <div class="col-md-6 form-group">
	                    	<span>회원권 사용기간</span>
	                      <input name="months" type="text" class="form-control" placeholder = "${productBean.months}개월">
	                    </div>
	                     <div class="col-md-6 form-group">
	                    	<span>회원권 사용갯수</span>
	                      <input name="pcount" type="text" class="form-control" placeholder = "레슨 ${productBean.pcount}회">
	                    </div>
                    </div>	
               			<div class = "row" style = "margin-bottom:20px;">
                    <div class="col-md-6 form-group">
                       	<span>개인/그룹 수업</span>
                    	<select name="ptype" class="form-select">
                      		<option value = "">선택</option>
                      		<option value = "개인"
                      		<c:if test = "${prodBean.ptype eq '개인' or productBean.ptype eq '개인'}">
                      		selected
                      		</c:if>
                      		>개인</option>
                      		<option value = "그룹"
                      		<c:if test = "${prodBean.ptype eq '그룹' or productBean.ptype eq '그룹'}">
                      		selected
                      		</c:if>
                      		>그룹</option>
                      </select>
                    </div>
                  <div class="col-md-6 form-group">
                       	<span>수업참여 회원 갯수</span>
                      <input name="people" type="text" class="form-control" placeholder = "${ productBean.people }" onkeyup="numCheck()">
                    </div>
                  </div>
               			
               		<div class = "row" style = "margin-bottom:20px;">
                  <div class="col-md-6 form-group">
                  <span>가격</span>
                      <input name="price" type="text" class="form-control" placeholder = "${productBean.price}만원">
                    </div>
                  </div>	
                  <div class = "" style = "margin-bottom: 20px;">
                  		<input type = "submit" class = "btn btn-warning" value = "등록" onClick = "return checkData()">
                  		<input type = "reset" class = "btn btn-primary" value = "초기화">
                  </div>
                </form>
                </div>            
            </div>
          </div>
      </div>
      </div>
      
      
    </section>
</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>