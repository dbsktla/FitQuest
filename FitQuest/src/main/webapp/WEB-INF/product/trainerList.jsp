<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>
<style type = "text/css">
	.btn:hover {
		background-color:#FAC710 !important;
	}
	.btn-check:checked{
		background-color:#FAC710 !important;
		border: #FAC710 !important;
	}
	.btn {
		color: #444444 !important;
		font-size: 16px !important;
		font-weight: 600 !important;
		padding: 7px 12px !important;
	}
	.box {
		color: #444444;
		font-size: 15px;
		font-weight: 600;
	}
	.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
	.btn-check:checked + .btn-check-label :{
		background-color: #FAC710;
		color: white !important;
		outline:none;
	}
	.section{ padding: 20px 0px !important; }
	.btn-check-label, .form-check-label{
		border-radius: 25px !important;
	}
</style>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
$(function(){
    areaSelectMaker("select[name=addressRegion]");
});
var areaSelectMaker = function(target){
    if(target == null || $(target).length == 0){
        console.warn("Unknown Area Tag");
        return;
    }

    var area = {
        "수도권" :{
            "서울" : [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ],
            "경기" : [ "수원시 장안구", "수원시 권선구", "수원시 팔달구", "수원시 영통구", "성남시 수정구", "성남시 중원구", "성남시 분당구", "의정부시", "안양시 만안구", "안양시 동안구", "부천시", "광명시", "평택시", "동두천시", "안산시 상록구", "안산시 단원구", "고양시 덕양구", "고양시 일산동구",
                "고양시 일산서구", "과천시", "구리시", "남양주시", "오산시", "시흥시", "군포시", "의왕시", "하남시", "용인시 처인구", "용인시 기흥구", "용인시 수지구", "파주시", "이천시", "안성시", "김포시", "화성시", "광주시", "양주시", "포천시", "여주시", "연천군", "가평군",
                "양평군" ],
            "인천" : [ "계양구", "미추홀구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군", "옹진군" ]			
        },
        "강원권" :{
            "강원" : [ "춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군" ]			
        },
        "충청권" :{
            "충북" : [ "청주시 상당구", "청주시 서원구", "청주시 흥덕구", "청주시 청원구", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군" ],
            "충남" : [ "천안시 동남구", "천안시 서북구", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군" ],
            "대전" : [ "대덕구", "동구", "서구", "유성구", "중구" ],
            "세종특별자치시" : [ "세종특별자치시" ]			
        },
        "전라권" :{
            "전북" : [ "전주시 완산구", "전주시 덕진구", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군" ],
            "전남" : [ "목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군" ],
            "광주" : [ "광산구", "남구", "동구", "북구", "서구" ]			
        },
        "경상권" : {
            "경북" : [ "포항시 남구", "포항시 북구", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군" ],
            "경남" : [ "창원시 의창구", "창원시 성산구", "창원시 마산합포구", "창원시 마산회원구", "창원시 진해구", "진주시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "의령군", "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군" ],
            "부산" : [ "강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군" ],
            "대구" : [ "남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군" ],
            "울산" : [ "남구", "동구", "북구", "중구", "울주군" ]			
        },
        "제주권" : {
            "제주특별자치도" : [ "서귀포시", "제주시" ]			
        }
    };
	
    for(i=0; i<$(target).length; i++){
        (function(z){
            var a1 = $(target).eq(z);
            var a2 = a1.next();
            var a3 = a2.next();

            //초기화
			init(a1, true);

            //권역 기본 생성
            var areaKeys1 = Object.keys(area);
            areaKeys1.forEach(function(Region){
                a1.append("<option value="+Region+">"+Region+"</option>");
            });

            //변경 이벤트
            $(a1).change( function(){
                 init($(this), false); 
                var Region = $(this).val();
                var keys = Object.keys(area[Region]);
                keys.forEach(function(Do){
                    a2.append("<option value="+Do+">"+Do+"</option>");    
                });
            });

            $(a2).change( function(){
                 a3.empty().append("");
                 var Region = a1.val();
                var Do = $(this).val();
                var keys = Object.keys(area[Region][Do]);
                keys.forEach(function(SiGunGu){
                    a3.append("<option value="+area[Region][Do][SiGunGu]+">"+area[Region][Do][SiGunGu]+"</option>");    
                });
            });
        })(i);        

         function init(t, first){
            first ? t.empty().append("") : "";
            t.next().empty().append("");
            t.next().next().empty().append("");
        } 
    }
}
	function filter(sport){
		// Get all buttons with class="btn" inside the container
		var btns = document.getElementsByClassName("filter");
		for (var i = 0; i < btns.length; i++) {
			  btns[i].addEventListener("click", function() {
			    var current = document.getElementsByClassName("filter-active");
			    // If there's no active class
			    if (current.length > 0) {
			      current[0].className = current[0].className.replace(" filter-active", "");
			    }
			    // Add the active class to the current/clicked button
			    this.className += " filter-active";
			
			  });
			}
	    var inputCheck = document.getElementById("input");
	    var input = document.createElement("input");
		if(inputCheck != null){
			inputCheck.remove();			
		}
	    input.setAttribute("type", "hidden");
	    input.setAttribute("id", "input");
	    input.setAttribute("name", "activity");
	    input.setAttribute("value", sport);
	    //append to form element that you want .s
	    document.getElementById("myform").appendChild(input);
		//Resend request with filter ->
	}
</script>
<!-- 운동 카테고리 선택.-->
<body style="background-color : #FEF9E7;">
	<div class="title-container">
		<div class="title-text">트레이너 목록</div>
	</div>
 <section id="portfolio" class="portfolio" style = "background-color: #FEF9E7 !important; padding: 20px 0px;"> 
      <div class="container" data-aos="fade-up">
        <div class="row" data-aos="fade-up" data-aos-delay="100">
	      <form action = "trainerList.pd" id = "myform">
          <div class="col-lg-12 d-flex justify-content-center" style = "margin-bottom: 60px; align-items: center;">
            <select name="addressRegion" id="addressRegion1" class="form-select" size = "5" aria-label="multiple select example"></select>
		    <select name="addressDo" id="addressDo1" class="form-select" size = "5" aria-label="multiple select example"></select>
		    <select name="addressSiGunGu" id="addressSiGunGu1" class="form-select" size = "5" aria-label="multiple select example"></select>
          </div>
          <div class="col-lg-12 d-flex justify-content-center">
          	  <span class = "box" style = "line-height:40px; margin-right: 8px;">원하는 운동 : </span>
          	  <input type="radio" class="btn-check" value = "null" name="activity" id="option1" autocomplete="off"
          	  <c:if test = "${activity eq 'null' or activity eq null}">
          	  checked
          	  </c:if>
          	  >
			  <label class="btn btn-check-label" for="option1">전체보기</label>
          	  <input type="radio" class="btn-check" value = "PT" name="activity" id="option2" autocomplete="off"
          	  <c:if test = "${activity eq 'PT' }">
          	  checked
          	  </c:if>
          	  >
			  <label class="btn btn-check-label" for="option2">PT</label>
          	  <input type="radio" class="btn-check" value = "필라테스" name="activity" id="option3" autocomplete="off"
          	  <c:if test = "${activity eq '필라테스' }">
          	  checked
          	  </c:if>
          	  >
			  <label class="btn btn-check-label" for="option3">필라테스</label>
          	  <input type="radio" class="btn-check" value = "요가" name="activity" id="option4" autocomplete="off"
          	  <c:if test = "${activity eq '요가' }">
          	  checked
          	  </c:if>
          	  >
			  <label class="btn btn-check-label" for="option4">요가</label>
          </div>
          <div class="col-lg-12 d-flex justify-content-center">
          	  <span class = "box" style = "line-height:40px; margin-right: 8px;">원하는 효과 : </span>
	          <input class="form-check-input btn-check" type="checkbox" name = "purpose" value="체지방 감소" id="flexCheckDefault5"
	          <c:if test = "${ purpose.contains('체지방 감소') }">
          	  checked
          	  </c:if>
	          >
			  <label class="form-check-label btn" for="flexCheckDefault5">
			    체지방 감소
			  </label>
			  <span class = "box">
	          <input class="form-check-input btn-check" type="checkbox" name = "purpose" value="근육량 증가" id="flexCheckDefault6"
	          <c:if test = "${ purpose.contains('근육량 증가') }">
          	  checked
          	  </c:if>
	          >
			  <label class="form-check-label btn" for="flexCheckDefault6">
			    근육량 증가
			  </label>
			  </span>
			  <span class = "box">
	          <input class="form-check-input btn-check" type="checkbox" name = "purpose" value="재활" id="flexCheckDefault7"
	          <c:if test = "${ purpose.contains('재활') }">
          	  checked
          	  </c:if>
	          >
			  <label class="form-check-label btn" for="flexCheckDefault7">
			    재활
			  </label>
			  </span>
			  <span class = "box">
	          <input class="form-check-input btn-check" type="checkbox" name = "purpose" value="체력 강화" id="flexCheckDefault8"
	          <c:if test = "${ purpose.contains('체력 강화') }">
          	  checked
          	  </c:if>
	          >
			  <label class="form-check-label btn" for="flexCheckDefault8">
			    체력 강화
			  </label>
			  </span>
          </div>
           <div class = "col-lg-12 d-flex justify-content-space-between">
			  <span class = "box" style = "line-height:40px; margin-right: 8px;">순서 선택 : </span>
	          <input class="form-check-input btn-check" type="radio" name = "ordering" value="all" id="flexCheckDefault9"
	          <c:if test = "${ordering eq 'all' }">
	          checked
	          </c:if>
	          >
			  <label class="form-check-label btn" for="flexCheckDefault9">
			    기본순
			  </label>
	          <input class="form-check-input btn-check" type="radio" name = "ordering" value="review" id="flexCheckDefault10"
	          <c:if test = "${ordering eq 'review' }">
	          checked
	          </c:if>
	          >
			  <label class="form-check-label btn" for="flexCheckDefault10">
			    인기순
			  </label>
			 <input type = "submit" class = "btn" value = "검색하기" style = "background-color: #FAC710; margin-left: auto;">
		  </div>
          </form>
        </div>
	</div>
</section>
 <section id="team" class="team" style = "background-color: #FEF9E7 !important;">

      <div class="container" data-aos="fade-up">
        <div class="row gy-4">
		  <c:forEach var = "trainer" items = "${tList }">
          <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
                <a href = "trainerDetail.pd?id=${trainer.id }&pageNumber=${pageInfo.pageNumber}&hasReview=${trainer.hasReview}">
             	 <div class="member-img">
               	 <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainer.timage}" class="img-fluid" alt="text" width="400px"/>
            	 </div>
                </a>
              <div class="member-info">
                <h4 style = "margin-top:10px; color:black;">${trainer.name }</h4>
                <span class="magin-top-15">${trainer.activity} : ${trainer.purpose }</span>
				<span style = "color:black;">${trainer.gaddr1}</span>
               	<fmt:formatNumber var = "rating1" value="${trainer.rating }" type="number" pattern="#.##"/>
				<fmt:formatNumber var = "rating" value="${trainer.rating }" type="number" pattern="#"/>
				<c:set var = "starCount" value = "0"/>
				<div class="stars">
				<c:forEach begin = "1" end = "${rating }" step="1" var="i">
                  <i class="bi bi-star-fill" style = "color: #FAC710;"></i>
                  <c:set var = "starCount" value = "${starCount + 1 }"/>
				</c:forEach>
				<c:forEach begin = "1" end = "${5 - starCount }" step = "1" var = "j">
				<i class = "bi bi-star" style = "color: #FAC710;"></i>
				</c:forEach>
				<c:if test = "${ trainer.hasReview eq 'Y' }">
				(${rating1})<br>
				</c:if>
				<c:if test = "${ trainer.hasReview eq 'N' }">
				<br>(작성된 리뷰 없습니다)
				</c:if>
				<br>
                </div>
                <p>
                <input type = "button" value = "자세히 보기" class = "btn btn-warning" onclick= "location.href='trainerDetail.pd?id=${trainer.id }&pageNumber=${pageInfo.pageNumber}&hasReview=${trainer.hasReview}'">
                </p>
              </div>
            </div>
          </div>	
		  </c:forEach>
        </div>	
      </div>
	<div align = "center" style = "margin-top:20px;">
		${pageInfo.pagingHtml}
	</div>
    </section><!-- End Team Section -->
    </body>
<%@ include file="../common/bottom.jsp" %>