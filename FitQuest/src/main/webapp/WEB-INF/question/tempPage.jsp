<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
tempPage

<input type="hidden" id="temail" value="${tquestionBean.tqemail}">
<input type="hidden" id="aemail" value="${tquestionBean.tqanswer}">
<input type="hidden" id="content" value="${tquestionBean.tqcontent}">
<input type="hidden" id="subject" value="${tquestionBean.tqsubject}">


<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var temail = $('#temail').val();
	var aemail = $('#aemail').val();
	var content = $('#content').val();
	var subject = $('#subject').val();
	
	$.ajax({
		type : 'get',
		url : 'sendQuestEmail.qt', 
		data : {'temail' : temail, 'aemail' : aemail, 'content' : content, 'subject' : subject},
		success : function () {
			
			alert('문의 메일이 전송되었습니다.')
		}			
	}); 
});
</script>