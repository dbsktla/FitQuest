<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	
	
  <!-- ======= 메뉴바!!! ======= -->
  <aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav" style="padding-top: 20px;">

	  <li class="nav-heading">Profile</li>
	  	
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myDetailMain'}">collapsed</c:if>" href="trainerDetail.mb">
          <i class="bi bi-layout-text-window-reverse"></i><span>마이페이지</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myBoardMain'}">collapsed</c:if>" href="myBoardList.co">
          <i class="bi bi-layout-text-window-reverse"></i><span>내글보기</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      	
      <li class="nav-heading">Manage</li>
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != ''}">collapsed</c:if>" href="memberHealthCare.ht">
          <i class="bi bi-layout-text-window-reverse"></i><span>회원운동관리</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      	
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myProductMain'}">collapsed</c:if>" href="viewProductList.pd">
          <i class="bi bi-layout-text-window-reverse"></i><span>상품관리</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myReviewMain'}">collapsed</c:if>" href="trainerReviewList.mb">
          <i class="bi bi-layout-text-window-reverse"></i><span>리뷰관리</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'mySalesMain'}">collapsed</c:if>" href="productSalesDetail.pd">
          <i class="bi bi-layout-text-window-reverse"></i><span>수익보기</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      


  </aside><!-- End Sidebar-->
  
  <main id="main" class="main" style="margin-top: 5px;">