<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>
<script type = "text/javascript" src = "<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script type = "text/javascript">
	function submitCheck(){
		var answer = confirm("리뷰 신고하시겠습니까?");
		if(answer == false){
			return false;
		}
	}
</script>
<style>
section{
	padding: 0px !important;
}
.btn:checked{
	background-color: #ffc107 !important;
}
.btn:hover {
		background-color:#FAC710 !important;
	}
.btn-check{
	border-radius:20px !important;
}
.btn-check + &:hover {
    // override for the checkbox/radio buttons
    background-color: #ffc107 !important;
  }
.row{
	margin-bottom:25px;
}
	.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
</style>
<body style="background-color : #FEF9E7;">
    <section class="section"  style = "height: 72%;">
	
    <div class="pagetitle" style = "margin-top:40px;">
      <h1>리뷰 내용보기</h1>
    </div><!-- End Page Title -->

      <div class="row" style = "margin-top:40px;">
      
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
             	 <h5 class="card-title">
             	 <fmt:formatNumber var = "rating1" value="${reviewBean.rating }" type="number" pattern="#.0"/>
					<fmt:formatNumber var = "rating" value="${reviewBean.rating}" type="number" pattern="#"/>
	                리뷰 별점 : 
					<c:set var = "starCount" value = "0"/>
					<c:forEach begin = "1" end = "${rating }" step="1" var="i">
	                  <i class="bi bi-star-fill"></i>
	                  <c:set var = "starCount" value = "${starCount + 1 }"/>
					</c:forEach>
					<c:forEach begin = "1" end = "${5 - starCount }" step = "1" var = "j">
					<i class = "bi bi-star"></i>
					</c:forEach>
					${rating1 }
             	 </h5>
             	 <div class="reply-form">
                <form action="reportReview.mb" name = "myform">
                <input type = "hidden" value = "${reviewBean.renum }" name = "renum">
                  <div class="row">
                    <div class="col-md-3 form-group">
                      <input name="email" type="text" class="form-control" value = "작성자:  ${memberBean.name } (${memberBean.id})회원님" disabled>
                    </div>
                    <div class="col-md-3 form-group">
                      <fmt:parseDate value = "${reviewBean.rdate }" pattern = "yyyy-MM-dd" var = "date"/>
                    	<fmt:formatDate value = "${date }" var = "date" pattern = "yyyy-MM-dd"/>
                      <input name="email" type="text" class="form-control" value = "작성날짜:  ${date}" disabled>
                    </div>
                    <div class="col-md-6 form-group">
                      <input name="name" type="text" class="form-control" value = "제목:  ${reviewBean.rtitle }" disabled>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col form-group">
                      <textarea name="comment" class="form-control" disabled>${reviewBean.rcontent }</textarea>
                    </div>
                  </div>
                  <button type="submit" class="btn btn-danger" onclick = "return submitCheck()">신고하기</button>
                  <button type="button" class="btn btn-warning" onClick = "location.href='trainerReviewList.mb'">리뷰 목록</button>
			      <p>*악의적인 리뷰인 경우에만 신고하세요<p>
                </form>
				
              </div>
            </div>
          </div>
      </div>
      </div>
      
    </section>
<body style="background-color : #FEF9E7;">
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>