<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>

<style>
	.swiper:hover {
	cursor: pointer;
}
</style>

<body data-aos-easing="ease-in-out" data-aos-duration="1000" data-aos-delay="0">

  <!-- ======= Hero Section ======= -->
  <section id="hero" class="hero d-flex align-items-center">

    <div class="container">
      <div class="row">
        <div class="col-lg-6 d-flex flex-column justify-content-center">
          <h1 data-aos="fade-up" class="aos-init aos-animate">We offer modern solutions for growing your business</h1>
          <h2 data-aos="fade-up" data-aos-delay="400" class="aos-init aos-animate">We are team of talented designers making websites with Bootstrap</h2>
          <div data-aos="fade-up" data-aos-delay="600" class="aos-init aos-animate">
            <div class="text-center text-lg-start">
              <a href="#about" class="btn-get-started scrollto d-inline-flex align-items-center justify-content-center align-self-center">
                <span>Get Started</span>
                <i class="bi bi-arrow-right"></i>
              </a>
            </div>
          </div>
        </div>
        <div class="col-lg-6 hero-img aos-init aos-animate" data-aos="zoom-out" data-aos-delay="200">
          <img src="assets/img/hero-img.png" class="img-fluid" alt="">
        </div>
      </div>
    </div>

  </section><!-- End Hero -->

<main style="margin: 0;">

    <!-- ======= Pricing Section ======= -->
    <section id="pricing" class="pricing">

      <div class="container aos-init aos-animate" data-aos="fade-up">

        <header class="section-header">
          <p>What's FitQuest</p>
        </header>

        <div class="row gy-4 aos-init aos-animate" data-aos="fade-left">

          <div class="col-lg-3 col-md-6 aos-init aos-animate" data-aos="zoom-in" data-aos-delay="100">
            <div class="box">
             <h2>건강 정보 관리하기</h2>
              <p style="color: grey;">트레이너와 함께 만들어가는 내 건강<br><br></p>
              <img src="<%= request.getContextPath() %>/resources/Image/MainImage/mainHealth.jpg" class="img-fluid">
              <a href="health.ht" class="btn btn-outline-warning">&ensp;GO!&ensp;</a>
            </div>
          </div>

          <div class="col-lg-3 col-md-6 aos-init aos-animate" data-aos="zoom-in" data-aos-delay="200">
            <div class="box">
             <h2>맞춤 트레이너 찾기</h2>
              <p style="color: grey;">검증된 리뷰와 함께 카테고리 별<br>트레이너를 한눈에 살피기</p>
               <img src="<%= request.getContextPath() %>/resources/Image/MainImage/mainTrainer.jpg" class="img-fluid">
             <a href="trainerList.pd" class="btn btn-outline-warning">&ensp;GO!&ensp;</a>
            </div>
          </div>

          <div class="col-lg-3 col-md-6 aos-init aos-animate" data-aos="zoom-in" data-aos-delay="300">
            <div class="box">
              <h2>간편한 PT 예약</h2>
              <p style="color: grey;">트레이너와 내 일정을 한눈에 살펴<br>편리하게 예약하기</p>
               <img src="<%= request.getContextPath() %>/resources/Image/MainImage/mainPT.jpg" class="img-fluid">
              <a href="genericCalendar.rv" class="btn btn-outline-warning">&ensp;GO!&ensp;</a>
            </div>
          </div>

          <div class="col-lg-3 col-md-6 aos-init aos-animate" data-aos="zoom-in" data-aos-delay="400">
            <div class="box">
             <h2>건강 정보 글</h2>
              <p style="color: grey;">트레이너들이 직접 올리는 꿀팁들<br><br></p>
               <img src="<%= request.getContextPath() %>/resources/Image/MainImage/mainBoard.jpg" class="img-fluid">
              <a href="healthBoardList.co" class="btn btn-outline-warning">&ensp;GO!&ensp;</a>
            </div>
          </div>

        </div>

      </div>

    </section><!-- End Pricing Section -->


    <!-- ======= Portfolio Section ======= -->
    <section id="portfolio" class="portfolio">

      <div class="container aos-init aos-animate" data-aos="fade-up">

        <header class="section-header">
          <p>Trainers</p>
        </header>

