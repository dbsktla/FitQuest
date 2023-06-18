<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- memberHealthCareMain.jsp -->
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>



<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	$(document).ready(function(){
		$('.datatable-search').css('display','none');
	});
</script>
<body style="background-color: #FEF9E7; ">

	<div class="pagetitle" style="margin: 40px 0px;">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 회원운동관리
		</h1>
	</div>
	
	<div class="row">
		
		<!-- 상단 회원 간략 정보 -->
		<div class="col-lg-12" style="margin: 40px 0px;">
			신규 회원
			유효 회원
			만료 회원
			
		</div><!-- 회원 간략 정보  -->
		
		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
				<form action="memberHealthCare.ht">
					
					<!-- 필터 -->
					<div>
						<div class="col-lg-2 btn-group" role="group" aria-label="Basic outlined example" style="padding: 2% 3%;">
							<input type="radio" class="btn-check" value="남자" name="whatGender" id="whatGender1" autocomplete="off"
								<c:if test = "${whatGender eq '남자'}">checked</c:if>>
							<label class="btn btn-outline-warning btn-sm" for="whatGender1">남자</label> 
							
							<input type="radio" class="btn-check" value="여자" name="whatGender" id="whatGender2" autocomplete="off"
								<c:if test = "${whatGender eq '여자'}">checked</c:if>>
							<label class="btn btn-outline-warning btn-sm" for="whatGender2">여자</label> 
						</div>
					
						<div class="col-lg-2 btn-group" role="group" aria-label="Basic outlined example" style="padding: 2% 3%;">
							<input type="radio" class="btn-check" value="available" name="whatStatus" id="whatStatus1" autocomplete="off"
								<c:if test = "${whatStatus eq 'available'}">checked</c:if>>
							<label class="btn btn-outline-warning btn-sm" for="whatStatus1">유효</label> 
							
							<input type="radio" class="btn-check" value="unavailable" name="whatStatus" id="whatStatus2" autocomplete="off"
								<c:if test = "${whatStatus eq 'unavailable'}">checked</c:if>>
							<label class="btn btn-outline-warning btn-sm" for="whatStatus2">만료</label> 
						</div>
						
						<div class="col-lg-5 btn-group" role="group" aria-label="Basic outlined example"  style="padding: 2% 3%;">
							<input type="radio" class="btn-check" value="10" name="whatAge" id="whatAge1" autocomplete="off"
								<c:if test = "${whatAge == 10}">checked</c:if>>
							<label class="btn btn-outline-secondary btn-sm" for="whatAge1">10대</label> 
							
							<input type="radio" class="btn-check" value="20" name="whatAge" id="whatAge2" autocomplete="off"
								<c:if test = "${whatAge == 20}">checked</c:if>>
							<label class="btn btn-outline-secondary btn-sm" for="whatAge2">20대</label>
							
							<input type="radio" class="btn-check" value="30" name="whatAge" id="whatAge3" autocomplete="off"
								<c:if test = "${whatAge == 30}">checked</c:if>>
							<label class="btn btn-outline-secondary btn-sm" for="whatAge3">30대</label> 
							
							<input type="radio" class="btn-check" value="40" name="whatAge" id="whatAge4" autocomplete="off"
								<c:if test = "${whatAge == 40}">checked</c:if>>
							<label class="btn btn-outline-secondary btn-sm" for="whatAge4">40대</label>
							
							<input type="radio" class="btn-check" value="50" name="whatAge" id="whatAge5" autocomplete="off"
								<c:if test = "${whatAge == 50}">checked</c:if>>
							<label class="btn btn-outline-secondary btn-sm" for="whatAge5">50대</label>
						</div>
						
						
						<input type="reset" class="btn btn-warning btn-sm" value="전체 선택해제" style="float: right;">
					</div><!-- 필터 -->
					
					<div style="padding-left: 3%; width: 30%;">
						<input type="text" name="whatName" placeholder="이름검색" value="${whatName}" style="flex: auto;">
						<input type="submit" class="btn btn-warning btn-sm" value="검색">
					</div>
				</form>
				
				
				</div>
			</div>
		</div>
		
		<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
				
				<h5 class="card-title">구매 회원 목록</h5>
				<table class="table datatable">
					<thead>
						<tr>
							<th scope="col">NO.</th>
							<th scope="col">이름</th>
							<th scope="col">성별</th>
							<th>연령</th>
							<th>전화번호</th>
							<th>이메일주소</th>
							<th scope="col">최초구매일</th>
							<th scope="col">남은횟수</th>
							<th scope="col">회원상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty hclist}">
							<tr>
								<td colspan="9">조회할 정보가 없습니다.</td>
							</tr>
						</c:if>
						
						<c:if test="${not empty hclist}">
							<c:forEach var="hclist" items="${hclist}" varStatus="status">
							
							<tr id="${hclist.mid}">
								<td scope="row">${status.count}</td>
								<td>${hclist.name}</td>
								<td>${hclist.gender}</td>
								<td>만 ${hclist.age}세</td>
								<td>${hclist.mphone}</td>
								<td>${hclist.email}</td>
								<td>
									<fmt:parseDate value="${hclist.odate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
									<fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/>
								</td>
								<td>${hclist.usage}</td>
								<td>
									<c:if test="${hclist.ustate eq 'available'}"><font color="green">유효</font></c:if>
									<c:if test="${hclist.ustate eq 'unavailable'}"><font color="red">만료</font></c:if>
								</td>
							</tr>
							
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				</div>
			</div>
		</div><!-- col 10 -->
		
	</div><!-- row -->
	
</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>

