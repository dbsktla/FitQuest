<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>


<c:if test="${param.phimage == 'undefined'}">
	등록된 인바디 파일이 없습니다
</c:if>

<c:if test="${param.phimage != 'undefined'}">
	<img src="<%=request.getContextPath()%>/resources/Image/InbodyImage/${param.phimage}">
</c:if>