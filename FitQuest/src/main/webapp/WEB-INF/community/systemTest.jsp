<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp" %>

<!-- <body style="background-color: white;"> -->
<!-- 	<table width="70%" style="margin: 100 auto;"> -->
<!-- 		<tr> -->
<!-- 			<td height="100" align="center"> -->
<!-- 				<h1><i class="bi bi-person"></i></h1> -->
<!-- 				비회원 -->
<!-- 			</td> -->
<!-- 			<td> -->
<!-- 				<h1><i class="bi bi-arrow-right"></i></h1> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">메인</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>메인페이지</td></tr> -->
<!-- 					<tr><td>ABOUT US</td></tr> -->
<!-- 					<tr><td>게시판</td></tr> -->
<!-- 					<tr><td>트레이너 조회</td></tr> -->
<!-- 					<tr><td>로그인</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr valign="top"> -->
<!-- 			<td height="100" align="center" valign="middle"> -->
<!-- 				<h1><i class="bi bi-person-check"></i></h1> -->
<!-- 				회원 -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">PT예약</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>트레이너 목록 조회</td></tr> -->
<!-- 					<tr><td>장바구니</td></tr> -->
<!-- 					<tr><td>리뷰 작성</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">운동 관리</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>운동 내역</td></tr> -->
<!-- 					<tr><td>캘린더</td></tr> -->
<!-- 					<tr><td>목표 설정</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">식단 관리</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>식단 정보</td></tr> -->
<!-- 					<tr><td>영양 정보</td></tr> -->
<!-- 					<tr><td>북마크</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">신체 관리</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>신체 정보</td></tr> -->
<!-- 					<tr><td>BMI</td></tr> -->
<!-- 					<tr><td>인바디</td></tr> -->
<!-- 					<tr><td>신체 변화 그래프</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">자유게시판</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>게시글 작성</td></tr> -->
<!-- 					<tr><td>답글 작성</td></tr> -->
<!-- 					<tr><td>댓글 작성</td></tr> -->
<!-- 					<tr><td>게시글/댓글 신고</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">문의/알림</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>1:1 문의</td></tr> -->
<!-- 					<tr><td>알림</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr valign="top"> -->
<!-- 			<td height="100" align="center" valign="middle"> -->
<!-- 				<h1><i class="bi bi-people"></i></h1> -->
<!-- 				트레이너 -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">회원 운동 관리</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>회원 조회</td></tr> -->
<!-- 					<tr><td>회원 별 운동 조회</td></tr> -->
<!-- 					<tr><td>운동 추가</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">PT예약</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>예약 가능 시간 설정</td></tr> -->
<!-- 					<tr><td>예약 신청 내역 확인</td></tr> -->
<!-- 					<tr><td>예약 승인/거절</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">상품 관리</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>상품 등록</td></tr> -->
<!-- 					<tr><td>회원 수 그래프</td></tr> -->
<!-- 					<tr><td>수익 계산</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">트레이너 정보</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>트레이너 정보 작성</td></tr> -->
<!-- 					<tr><td>리뷰 조회</td></tr> -->
<!-- 					<tr><td>리뷰 삭제 요청</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">건강 정보 게시판</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>게시글 작성</td></tr> -->
<!-- 					<tr><td>댓글 작성</td></tr> -->
<!-- 					<tr><td>게시글/댓글 신고</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<td height="100" align="center"> -->
<!-- 				<h1><i class="ri-admin-line"></i></h1> -->
<!-- 				관리자 -->
<!-- 			</td> -->
<!-- 			<td width="15%" height="20"> -->
<!-- 				<table class="table table-hover" border="1" style="text-align: center;"> -->
<!-- 					<tr> -->
<!-- 						<th style="background-color: #FAC710;">관리자</th> -->
<!-- 					</tr> -->
<!-- 					<tr><td>리뷰 삭제 요청</td></tr> -->
<!-- 					<tr><td>게시글/댓글 신고</td></tr> -->
<!-- 					<tr><td>1:1 문의</td></tr> -->
<!-- 				</table> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
<!-- 	<i class="ri-admin-line"></i> 관리자 -->
<!-- 	<i class="bi bi-person"></i>비회원 -->
<!-- 	<i class="bi bi-person-check"></i>회원 -->
<!-- 	<i class="bi bi-people"></i>트레이너 -->
<!-- </body> -->


