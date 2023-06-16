<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
	
	
  <!-- ======= 메뉴바!!! ======= -->
  <aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav" style="padding-top: 20px;">

	  <li class="nav-heading">Main</li>
	
      <li class="nav-item">
        <a class="nav-link  <c:if test="${menubar != 'myHealthMain'}">collapsed</c:if>" href="health.ht">
          <i class="bi bi-grid"></i>
          <span>내 건강 정보</span>
        </a>
      </li><!-- End Dashboard Nav -->
	 
	  <li class="nav-heading">Pages</li>
	  
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myHealth'}">collapsed</c:if>" href="myHealthList.ht">
          <i class="bi bi-layout-text-window-reverse"></i><span>운동관리</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myNutrition'}">collapsed</c:if>" href="myNutritionList.ht">
          <i class="bi bi-layout-text-window-reverse"></i><span>식단관리</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myPhysique'}">collapsed</c:if>" href="myPhysiqueList.ht">
          <i class="bi bi-layout-text-window-reverse"></i><span>신체정보</span><!-- <i class="bi bi-chevron-down ms-auto"></i> -->
        </a>
      </li><!-- End Tables Nav -->
      
      <li class="nav-item">
        <a class="nav-link <c:if test="${menubar != 'myPhysiqueGoal'}">collapsed</c:if>" href="myPhysiqueGoal.ht">
          <i class="bi bi-person"></i><span>목표관리</span>
        </a>
      </li>


  </aside><!-- End Sidebar-->
  
  <main id="main" class="main" style="margin-top: 5px">