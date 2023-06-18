<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- top.jsp -->
<%@ include file="../common/common.jsp" %>
<style>
	.notification-item:hover{
		background-color:#FEF9E7;
	}
	.notification-item{
		padding: 0px;
	}
	p{
		padding: 0px;
	}
</style>
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
          <li><a class="nav-link scrollto <c:if test="${topmenu eq 'main'}">active</c:if>" href="main.go">ABOUT US</a></li>
          
          <li class="dropdown" ><a href="healthBoardList.co" class="<c:if test="${topmenu eq 'healthBoard'}">active</c:if>"><span>COMMUNITY</span><i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a href="healthBoardList.co">건강 정보 게시판</a></li>
              <li><a href="freeBoardList.co">자유 게시판</a></li>
            </ul>
          </li>
          
          <li><a class="nav-link scrollto <c:if test="${topmenu eq 'trainerList'}">active</c:if>" href="trainerList.pd">TRAINERS</a></li>
          
          <!-- 일반회원 메뉴 -->
          <c:if test="${loginInfo.mtype eq 'generic'}">
	          <li class="dropdown"><a href="genericCalendar.rv"><span>MY PT</span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="genericCalendar.rv">My PT</a></li>
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
	              <li><a href="#">1</a></li>
	              <li><a href="#">2</a></li>
	              <li><a href="#">3</a></li>
	            </ul>
	          </li>
          </c:if>
          
          
          <!-- 일반회원 메뉴 -->
          <c:if test="${loginInfo.mtype eq 'generic'}">
	          <li class="dropdown"><a href="health.ht" class="<c:if test="${topmenu eq 'healthList'}">active</c:if>"><span>HEALTHCARE</span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="health.ht">내 건강관리</a></li>
	              <li><a href="myHealthList.ht">운동관리</a></li>
	              <li><a href="myNutritionList.ht">식단관리</a></li>
	              <li><a href="myPhysiqueList.ht">신체정보</a></li>
	            </ul>
	          </li>
          </c:if>


          
          <!-- 내글보기, 회원정보수정 등 - 트레이너  -->
          <c:if test="${loginInfo.mtype eq 'trainer'}">
          	<li class="dropdown" ><a href="trainerDetail.mb" class="<c:if test="${topmenu eq 'trainerMember'}">active</c:if>"><span><font size="2">${loginInfo.name}님(${loginInfo.nickname})</font></span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="trainerDetail.mb">마이페이지</a></li>
	              <li><a href="myBoardList.co">내 글보기</a></li>
	              <li><a href="memberHealthCare.ht">회원운동관리</a></li>
	              <li><a href="viewProductList.pd">상품관리</a></li>
	              <li><a href="trainerReviewList.mb">리뷰관리</a></li>
	              <li><a href="myQuestionList.qt">문의 내역</a></li>
	            </ul>
	          </li>
           </c:if>
          <!-- 내글보기, 회원정보수정 등 - 회원  -->
          <c:if test="${loginInfo.mtype eq 'generic'}">
          	<li class="dropdown" ><a href="genericMemberDetail.mb" class="<c:if test="${topmenu eq 'genericMember'}">active</c:if>"><span><font size="2">${loginInfo.name}님(${loginInfo.nickname})</font></span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="genericMemberDetail.mb">마이페이지</a></li>
	              <li><a href="myBoardList.co">내 글보기</a></li>
	              <li><a href="viewMyOrderList.od">구매관리</a></li>
	              <li><a href="viewMyReviewList.mb">리뷰관리</a></li>
	              <li><a href="myQuestionList.qt">문의 내역</a></li>
	            </ul>
	          </li>
	      
	    <!--   장바구니 - 일반 회원 -->
	      <li>
          	<a href = "cartList.od">
          		<i class="bi bi-cart" style="font-size: 30px;"></i>
          	</a>
          </li>
           </c:if>
           <c:if test = "${loginInfo.mtype eq 'admin' }">
           <li class="dropdown" ><a href=""><span><font size="2">${loginInfo.name}님(${loginInfo.nickname})</font></span><i class="bi bi-chevron-down"></i></a>
	            <ul>
	              <li><a href="questionList">문의 관리</a></li>
	              <li><a href="reviewDeleteRequestList.mb">리뷰삭제 신청 관리</a></li>
	              <li><a href=""></a></li>
	              <li><a href=""></a></li>
	            </ul>
	       </li>
           </c:if>
           
		  <!-- 알림 -->
		  <c:if test = "${loginInfo.mtype != null }">
		  <c:if test = "${ notifCount != null }">
		  <li class="nav-item dropdown">

          <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
            <i class="bi bi-bell" style = "font-size: 25px;"></i>
            <span class="badge bg-primary badge-number">${notifCount }</span>
          </a><!-- End Notification Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
            <li class="dropdown-header" style = "display:flex; justify-content: space-around; align-items: center; padding:0px;">
              알림 ${ notifCount }개 있습니다.
              <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>
			
			<c:forEach var = "notif" items = "${notifList}">
            <li class="notification-item" style = "display:flex; justify-content: space-around; align-items: center; padding: 0px;">
              <i class="bi bi-exclamation-circle text-warning"></i>
              <div>
                <p>${notif.notifContent }</p>
              </div>
            </li>

            <li>
              <hr class="dropdown-divider">
            </li>
			</c:forEach>
            <li class="dropdown-footer">
              <a href="#">전체 알림 보기</a>
            </li>
            
          </ul><!-- End Notification Dropdown Items -->
        </li><!-- End Notification Nav -->
        </c:if>
        </c:if>
        
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


