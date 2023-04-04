<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세 - 시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/eventDetailView.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
	<div class="topWrap">
		<div class="title">[귀멸의 칼날] IMAX 포스터</div>
		<div class="date">기간: 2023.03.02 ~ 2023.03.08</div>
	</div>
	<div class="imageWrap">
		<img src="/images/eventDetail2.jpeg">
	</div>
	<div class="goListBtn">목록으로</div>
</div>
<%@ include file="footer.jsp" %>
<script>
	$(".goListBtn").on("click", function(){
		const id = $("#id").val();
		location.href = "/user/myStamp?id=" + id;
	});
</script>
</body>
</html>