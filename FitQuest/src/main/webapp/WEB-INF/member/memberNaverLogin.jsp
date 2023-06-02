<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("KBhXUzgWQu6NpbT90un8", "http://localhost:8080/ex/");
  // 접근 토큰 값 출력
  alert("token : " + naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	var check = confirm('네이버 로그인(회원가입)은 일반 회원만 가능합니다.\n(트레이너 회원가입은 트레이너 회원가입 창을 이용해 주세요.)');
	if(check){
		alert("id : " + naver_id_login.getProfileData('id'));
	    alert("이름 : " + naver_id_login.getProfileData('name'));
	    alert("이메일 : " + naver_id_login.getProfileData('email'));
	    alert("별명 : " + naver_id_login.getProfileData('nickname'));
	    alert("성별 : " + naver_id_login.getProfileData('gender'));
	    alert("생일 : " + naver_id_login.getProfileData('birthday'));
	    alert("출생년도 : " + naver_id_login.getProfileData('birthYear'));
	    alert("mobile : " + naver_id_login.getProfileData('mobile')); 
	    //window.opener.location.href = "kakaoLogin.mb?id=' + id + '&email='+email + "&name=" + name + "&gender=" + gender + "&birthday=" + birthday + "&birthyear=" + birthyear + "&nickname=" + nickname + "&mphone=" + mphone;";
	    window.close();
	}
	else{
		check = confirm('트레이너 회원가입 하시겠습니까?');
		if(check){
			//window.opener.location.href = 'trainerInsert.mb'; 
			window.close();
		}
		else{
			window.close();
		}
	}
  }
</script>
 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "KBhXUzgWQu6NpbT90un8",
		callbackUrl : "http://localhost:8080/ex/", 
		isPopup : false,
		callBackHandle : true
	});
	
	naverLogin.init();
	
	window.addEventListener('load',function(){
		naverLogin.getLoginStatus(function(status) {
			var check = confirm('네이버 로그인(회원가입)은 일반 회원만 가능합니다.\n(트레이너 회원가입은 트레이너 회원가입 창을 이용해 주세요.)');
			
			if(status){
				if(check){
					   var id = naverLogin.user.id;
	                   var name = naverLogin.user.name;
	                   var nickname = naverLogin.user.nickname;
	                   var email = naverLogin.user.email;
	                   var gender = naverLogin.user.gender;
	                   var mphone = naverLogin.user.mobile;
	                   var birthday = naverLogin.user.birthday;
	                   var birthyear = naverLogin.user.birthyear;
	                   
				    window.opener.location.href = 'naverLogin.mb?id=' + id + '&email='+email + "&name=" + name + "&gender=" + gender + "&birthday=" + birthday + "&birthyear=" + birthyear + "&nickname=" + nickname + "&mphone=" + mphone;
				    window.close();
				}
				else{
					check = confirm('트레이너 회원가입 하시겠습니까?');
					if(check){
						window.opener.location.href = 'trainerInsert.mb'; 
						window.close();
					}
					else{
						window.close();
					}
				}
			}
		})
	});
</script>