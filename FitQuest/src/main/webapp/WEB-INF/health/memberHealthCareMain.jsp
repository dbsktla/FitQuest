<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- memberHealthCareMain.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>

<body style="background-color: #FEF9E7; ">

	<div class="pagetitle" style="margin: 40px 0px;">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 회원운동관리
		</h1>
	</div>
	
	<div class="row">
		
		<!-- 상단 회원 간략 정보 -->
		<div class="col-lg-10" style="margin: 40px 0px;">
			신규 회원
			유효 회원
			만료 회원
		</div><!-- 회원 간략 정보  -->
		
		<div class="col-lg-10">
			<div class="card">
				<div class="card-body">
				
				필터
				이름 검색, 성별보기, 연령대 보기(10,20,30,40,50이상), 구매일순, 남은횟수별
				<br>
				회원목록
				이름 성별 연령 전화번호 이메일주소 최초구매일 남은횟수 회원상태
				클릭은 한줄로진행하기
				
				</div>
			</div>
		</div><!-- col 10 -->
		
	</div><!-- row -->
	
</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>

