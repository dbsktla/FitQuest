<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>
<%
	session.setAttribute("flag1", true); 
%>
<style>
	.entry-title{
		color: black !important;
		font-size: 24px !important;
		margin-top: 50px !important;
	}
	h3{
		color: black !important;
		font-size: 18px !important;
	}
	.entry-meta{
		padding-bottom: 20px;
		border-bottom: 1px solid lightgray;
	}
	.blog-author{
		background-color: white;
		border-radius: 10px;
	}
	.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
	h5{
		margin: 5px 0px !important;
	}
</style>

<script>
	function tquestion(tid) {
		// alert(tid);
		var popWidth = 600;
		var popHeight = 600;
		
		var popX = (window.screen.width / 2) - (popWidth / 2);
		var popY = (window.screen.height / 2) - (popHeight / 2);
		
		window.name = "parentForm";
		
		windowObj = window.open("openTQuestion.qt?tid="+tid , 'childForm', "width="+popWidth+" , height="+popHeight+" , left="+popX+" , top="+popY);
	}
	
</script>


<body style="background-color: #FEF9E7;">
 <section class="breadcrumbs">
      <div class="container">
        <ol>
          <li><a href="main.go">홈페이지</a></li>
          <li><a href="trainerList.pd?pageNumber=${pageNumber}">목록보기</a></li>
        </ol>
      </div>
