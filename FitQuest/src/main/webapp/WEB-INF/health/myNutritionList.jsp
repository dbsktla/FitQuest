<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myNutritionList.jsp -->
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>
<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 식단관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item active">식단관리</li>
			</ol>
		</nav>
	</div>

	<div class="row">
		<div class="col-lg-4" >
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">일자 선택</h5>
				</div>
			</div>
		</div>
		
		<div class="col-lg-8">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">식단 상세 정보</h5>
				</div>
			</div>
		</div>
	</div><!-- row -->

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>