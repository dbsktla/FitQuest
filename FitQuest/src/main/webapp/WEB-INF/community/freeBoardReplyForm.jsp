<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<%@ include file="../common/adminBootTop.jsp"%>

<style>
	.err{
		color : #E04848;
		font-size: 10pt;
	}
</style>

<script type="text/javascript" src="resources/js/jquery.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	// 글자 바이트 체크
	function validateMaxByte(size){	
		$("#divTest").keyup(function (e){
		    var str = document.getElementsByClassName('ql-editor')[0].innerText;
		    	$(this).val();	    
		    var str_len = str.length;
		    
		    var rbyte = 0;
		    var rlen = 0;
		    var one_char = "";
		    
		    for(var i=0; i<str_len; i++){
		    	one_char = str.charAt(i);
		    	if(escape(one_char).length > 4){
		    	    rbyte += 3;                                         //한글3Byte
		    	}else{
		    	    rbyte++;                                            //영문 등 나머지 1Byte
		    	}

		    	if(rbyte <= size){
		    	    rlen = i+1;                                          //return할 문자열 갯수
		    	}
		    }
		    
		    if(rbyte > size){
		    	alert("최대 "+size+"byte까지 입력 가능합니다.");
		    	 $(this).val(str.substr(0,rlen));
		    }
		    document.getElementById("checkByte").innerText = rbyte;

		});
	}

	validateMaxByte(3000);	// maxbyte 체크
	
	$('#sub').click(function(){
		var bcontent = document.getElementsByClassName('ql-editor');
		var bcontentHTML = bcontent[0].innerHTML;
		var bcontentText = bcontent[0].innerText;
		var divTest = document.getElementById('divTest');
		
		$('#bcontent').attr('value',bcontentHTML);
		var test = $('#bcontent').val();
	});

});
</script>

<body style="background-color: #FEF9E7;">
	<main>
		<div class="card" style="width: 55%; margin: auto; text-align: center;">

			<div class="card-body">
				<h2 align="center" class="card-title">답글 작성</h2>

				<form:form commandName="boardBean" method="post" class="row g-3"
					action="freeBoardReply.co">
					<input type="hidden" name="bref" value="${ param.bref }">
					<input type="hidden" name="brestep" value="${ param.brestep }">
					<input type="hidden" name="brelevel" value="${ param.brelevel }">
					<input type="hidden" name="bcategory" value="${ param.bcategory }">
					<input type="hidden" name="bnum" value="${ param.bnum }">
					<div class="col-md-9" align="left">
						<label for="bsubject" class="form-label">제목</label> <input
							type="text" name="bsubject" class="form-control" id="bsubject" value="${ boardBean.bsubject }">
							 <form:errors cssClass="err" path="bsubject" />
					</div>
					<div class="col-md-3" align="left">
						<label for="bcategory" class="form-label">카테고리</label> 
						<input type="text" name="bcategory" class="form-control" value="${ param.bcategory }" disabled>
						<form:errors cssClass="err" path="bcategory" />
					</div>

					<div class="quill-editor-default" id="divTest">
						${ boardBean.bcontent }
					</div>
					<div style="text-align: right;">
						<span id="checkByte">0</span>/3000bytes
					</div>
					<input type="hidden" name="bcontent" id="bcontent">
					<div class="err"></div>
					<div class="text-center">
						<button type="submit" id="sub" class="btn btn-warning btn-sm">작성하기</button>
					</div>
				</form:form>
			</div>

			</div>	
	</main>
	
</body>	
	
<%@ include file="../common/bottom.jsp"%>
<%@ include file="../common/adminBootBottom.jsp"%>
