<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/top.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

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
	                   
	                  /*  alert(res.id);
	                   alert(res.kakao_account.name);
	                   alert(res.kakao_account.profile.nickname);
	                   alert(res.kakao_account.email);
	                   alert(res.kakao_account.gender);
	                   alert(res.kakao_account.phone_number);
	                   alert(res.kakao_account.birthday);
	                   alert(res.kakao_account.birthyear); 
	                  */
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
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">로그인</h5>
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
					
                    <div class="card-body" id="naver_id_login" style="text-align: center;">
                 	<!-- <div style="height: 50px;" ></div>
					  //네이버 로그인 버튼 노출 영역
					  <script type="text/javascript">
					  	var naver_id_login = new naver_id_login("5LAnxikAbCZNCyaKwbUp", "http://localhost:9001/ELTRUT/naverLogin");
					  	var state = naver_id_login.getUniqState();
					  	naver_id_login.setButton("green",1);
					  	naver_id_login.setState(state);	
					  	naver_id_login.setPopup();
					  	naver_id_login.init_naver_id_login();
					   </script> -->
					   <a href="javascript:kakaoLogin();"><img class="w-100" height="50" src="<%= request.getContextPath() %>/resources/Image/LoginImage/kakao_login_medium_wide.png" alt="카카오계정 로그인" /></a>
		
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">계정이 없으시다면? <br>
                      	<a href="insert.mb">일반 회원가입</a>/
                      	<a href="insertT.mb">트레이너 회원가입</a>
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