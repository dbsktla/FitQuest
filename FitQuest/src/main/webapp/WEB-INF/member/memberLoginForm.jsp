<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/top.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>
<style>
	.form-label{
		font-weight: bold !important;
	}
</style>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        window.Kakao.init("3d70a452c3329afb28a7dfefc1825a3c");

        function kakaoLogin() {
        	var check = confirm('카카오 로그인(회원가입)은 일반 회원만 가능합니다.\n(트레이너 회원가입은 트레이너 회원가입 창을 이용해 주세요.)');
        	//alert(check);
        	if(check){
	             window.Kakao.Auth.login({
	                scope: 'name,profile_nickname,account_email,gender,birthday,birthyear,phone_number,shipping_address', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
	                success: function(response) {
	                    console.log(response) // 로그인 성공하면 받아오는 데이터
	                    window.Kakao.API.request({ // 사용자 정보 가져오기 
	                        url: '/v2/user/me',
	                        success: (res) => {
	                            const kakao_account = res.kakao_account;
	                            console.log(kakao_account)
	                            
	                   var id = res.id;
	                   var name = res.kakao_account.name;
	                   var nickname = res.kakao_account.profile.nickname;
	                   var email = res.kakao_account.email;
	                   var gender = res.kakao_account.gender;
	                   var mphone = res.kakao_account.phone_number;
	                   var birthday = res.kakao_account.birthday;
	                   var birthyear = res.kakao_account.birthyear;
	                   
	                  window.location.href='kakaoLogin.mb?id=' + id + '&email='+email + "&name=" + name + "&gender=" + gender + "&birthday=" + birthday + "&birthyear=" + birthyear + "&nickname=" + nickname + "&mphone=" + mphone; //리다이렉트 되는 코드
	                        }
	                    });
	                },
	                fail: function(error) {
	                    console.log(error);
	                }
	            }); 
        	}//if
        	else{
        		check = confirm('트레이너 회원가입 하시겠습니까?');
        		if(check){
        		 	window.location.href = 'trainerInsert.mb'; 
        		}
        	}
        }
function findId(){
	var openWin = window.open("memberFindId.mb", "_blank", "width=500, height=500, left=300");
}        
function findPw(){
	var openWin = window.open("memberFindPw.mb", "_blank", "width=500, height=500, left=300");
}        
</script>



<body style="background-color : #FEF9E7;">
<main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
         <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
              <div class="card mb-3">
                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D; border: none;">로그인</h5>
                  </div>

                  <form action="login.mb" method="post" class="row g-3 needs-validation" novalidate>

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">아이디</label>
                      <div class="input-group has-validation">
                        <input type="text" name="id" class="form-control" id="yourUsername" required>
                        <div class="invalid-feedback">아이디를 입력하세요.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">비밀번호</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" required>
                      <div class="invalid-feedback">비밀번호를 입력하세요.</div>
                    </div>
					
					<div class="col-12">
                      <button type="submit" class="btn btn-warning w-100">Login</button>
                    </div>
                    
					<div class="col-12" style="text-align: center;">
						<a style="color:gray;" href="javascript:findId()">아이디 찾기</a> <font color="gray">|</font>
                      	<a style="color:gray;" href="javascript:findPw()">비밀번호 찾기</a>
					</div>
					
                    <div class="card-body" id="naverIdLogin" style="text-align: center;">
                 	<div style="height: 50px;" ></div>
					<script type="text/javascript">
						var naverLogin = new naver.LoginWithNaverId({
							clientId : "KBhXUzgWQu6NpbT90un8",
							callbackUrl : "http://localhost:8080/ex/naverLoginPopup.mb", 
							isPopup : true,
							loginButton : {color : "green" , type : 1, height: 42}
						});
						
						naverLogin.init();
					</script>   
					   	&nbsp;
					   <a href="javascript:kakaoLogin();"><img height="42" src="<%= request.getContextPath() %>/resources/Image/LoginImage/kakaoLogin.png" alt="카카오계정 로그인" /></a>
		
                    </div>
                    <div class="col-12" style="text-align: center;">
                      <p class="small mb-0">계정이 없으시다면? <br>
                      	<a style="color:gray;" href="memberInsert.mb">일반 회원가입</a> <font color="gray">|</font>
                      	<a style="color:gray;" href="trainerInsert.mb">트레이너 회원가입</a>
                      </p>
                    </div>
                  </form>
                  
                </div>
              </div>

              <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
              </div>

            </div>
          </div>
		</div>
      </section>

    </div>
  </main>
</body>
<%@ include file="../common/bottom.jsp" %>
<%@ include file="../common/adminBootBottom.jsp" %>  