<body style="background-color: white;">
	<table width="70%" style="margin: 100 auto;">
		<tr>
			<td height="100" align="center">
				<h1><i class="bi bi-person"></i></h1>
				비회원
			</td>
			<td height="100" align="center" valign="middle">
				<h1><i class="bi bi-person-check"></i></h1>
				회원
			</td>
			<td height="100" align="center" valign="middle">
				<h1><i class="bi bi-people"></i></h1>
				트레이너
			</td>
			<td height="100" align="center">
				<h1><i class="ri-admin-line"></i></h1>
				관리자
			</td>
		</tr>
		<tr valign="top">
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">메인</th>
					</tr>
					<tr><td>메인페이지</td></tr>
					<tr><td>ABOUT US</td></tr>
					<tr><td>게시판</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">PT예약</th>
					</tr>
					<tr><td>예약 신청</td></tr>
					<tr><td>운동 스케줄 관리</td></tr>
					<tr><td>리뷰 작성</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">PT예약</th>
					</tr>
					<tr><td>예약 가능 시간 설정</td></tr>
					<tr><td>예약 신청 내역 확인</td></tr>
					<tr><td>예약 승인/거절</td></tr>
				</table>
			</td>
			
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">관리자</th>
					</tr>
					<tr><td>리뷰 삭제 요청</td></tr>
					<tr><td>게시글/댓글 신고</td></tr>
					<tr><td>1:1 문의</td></tr>
				</table>
			</td>
	
		</tr>
		<tr valign="top">
			<td>
				<table border="1" class="table table-hover" style="text-align: center;">
					<tr><td>트레이너 조회</td></tr>
					<tr><td>로그인</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">상품 구매</th>
					</tr>
					<tr><td>트레이너 조회</td></tr>
					<tr><td>장바구니 및 결제</td></tr>
					<tr><td>리뷰작성</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">상품 관리</th>
					</tr>
					<tr><td>상품 등록</td></tr>
					<tr><td>회원 수 그래프</td></tr>
					<tr><td>수익 계산</td></tr>
				</table>
			</td>
			<td></td>
			
		</tr>
		
		<tr valign="top">
			<td></td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">운동 관리</th>
					</tr>
					<tr><td>운동 내역</td></tr>
					<tr><td>캘린더</td></tr>
					<tr><td>목표 설정</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">회원 운동 관리</th>
					</tr>
					<tr><td>회원 목록 조회</td></tr>
					<tr><td>회원 별 운동,신체 관리</td></tr>
					<tr><td>회원 별 식단 관리</td></tr>
				</table>
			</td>
			<td></td>
			
		</tr>
		
		<tr valign="top">
			<td></td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">식단 관리</th>
					</tr>
					<tr><td>식단 정보</td></tr>
					<tr><td>영양 정보</td></tr>
					<tr><td>북마크</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">트레이너 정보</th>
					</tr>
					<tr><td>트레이너 정보 작성</td></tr>
					<tr><td>리뷰 조회</td></tr>
					<tr><td>리뷰 삭제 요청</td></tr>
				</table>
			</td>
			<td></td>
		</tr>
		<tr  valign="top">
			<td></td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">신체 관리</th>
					</tr>
					<tr><td>신체 정보</td></tr>
					<tr><td>BMI</td></tr>
					<tr><td>인바디</td></tr>
					<tr><td>신체 변화 그래프</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">건강 정보 게시판</th>
					</tr>
					<tr><td>게시글 작성</td></tr>
					<tr><td>댓글 작성</td></tr>
					<tr><td>게시글/댓글 신고</td></tr>
					<tr><td>게시글 스크랩</td></tr>
				</table>
			</td>
		</tr>
		<tr valign="top">
			<td></td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">자유게시판</th>
					</tr>
					<tr><td>게시글 작성</td></tr>
					<tr><td>답글 작성</td></tr>
					<tr><td>댓글 작성</td></tr>
					<tr><td>게시글/댓글 신고</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">자유게시판</th>
					</tr>
					<tr><td>게시글 작성</td></tr>
					<tr><td>답글 작성</td></tr>
					<tr><td>댓글 작성</td></tr>
					<tr><td>게시글/댓글 신고</td></tr>
				</table>
			</td>
			<td></td>
		</tr>
		<tr valign="top">
			<td></td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">문의/알림</th>
					</tr>
					<tr><td>1:1 관리자 문의</td></tr>
					<tr><td>트레이너-일반회원 문의</td></tr>
					<tr><td>알림</td></tr>
				</table>
			</td>
			<td width="15%" height="20">
				<table class="table table-hover" border="1" style="text-align: center;">
					<tr>
						<th style="background-color: #FAC710;">문의/알림</th>
					</tr>
					<tr><td>1:1 관리자 문의</td></tr>
					<tr><td>트레이너-일반회원 문의</td></tr>
					<tr><td>알림</td></tr>
				</table>
			</td>
			<td></td>
		</tr>
		
	</table>
	
			
</body>