<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myTrainerTop.jsp"%>

<style>
	body{
		background-color: #FEF9E7;
		color : black;
	}
	.err{
		color : #E04848;
		font-size: 10pt;
	}
	input[type=checkbox]{
		accent-color : #FAC710;
	}
	input[type=radio]{
		accent-color : #FAC710;
	}
	section{
		padding: 0px !important;
		}
	.pageTitle{
		margin-top: 50px;
		margin-bottom: 50px;
	}
}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	var nuse = "";
	var isCheckN = false;	
	
	$('#NicknameCheck').click(function(){ 
		isCheckN = true;
		$.ajax({
			url : "nickname_check.mb", 
			data : ({ 
					nickname : $("input[name=nickname]").val()
			}),
			success : function(data){
				if($("input[name=nickname]").val() == "${memberBean.nickname}"){
					
				}else if($("input[name=nickname]").val() == ""){
					$('#NicknameMessage').html("<font color=green>입력 누락되었습니다.</font>");
					nuse = "missing";
					$('#NicknameMessage').show();
				}
				else if(data == "YES"){
					$('#NicknameMessage').html("<font color=blue>사용 가능합니다.</font>");
					nuse = "possible";
					$('#NicknameMessage').show();
				}else{ 
					$('#NicknameMessage').html("<font color=red>이미 사용중인 별명입니다.</font>");
					nuse = "impossible";
					$('#NicknameMessage').show();
				}
				
			}
		}); 
	});
	
	$('#sub').click(function(){
		if($("input[name=nickname]").val() == "${memberBean.nickname}") { //만약에 원래 있었던 별명이랑 같으면 중복 시키지 않음.
			
		} else if(nuse == "missing"){
			alert("입력 누락되었습니다.");
			$("input[name=nickname]").focus();
			return false; 
			
		} else if(nuse == "impossible"){
			alert("이미 등록된 별명입니다.");
			$("input[name=nickname]").select();
			return false;
			
		} else if(isCheckN == false){
			alert("별명 중복확인 필수입니다.");
			return false;
		}
		if($('input[name=birth]').val() == ""){
			alert("생년월일 입력하세요");
			return false;
		}
	}); 
	var pwChk = "";
	var npwChk = "";
	var regexp = new RegExp("(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}");
	
	$("input[name=nickname]").keydown(function(){ 
		$('#NicknameMessage').css('display','none');
		nuse = "";
		isCheckN = false;
	});
	$('#trSub').click(function(){
		if($('select[name=activity]').val() == ""){
			alert("운동 종류 선택하세요");
			$('select[name=activity]').focus();
			return false;
		}
		var checkboxes = document.querySelectorAll('input[type=checkbox]:checked');
		if(checkboxes.length == 0){
			alert("운동 목적 최소 하나 선택하세요");
			$('input[name=purpose]').focus();
			return false;
		}
		if($('textarea[name=intro]').val() == ""){
			alert("소개내용 입력하세요");
			$('textarea[name=intro]').focus();
			return false;
		}
		if($('textarea[name=exp]').val() == ""){
			alert("경력내용 입력하세요");
			$('textarea[name=exp]').focus();
			return false;
		}
	});
	$('#pwSub').click(function(){
		if(pwChk == 'incorrect'){
			alert("현재 비밀번호 틀렸습니다.");
			return false;
		}
		if(npwChk == 'incorrect'){
			alert("새로운 비밀번호가 일치 안합니다.");
			return false;
		}
		if($('input[name=oldpassword]').val() == ""){
			alert("현재 비밀번호 입력하세요");
			$('input[name=oldpassword]').focus();
			return false;
		}
		if($('input[name=password]').val() == ""){
			alert("현재 비밀번호 입력하세요");
			$('input[name=password]').focus();
			return false;
		}
		if($('input[name=renewpassword]').val() == ""){
			alert("현재 비밀번호 입력하세요");
			$('input[name=renewpassword]').focus();
			return false;
		}
		if(regexp.test($('input[name=password]').val()) == false){
			alert("비밀번호 형식 맞게 작성해 주세요.");
			return false;
		}
	});
	$('input[name=oldpassword]').keyup(function(){
		if($('input[name=oldpassword]').val() != '${memberBean.password}'){
			$('#oldPwmessage').html("<font color=red>비밀번호 틀렸습니다.</font>");
			pwChk = "incorrect";
			$('#oldPwmessage').show();
		} else {
			$('#oldPwmessage').html("<font color=green>비밀번호 일치합니다.</font>");
			pwChk = "correct";
			$('#oldPwmessage').show();
		}
	});
	$('input[name=password]').keyup(function(){
		if($('input[name=password]').val() != $('input[name=renewpassword]').val()){
			$('#newPwmessage').html("<font color=red>새로운 비밀번호 일치 안합니다.</font>");
			npwChk = "incorrect";
			$('#newPwmessage').show();
		} else {
			$('#newPwmessage').html("<font color=green>새로운 비밀번호 일치합니다.</font>");
			npwChk = "correct";
			$('#newPwmessage').show();
		}
	});
	$('input[name=renewpassword]').keyup(function(){
		if($('input[name=password]').val() != $('input[name=renewpassword]').val()){
			$('#newPwmessage').html("<font color=red>새로운 비밀번호 일치 안합니다.</font>");
			npwChk = "incorrect";
			$('#newPwmessage').show();
		} else {
			$('#newPwmessage').html("<font color=green>새로운 비밀번호 일치합니다.</font>");
			npwChk = "correct";
			$('#newPwmessage').show();
		}
	});
});
</script>
    <section class="section">
	 <section class="section profile">
	 <div class="pagetitle">
      <h1>마이 페이지</h1>
    </div><!-- End Page Title -->
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
          <form action = "trainerUpdateImage.mb" method = "post" enctype="multipart/form-data">
            <div class="card-body pt-4 d-flex flex-column align-items-center">
              <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainerBean.timage}" class="rounded-circle" style = "width = 180px !important; height:220px; margin-bottom: 25px;">
              <h2>${memberBean.name }</h2>
              <h3>${trainerBean.activity} 트레이너</h3>
              <h3>운동 목적: ${trainerBean.purpose}</h3>
              <input type = "hidden" name = "id" value = "${trainerBean.id }">
              <p style = "display:flex;"><input class="form-control" type="file" name="upload" id="upload" value = "사진 올리기"/>
			  <input type = "submit" value = "사진 수정" class = "btn btn-warning">
              <input name = "oldtimage" value = "${trainerBean.timage }" type = "hidden"></p>
            </div>
            </form>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">프로필 보기</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">개인 정보 수정</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings">트레이너 정보 수정</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">비밀번호 수정</button>
                </li>

              </ul>
              
             <!--  정보 보기 탭 -->
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                  <h5 class="card-title">자기소개</h5>
                  <p class="small fst-italic">${trainerBean.intro }</p>

                  <h5 class="card-title">프로필 정보</h5>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">아이디</div>
                    <div class="col-lg-9 col-md-8">${memberBean.id}</div>
                  </div>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">이름 / 별명</div>
                    <div class="col-lg-9 col-md-8">${memberBean.name } / ${memberBean.nickname }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">경력</div>
                    <div class="col-lg-9 col-md-8">${trainerBean.exp}</div>
                  </div>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">생년월일</div>
                    <div class="col-lg-9 col-md-8">${memberBean.birth }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">개인 이메일</div>
                    <div class="col-lg-9 col-md-8">${memberBean.email }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">개인 주소</div>
                    <div class="col-lg-9 col-md-8">${memberBean.maddr1 }, ${memberBean.maddr2 }</div>
                  </div>
                  
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">개인 전화번호</div>
                    <div class="col-lg-9 col-md-8">${memberBean.mphone}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">헬스장</div>
                    <div class="col-lg-9 col-md-8">${gymBean.gname }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">헬스장 주소</div>
                    <div class="col-lg-9 col-md-8">${gymBean.gaddr1 }, ${gymBean.gaddr2 }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">헬스장 전화번호</div>
                    <div class="col-lg-9 col-md-8">${gymBean.gphone}</div>
                  </div>
                </div>
				
				<!-- 트레이너 정보 수정 form -->
                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
					
                  <form:form commandName="memberBean" action="trainerMemberUpdate.mb" method="post" class="row g-3 needs-validation" novalidate="novalidate">
                  	<input type="hidden" name="id" value="${memberBean.id }">
                  	<input type="hidden" name="mtype" value="trainer">
                    
                     <div class="col-12">
                      <label for="yourUsername" class="form-label">이름</label>
                      <div class="input-group has-validation">
                        <input type="text" name="name" class="form-control" id="yourUsername" value="${memberBean.name}" required>
                        <div class="invalid-feedback">이름을 입력해 주세요.</div>
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourNickName" class="form-label">별명</label>
                      <button type="button" id="NicknameCheck" class="btn btn-outline-warning btn-sm">중복확인</button>
                      <input type="text" name="nickname" class="form-control" id="yourNickName" value="${ memberBean.nickname }" required>
                      <div id="NicknameMessage"></div>
                      <div class="invalid-feedback">별명을 입력해 주세요.</div>
                    </div>

                    <div class="col-12">
                      <label for="email" class="form-label">이메일</label>
                      <input type="email" name="email" class="form-control" id="email" value="${ memberBean.email }" placeholder="ex) fitness@fitquest.com" required>
                      <div class="invalid-feedback">이메일 형식에 맞게 작성해 주세요.</div>
                       <div id="mailMessage"></div>
                    </div>
                    
                    <div class="col-12">
                      <label for="yourBirth" class="form-label">생년월일 ${date}</label>
                      <input type="date" name="birth" class="form-control" id="yourBirth" value="${memberBean.birth}">
                    </div>
                    
                     <div class="col-12">
                      <label for="gender" class="form-label">성별</label> <br>
                     <label for="남자"><input type="radio" name="gender" id="남자" value="남자" <c:if test="${ memberBean.gender eq '남자' }">checked</c:if>> 남자</label> &nbsp;
                     <label for="여자"><input type="radio" name="gender" id="여자" value="여자" <c:if test="${ memberBean.gender eq '여자' }">checked</c:if>> 여자</label><br>
                    <form:errors cssClass="err" path="gender" />
                    </div>
                   
                   <div class="col-12">
                      <label for="yourPhone" class="form-label">전화번호</label>
                      <input type="text" name="mphone" class="form-control" id="yourPhone" value="${ memberBean.mphone }" placeholder="숫자만 입력">
                      <form:errors cssClass="err" path="mphone"/>
                    </div>
                    <div class="col-12">
                    	 <label for="yourAddr" class="form-label">주소</label>
						<input type="button" id="yourAddr" class="btn btn-outline-warning btn-sm" onclick="sample4_execDaumPostcode()" value="주소 찾기"><br>
						<input type="text" name="maddr1" class="form-control" id="sample4_jibunAddress" value="${ memberBean.maddr1 }" placeholder="지번주소">
						<input type="text" name="maddr2" class="form-control" id="sample4_detailAddress" value="${ memberBean.maddr2 }" placeholder="상세주소">
	                    <input type="hidden" id="sample4_postcode" placeholder="우편번호">
						<input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
						<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
						<span id="guide" style="color:#999;display:none"></span>
					</div>
					<div class = "col-12">
						<input type = "submit" class = "btn btn-warning" id = "sub" value = "수정">
						<input type = "reset" class = "btn btn-primary" value = "초기화">
					</div>
                  </form:form>
                </div>


				<!-- 회원 정보 수정 form -->
                <div class="tab-pane fade pt-3" id="profile-settings">

                  <!-- Settings Form -->
                  <form action="trainerInfoUpdate.mb" method="post" class="row g-3 needs-validation" novalidate="novalidate">
						<input type = "hidden" name = "id" value = "${trainerBean.id }"/>
						<div class="col-12">
                      <label for="activity" class="form-label">운동 종류</label>
                      <select class="form-select" name="activity" id="activity">
                      	<option value="">선택</option>
	                    <c:forEach var="act" items="PT,필라테스,요가">
	                    	<option value="${ act }" <c:if test="${ trainerBean.activity eq act }">selected</c:if>>${ act }</option>  
	                    </c:forEach>
                      </select>
                    </div>
                    
                    <div class="col-12">
                      <label for="purpose" class="form-label">운동 목적</label> <br>
                      <c:forEach var="pur" items="체지방 감소,근육량 증가,재활,체력 강화">
                      	<label for="${ pur }">
                      	<input type="checkbox" name="purpose" id="${pur}" value="${pur}" <c:if test="${ trainerBean.purpose.contains(pur) }">checked</c:if>>
                      	${ pur } 
                      </label>
                      </c:forEach>
                    </div>
                    
                    <div class="col-12">
                      <label for="intro" class="form-label">소개</label>
                      <textarea id="intro" name="intro" class="form-control" style="height: 100px">${ trainerBean.intro }</textarea>
                    </div>
                    
                    <div class="col-12">
                      <label for="exp" class="form-label">경력</label>
                      <textarea id="exp" name="exp" class="form-control" style="height: 100px">${ trainerBean.exp }</textarea>
                    </div>
                    
                    <div class = "col-12">
						<input type = "submit" class = "btn btn-warning" id = "trSub" value = "수정">
						<input type = "reset" class = "btn btn-primary" value = "초기화">
					</div>
					</form>
                </div>
				
				<!-- 비밀번호 수정 form -->
                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form action = "memberChangePassword.mb">
                    <div class="row mb-3">
                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">현재 비밀번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="oldpassword" type="password" class="form-control" id="currentPassword">
                      </div>
                      <span id = "oldPwmessage"></span>
                    </div>

                    <div class="row mb-3">
                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">새 비밀번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="password" placeholder = "대소문자 특수문자 포함 8~16자" type="password" class="form-control" id="newPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">새 비밀번호 재입력</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                      </div>
                      <span id = "newPwmessage"></span>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary" id = "pwSub">수정</button>
                    </div>
                  </form><!-- End Change Password Form -->

                </div>
              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>
      
    </section>
    
<%@ include file="myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>