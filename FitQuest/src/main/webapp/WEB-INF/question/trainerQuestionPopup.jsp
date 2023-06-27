<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<style>
	.errmsg{
		color: red;
		font-size: 14px;
	}
</style>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script>
	function datacheck() {
		$('.errmsg').empty();
		var check = false;
		
		if($('#tqsubject').val() == ''){
			$('#serr').append('필수입력');
			check = true;
		}
		
		if($('#tqcontent').val() == ''){
			$('#cerr').append('필수입력');
			check = true;
		}
		if($('#tqanswer').val() == ''){
			$('#aerr').append('필수입력');
			check = true;
		}
		
		if(check){
			return false;
		}
	}
</script>
<body style="background-color: #FEF9E7">

	<form action="tquestionInsert.qt" method="post">
		<div class="col-10" style="margin: auto;margin-top: 5%; ">
			
			<input type="hidden" name="id" value="${ memberBean.id }">
			<input type="hidden" name="name" value="${ memberBean.name }">
			
			<div style="padding: 15 15 15 0"><font color="gray">*문의는 이메일로 전송됩니다.</font></div>
			
			<label for="tqemail">트레이너 이메일</label> 
			<div  style="margin-bottom: 5%;">
				<input type="text" name="tqemail" id="tqemail" value="${tmember.email}" class="form-control" readonly style="width: 100%;">
			</div>
			
			<label for="tqsubject">문의 제목</label> 
			<div style="margin-bottom: 5%;">
				<input type="text" name="tqsubject" id="tqsubject" class="form-control" style="width: 100%;">
				<span class="errmsg" id="serr"></span>
			</div>
			
			<label>문의 내용</label> 
			<div style="margin-bottom: 5%;">
				<textarea rows="5" cols="50" name="tqcontent" class="form-control" id="tqcontent"></textarea>
				<div class="errmsg " id="cerr"></div>
			</div>
			
			<label for="tqanswer">답변받을 연락처</label> 
			<div style="margin-bottom: 5%;">
				<input type="text" name="tqanswer" id="tqanswer" value="${memberBean.email}" class="form-control" style="width:100%;">
				<div class="errmsg " id="aerr"></div>
			</div>
			
			<div class="text-center">
				<button type="submit" onclick="return datacheck()" class="btn btn-warning btn-sm">문의하기</button>
			</div>
		</div>
	</form>
</body>
<%@ include file="../common/adminBootBottom.jsp" %>