<!--         <div class="row aos-init aos-animate" data-aos="fade-up" data-aos-delay="100"> -->
<!--           <div class="col-lg-12 d-flex justify-content-center"> -->
<!--             <ul id="portfolio-flters"> -->
<!--               <li data-filter="*" class="filter-active">All</li> -->
<!--               <li data-filter=".filter-app">App</li> -->
<!--               <li data-filter=".filter-card">Card</li> -->
<!--               <li data-filter=".filter-web">Web</li> -->
<!--             </ul> -->
<!--           </div> -->
<!--         </div> -->

        <div class="row gy-4 portfolio-container aos-init aos-animate" data-aos="fade-up" data-aos-delay="200" style="position: relative; height: 1380px;">

          <div class="col-lg-4 col-md-6 portfolio-item filter-app" style="position: absolute; left: 0px; top: 0px;">
            <div class="portfolio-wrap">
              <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[0].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[0].name }</h4>
                <p>${ trainerList[0].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[0].id }&pageNumber=1&hasReview=${ trainerList[0].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-web" style="position: absolute; left: 360px; top: 0px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[1].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[1].name }</h4>
                <p>${ trainerList[1].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[1].id }&pageNumber=1&hasReview=${ trainerList[1].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-app" style="position: absolute; left: 0px; top: 276px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[2].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
               <h4>${ trainerList[2].name }</h4>
                <p>${ trainerList[2].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[2].id }&pageNumber=1&hasReview=${ trainerList[2].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-card" style="position: absolute; left: 360px; top: 276px;">
            <div class="portfolio-wrap">
              <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[3].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[3].name }</h4>
                <p>${ trainerList[3].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[3].id }&pageNumber=1&hasReview=${ trainerList[3].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-web" style="position: absolute; left: 0px; top: 552px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[4].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[4].name }</h4>
                <p>${ trainerList[4].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[4].id }&pageNumber=1&hasReview=${ trainerList[4].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-app" style="position: absolute; left: 360px; top: 552px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[5].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
               <h4>${ trainerList[5].name }</h4>
                <p>${ trainerList[5].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[5].id }&pageNumber=1&hasReview=${ trainerList[5].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-card" style="position: absolute; left: 0px; top: 828px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[6].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[6].name }</h4>
                <p>${ trainerList[6].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[6].id }&pageNumber=1&hasReview=${ trainerList[6].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-card" style="position: absolute; left: 360px; top: 828px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[7].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[7].name }</h4>
                <p>${ trainerList[7].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[7].id }&pageNumber=1&hasReview=${ trainerList[7].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6 portfolio-item filter-web" style="position: absolute; left: 0px; top: 1104px;">
            <div class="portfolio-wrap">
               <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ trainerList[8].timage }" class="img-fluid" alt="" width="100%">
              <div class="portfolio-info">
                <h4>${ trainerList[8].name }</h4>
                <p>${ trainerList[8].activity }</p>
                <div class="portfolio-links">
                  <a href="trainerDetail.mb?id=${ trainerList[8].id }&pageNumber=1&hasReview=${ trainerList[8].hasReview }" title="More Details"><i class="bi bi-link"></i></a>
                </div>
              </div>
            </div>
          </div>

        </div>

      </div>

    </section><!-- End Portfolio Section -->

   <!-- ======= Testimonials Section ======= -->
    <section id="testimonials" class="testimonials" style="background-color: #FEF9E7">

      <div class="container" data-aos="fade-up">

        <header class="section-header">
          <p>Reviews</p>
        </header>

        <div class="testimonials-slider swiper" data-aos="fade-up" data-aos-delay="200" style="height: 60%">
          <div class="swiper-wrapper">

            <div class="swiper-slide" onclick="location.href='trainerDetail.pd?id=${ reviewList[0].tid }&pageNumber=1&hasReview=${ reviewList[0].hasReview }'">
              <div class="testimonial-item">
                <div class="stars">
                	<c:choose>
                		<c:when test="${ reviewList[0].rating == 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                		</c:when>
                		<c:when test="${ reviewList[0].rating >= 4 && reviewList[0].rating < 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[0].rating >= 3 && reviewList[0].rating < 4 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[0].rating >= 2 && reviewList[0].rating < 3 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[0].rating >= 1 && reviewList[0].rating < 2 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:otherwise>
                			<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:otherwise>
                	</c:choose>
                	(<fmt:formatNumber value="${ reviewList[0].rating }" type="number" pattern="#.0"/>)
                </div>
                <p>
                  ${ reviewList[0].rcontent }
                </p>
                <br><br>
                <div>
                  <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ reviewList[0].timage }" class="testimonial-img" alt="">
                  <h3>${ reviewList[0].name }</h3>
                  <h4>${ reviewList[0].activity }</h4>
                </div>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide" onclick="location.href='trainerDetail.pd?id=${ reviewList[1].tid }&pageNumber=1&hasReview=${ reviewList[1].hasReview }'">
              <div class="testimonial-item">
                <div class="stars">
                	<c:choose>
                		<c:when test="${ reviewList[1].rating == 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                		</c:when>
                		<c:when test="${ reviewList[1].rating >= 4 && reviewList[1].rating < 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[1].rating >= 3 && reviewList[1].rating < 4 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[1].rating >= 2 && reviewList[1].rating < 3 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[1].rating >= 1 && reviewList[1].rating < 2 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:otherwise>
                			<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:otherwise>
                	</c:choose>
                	(<fmt:formatNumber value="${ reviewList[1].rating }" type="number" pattern="#.0"/>)
                </div>
                <p>
                  ${ reviewList[1].rcontent }
                </p>
                <br><br>
                <div>
                  <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ reviewList[1].timage }" class="testimonial-img" alt="">
                  <h3>${ reviewList[1].name }</h3>
                  <h4>${ reviewList[1].activity }</h4>
                </div>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide" onclick="location.href='trainerDetail.pd?id=${ reviewList[2].tid }&pageNumber=1&hasReview=${ reviewList[2].hasReview }'">
              <div class="testimonial-item">
               <div class="stars">
                	<c:choose>
                		<c:when test="${ reviewList[2].rating == 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                		</c:when>
                		<c:when test="${ reviewList[2].rating >= 4 && reviewList[2].rating < 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[2].rating >= 3 && reviewList[2].rating < 4 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[2].rating >= 2 && reviewList[2].rating < 3 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[2].rating >= 1 && reviewList[2].rating < 2 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:otherwise>
                			<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:otherwise>
                	</c:choose>
                	(<fmt:formatNumber value="${ reviewList[2].rating }" type="number" pattern="#.0"/>)
                </div>
                <p>
                  ${ reviewList[2].rcontent }
                </p>
                <br><br>
                <div>
                  <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ reviewList[2].timage }" class="testimonial-img" alt="">
                  <h3>${ reviewList[2].name }</h3>
                  <h4>${ reviewList[2].activity }</h4>
                </div>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide">
              <div class="testimonial-item" onclick="location.href='trainerDetail.pd?id=${ reviewList[3].tid }&pageNumber=1&hasReview=${ reviewList[3].hasReview }'">
                <div class="stars">
                	<c:choose>
                		<c:when test="${ reviewList[3].rating == 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                		</c:when>
                		<c:when test="${ reviewList[3].rating >= 4 && reviewList[3].rating < 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[3].rating >= 3 && reviewList[3].rating < 4 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[3].rating >= 2 && reviewList[3].rating < 3 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[3].rating >= 1 && reviewList[3].rating < 2 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:otherwise>
                			<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:otherwise>
                	</c:choose>
                	(<fmt:formatNumber value="${ reviewList[3].rating }" type="number" pattern="#.0"/>)
                </div>
                 <p>
                  ${ reviewList[3].rcontent }
                </p>
                 <br><br>
                <div>
                  <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ reviewList[3].timage }" class="testimonial-img" alt="">
                  <h3>${ reviewList[3].name }</h3>
                  <h4>${ reviewList[3].activity }</h4>
                </div>
              </div>
            </div><!-- End testimonial item -->

            <div class="swiper-slide" onclick="location.href='trainerDetail.pd?id=${ reviewList[4].tid }&pageNumber=1&hasReview=${ reviewList[4].hasReview }'">
              <div class="testimonial-item">
               <div class="stars">
                	<c:choose>
                		<c:when test="${ reviewList[4].rating == 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                		</c:when>
                		<c:when test="${ reviewList[4].rating >= 4 && reviewList[4].rating < 5 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[4].rating >= 3 && reviewList[4].rating < 4 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[4].rating >= 2 && reviewList[4].rating < 3 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:when test="${ reviewList[4].rating >= 1 && reviewList[4].rating < 2 }">
                			<i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:when>
                		<c:otherwise>
                			<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                		</c:otherwise>
                	</c:choose>
                	(<fmt:formatNumber value="${ reviewList[4].rating }" type="number" pattern="#.0"/>)
                </div>
                <p>
                  ${ reviewList[4].rcontent }
                </p>
                <br><br>
                <div>
                  <img src="<%= request.getContextPath() %>/resources/Image/TrainerImage/${ reviewList[4].timage }" class="testimonial-img" alt="">
                  <h3>${ reviewList[4].name }</h3>
                  <h4>${ reviewList[4].activity }</h4>
                </div>
              </div>
            </div><!-- End testimonial item -->

         </div>
        </div>
        
		</div>
          <div class="swiper-pagination"></div>
    </section><!-- End Testimonials Section -->
    

    <!-- ======= Recent Blog Posts Section ======= -->
    <section id="recent-blog-posts" class="recent-blog-posts">

      <div class="container" data-aos="fade-up">

        <header class="section-header">
          <p>Community</p>
        </header>

        <div class="row">
        
		<c:forEach var="board" items="${ healthBoardList }">
          <div class="col-lg-4">
            <div class="post-box">
              <div class="post-img"><img src="<%= request.getContextPath() %>/resources/Image/CommunityImage/${ board.bimage }" class="img-fluid" alt=""></div>
              <span class="post-date">
              	<c:if test="${ board.bregdate.contains('-01-') }">
              		January
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-02-') }">
              		February
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-03-') }">
              		March
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-04-') }">
              		April
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-05-') }">
              		May
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-06-') }">
              		June
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-07-') }">
              		July
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-08-') }">
              		August
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-09-') }">
              		September
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-10-') }">
              		October
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-11-') }">
              		November
              	</c:if>
              	<c:if test="${ board.bregdate.contains('-12-') }">
              		December
              	</c:if>
              	${ fn:substring(board.bregdate,8,10) }
              </span>
              <h3 class="post-title">${ board.bsubject }</h3>
              <a href="healthBoardDetail.co?bnum=${ board.bnum }" class="readmore stretched-link mt-auto"><span>Read More</span><i class="bi bi-arrow-right"></i></a>
            </div>
          </div>
		</c:forEach>
		
        </div>

      </div>

    </section><!-- End Recent Blog Posts Section -->

    
        <!-- ======= F.A.Q Section ======= -->
    <section id="faq" class="faq">

      <div class="container aos-init aos-animate" data-aos="fade-up">

        <header class="section-header">
          <p>자주 묻는 질문</p>
        </header>

        <div class="row">
          <div class="col-lg-6">
            <!-- F.A.Q List 1-->
            <div class="accordion accordion-flush" id="faqlist1">
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-1">
                    Non consectetur a erat nam at lectus urna duis?
                  </button>
                </h2>
                <div id="faq-content-1" class="accordion-collapse collapse" data-bs-parent="#faqlist1">
                  <div class="accordion-body">
                    Feugiat pretium nibh ipsum consequat. Tempus iaculis urna id volutpat lacus laoreet non curabitur gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus non.
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-2">
                    Feugiat scelerisque varius morbi enim nunc faucibus a pellentesque?
                  </button>
                </h2>
                <div id="faq-content-2" class="accordion-collapse collapse" data-bs-parent="#faqlist1">
                  <div class="accordion-body">
                    Dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Id interdum velit laoreet id donec ultrices. Fringilla phasellus faucibus scelerisque eleifend donec pretium. Est pellentesque elit ullamcorper dignissim. Mauris ultrices eros in cursus turpis massa tincidunt dui.
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-3">
                    Dolor sit amet consectetur adipiscing elit pellentesque habitant morbi?
                  </button>
                </h2>
                <div id="faq-content-3" class="accordion-collapse collapse" data-bs-parent="#faqlist1">
                  <div class="accordion-body">
                    Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis orci. Faucibus pulvinar elementum integer enim. Sem nulla pharetra diam sit amet nisl suscipit. Rutrum tellus pellentesque eu tincidunt. Lectus urna duis convallis convallis tellus. Urna molestie at elementum eu facilisis sed odio morbi quis
                  </div>
                </div>
              </div>

            </div>
          </div>

          <div class="col-lg-6">

            <!-- F.A.Q List 2-->
            <div class="accordion accordion-flush" id="faqlist2">

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2-content-1">
                    Ac odio tempor orci dapibus. Aliquam eleifend mi in nulla?
                  </button>
                </h2>
                <div id="faq2-content-1" class="accordion-collapse collapse" data-bs-parent="#faqlist2">
                  <div class="accordion-body">
                    Dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Id interdum velit laoreet id donec ultrices. Fringilla phasellus faucibus scelerisque eleifend donec pretium. Est pellentesque elit ullamcorper dignissim. Mauris ultrices eros in cursus turpis massa tincidunt dui.
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2-content-2">
                    Tempus quam pellentesque nec nam aliquam sem et tortor consequat?
                  </button>
                </h2>
                <div id="faq2-content-2" class="accordion-collapse collapse" data-bs-parent="#faqlist2">
                  <div class="accordion-body">
                    Molestie a iaculis at erat pellentesque adipiscing commodo. Dignissim suspendisse in est ante in. Nunc vel risus commodo viverra maecenas accumsan. Sit amet nisl suscipit adipiscing bibendum est. Purus gravida quis blandit turpis cursus in
                  </div>
                </div>
              </div>

              <div class="accordion-item">
                <h2 class="accordion-header">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2-content-3">
                    Varius vel pharetra vel turpis nunc eget lorem dolor?
                  </button>
                </h2>
                <div id="faq2-content-3" class="accordion-collapse collapse" data-bs-parent="#faqlist2">
                  <div class="accordion-body">
                    Laoreet sit amet cursus sit amet dictum sit amet justo. Mauris vitae ultricies leo integer malesuada nunc vel. Tincidunt eget nullam non nisi est sit amet. Turpis nunc eget lorem dolor sed. Ut venenatis tellus in metus vulputate eu scelerisque. Pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus faucibus. Nibh tellus molestie nunc non blandit massa enim nec.
                  </div>
                </div>
              </div>

            </div>
          </div>

        </div>

      </div>

    </section><!-- End F.A.Q Section -->
    

 </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer" style="margin: 0;">

    <div class="footer-top">
      <div class="container">
        <div class="row gy-4">
          <div class="col-lg-5 col-md-12 footer-info">
            <a href="main.go" class="logo d-flex align-items-center">
              <img src="<%= request.getContextPath() %>/resources/FlexStart/assets/img/logo.png" alt="">
              <span>FitQuest</span>
            </a>
            <p>Cras fermentum odio eu feugiat lide par naso tierra. Justo eget nada terra videa magna derita valies darta donna mare fermentum iaculis eu non diam phasellus.</p>
            <div class="social-links mt-3">
              <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
              <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
              <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
              <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
            </div>
          </div>

          <div class="col-lg-2 col-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Home</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">About us</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="healthBoardList.co">Community</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-2 col-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Web Design</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Web Development</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Product Management</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Marketing</a></li>
              <li><i class="bi bi-chevron-right"></i> <a href="#">Graphic Design</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-12 footer-contact text-center text-md-start">
            <h4>Contact Us</h4>
            <p>
              서울특별시 마포구<br>
              월드컵북로 21 풍성빌딩 2층<br><br>
              <strong>Phone:</strong> +1 5589 55488 55<br>
              <strong>Email:</strong> fitquest1470@gmail.com <br>
            </p>

          </div>

        </div>
      </div>
    </div>
	</footer>
</body>

  
<%@ include file="../common/bottom.jsp" %>