<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/top.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

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
	var use,nuse;
	var isCheck = false, isCheckN = false;	
	
	$('#idCheck').click(function(){
		isCheck = true;
		$.ajax({
			url : "id_check.mb", 
			data : ({ 
					id : $("input[name=id]").val()
			}),
			success : function(data){
				if($("input[name=id]").val() == ""){
					$('#idmessage').html("<font color=green>입력 누락되었습니다.</font>");
					use = "missing";
					$('#idmessage').show();
				}
				else if(data == "YES"){
					$('#idmessage').html("<font color=blue>등록 가능합니다.</font>");
					use = "possible";
					$('#idmessage').show();
				}else{ 
					$('#idmessage').html("<font color=red>이미 등록된 아이디입니다.</font>");
					use = "impossible";
					$('#idmessage').show();
				}
				
			}
		}); 
	});
	
	$('#NicknameCheck').click(function(){ 
		isCheckN = true;
		$.ajax({
			url : "nickname_check.mb", 
			data : ({ 
					nickname : $("input[name=nickname]").val()
			}),
			success : function(data){
				if($("input[name=nickname]").val() == ""){
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
		if(use == "missing"){
			alert("입력 누락되었습니다.");
			$("input[name=id]").focus();
			return false; 
			
		} else if(use == "impossible"){
			alert("이미 등록된 아이디입니다.");
			$("input[name=id]").select();
			return false;
			
		} else if(isCheck == false){
			alert("아이디 중복확인 필수입니다.");
			return false;
		}
		
		if(nuse == "missing"){
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
	}); 
	
	$("input[name=id]").keydown(function(){ 
		$('#idmessage').css('display','none');
		use = "";
		isCheck = false;
	});
	
	$("input[name=nickname]").keydown(function(){ 
		$('#NicknameMessage').css('display','none');
		nuse = "";
		isCheckN = false;
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

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">회원 가입(트레이너)</h5>
                  </div>
                  
                  <form:form commandName="trainerBean" action="insertT.mb" method="post" enctype="multipart/form-data" class="row g-3 needs-validation" novalidate="novalidate">
                  	<input type="hidden" name="mtype" value="trainer">
                    <div class="col-12">
                      <label for="yourName" class="form-label">아이디</label>
                      <button type="button" id="idCheck" class="btn btn-outline-warning btn-sm">중복확인</button>
                      <input type="text" name="id" class="form-control" id="yourName" value="${ trainerBean.id }" required>
                      <div id="idmessage"></div>
                      <div class="invalid-feedback">아이디를 입력해 주세요.</div>
                    </div>
                    
                     <div class="col-12">
                      <label for="yourUsername" class="form-label">이름</label>
                      <div class="input-group has-validation">
                        <input type="text" name="name" class="form-control" id="yourUsername" value="${ trainerBean.name }" required>
                        <div class="invalid-feedback">이름을 입력해 주세요.</div>
                      </div>
                    </div>
                    
                    <div class="col-12">
                      <label for="yourPassword" class="form-label">비밀번호</label>
                      <input type="password" name="password" class="form-control" id="yourPassword" value="${ trainerBean.password }" placeholder="대소문자 특수문자 포함 8~16자" required>
                      <div class="invalid-feedback">비밀번호를 입력해 주세요.</div>
                      <form:errors cssClass="err" path="password" />
                    </div>

                    <div class="col-12">
                      <label for="yourNickName" class="form-label">별명</label>
                      <button type="button" id="NicknameCheck" class="btn btn-outline-warning btn-sm">중복확인</button>
                      <input type="text" name="nickname" class="form-control" id="yourNickName" value="${ trainerBean.nickname }" required>
                      <div id="NicknameMessage"></div>
                      <div class="invalid-feedback">별명을 입력해 주세요.</div>
                    </div>

                    <div class="col-12">
                      <label for="yourEmail" class="form-label">이메일</label>
                      <input type="email" name="email" class="form-control" id="yourEmail" value="${ trainerBean.email }" placeholder="ex) fitness@fitquest.com" required>
                      <div class="invalid-feedback">이메일 형식에 맞게 작성해 주세요.</div>
                    </div>
                    
                    <div class="col-12">
                      <label for="yourBirth" class="form-label">생년월일</label>
                      <input type="date" name="birth" class="form-control" id="yourBirth" value="${ trainerBean.birth }">
                    </div>
                    
                    <div class="col-12">
                      <label for="gender" class="form-label">성별</label> <br>
                     <label for="남자"><input type="radio" name="gender" id="남자" value="남자"> 남자</label>
                     <label for="여자"><input type="radio" name="gender" id="여자" value="여자"> 여자</label><br>
                    <form:errors cssClass="err" path="gender" />
                    </div>
                   
                   <div class="col-12">
                      <label for="yourPhone" class="form-label">전화번호</label>
                      <input type="text" name="mphone" class="form-control" id="yourPhone" value="${ trainerBean.mphone }" placeholder="숫자만 입력">
                      <form:errors cssClass="err" path="mphone"/>
                    </div>
                    
                    <div class="col-12">
                    	 <label for="yourAddr" class="form-label">주소</label>
						<input type="button" id="yourAddr" class="btn btn-outline-warning btn-sm" onclick="sample4_execDaumPostcode()" value="주소 찾기"><br>
						<input type="text" name="maddr1" class="form-control" id="sample4_jibunAddress" value="${ trainerBean.maddr1 }" placeholder="지번주소">
						<input type="text" name="maddr2" class="form-control" id="sample4_detailAddress" value="${ trainerBean.maddr2 }" placeholder="상세주소">
						
	                    <input type="hidden" id="sample4_postcode" placeholder="우편번호">
						<input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
						<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
						<span id="guide" style="color:#999;display:none"></span>
					</div>
					
                    <div class="col-12">
                      <label for="yourGym" class="form-label">헬스장</label>
                       <button type="button" class="btn btn-warning btn-sm" onclick="location.href='insertG.mb'">등록하기</button>
                      <select class="form-select" name="gnum" id="yourGym">
                      	<option value="0">선택</option>
	                    <c:forEach var="gymBean" items="${ glist }">
	                    	<option value="${ gymBean.gnum }" <c:if test="${ trainerBean.gnum eq gymBean.gnum }">selected</c:if>>${ gymBean.gname }</option>  
	                    </c:forEach>
                      </select>
                      <form:errors cssClass="err" path="gnum"/>
                    </div>
                    
                    <div class="col-12">
                      <label for="activity" class="form-label">운동 종류</label>
                      <select class="form-select" name="activity" id="activity">
                      	<option value="">선택</option>
	                    <c:forEach var="act" items="PT,필라테스,요가">
	                    	<option value="${ act }" <c:if test="${ act eq trainerBean.activity }">selected</c:if>>${ act }</option>  
	                    </c:forEach>
                      </select>
                      <form:errors cssClass="err" path="activity"/>
                    </div>
                    
                    <div class="col-12">
                      <label for="purpose" class="form-label">운동 목적</label> <br>
                      <c:forEach var="pur" items="체지방 감소,근육량 증가,재활,체력 강화">
                      	<label for="${ pur }">
                      	<input type="checkbox" name="purpose" id="${ pur }" value="${ pur }">
                      	${ pur } 
                      </label>
                      </c:forEach>
                      <form:errors cssClass="err" path="purpose"/>
                    </div>
                    
                    <div class="col-12">
                      <label for="intro" class="form-label">소개</label>
                      <textarea id="intro" name="intro" class="form-control" style="height: 100px">${ trainerBean.intro }</textarea>
                      <form:errors cssClass="err" path="intro"/>
                    </div>
                    
                    <div class="col-12">
                      <label for="exp" class="form-label">경력</label>
                      <textarea id="exp" name="exp" class="form-control" style="height: 100px">${ trainerBean.exp }</textarea>
                      <form:errors cssClass="err" path="exp"/>
                    </div>
                    
                     <div class="col-12">
                      <label for="upload" class="form-label">사진</label>
                      <input type="file" name="upload" class="form-control" id="upload" value="${ trainerBean.upload }">
                    </div>
                    
                    <div class="col-12">
                    	<button type="submit" id="sub" class="btn btn-warning w-100">회원 가입</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">계정이 있다면? <a href="login.mb">로그인</a></p>
                    </div>
                  </form:form> 

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