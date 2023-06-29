<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>
<%@ include file="../common/myTrainerTop.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>
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
	section{
		padding: 0px !important;
	}
	.pageTitle{
		margin-top: 50px;
		margin-bottom: 50px;
	}
	.header{
		background-color: white !important;
		padding-bottom: 50px;
	}
	#submit{ 
		padding: 11px 18px !important;
	}
</style>
<body style="background-color : #FEF9E7;">
    <section class="section">
	
    <div class="pagetitle">
      <h1><i class="bi bi-list toggle-sidebar-btn"></i> 리뷰관리</h1>
    </div><!-- End Page Title -->

      <div class="row">
      <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            	<form action = "trainerReviewList.mb" name = "myform" style = "display:flex; align-items:center; justify-content: space-between; margin-bottom: 0px;">
            		<div class = "col-lg-6">
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="1" id="flexCheckDefault" onClick = "sendForm()"
				          <c:if test = "${ordering eq '1' }">
				          checked
				          </c:if>
				          checked
				          >
						  <label class="form-check-label btn" for="flexCheckDefault">
						    기본순
						  </label>
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="2" id="flexCheckDefault2" onClick = "sendForm()"
				          <c:if test = "${ordering eq '2'}">
				          checked
				          </c:if>
				          >
						  <label class="form-check-label btn" for="flexCheckDefault2">
						    별점 높은순
						  </label>
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="3" id="flexCheckDefault3" onClick = "sendForm()"
				          <c:if test = "${ordering eq '3' }">
				          checked
				          </c:if>
				          >
						  <label class="form-check-label btn" for="flexCheckDefault3">
						    별점 낮은순
						  </label>
            			 <input class="form-check-input btn-check" type="radio" name = "ordering" value="4" id="flexCheckDefault4" onClick = "sendForm()"
				          <c:if test = "${ordering eq '4' }">
				          checked
				          </c:if>
				          >
						  <label class="form-check-label btn" for="flexCheckDefault4">
						    최신순
						  </label>
            		</div>
            		<div class = "col-lg-6" align="right" style = "vertical-align:center;">
            		<select name = "whatColumn" class="search-choose">
            			<option value = "">선택</option>
            			<option value = "tname"
            			<c:if test = "${whatColumn eq 'tname' }">
				          selected
				          </c:if>
            			>회원 이름</option>
            			<option value = "rtitle"
            			<c:if test = "${whatColumn eq 'rtitle' }">
				          selected
				          </c:if>
            			>리뷰 제목</option>
            		</select>
            		<input type = "text" name = "keyword" value = 
            		<c:if test = "${keyword != 'null' }">	
            		"${ keyword }"
            		</c:if>
            		class="search-box">
            		<button type="submit" id="submit" class="btn btn-warning" style = "background-color: #FAC710; border: none; margin-bottom:3px;">
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
              <c:if test = "${hasReview eq 'Y' }">
             	 <h5 class="card-title">
	             	<fmt:formatNumber var = "rating1" value="${avgScore }" type="number" pattern="#.0"/>
					<fmt:formatNumber var = "rating" value="${avgScore}" type="number" pattern="#"/>
	                평균 별점 : 
					<c:set var = "starCount" value = "0"/>
					<c:forEach begin = "1" end = "${rating }" step="1" var="i">
	                  <i class="bi bi-star-fill" style = "color: #FAC710;"></i>
	                  <c:set var = "starCount" value = "${starCount + 1 }"/>
					</c:forEach>
					<c:forEach begin = "1" end = "${5 - starCount }" step = "1" var = "j">
					<i class = "bi bi-star" style = "color: #FAC710;"></i>
					</c:forEach>
					<span  style = "color: #FAC710; font-size:20px;">${rating1 }</span>
             	 </h5>
             		 <table class="table">
                <thead>
                  <tr>
                    <th scope="col">리뷰 작성 날짜</th>
                    <th scope="col">리뷰 작성자 아이디</th>
                    <th scope="col">리뷰 제목</th>
                    <th scope="col">리뷰 별점</th>
                    <th scope="col">리뷰 내용보기</th>
                  </tr>
                </thead>
                <tbody>
                	<c:forEach var = "review" items = "${ rList }">
                	<tr>
                		<fmt:parseDate value = "${review.rdate }" pattern = "yyyy-MM-dd" var = "date"/>
                    	<fmt:formatDate value = "${date }" var = "date" pattern = "yyyy-MM-dd"/>
	                	<td>${date}</td>
	                	<td>${review.name } (${review.mid })</td>
	                	<td>${review.rtitle }</td>
	                	<td>${review.rating }</td>
	                	<td><a href = "reviewDetail.mb?renum=${review.renum }&mid=${review.mid}"><i class="bi bi-blockquote-left"></i>내용보기</a></td>
                	</tr>
                	</c:forEach>
             	</tbody>
              </table>
              </c:if>
			  <c:if test = "${hasReview eq 'N' }">
			  	<h5 class="card-title">
			  		아직 작성된 리뷰 없습니다.
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
</body>
<%@ include file="../common/myTrainerBot.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
<%@ include file="../common/bottom.jsp"%>