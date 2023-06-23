<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myMemberTop.jsp"%>
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
	.btn-buy:hover {
		background-color:#FAC710 !important;
		color: white !important;
	}
	.btn-check:checked{
		background-color:#FAC710 !important;
		border: #FAC710 !important;
	}
	.btn-buy {
		border-radius: 25px !important;
		color: #444444 !important;
		font-size: 15px !important;
		font-weight: 600 !important;
		padding: 8px 20px 10px 20px !important;
		border: 1px solid #FAC710 !important;
	}
	.btn-buy:hover{
		color:white;
	}
	.box {
		color: #444444;
		font-size: 15px;
		font-weight: 600;
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
<body style="background-color : #FEF9E7;">

     <!-- ======= 사용권 섹션 ======= -->
    <section id="pricing" class="pricing">

      <div class="container" data-aos="fade-up">

        <header class="section-header">
          <h2 style = "color: #012970">My 회원권</h2>
        </header>
		<c:if test = "${ not empty muList }">
        <div class="row gy-4" data-aos="fade-left" style = "padding-bottom: 50px;">
		<c:forEach var = "usage" items = "${muList }">
		<c:if test = "${usage.activity eq 'PT'}">
			<c:set var = "color" value = "#ff901c"/>
		</c:if>
		<c:if test = "${usage.activity eq '필라테스'}">
			<c:set var = "color" value = "#ff0071"/>
		</c:if>
		<c:if test = "${usage.activity eq '요가'}">
			<c:set var = "color" value = "#65c600"/>
		</c:if>
          <div class="col-lg-3 col-md-6" data-aos="zoom-in" data-aos-delay="100">
            <div class="box">
              <h3 style="color: ${color};">${usage.activity }</h3>
              <div class="price"><sup>x</sup>${usage.usage}<span>&nbsp;남은 사용횟수</span></div>
              <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${usage.timage}" class="img-fluid" alt="">
              <ul>
                <li style = "font-weight: bold;">${ usage.name } 선생님</li>
                <li>장소 : ${usage.gname }</li>
                <li>${usage.ptype} 수업  (${usage.people}명)</li>
              </ul>
              <a href="genericReservation.rv?tid=${usage.tid }&tname=${usage.name}&people=${usage.people}" class="btn-buy">예약하기</a>
            </div>
          </div>
		</c:forEach>
        </div>
	  </c:if>
	  
	  <c:if test = "${ empty muList}">
	   <div class="card" style = "height: 100%; min-height: 350px;">
            <div class="card-body">
              	 <h5 class="card-title">
              	 	현재 회원권 없습니다.
             	 </h5>
            </div>
       </div>
	  </c:if>
      </div>

    </section><!-- End 사용권 섹션 -->
	

  <section id="pricing" class="pricing"  style = "margin-top: 60px;">

      <div class="container" data-aos="fade-up">
        <header class="section-header">
          <h2 style = "color: #012970">주문 내역</h2>
        </header>
        
        <div class="card">
            <div class="card-body">
			    <c:if test = "${not empty mList }">
            	 <table class="table">
                <thead>
                  <tr>
                    <th scope="col">주문 번호</th>
                    <th scope="col">주문 날짜</th>
                    <th scope="col">상품 갯수</th>
                    <th scope="col">총 가격</th>
                    <th scope="col">자세히 보기</th>
                  </tr>
                </thead>
                <tbody>
                	<c:forEach var = "order" items = "${ mList }">
                	<tr>
                		<fmt:parseDate value = "${order.odate}" pattern = "yyyy-MM-dd" var = "date"/>
                    	<fmt:formatDate value = "${date }" var = "date" pattern = "yyyy-MM-dd"/>
	                	<td>${order.onum}</td>
	                	<td>${date}</td>
	                	<td>${order.orderCount}</td>
	                	<td>${order.totalPrice }</td>
	                	<td><a href = "orderDetail.od?onum=${order.onum }"><i class="bi bi-blockquote-left"></i>자세히 보기</a></td>
                	</tr>
                	</c:forEach>
             	</tbody>
              </table>
              </c:if>
			    <c:if test = "${empty mList}">
			  	<h5 class="card-title">
		  		아직 주문 없습니다.
			  	</h5>
              </c:if>
            </div>
	    </div>
      </div>
  </section>
 </body>
<%@ include file="../common/myMemberBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>