<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myAdminTop.jsp"%>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
	function sendForm(){
		document.myform.submit();
	}
</script>
<style>
	section{
		padding: 0px !important;
		}
	.pageTitle{
		margin-top: 50px;
		margin-bottom: 50px;
	}
</style>
 <section class="section">
	
    <div class="pagetitle">
      <h1>리뷰삭제 신청 관리</h1>
    </div><!-- End Page Title -->

      <div class="row">
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            	<form action = "reviewDeleteRequestList.mb" name = "myform" style = "display:flex; align-items:center; justify-content: space-between; margin-bottom: 0px;">
            		<div class = "col-lg-6">
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="1" id="flexCheckDefault" onClick = "sendForm()"
				          <c:if test = "${ordering eq '1' }">
				          checked
				          </c:if>
				          checked
				          >
						  <label class="form-check-label btn" for="flexCheckDefault">
						    전체
						  </label>
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="2" id="flexCheckDefault2" onClick = "sendForm()"
				          <c:if test = "${ordering eq '2'}">
				          checked
				          </c:if>
				          >
						  <label class="form-check-label btn" for="flexCheckDefault2">
						    거절된 신청
						  </label>
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="3" id="flexCheckDefault3" onClick = "sendForm()"
				          <c:if test = "${ordering eq '3' }">
				          checked
				          </c:if>
				          >
						  <label class="form-check-label btn" for="flexCheckDefault3">
						    미확인 신청
						  </label>
            		</div>
            		<div class = "col-lg-6" align="right" style = "vertical-align:center;">
            		<select name = "whatColumn">
            			<option value = "">선택</option>
            			<option value = "tname"
            			<c:if test = "${whatColumn eq 'tname' }">
				          selected
				          </c:if>
            			>트레이너 이름</option>
            			<option value = "nickname"
            			<c:if test = "${whatColumn eq 'nickname' }">
				          selected
				          </c:if>
            			>트레이너 별명</option>
            		</select>
            		<input type = "text" name = "keyword" value = 
            		<c:if test = "${keyword != 'null' }">	
            		"${ keyword }"
            		</c:if>
            		>
            		<button type="submit" class="btn btn-primary" style = "background-color: #FAC710; border-color: black; margin-bottom:3px;">
					  <i class="bi bi-search"></i>
					</button>
            		</div>
            	</form>
            </div>
          </div>
      </div>
        <div class="col-lg-12">
          <div class="card" style = "height: 100%; min-height: 350px;">
            <div class="card-body">
               <c:if test = "${not empty rList }">
              	 <h5 class="card-title">
             	 </h5>
             	 <table class="table">
                <thead>
                  <tr>
                    <th scope="col">리뷰 작성자 아이디</th>
                    <th scope="col">트레이너 아이디</th>
                    <th scope="col">리뷰 작성날짜</th>
                    <th scope="col">리뷰 제목</th>
                    <th scope="col">확인 상태</th>
                    <th scope="col">자세히 보기</th>
                  </tr>
                </thead>
                <tbody>
                	<c:forEach var = "review" items = "${ rList }">
                	<tr>
                		<fmt:parseDate value = "${review.rdate }" pattern = "yyyy-MM-dd" var = "date"/>
                    	<fmt:formatDate value = "${date }" var = "date" pattern = "yyyy-MM-dd"/>
	                	<td>${review.mid}</td>
	                	<td>${review.tid }</td>
	                	<td>${review.rdate}</td>
	                	<td>${review.rtitle }</td>
	                	<c:if test = "${review.report eq 'Y'}">
	                	<td>미확인</td>
	                	</c:if>
	                	<c:if test = "${review.report eq 'approve'}">
	                	<td>수락(삭제)</td>
	                	</c:if>
	                	<c:if test = "${review.report eq 'unapprove'}">
	                	<td>거절</td>
	                	</c:if>
	                	<td><a href = "reviewDeleteRequestDetail.mb?renum=${review.renum }"><i class="bi bi-blockquote-left"></i>내용보기</a></td>
                	</tr>
                	</c:forEach>
             	</tbody>
              </table>
              </c:if>
			    <c:if test = "${empty rList}">
			  	<h5 class="card-title">
		  		해당되는 신청이 없습니다.
			  	</h5>
              </c:if>
            </div>
            <div align = "center" style= "margin-bottom:12px;">
	            ${pageInfo.pagingHtml }
            </div>
          </div>
        </div>
      </div>
    </section>
<%@ include file="../common/myAdminBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>