</section><!-- End Breadcrumbs -->
 <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">
		
        <div class="row" style = "justify-contents: center;">
		  <div class ="col-lg-2"></div>
          <div class="col-lg-8 entries">

            <article class="entry entry-single" style="background-color: white; border-radius: 10px;">

              <div class="entry-img" align = "center">
                <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainerBean.timage}" alt="" class="img-fluid" style = "width: 92%; text-align:center; margin-top: 50px;">
              </div>

              <h2 class="entry-title">
              	${memberBean.name } ${trainerBean.activity } 선생님
              </h2>

              <div class="entry-meta">
                <ul>
                  <li class="d-flex align-items-center s-text"><i class="bi bi-person"></i>별명 : ${memberBean.nickname }</li>
                  <li class="d-flex align-items-center s-text"><i class="bi bi-clock"></i>나이 : ${age}세</li>
                  <c:if test = "${hasReview eq 'Y' }">
                  	<li class="d-flex align-items-center s-text"><i class="bi bi-chat-dots"></i><a href="#reviewSection" class="s-text">리뷰 : ${reviewCount}개</a></li>
                  </c:if>
                  <li class="d-flex align-items-center s-text"><input type="button" onclick="tquestion('${trainerBean.id}')" value="트레이너 문의하기" class="btn btn-warning btn-sm"></li>
                </ul>
              </div>

              <div class="entry-content">
                <blockquote>
                  <p>
					${trainerBean.intro}
                  </p>
                </blockquote>
 				<h3>선생님 소개</h3>
 				<table class="t-table">
                	<tr>
                		<th class="t-th">운동 목적</th>
                		<td class="t-td">
                			<c:forEach var = "purpose" items = "${trainerBean.purpose }">
		                		<i class="bi bi-check"></i>${purpose}<br>
		                	</c:forEach>
                		</td>
                	</tr>
                	<tr>
                		<th class="t-th">경력</th>
                		<td class="t-td">${trainerBean.exp}</td>
                	</tr>
                	<tr>
                		<th class="t-th">나이</th>
                		<td class="t-td">${age}세</td>
                	</tr>
                	<tr>
                		<th class="t-th">성별</th>
                		<td class="t-td">${memberBean.gender}</td>
                	</tr>
                	<tr>
                		<th class="t-th">전화번호</th>
                		<td class="t-td">${memberBean.mphone}</td>
                	</tr>
                	<tr>
                		<th class="t-th">이메일</th>
                		<td class="t-td">${memberBean.email}</td>
                	</tr>
                </table>
                <h3>${gymBean.gname}</h3>
                <table class="t-table">
                	<tr>
                		<th class="t-th">주소</th>
                		<td class="t-td">${gymBean.gaddr1}</td>
                	</tr>
                	<tr>
                		<th class="t-th">전화번호</th>
                		<td class="t-td">${gymBean.gphone}</td>
                	</tr>
                </table>
              </div>
				
            </article><!-- End blog entry -->
            <h2 class="entry-title">수업 회원권</h2><br>
			<c:forEach var = "product" items = "${pList }">
            <div class="blog-author d-flex align-items-center" style = "justify-content: space-between;">
			  <i class="bi bi-cart-plus" style="font-size: 30px"></i>
              <div>
                <h5 class="p-text"><span class="p-box">${ product.months }개월 회원권</span>&emsp;&emsp;&emsp;
                ${product.ptype}레슨(${product.people}명 수업) ${product.pcount }회 : ${product.price }만원</h5>
              </div>
              <div>
              	<input type = "button" class ="btn btn-warning" value = "카트 추가하기" onclick = "location.href='cartInsert.od?pnum=${product.pnum}&id=${trainerBean.id }'">
              	
              </div>
            </div><!-- End blog author bio -->
            </c:forEach>
            <!--  리뷰 섹션 -->
            <c:if test = "${hasReview eq 'Y' }">
            <div class="blog-comments" id = "reviewSection">
              <h2 class="entry-title">리뷰 : ${reviewCount}개<br><br>
              <fmt:formatNumber var = "rating1" value="${avgScore }" type="number" pattern="#.0"/>
				<fmt:formatNumber var = "rating" value="${avgScore}" type="number" pattern="#"/>
                <span style="font-size: 17px;">
                평균 별점 : 
				<c:set var = "starCount" value = "0"/>
				<c:forEach begin = "1" end = "${rating }" step="1" var="i">
                  <i class="bi bi-star-fill"></i>
                  <c:set var = "starCount" value = "${starCount + 1 }"/>
				</c:forEach>
				<c:forEach begin = "1" end = "${5 - starCount }" step = "1" var = "j">
				<i class = "bi bi-star"></i>
				</c:forEach>
				${rating1}</span>
				</h2>
			  <c:forEach var = "review" items = "${rList }">
              <div id="comment-1" class="comment">
                <div class="review-box">
                  <div class = "reviewComment">
                  	<h5 style = "font-weight: bold; font-size: 17px;">"${review.rtitle }"</h5>
                  	<h5 style = "font-weight: bold; color: gray; ">${review.mid}</h5>
                  	<h5>
                  	<fmt:formatNumber var = "rating3" value="${review.rating }" type="number" pattern="#.0"/>
					<fmt:formatNumber var = "rating2" value="${review.rating}" type="number" pattern="#"/>
					<c:set var = "starCount1" value = "0"/>
					<c:forEach begin = "1" end = "${rating2 }" step="1" var="k">
	                  <i class="bi bi-star-fill"></i>
	                  <c:set var = "starCount1" value = "${starCount1 + 1 }"/>
					</c:forEach>
					<c:forEach begin = "1" end = "${5 - starCount1 }" step = "1" var = "l">
					<i class = "bi bi-star"></i>
				</c:forEach>
					${rating3 }
                  	</h5>
                    <fmt:parseDate value = "${review.rdate }" pattern = "yyyy-MM-dd" var = "date"/>
                    <fmt:formatDate value = "${date }" var = "date" pattern = "yyyy-MM-dd"/>
                    <h6 style = "color: #FAC710">${date }</h6>
                    <p style="margin: 5px 0px;">
                    ${review.rcontent }
                    </p>
                  </div>
                </div>
              </div><!-- End comment #1 -->
		      </c:forEach>
            </div><!-- End blog comments -->
		  </c:if>
		  <c:if test = "${hasReview eq 'N' }">
		  	<div class="review-box" style="margin: 20px 0px;font-weight:bold; font-size:17px; height:80px;display: flex; align-items: center; justify-content: space-between;">아직 작성된 리뷰가 없습니다.</div>
		  </c:if>
		  
		  <div style="font-weight:bold; font-size:17px; height:80px; display: flex; align-items: center; justify-content: space-between;" class="review-box">
			  <span style="margin-right: 50px;">
			    ${memberBean.name} 선생님에게 수업 3번 이상 받으시면 리뷰 작성 가능합니다!
			  </span>
			  <input type="button" class="btn btn-warning" value="리뷰 작성하기" onclick="location.href='reviewWrite.pd?id=${trainerBean.id}'">
		  </div>
		  
          <!-- 비슷한 트레이너 보기 : -->
          <div class="container" data-aos="fade-up" style = "margin-top: 60px; padding: 0;">
		  <h2 class="entry-title">다른 ${trainerBean.activity} 트레이너들 둘러보기</h2>
		  <section id="team" class="team" style = "background-color: #FEF9E7 !important;">
     	  <div class="container" data-aos="fade-up">
		  <div class="row gy-4">
		  <c:set var = "similarTrainerCount" value = "0"/>
		  <c:forEach var = "trainer" items = "${tList }" varStatus="status">
		  <c:if test = "${ trainer.id != trainerBean.id  }">
		  <c:if test = "${similarTrainerCount < 3 }">
		  <c:set var = "similarTrainerCount" value = "${similarTrainerCount + 1 }"/>
          <div class="col-lg-4 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
                <a href = "trainerDetail.pd?id=${trainer.id }&pageNumber=${pageInfo.pageNumber}&hasReview=${trainer.hasReview}">
             	 <div class="member-img">
               	 <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainer.timage}" class="img-fluid" alt="text" width="400px"/>
            	 </div>
                </a>
              <div class="member-info">
                <h4 style = "margin-top:10px; color:black;">${trainer.name }</h4>
                <span>${trainer.activity} : ${trainer.purpose }</span><br>
				<span style = "color:black;">${trainer.gaddr1}</span><br>
               	<fmt:formatNumber var = "rating1" value="${trainer.rating }" type="number" pattern="#.##"/>
				<fmt:formatNumber var = "rating" value="${trainer.rating }" type="number" pattern="#"/>
				<c:set var = "starCount" value = "0"/>
				<div class="stars">
				<c:forEach begin = "1" end = "${rating }" step="1" var="i">
                  <i class="bi bi-star-fill"></i>
                  <c:set var = "starCount" value = "${starCount + 1 }"/>
				</c:forEach>
				<c:forEach begin = "1" end = "${5 - starCount }" step = "1" var = "j">
				<i class = "bi bi-star"></i>
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
                <input type = "button" value = "자세히 보기" class = "btn btn-warning" onclick= "location.href='trainerDetail.pd?id=${trainer.id}&pageNumber=${pageNumber }&hasReview=${ trainer.hasReview}'">
                </p>
              </div>
            </div>
          </div>	
          </c:if>
          </c:if>
		  </c:forEach>
		  
        </div>
        </div>
        </section>
        </div>
          
          
          </div><!-- End blog entries list -->
          
          
			
        </div>

      </div>
    </section><!-- End Blog Single Section -->
</body>
<%@ include file="../common/bottom.jsp" %>
    