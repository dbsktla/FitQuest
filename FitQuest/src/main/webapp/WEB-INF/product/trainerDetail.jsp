<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>
 <section class="breadcrumbs">
      <div class="container">
        <ol>
          <li><a href="main.go">홈 페이지</a></li>
          <li><a href="trainerList.pd?pageNumber=${pageNumber }">목록보기</a></li>
        </ol>
      </div>
</section><!-- End Breadcrumbs -->
 <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
		  <div class ="col-lg-2"></div>
          <div class="col-lg-8 entries">

            <article class="entry entry-single">

              <div class="entry-img" align = "center">
                <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainerBean.timage}" alt="" class="img-fluid" style = "width: 80%; text-align:center; margin-top: 50px;">
              </div>

              <h2 class="entry-title">
              	${memberBean.name } ${trainerBean.activity } 선생님 소개합니다!
              </h2>

              <div class="entry-meta">
                <ul>
                  <li class="d-flex align-items-center"><i class="bi bi-person"></i>별명 : ${memberBean.nickname }</li>
                  <li class="d-flex align-items-center"><i class="bi bi-clock"></i>나이 : ${ age }</li>
                  <li class="d-flex align-items-center"><i class="bi bi-chat-dots"></i> <a href="#reviewSection">리뷰 : ${reviewCount } 글</a></li>
                </ul>
              </div>

              <div class="entry-content">
                <h3>헬스장 안내 : ${gymBean.gname }</h3>
                <p>
                	주소 : ${gymBean.gaddr1 } <br> ${ gymbean.gaddr2 }
                	전화 번호 : ${gymBean.gphone }
                </p>
                <blockquote>
                  <p>
					${trainerBean.intro}
                  </p>
                </blockquote>
 				<h3>트레이너 정보 (${trainerBean.activity })</h3>
                <p>
                	운동 목적 : <br>
                	<c:forEach var = "purpose" items = "${trainerBean.purpose }">
                		<i class="bi bi-check"></i>${purpose }<br>
                	</c:forEach>
                	경력 : ${trainerBean.exp }<br>
                	나이 : ${age }<br>
                	성별 : ${memberBean.gender}<br>
                	전화번호 : ${memberBean.mphone }<br>
                	이메일 : ${memberBean.email }
                </p>
              </div>
				
            </article><!-- End blog entry -->
            <h4 class="comments-count">수업 회원권 : </h4><br>
			<c:forEach var = "product" items = "${pList }">
            <div class="blog-author d-flex align-items-center" style = "justify-content: space-between;">
			  <i class="bi bi-cart-plus" style="font-size: 30px"></i>
              <div>
                <h5 style = "color: #FAC710">${ product.months }개월 회원권 = ${product.ptype}레슨(${product.people}명 수업) ${product.pcount }회 : ${product.price }만원</h5>
              </div>
              <div>
              	<input type = "button" class ="btn btn-warning" value = "카트 추가하기" onclick = "location.href='cartInsert.pd?pnum=${product.pnum}&id=${trainerBean.id }'">
              	
              </div>
            </div><!-- End blog author bio -->
            </c:forEach>
            <!--  리뷰 섹션 -->
            <c:if test = "${hasReview eq 'Y' }">
            <div class="blog-comments" id = "reviewSection">
              <h4 class="comments-count">리뷰 : ${reviewCount }<br><br>
              <fmt:formatNumber var = "rating1" value="${avgScore }" type="number" pattern="#.0"/>
				<fmt:formatNumber var = "rating" value="${avgScore}" type="number" pattern="#"/>
                평균 별점 : 
				<c:set var = "starCount" value = "0"/>
				<c:forEach begin = "1" end = "${rating }" step="1" var="i">
                  <i class="bi bi-star-fill"></i>
                  <c:set var = "starCount" value = "${starCount + 1 }"/>
				</c:forEach>
				<c:forEach begin = "1" end = "${5 - starCount }" step = "1" var = "j">
				<i class = "bi bi-star"></i>
				</c:forEach>
				${rating1 }
				</h4>
			  <c:forEach var = "review" items = "${rList }">
              <div id="comment-1" class="comment">
                <div class="d-flex">
                  <div class = "reviewComment">
                  	<h5 style = "font-weight: bold; ">${review.mid }회원님 : "${review.rtitle }"</h5>
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
                    <p>
                    ${review.rcontent }
                    </p>
                  </div>
                </div>
              </div><!-- End comment #1 -->
		      </c:forEach>
            </div><!-- End blog comments -->
		  </c:if>
		  <c:if test = "${hasReview eq 'N' }">
		  	아직 작성된 리뷰가 없습니다.
		  </c:if>
		  
		  <div style = "font-weight:bold;font-size:14px;">
		  <input type = "button" class ="btn btn-warning" value = "리뷰 작성하기" onclick="location.href='reviewInsert.pd'">
 			${memberBean.name } 선생님에게 수업 3번 이상 받으시면 리뷰 작성 가능합니다!
		  </div>
          <!-- 비슷한 트레이너 보기 : -->
          <div class="container" data-aos="fade-up" style = "margin-top: 60px;">
		  <h4>다른 ${trainerBean.activity } 트레이너들도 보세요 :</h4>
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
               	 <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${trainer.timage}" class="img-fluid" alt="text"/>
            	 </div>
                </a>
              <div class="member-info">
                <h4 style = "margin-top:10px;">${trainer.name }</h4>
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
				(${rating1})
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
          
          
          </div><!-- End blog entries list -->
          
          
			
        </div>

      </div>
    </section><!-- End Blog Single Section -->
<%@ include file="../common/bottom.jsp" %>
    