<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 - 씨네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/myStamp.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
	<div class="myStampTitle">${member.name }님의 스탬프 적립 내역</div>
	<input type="hidden" class="stampCount" value="${member.stamp }">
	<div class="stampSection">
		<div class="stampWrap">
			<div class="firstLine">
				<!--  -->
			</div>
			<div class="secondLine">
				<!--  -->
			</div>
		</div>	
	</div>
	<div class="eventSectionTitle">EVENT ZONE</div>
	<div class="eventSection">
		<a href="/user/eventDetailView">
			<div class="box">
				<img class="thumbnail" src="/images/thumbnail2.jpeg">
				<div class="eventInfoTitle">[귀멸의 칼날] IMAX 포스터</div>
				<div class="eventInfoDate">기간: 2023.03.08 ~ 2023.03.31</div>
			</div>
		</a>
		<!-- <a href="#">
			<div class="box">
				<img class="thumbnail" src="/images/thumbnail1.jpeg">
				<div class="eventInfoTitle">[더 퍼스트 슬램덩크] 앵콜! 팬심대전</div>
				<div class="eventInfoDate">기간: 2023.03.08 ~ 2023.03.31</div>
			</div>
		</a> -->
		<a href="#">
			<div class="box">
				<img class="thumbnail" src="/images/thumbnail3.jpeg">
				<div class="eventInfoTitle">[대외비] 필름마크</div>
				<div class="eventInfoDate">기간: 2023.03.08 ~ 2023.03.31</div>
			</div>
		</a>
		<a href="#">
			<div class="box">
				<img class="thumbnail" src="/images/thumbnail4.jpeg">
				<div class="eventInfoTitle">[에브리씽 에브리웨어 올 앳 원스] 필름마크</div>
				<div class="eventInfoDate">기간: 2023.03.08 ~ 2023.03.31</div>
			</div>
		</a>
		<a href="#">
			<div class="box">
				<img class="thumbnail" src="/images/thumbnail5.jpeg">
				<div class="eventInfoTitle">[앤트맨과 와스프 -퀸텀매니아] 필름마크</div>
				<div class="eventInfoDate">기간: 2023.03.08 ~ 2023.03.31</div>
			</div>
		</a>
		<a href="#">
			<div class="box">
				<img class="thumbnail" src="/images/thumbnail6.jpeg">
				<div class="eventInfoTitle">[스즈메의 문단속] IMAX 포스터</div>
				<div class="eventInfoDate">기간: 2023.03.08 ~ 2023.03.31</div>
			</div>
		</a>
	</div>
</div>
<%@ include file="footer.jsp" %>
</body>
<script>
	$(document).ready(getStampList());
	
	// 초기 판 세팅
	function getStampList(){
		for(let i = 0; i < 4; i++){
			$(".firstLine").append(
					"<div class='item item" + (i + 1) + "'>"
						+ "<img src='/images/noStamp.png'>"  
					+ "</div>"
			);
			$(".secondLine").append(
					"<div class='item item" + (i + 5) + "'>"
						+ "<img src='/images/noStamp.png'>"  
					+ "</div>"
			);
			
		}
		$(".firstLine").append(
				"<div class='item image1'>"
					+ "<img src='/images/stampCola.png'>"  
				+ "</div>"
		);
		$(".secondLine").append(
				"<div class='item image2'>"
					+ "<img src='/images/stampPopcorn.png'>"  
				+ "</div>"
		);
		let count = parseInt($(".stampCount").val(), 10);
		for(let i = 1; i < count + 1; i++){
			$(".item" + i + " > img").attr("src", "/images/stamp.png");
		}
		if(count >= 4){
			$(".image1 > img").attr("src", "/images/colaClear.png");
		}
		if(count == 8){
			$(".image2 > img").attr("src", "/images/popcornClear.png");
		}
	}
	
	
</script>
</html>