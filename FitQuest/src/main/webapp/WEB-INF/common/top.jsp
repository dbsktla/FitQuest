<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- top.jsp -->
<%@ include file="../common/common.jsp" %>

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>FlexStart Bootstrap Template - Index</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/img/favicon.png" rel="icon">
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=request.getContextPath()%>/resources/FlexStart/assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: FlexStart
  * Updated: May 30 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/flexstart-bootstrap-startup-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  

</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top" style="height: 80px">
    <div class="container-fluid container-xl d-flex align-items-center justify-content-between">

      <a href="main.go" class="logo d-flex align-items-center">
        <img src="" alt="">
        <span>FlexStart</span>
      </a>

      <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto active" href="#">ABOUT US</a></li>
          
          <li class="dropdown" ><a href="#"><span>COMMUNITY</span><i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="#">건강 정보 게시판</a></li>
              <li><a href="freeBoardList.co">자유 게시판</a></li>
            </ul>
          </li>
          
          <li><a class="nav-link scrollto" href="#">TIPS</a></li>
          
          <li class="dropdown" ><a href="trainerList.pd"><span>TRAINERS</span><i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="trainerList.pd">트레이너 찾기</a></li>
              <li><a href="#">Drop Down 2</a></li>
              <li><a href="#">Drop Down 3</a></li>
              <li><a href="#">Drop Down 4</a></li>
            </ul>
          </li>
          
          <!-- 일반회원 메뉴 -->
          <c:if test="${loginInfo.mtype eq 'generic'}">
	          <li class="dropdown"><a href="genericCalendar.rv"><span>MY PT</span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="genericCalendar.rv">My PY</a></li>
	              <li><a href="#">1</a></li>
	              <li><a href="#">2</a></li>
	              <li><a href="#">3</a></li>
	            </ul>
	          </li>
          </c:if>
           <!-- 트레이너 메뉴 -->
          <c:if test="${loginInfo.mtype eq 'trainer'}">
	          <li class="dropdown"><a href="trainerCalendar.rv"><span>MY PT</span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="trainerCalendar.rv">My PT</a></li>
	              <li><a href="trainerReviewList.mb">My Reviews</a></li>
	              <li><a href="#">2</a></li>
	              <li><a href="#">3</a></li>
	            </ul>
	          </li>
          </c:if>
          
          <!-- 일반회원 메뉴 -->
          <c:if test="${loginInfo.mtype eq 'generic'}">
	          <li class="dropdown"><a href="health.ht"><span>HEALTHCARE</span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="health.ht">내 건강관리</a></li>
	              <li><a href="#">운동관리</a></li>
	              <li><a href="#">식단관리</a></li>
	              <li><a href="#">신체정보</a></li>
	            </ul>
	          </li>
          </c:if>
          <!-- 트레이너 메뉴 -->
          <c:if test="${loginInfo.mtype eq 'trainer'}">
	          <li class="dropdown"><a href="#"><span>HEALTHCARE</span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="#">회원목록</a></li>
	              <li><a href="#">운동관리</a></li>
	              <li><a href="#">식단관리</a></li>
	              <li><a href="#">신체정보</a></li>
	            </ul>
	          </li>
          </c:if>
          
          <!-- 내글보기, 회원정보수정 -->
          <c:if test="${loginInfo != null}">
          	<li class="dropdown" ><a href="#"><span><font size="2">${loginInfo.name}님(${loginInfo.nickname})</font></span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="#">마이페이지</a></li>
	              <li><a href="#">개인정보수정</a></li>
	              <li><a href="#">내 글보기</a></li>
	              <li><a href="#">스크랩</a></li>
	            </ul>
	          </li>
           </c:if>
          <li>
          	<a href = "cartList.od">
          		<i class="bi bi-cart" style="font-size: 30px;"></i>
          	</a>
          </li>
          <li>
          	<a class="scrollto">
          		<!-- 로그인 정보 없으면 login -->
          		<c:if test="${loginInfo == null}">
          		<button type="button" class="btn btn-warning scrollto" onclick="location.href='login.mb'">LOGIN</button>
          		</c:if>
          		
          		<!-- 로그인 정보 있으면 logout -->
          		<c:if test="${loginInfo != null}">
          		<button type="button" class="btn btn-warning scrollto" onclick="location.href='logout.mb'">LOGOUT</button>
          		</c:if>
          	</a>
          </li>
          
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

    </div>
  </header><!-- End Header -->


<!-- Vendor JS Files -->
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/aos/aos.js"></script>
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="<%=request.getContextPath()%>/resources/FlexStart/assets/js/main.js"></script>


  <main id="main" style="margin-left: 0;">
    <section id="about" class="about">


