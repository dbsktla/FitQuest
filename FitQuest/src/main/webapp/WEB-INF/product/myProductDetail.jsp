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
.btn-check{
	border-radius:20px !important;
}
.td{
	text-align:center;
}
.err{
	color:red;
	font-size:12px;
	font-weight:bold;
}
.header{
		background-color: white !important;
		padding-bottom: 50px;
}
</style>
<body style="background-color : #FEF9E7;">
    <section class="section"  style = "height: 90%;">
    <div class="pagetitle" style = "margin-bottom:60px;">
      <h1>상품 자세히보기</h1>
    </div><!-- End Page Title -->
      <div class="row">
      <div class="col-lg-1"></div>
      <div class="col-lg-10">
          <div class="card" style = "height: 100%; min-height: 450px;">
            <div class="card-body">
              <h5 class="card-title">상품관리</h5>
              <!-- Default Tabs -->
              <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">상품 정보</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">수정하기</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">삭제하기</button>
                </li>
              </ul>
              <div class="tab-content pt-2" id="myTabContent">
              <!-- 상품 정보 탭 부분 -->
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				<h5 class="card-title">총 구매 갯수 : ${ orderCount }</h5>
             	 <div class="reply-form">
                <form action="">
                  <div class="row" style = "margin-bottom:20px;">
                    <div class="col-md-6 form-group">
                      <input name="email" type="text" class="form-control" value = "회원권 사용기간 :  ${productBean.months}개월" disabled>
                    </div>
                     <div class="col-md-6 form-group">
                      <input name="email" type="text" class="form-control" value = "회원권 사용갯수 :  레슨 ${productBean.pcount}회" disabled>
                    </div>
                  </div>
                  <div class = "row" style = "margin-bottom:20px;">
                  <div class="col-md-6 form-group">
                      <input name="name" type="text" class="form-control" value = "운동 :  ${ trainerBean.activity }" disabled>
                    </div>
                    <div class="col-md-6 form-group">
                      <input name="email" type="text" class="form-control" value = "수업타입 :  ${productBean.ptype} (${productBean.people}명)" disabled>
                    </div>
                  </div>
                  <div class = "row" style = "margin-bottom:20px;">
                  <div class="col-md-6 form-group">
                      <input name="email" type="text" class="form-control" value = "사용기간 :  ${productBean.price}만원" disabled>
                    </div>
                  </div>
                </form>
                </div>
                </div>
                <!-- 수정하기 탭 부분 -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
					<h5 class="card-title">상품 정보 수정</h5>
             	 <div class="reply-form">
               			
               			
               	<form action="updateProduct.pd">
               		<input type = "hidden" name = "pnum" value = "${productBean.pnum}">
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
                  		<input type = "submit" class = "btn btn-warning" value = "수정" onClick = "return checkData()">
                  		<input type = "reset" class = "btn btn-primary" value = "초기화">
                  </div>
                </form>
                </div>
                </div>
                <!-- 삭제하기 탭 부분 -->
                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
				<div style = "text-align:center; margin:auto;">
					<h2 style = "margin-top:40px;">삭제하시면 앞으로 구매 불가능합니다.<br>삭제 하시겠습니까?</h2>
					<input style = "margin-top:60px;" type = "button" class ="btn btn-danger" value = "상품 삭제" onclick = "location.href='deleteProduct.pd?pnum=${productBean.pnum}'">
				</div>
                </div>
              </div><!-- End Default Tabs -->
            </div>
          </div>
                </div>    
                  <div class="col-lg-1"></div>
            </div>
      
      
    </section>
</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>