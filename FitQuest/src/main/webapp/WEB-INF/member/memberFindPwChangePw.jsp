<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	var npwChk = "";
	var regexp = new RegExp("(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}");
	$('#sub').click(function(){
		if(npwChk == 'incorrect'){
			alert("새로운 비밀번호가 일치 안합니다.");
			return false;
		}
		if($('input[name=password]').val() == ""){
			alert("비밀번호 입력하세요");
			$('input[name=password]').focus();
			return false;
		}
		if($('input[name=renewpassword]').val() == ""){
			alert("비밀번호 확인을 입력하세요");
			$('input[name=renewpassword]').focus();
			return false;
		}
		if(regexp.test($('input[name=password]').val()) == false){
			alert("비밀번호 형식 맞게 작성해 주세요.");
			return false;
		}
	});
	
	$('input[name=password]').keyup(function(){
		if($('input[name=password]').val() != $('input[name=renewpassword]').val()){
			$('#newPwmessage').html("<font color=red>비밀번호 일치 안합니다.</font>");
			npwChk = "incorrect";
			$('#newPwmessage').show();
		} else {
			$('#newPwmessage').html("<font color=green>비밀번호 일치합니다.</font>");
			npwChk = "correct";
			$('#newPwmessage').show();
		}
	});
	
	$('input[name=renewpassword]').keyup(function(){
		if($('input[name=password]').val() != $('input[name=renewpassword]').val()){
			$('#newPwmessage').html("<font color=red>비밀번호 일치 안합니다.</font>");
			npwChk = "incorrect";
			$('#newPwmessage').show();
		} else {
			$('#newPwmessage').html("<font color=green>비밀번호 일치합니다.</font>");
			npwChk = "correct";
			$('#newPwmessage').show();
		}
	});
});
</script>
<body style="background-color : #FEF9E7;">
<main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
         <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
              <div class="card mb-10">
               <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">비밀번호 변경</h5>
                  </div>

                  <form action="memberFindPwChangePw.mb" method="post" class="row g-3 needs-validation" novalidate="novalidate">
					<input type="hidden" name="id" value="${ param.id }">
                    <div class="col-12">
                      <label for="password" class="form-label">비밀번호</label>
                      <div class="input-group has-validation">
                        <input type="password" name="password" placeholder = "대소문자 특수문자 포함 8~16자" class="form-control" id="password" required>
                        <div class="invalid-feedback">비밀번호를 입력하세요.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="renewPassword" class="form-label">비밀번호 확인</label>
                      <input type="password" name="renewpassword" class="form-control" id="renewPassword" required>
                      <span id = "newPwmessage"></span>
                    </div>
					
					<div class="col-12">
                      <button id="sub" type="submit" class="btn btn-warning w-100">비밀번호 변경</button>
                    </div>
                    
                  </form>
                  
                </div>
              </div>


            </div>
          </div>
		</div>
      </section>

    </div>
  </main>
</body>
