<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Event Edit Pop</title>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css"
	rel="stylesheet">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<!-- 한국어 다국어 파일 추가 -->
<link rel="stylesheet" href="/css/adminMenu.css">
<script type="text/javascript" src="/js/adminMenu.js"></script>
<style>
#event_Box {
	width: 950px;
}
</style>

</head>
<body>
	<div id="event_Box">
		<h2>이벤트 수정</h2>
		<hr>
		
		<form action="editEvent" method="post" enctype="multipart/form-data">
			<c:forEach items="${event}" var="event">
				<div>
					<label>이벤트 번호</label>
					<input type="text" name="eventNo" style=" border: none;" value="${event.eventNo }" readonly>
				</div>
				<div>
					<label>이벤트 제목</label> <input type="text" name="title"
						style="width: 820px; height: 30px;" value="${event.title }">
				</div>
				<div>
					<label>이벤트 메인 파일</label> <input type="file" name="eventFileName" value="${event.fileName }">
				</div>
				<div>
					<label>이벤트 진행 날짜</label> <input type="date" name="startDate"
						style="margin-left: 60px; width: 300px; height: 30px; text-align: center;" value="${event.startDate }">
					&nbsp;&nbsp; ~ &nbsp;&nbsp; <input type="date" name="endDate"
						style="width: 300px; height: 30px; text-align: center;" value="${event.endDate }">
				</div>
				<div>
					<label>이벤트 내용</label>
					<textarea id="summernote" name="contents" style="width: 900px;" value="${event.contents }"></textarea>
					<!-- content라는 이름으로 내용을 전송하도록 함 -->
				</div>
			</c:forEach>
			<button type="submit">수정</button>
		</form>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							$('#summernote')
									.summernote(
											{
												width : 900, // 에디터 너비
												height : 500, // 에디터 높이
												minHeight : null, // 최소 높이
												maxHeight : null, // 최대 높이
												focus : true, // 에디터 로딩 후 포커스를 맞출지 여부
												lang : 'ko-KR', // 한글 설정
												placeholder : '이벤트 내용을 입력해주세요!', //placeholder 설정

												toolbar : [
														[ 'style', [ 'style' ] ],
														[ 'color', [ 'color' ] ],
														[
																'font',
																[
																		'bold',
																		'underline',
																		'clear' ] ],
														[
																'para',
																[ 'ul', 'ol',
																		'paragraph' ] ],
														[ 'table', [ 'table' ] ],
														[
																'insert',
																[
																		'link',
																		'picture',
																		'video' ] ],
														[
																'view',
																[
																		'fullscreen',
																		'codeview',
																		'help' ] ], ]
											/* 
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