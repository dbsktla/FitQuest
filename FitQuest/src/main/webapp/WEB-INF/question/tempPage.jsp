<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<body style="background-color: #FEF9E7">
	
	<div class="spinner-border text-warning" role="status" style="margin: 50% 0 0 47%;">
		<span class="visually-hidden">Loading...</span>
	</div>
	<div style="text-align: center;">Loading...</div>
	
	<input type="hidden" id="temail" value="${tquestionBean.tqemail}">
	<input type="hidden" id="aemail" value="${tquestionBean.tqanswer}">
	<input type="hidden" id="content" value="${tquestionBean.tqcontent}">
	<input type="hidden" id="subject" value="${tquestionBean.tqsubject}">
	<input type="hidden" id="name" value="${param.name}">

</body>


<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var temail = $('#temail').val();
	var aemail = $('#aemail').val();
	var content = $('#content').val();
	var subject = $('#subject').val();
	var name = $('#name').val();
	
	$.ajax({
		type : 'get',
		url : 'sendQuestEmail.qt', 
		data : {'temail' : temail, 'aemail' : aemail, 'content' : content, 'subject' : subject, 'name' : name},
		success : function (data) {
			
			if(data == 'success'){
				alert('문의 메일이 전송되었습니다.')
				window.close();
			}else{
				alert('메일 전송 실패. 잠시 후 다시 시도해주세요')
			}
		}			
	}); 
});
</script>


<%@ include file="../common/adminBootBottom.jsp" %>
