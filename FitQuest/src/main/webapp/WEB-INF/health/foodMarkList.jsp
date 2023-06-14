<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- foodMarkList.jsp -->
<%@ include file="../common/common.jsp" %>
<%@ include file="../common/adminBootTop.jsp" %>

<style>
	#listOne:hover{
		background-color: #fff3cd ;
	}
	#listOne:active{
		background-color: #ffd073 ;
	}
</style>


<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script>
	function listOneClick(num) {
		var fn = "form" + num
		document.getElementById(fn).submit();
	}
	
	function delMark(fknum) {
		//alert(fknum);
		
		$.ajax({
			url : "foodmarkDelete.ht",
			type : "POST",
			data : {"fknum" : fknum},
			success : function (data) {
				
				if(data == 'Y'){
					alert('삭제완료');
				}else{
					alert("삭제실패");
				}
				
				location.reload();
			}
		});
	}
</script>



<body style="background-color: #FEF9E7">
	<div class="col-10" style="margin: auto;margin-top: 5%;">
		<div id="listScope">
			<h2>식단 정보 북마크</h2>
			<br>
			<c:if test="${empty fklist}">
			저장된 식단정보가 없습니다.
			</c:if>
			
			<c:if test="${not empty fklist}">
				<c:forEach var="fklist" items="${fklist}" varStatus="status">
				
					<div class="row">
					<form id="form${status.index}" action="searchInputFood.ht">
						<div id="listOne" onclick="listOneClick(${status.index})" style="width: 90%;float: left;">
							<font><b>${fklist.fname}</b></font><br>
							<font size="2">${fklist.calories} kcal, ${fklist.fweight} g</font>
							
							<input type="hidden" value="${fklist.fnum}" class="li${status.index}" name="fknum">
							<input type="hidden" value="${fklist.fname}" class="li${status.index}" name="fname">
							<input type="hidden" value="${fklist.fweight}" class="li${status.index}" name="fweight">
							<input type="hidden" value="${fklist.calories}" class="li${status.index}" name="calories">
							<input type="hidden" value="${fklist.carbohydrate}" class="li${status.index}" name="carbohydrate">
							<input type="hidden" value="${fklist.protein}" class="li${status.index}" name="protein">
							<input type="hidden" value="${fklist.fat}" class="li${status.index}" name="fat">
							<input type="hidden" value="${fklist.sugar}" class="li${status.index}" name="sugar">
							<input type="hidden" value="${fklist.sodium}" class="li${status.index}" name="sodium">
							<hr>
						</div>
						<div style="width: 5%;float: left;">
							<a href="javascript:delMark(${fklist.fnum})">
								<i class="ri-delete-bin-6-fill" style="color: gray; margin-right: 5%;"></i>
							</a>
						</div>
					</form>
					</div><!-- row -->
					
				</c:forEach>
			</c:if>
		</div>
	</div>
</body>
							

<%@ include file="../common/adminBootBottom.jsp" %>