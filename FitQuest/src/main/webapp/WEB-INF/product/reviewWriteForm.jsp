<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/basicCSS.css?after"/>
<%@ include file="../common/top.jsp" %>
<style type = "text/css">
	h2{
		font-weight:normal !important;
		color: #444444 !important;
	}
	.rating {
    float:left;
	}
	.rating:not(:checked) > input {
	    position:absolute;
	    top:-9999px;
	    clip:rect(0,0,0,0);
	}
	
	.rating:not(:checked) > label {
	    float:right;
	    width:1em;
	    padding:0 .1em;
	    overflow:hidden;
	    white-space:nowrap;
	    cursor:pointer;
	    font-size:200%;
	    line-height:1.2;
	    color:#ddd;
	    text-shadow:1px 1px #bbb, 2px 2px #666, .1em .1em .2em rgba(0,0,0,.5);
	}
	
	.rating:not(:checked) > label:before {
	    content: '★ ';
	}
	
	.rating > input:checked ~ label {
	    color: #FAC710;
	    text-shadow:1px 1px #c60, 2px 2px #940, .1em .1em .2em rgba(0,0,0,.5);
	}
	
	.rating:not(:checked) > label:hover,
	.rating:not(:checked) > label:hover ~ label {
	    color: gold;
	    text-shadow:1px 1px goldenrod, 2px 2px #B57340, .1em .1em .2em rgba(0,0,0,.5);
	}
	
	.rating > input:checked + label:hover,
	.rating > input:checked + label:hover ~ label,
	.rating > input:checked ~ label:hover,
	.rating > input:checked ~ label:hover ~ label,
	.rating > label:hover ~ input:checked ~ label {
	    color: #ea0;
	    text-shadow:1px 1px goldenrod, 2px 2px #B57340, .1em .1em .2em rgba(0,0,0,.5);
	}
	
	.rating > label:active {
	    position:relative;
	    top:2px;
	    left:2px;
	}
	.form-group{
		margin-bottom: 20px;
	}
	.err{
		color:red;
		font-weight:bold;
		font-size: 10px;
	}
	.header{
			background-color: white !important;
			padding-bottom: 50px;
	}
	.title-container{
		margin-bottom: 0 !important; 
	}
	.btn{
		margin: 2.5px;
	}
</style>
<script>
	function checkRating(){
		if(reviewBean.rating.value == ""){
			alert("리뷰 별점 선택하세요.");
			return false;
		}
	}
</script>
<body style="background-color : #FEF9E7;">
	<div class="title-container">
		<div class="title-text">리뷰 작성</div>
	</div>
<section id="blog" class="blog">
	<div class="container" data-aos="fade-up">

        <div class="row" style = "justify-contents: center;">
	      <div class ="col-lg-1"></div>
	      <div class="col-lg-10 entries" style = "padding: 0px;background-color: white;">
	      	<article class="entry entry-single" style = "margin:0px;">
   			 <div class="col-lg-12">
   			  <div class="col-lg-12 col-sm-12 hero-feature" style = " display: flex; justify-content: space-between;">
	        	<span style = "color: black; font-weight: bold;font-size:17px;">리뷰 대상 : ${tmemberBean.name } 선생님</span>
        		<span style = "margin-left: 60px; font-size:17px;">${tmemberBean.name } 선생님에게 <b>${trainerBean.activity }수업 ${reserveCount }번</b> 받았습니다.</span>
   			  </div>
	      	 </div>
	      	 </article>
	      </div>
	      <div class ="col-lg-1"></div>
	      
	      <div class ="col-lg-1"></div>  	
          <div class="col-lg-10 entries" style = "padding: 0px;background-color: white; margin-top:30px;">
   			<article class="entry entry-single" style = "margin:0px;">
   			 <div class="col-lg-12">
			        <div class="col-lg-12 col-sm-12 hero-feature">
			        
			        	<div class="reply-form">
		                <p>*모든 내용을 작성하세요</p>
		                <form:form commandName = "reviewBean" action="reviewWrite.pd" method = "post">
		                	<input type = "hidden" name = "mid" value = "${memberBean.id }">
		                	<input type = "hidden" name = "tid" value = "${trainerBean.id }">
		                	<input type = "hidden" name = "hasReview" value = "Y">
		                  <div class="row">
		                    <div class="col-md-6 form-group">
		                      <input name="id" type="text" class="form-control" value = "작성자 : ${memberBean.id } 회원님" disabled>
		                    </div> 
		                    <div class="col-md-6 form-group box" style="display:flex; justify-content:flex-end;">
		                    	<fieldset class="rating">
								    <input type="radio" id="star5" name="rating" value="5" 
								    <c:if test = "${reviewBean.rating eq 5 }">
								    checked
								    </c:if>
								    /><label for="star5">5 stars</label>
								    <input type="radio" id="star4" name="rating" value="4" 
								    <c:if test = "${reviewBean.rating eq 4 }">
								    checked
								    </c:if>
								    /><label for="star4">4 stars</label>
								    <input type="radio" id="star3" name="rating" value="3" 
								    <c:if test = "${reviewBean.rating eq 3 }">
								    checked
								    </c:if>
								    /><label for="star3">3 stars</label>
								    <input type="radio" id="star2" name="rating" value="2" 
								    <c:if test = "${reviewBean.rating eq 1 }">
								    checked
								    </c:if>
								    /><label for="star2">2 stars</label>
								    <input type="radio" id="star1" name="rating" value="1" 
								    <c:if test = "${reviewBean.rating eq 1 }">
								    checked
								    </c:if>
								    /><label for="star1">1 star</label>
			                    	<span style = "font-size: 20px;">별점 선택 : </span>
								</fieldset>
							</div>
		                  </div>
		                  <div class="row">
		                    <div class="col form-group">
		                      <input type="text" name = "rtitle" class="form-control" placeholder="제목 입력하세요">
							  <form:errors cssClass="err" path = "rtitle"/>
		                    </div>
		                  </div>
		                  <div class="row">
		                    <div class="col form-group">
		                      <textarea name="rcontent" class="form-control" placeholder="리뷰 내용입력하세요" rows="5" cols="50"></textarea>
							  <form:errors cssClass="err" path = "rcontent"/>
		                    </div>
		                  </div>
		                  <div style="display:flex; justify-content: center !important;">
			                  <button type="submit" class="btn btn-warning" onClick = "return checkRating()">리뷰 남기기</button>
			                  <button type="reset" class="btn btn-secondary">초기화</button>
		                  </div>
		                </form:form>
		              </div>
			        </div>
			 </div>
			</article>
		 </div>
		 <div class ="col-lg-1"></div>
		</div>
	</div>
</section>
</body>	        
			        
<%@ include file="../common/bottom.jsp" %>