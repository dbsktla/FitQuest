<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myHealthInsertForm -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 운동관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item"><a href="myHealthList.ht">운동관리</a></li>
				<li class="breadcrumb-item active">운동정보 추가</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<!-- <div class="card"> -->
			<div class="card mb-3">
				<div class="card-body">
					<h5 class="card-title">운동 정보 추가</h5><br>
					
					<form class="row g-3">
						<div class="col-md-12">
							<label for="hdate" class="form-label">운동일자</label> 
							<input type="date" class="form-control" id="hdate" name="hdate">
						</div>
						<div style="height: 10"></div>
						
						
						<div class="col-md-12">
							<label for="hname" class="form-label">운동명</label> 
							<input type="text" class="form-control" id="hname" name="hname">
						</div>
						
						<div class="col-md-6">
							<label for="starttime" class="form-label" style="display: block;">시작시간</label>
							<select id="starttime" name="starthour" class="form-select" style="width: 40%; display: inline;">
								<c:forEach var="hour" begin="0" end="23">
									<option value="${hour}">${hour}</option>
								</c:forEach>
							</select>
							<font style="margin-left: 5;margin-right: 15;">시</font>
							
							<select id="starttime" name="startminute" class="form-select" style="width: 40%; display: inline;">
								<c:forEach var="minute" begin="0" end="59">
									<option value="${minute}">${minute}</option>
								</c:forEach>
							</select>
							<font style="margin-left: 5;">분</font>
						</div>
						
						<div class="col-md-6">
							<label for="endtime" class="form-label" style="display: block;">종료시간</label>
							<select id="endtime" name="endhour" class="form-select" style="width: 40%; display: inline;">
								<c:forEach var="hour" begin="0" end="23">
									<option value="${hour}">${hour}</option>
								</c:forEach>
							</select>
							<font style="margin-left: 5;margin-right: 15;">시</font>
							
							<select id="endtime" name="endminute" class="form-select" style="width: 40%; display: inline;">
								<c:forEach var="minute" begin="0" end="59">
									<option value="${minute}">${minute}</option>
								</c:forEach>
							</select>
							<font style="margin-left: 5;">분</font>
						</div>
						
						<div class="col-md-6">
							<label for="inputEmail5" class="form-label">횟수</label>
							<input type="number" class="form-control" id="inputEmail5" value="0">
						</div>
						
						<div class="col-md-6">
							<label for="inputPassword5" class="form-label">세트</label>
							<input type="number" class="form-control" id="inputPassword5" value="0">
						</div>
						<div style="height: 10"></div>
						
						<div class="text-center">
						<button type="submit" class="btn btn-warning" onclick="location.href='myHealthInsert.ht'">추가하기</button>
						</div>
					</form>
				</div>
			</div>
		</div><!-- col-lg-12 -->
	</div><!-- row -->	
	
</body>
<%@ include file="myHealthBottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>