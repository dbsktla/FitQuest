<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<style>
	.err{
		color : #E04848;
		font-size: 10pt;
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
	var use;
	var isCheck = false;
	
	$('#GnameCheck').click(function(){
		isCheck = true;
		$.ajax({
			url : "gname_check.mb", 
			data : ({ 
					gname : $("input[name=gname]").val()
			}),
			success : function(data){
				if($("input[name=gname]").val() == ""){
					$('#gnamemessage').html("<font color=green>입력 누락되었습니다.</font>");
					use = "missing";
					$('#gnamemessage').show();
				}
				else if(data == "YES"){
					$('#gnamemessage').html("<font color=blue>등록 가능합니다.</font>");
					use = "possible";
					$('#gnamemessage').show();
				}else{ 
					$('#gnamemessage').html("<font color=red>이미 등록된 헬스장입니다.</font>");
					use = "impossible";
					$('#gnamemessage').show();
				}
				
			}
		}); 
	});
	
	$('#sub').click(function(){
		if(use == "missing"){
			alert("입력 누락되었습니다.");
			$("input[name=gname]").focus();
			return false; 
			
		} else if(use == "impossible"){
			alert("이미 등록된 헬스장입니다.");
			$("input[name=gname]").select();
			return false;
			
		} else if(isCheck == false){
			alert("헬스장 중복확인 필수입니다.");
			return false;
		}
		/* if(isNaN($("input[name=gphone]").val())){
			alert('전화번호는 숫자로 입력하세요.');
			return false;
		}
		if($("input[name=gaddr1]").val() == ''){
			alert('주소는 필수 항목입니다.');
			return false;
		}
		if($("input[name=gaddr2]").val() == ''){
			alert('주소는 필수 항목입니다.');
			return false;
		} */
	}); 
	
	$("input[name=gname]").keydown(function(){ 
		$('#gnamemessage').css('display','none');
		use = "";
		isCheck = false;
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
                    <h5 class="card-title text-center pb-0 fs-4" style="color : #5D5D5D;">헬스장 등록</h5>
                  </div>
                  
                  <form:form commandName="gymBean" action="gymInsert.mb" method="post" class="row g-3 needs-validation" novalidate="novalidate">
                    <div class="col-12">
                      <label for="yourName" class="form-label">헬스장 이름</label>
                      <button type="button" id="GnameCheck" class="btn btn-warning btn-sm">중복확인</button>
                      <input type="text" name="gname" class="form-control" id="yourName" value="${ gymBean.gname }" required>
                      <div id="gnamemessage"></div>
                      <div class="invalid-feedback">헬스장을 입력해 주세요.</div>
                    </div>
                    
                   <div class="col-12">
                      <label for="yourPhone" class="form-label">전화번호</label>
                      <input type="text" name="gphone" class="form-control" id="yourPhone" value="${ gymBean.gphone }" placeholder="숫자만 입력">
                      <form:errors cssClass="err" path="gphone"/>
                    </div>
                    
                    <div class="col-12">
                    	 <label for="yourAddr" class="form-label">주소</label>
						<input type="button" id="yourAddr" class="btn btn-light rounded-pill btn-sm" onclick="sample4_execDaumPostcode()" value="주소 찾기"><br>
						<input type="text" name="gaddr1" class="form-control" id="sample4_jibunAddress" value="${ gymBean.gaddr1 }" placeholder="지번주소">
						 <form:errors cssClass="err" path="gaddr1"/>
						<input type="text" name="gaddr2" class="form-control" id="sample4_detailAddress" value="${ gymBean.gaddr2 }" placeholder="상세주소">
						 <form:errors cssClass="err" path="gaddr2"/>
						
	                    <input type="hidden" id="sample4_postcode" placeholder="우편번호">
						<input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
						<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
						<span id="guide" style="color:#999;display:none"></span>
					</div>
                    
                    
                    <div class="col-12">
                    	<button type="submit" id="sub" class="btn btn-warning w-100">헬스장 등록</button>
                    </div>
                  </form:form>

                </div>
              </div>


            </div>
          </div>
        </div>

      </section>

    </div>
  </main>
</body>
