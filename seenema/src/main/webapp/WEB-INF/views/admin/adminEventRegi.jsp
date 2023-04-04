<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Event Regi Form</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
    <script src="//cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script> <!-- 한국어 다국어 파일 추가 -->
<link rel="stylesheet" href="/css/adminMenu.css">
<script type="text/javascript" src="/js/adminMenu.js"></script>

<style>
.note-editor * {
  box-sizing: content-box;
}
.note-toolbar button {
  float: none;
}
.note-editor .btn-toolbar {
  margin-bottom: 0;
}
.note-editor .note-toolbar {
  border-bottom: none;
}
.note-editor .note-statusbar {
  display: none;
}
</style>

</head>
<body>
	<div class="gamut">
<!-- 파일을 넣으니깐 썸머노트 실행이 안되서 코드로 삽입 -->
		 <div class="header">
		<div class="logo"><img src="/images/logo3.png" style="width: 200px; height: 100px;"></div>
		<nav>
			<ul class="mainmenu">
				<li><a href="adminPage">관리자 메인</a>
					<ul class="submenu"></ul></li>
				<li>영화 관리
					<ul class="submenu">
						<li><a href="movieReg">영화등록</a></li>
						<li><a href="movieList">영화 목록 및 괸리</a></li>
					</ul>
				</li>
				<li>영화관 관리
					<ul class="submenu">
						<li><a href="theaterReg">영화관 등록</a></li>
						<li><a href="theaterList">영화관 목록 및 관리</a></li>
					</ul>
				</li>
				<li><a href="adminReservationView">예매내역 관리</a>
				<ul class="submenu"></ul>
				</li>
				<li>상품 관리
					<ul class="submenu">
						<li><a href="productReg">상품 등록</a></li>
						<li><a href="productList">상품 목록 및 관리</a></li>
					</ul>
				</li>
				<li>매출 관리
					<ul class="submenu">			
						<li><a href="movieSalesPage">영화 및 영화관</a></li>
						<li><a href="adminProductSalesView">상품</a></li>
					</ul>
				</li>
				<li>이벤트
					<ul class="submenu">			
						<li><a href="adminEventRegi">이벤트 등록</a></li>
						<li><a href="#">이벤트 목록 및 관리</a></li>
					</ul>
				</li>
				<li><a href="MemberMGMT">회원관리 관리</a></li>
				<li><a href="qnaView">Q&A 관리</a></li>
				<li><a href="adNoticeView">공지사항 관리</a></li>
				<li><a href="adminReplyView">한줄평 관리</a></li>
			</ul>
		</nav>
	</div>
<!-- 파일을 넣으니깐 썸머노트 실행이 안되서 코드로 삽입 -->

		<!--상단바-->
		<!--  <div class="top_bar">
            상단바
        </div> -->
		<div class="main_view">

			<div id="doToday_menu">
				<div id="doToday_title" style="width: 970px; height: 30px;">
					<p style="margin: 30px 0 0 40px;">이벤트 등록</p>
				</div>

			</div>
			<div class="easy_menu">
				<div id="event_Box">
					<form action="regiEvent" method="post" enctype="multipart/form-data">
						<div>
						<label>이벤트 제목</label>
						<input type="text" name="title" style="width:820px; height: 30px;">
						</div>
						<div>
						<label>이벤트 메인 파일</label>
						<input type="file" name="eventFileName">
						</div>
						<div>
						<label>이벤트 진행 날짜</label>
						<input type="date" name="startDate" style="margin-left:60px; width:300px; height: 30px; text-align: center;">
									&nbsp;&nbsp; ~ &nbsp;&nbsp; <input type="date" name="endDate" style="width:300px; height: 30px; text-align: center;" >
						</div>
							    <div>
							    <label>이벤트 내용</label>
							    <textarea id="summernote" name="contents"  style="width: 900px;"></textarea> <!-- content라는 이름으로 내용을 전송하도록 함 -->
						</div>
						<button type="submit">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	 <script>
	 $(document).ready(function() {
	     $('#summernote').summernote({
	       width: 900, // 에디터 너비
	       height: 300, // 에디터 높이
	       minHeight: null, // 최소 높이
	       maxHeight: null, // 최대 높이
	       focus: true, // 에디터 로딩 후 포커스를 맞출지 여부
	       lang: 'ko-KR', // 한글 설정
	       placeholder: '이벤트 내용을 입력해주세요!', //placeholder 설정
	       
	       toolbar: [
	           ['font', ['bold', 'underline', 'clear']],
	           ['insert', ['link', 'picture', 'video']],
	           ['view', ['fullscreen', 'codeview', 'help']],
	           ]
	     /* ['style', ['style']],
         ['font', ['bold', 'underline', 'clear']],
         ['color', ['color']],
         ['para', ['ul', 'ol', 'paragraph']],
         ['table', ['table']],
         ['insert', ['link', 'picture', 'video']],
         ['view', ['fullscreen', 'codeview', 'help']] */
	     });
	   });
	 </script>
</body>
</html>