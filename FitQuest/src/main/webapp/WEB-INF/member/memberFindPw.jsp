<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>
<style>
	.card-title{
		border: none !important;
	}
</style>
<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	var euse = "missing";
	$('#emailCheck').click(function() {
		const email = $('#email').val(); 
		if(email == ''){
			alert('이메일을 입력해 주세요.');
			return;
		}
		console.log('완성된 이메일 : ' + email); 
		const checkInput = $('#emailCode') 
		
		$.ajax({
			type : 'get',
			url : 'email_check.mb?email='+email, 
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code = data;
				alert('인증번호가 전송되었습니다.')
			}			
		}); 
	}); 
	
	$('#emailCode').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mailMessage');
		
		if(inputCode === code){
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$('#emailCheck').attr('disabled',true);
			$('#email').attr('readonly',true);
			euse = "possible";
		}else{
			$resultMsg.html('인증번호가 불일치 합니다.');
			$resultMsg.css('color','red');
			euse = "impossible";
		}
	});
	
	$('#sub').click(function(){
		if(euse == "missing"){
			alert("이메일 인증 필수입니다.");
			$("#emailMessage").focus();
			return false; 
			
		} else if(euse == "impossible"){
			alert("인증번호를 다시 확인해주세요.");
			$("#emailMessage").select();
			return false;
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
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">비밀번호 찾기</h5>
                  </div>

                  <form action="memberFindPw.mb" method="post" class="row g-3">

                    <div class="col-12">
                      <label for="id" class="form-label">아이디</label>
                      <div class="input-group">
                        <input type="text" name="id" class="form-control" id="id" required>
                        <div class="invalid-feedback">아이디를 입력하세요.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="email" class="form-label">이메일</label>
                      <button type="button" id="emailCheck" class="btn btn-warning btn-sm">인증하기</button>
                      <input type="email" name="email" class="form-control" id="email" required>
                      <input class="form-control" id="emailCode" placeholder="인증번호 6자리" disabled="disabled" maxlength="6">
                      <div class="invalid-feedback">이메일 형식에 맞게 작성해 주세요.</div>
                       <div id="mailMessage"></div>
                    </div>
					
					<div class="col-12">
                      <button id="sub" type="submit" class="btn btn-warning w-100">비밀번호 찾기</button>
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
