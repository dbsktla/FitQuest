<%@page import="java.util.List"%>
<%@page import="health.model.HealthBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myHealthUpdateForm.jsp -->

<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="myHealthTop.jsp"%>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	var classcount
	function inputScope() {
		document.getElementById('healthScope').innerHTML += '<div class="row g-3 healthScopePlus">'
		+ '<div class="col-md-12"><label for="hname" class="form-label">운동명</label><input type="text" class="form-control" id="hname" name="hname"></div>'
		+ '<div class="col-md-6"><label for="starthour" class="form-label" style="display: block;">시작시간</label><select id="starthour" name="starthour" class="form-select" style="width: 40%; display: inline;"><c:forEach var="hour" begin="0" end="23"><option value="${hour}">${hour}</option></c:forEach></select><font style="margin-left: 5;margin-right: 15;">시</font><select id="startminute" name="startminute" class="form-select" style="width: 40%; display: inline;"><c:forEach var="minute" begin="0" end="59"><option value="${minute}">${minute}</option></c:forEach></select><font style="margin-left: 5;">분</font></div>'
		+ '<div class="col-md-6"><label for="endhour" class="form-label" style="display: block;">종료시간</label><select id="endhour" name="endhour" class="form-select" style="width: 40%; display: inline;"><c:forEach var="hour" begin="0" end="23"><option value="${hour}">${hour}</option></c:forEach></select><font style="margin-left: 5;margin-right: 15;">시</font><select id="endminute" name="endminute" class="form-select" style="width: 40%; display: inline;"><c:forEach var="minute" begin="0" end="59"><option value="${minute}">${minute}</option></c:forEach></select><font style="margin-left: 5;">분</font></div>'
		+ '<div class="col-md-6"><label for="hcount" class="form-label">횟수</label><input type="number" class="form-control" id="hcount" name="hcount" value="0"></div>'
		+ '<div class="col-md-6"><label for="hset" class="form-label">세트</label><input type="number" class="form-control" id="hset" name="hset" value="0"></div><div style="height: 10"></div>'
		+ '</div>';
	}
	
	function deleteScope() {
		var f = $('.healthScopePlus').length;
		
		if(f == 1){
			alert("운동 최소 한개는 작성해야 합니다.");
		}else{
			var slen = $('.healthScopePlus').length;
			
			$('.healthScopePlus').eq(slen-1).remove();
			
			flug--;
		}
	}

</script>

<%
	List<HealthBean> list = (List<HealthBean>)request.getAttribute("hlist");

	String[] sho = new String[list.size()];
	String[] smin = new String[list.size()];
	String[] eho = new String[list.size()];
	String[] emin = new String[list.size()];
	
	int i = 0;
	for(HealthBean hb : list){
		//2023-06-05 16:00:00
		sho[i] = hb.getStarttime().substring(hb.getStarttime().indexOf(" ") + 1, hb.getStarttime().indexOf(":"));
		smin[i] = hb.getStarttime().substring(14, 16);
		
		eho[i] = hb.getEndtime().substring(hb.getEndtime().indexOf(" ") + 1, hb.getEndtime().indexOf(":"));
		emin[i] = hb.getEndtime().substring(14, 16);
		
		//System.out.println("shour : " + sho[i] + " , smin : " + smin[i]);
		i++;
	}
%>

<body style="background-color: #FEF9E7">
	<div class="pagetitle">
		<h1>
			<i class="bi bi-list toggle-sidebar-btn"></i> 운동관리
		</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="health.ht">Home</a></li>
				<li class="breadcrumb-item"><a href="myHealthList.ht">운동관리</a></li>
				<li class="breadcrumb-item active">운동정보 수정</li>
			</ol>
		</nav>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<!-- <div class="card"> -->
			<div class="card mb-3">
				<div class="card-body">
					<h5 class="card-title">
						운동 정보 추가
						<button type="button" onclick="deleteScope()" class="btn btn-warning rounded-pill btn-sm" style="float: right;">운동삭제</button> 
						<button type="button" onclick="inputScope()" class="btn btn-warning rounded-pill btn-sm" style="float: right; margin-right: 10;">운동추가</button>
					</h5><br>
					
					<form class="row g-3" action="myHealthUpdate.ht" method="post">
					
					<fmt:parseDate value="${healthDateBean.hdate}" var="day" pattern="yyyy-MM-dd" scope="page"/>
					
						<input type = "hidden" name="hnum" value="${healthDateBean.hnum}">
						<div class="col-md-12">
							<label for="hdate" class="form-label">운동일자</label> 
							<input type="date" class="form-control" id="hdate" name="hdate" value='<fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/>'>
							<input type="hidden" name="olddate" value="<fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/>">
						</div>
						<div style="height: 10"></div>
						
						
						<div id="healthScope">
						
						
						<c:forEach var="hb" items="${hlist}" varStatus="status">
							<div class="row g-3 healthScopePlus">
							 
								<div class="col-md-12">
									<label for="hname" class="form-label">운동명</label> 
									<input type="text" class="form-control" id="hname" name="hname" value="${hb.hname}">
								</div>
								
								<c:set var="sho" value="<%=sho%>"/>
								<c:set var="smin" value="<%=smin%>"/>
								<c:set var="eho" value="<%=eho%>"/>
								<c:set var="emin" value="<%=emin%>"/>
								
								<div class="col-md-6">
									<label for="starthour" class="form-label" style="display: block;">시작시간</label>
									<select id="starthour" name="starthour" class="form-select" style="width: 40%; display: inline;">
										<c:forEach var="hour" begin="0" end="23">
											<option value="${hour}" <c:if test="${hour == sho[status.index]}">selected </c:if>>${hour}</option>
										</c:forEach>
									</select>
									<font style="margin-left: 5;margin-right: 15;">시</font>
									
									<select id="startminute" name="startminute" class="form-select" style="width: 40%; display: inline;">
										<c:forEach var="minute" begin="0" end="59">
											<option value="${minute}" <c:if test="${minute == smin[status.index]}">selected </c:if>>${minute}</option>
										</c:forEach>
									</select>
									<font style="margin-left: 5;">분</font>
								</div>
								
								<div class="col-md-6">
									<label for="endhour" class="form-label" style="display: block;">종료시간</label>
									<select id="endhour" name="endhour" class="form-select" style="width: 40%; display: inline;">
										<c:forEach var="hour" begin="0" end="23">
											<option value="${hour}" <c:if test="${hour == eho[status.index]}">selected </c:if>>${hour}</option>
										</c:forEach>
									</select>
									<font style="margin-left: 5;margin-right: 15;">시</font>
									
									<select id="endminute" name="endminute" class="form-select" style="width: 40%; display: inline;">
										<c:forEach var="minute" begin="0" end="59">
											<option value="${minute}" <c:if test="${minute == emin[status.index]}">selected </c:if>>${minute}</option>
										</c:forEach>
									</select>
									<font style="margin-left: 5;">분</font>
								</div>
								
								<div class="col-md-6">
									<label for="hcount" class="form-label">횟수</label>
									<input type="number" class="form-control" id="hcount" name="hcount" value="${hb.hcount}">
								</div>
								
								<div class="col-md-6">
									<label for="hset" class="form-label">세트</label>
									<input type="number" class="form-control" id="hset" name="hset" value="${hb.hset}">
								</div>
								<div style="height: 10"></div>
							
							</div><!-- healthScopePlus -->
						</c:forEach>
						
						
						</div>
						
						<div class="text-center">
						<button type="submit" class="btn btn-warning">수정하기</button>
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