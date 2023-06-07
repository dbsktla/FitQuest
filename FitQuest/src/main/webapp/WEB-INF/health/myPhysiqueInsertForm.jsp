<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPhysiqueInsertForm.jsp -->
<%@ include file="../common/common.jsp"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 신체정보
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item"><a href="myPhysiqueList.ht">신체정보</a></li>
				<li class="breadcrumb-item active">신체정보 추가</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<!-- Default Card -->
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">신체정보 추가</h5>
					
				</div><!-- card-body -->
			</div> <!-- card -->
		</div><!-- col 12 -->
	</div><!-- row -->
	

</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>