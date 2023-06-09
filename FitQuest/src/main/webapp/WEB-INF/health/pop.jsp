<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<link href="<%=request.getContextPath()%>/resources/NiceAdmin/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css" media="print">
  .noprint{ display:none; }
</style>


<c:if test="${param.phimage == 'undefined'}">
	등록된 인바디 파일이 없습니다
</c:if>

<c:if test="${param.phimage != 'undefined'}">
	<div class="noprint">
		<input type="button" value="인쇄하기" onclick="window.print()" class="btn btn-warning scrollto btn-sm" style="float: right;margin-right: 10;margin-top: 10;">
	</div>
	<img style="width: 470;margin:auto;" src="<%=request.getContextPath()%>/resources/Image/InbodyImage/${param.phimage}">
</c:if>