<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 등록 - 시네마</title>
<link rel="stylesheet" href="/css/regQnaView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
	<main id="qnaBoard">
		<div class="sideBar">
			<div class="sideBarMenu menu1">공지 / 뉴스</div>
			<div class="sideBarMenu menu2">Q&A</div>
			<div class="sideBarMenu menu3">상영관</div>
			<div class="ad ad1">
				<img src="/images/ad1.jpeg">
			</div>
			<div class="ad ad2">
				<img src="/images/ad2.png">
			</div>
		</div>
		<div class="qnaSection">
			<div class="pageBigTitle">Q&A</div>
			<div class="pageSmallTitle">SEENEMA에 대한 궁금한점을 올려주세요!</div>
			<table class="regQnaTable">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" maxlength="30" class="regTitle">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea maxlength="500" class="regContents"></textarea>
					</td>
				</tr>
			</table>
			<div class="buttonWrap">
				<div class="regQnaBtn">등록</div>
			</div>
		</div>
	</main>
<%@ include file="footer.jsp" %>
<script>
	const id = $("#id").val();

	$(document).ready(function(){
		$(".menu2").css("backgroundColor", "#FB4357");
		$(".menu2").css("color", "white");
	});
	
	$(".regQnaBtn").on("click", function(){
		if($(".regTitle").val() == ""){
			alert("제목을 입력해주세요.");
			return;
		}else if($(".regContents").val() == ""){
			alert("내용을 입력해주세요.");
			return;
		}else{
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let result = parseInt(this.responseText, 10);
				if(result == 1){
					alert("문의글을 성공적으로 등록하였습니다\n최대한 빠른 시일내에 답변드리겠습니다.");
					location.href = "/user/userQnaView";
				}else{
					alert("등록 실패");
				}
			}
			let title = $(".regTitle").val();
			let contents = $(".regContents").val();
			xhttp.open("post", "regQna.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("title=" + title + "&contents=" + contents + "&id=" + id);
		}
	});
	
	//사이드바 메뉴2
	$(".menu1").on("click", function(){
		location.href = "/user/userNoticeBoard";
	});
	
	$(".menu2").on("click", function(){
		location.href = "/user/userQnaView";
	});
	
	$(".menu3").on("click", function(){
		location.href = "/user/theaterView";
	});
</script>
</body>
</html>