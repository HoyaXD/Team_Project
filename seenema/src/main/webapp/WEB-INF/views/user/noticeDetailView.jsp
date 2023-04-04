<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항(상세) - 시네마</title>
<link rel="stylesheet" href="/css/noticeDetailView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
	<main id="noticeBoard">
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
		<div class="section">
			<div class="pageBigTitle">공지 / 뉴스</div>
			<div class="pageSmallTitle">SEENEMA의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</div>
			<div class="noticeInfoWrap">
				<input type="hidden" id="noticeCode" value="${notice.noticeCode }">
				<div class="noticeInfoWrapTop">
					<div class="noticeTitle">${notice.title }</div>
					<div class="noticeRegDate"><span>등록일&nbsp;</span><span class="bold">${notice.regiDate }</span></div>
					<div class="noticeView"><span>조회수&nbsp;</span><span class="bold">${notice.hit }</span></div>
				</div>
				<div class="noticeInfoContent">
					<p>${notice.contents }</p>
				</div>
			</div>
			<div class="goBtnWrap"><span id="goListBtn">목록으로</span></div>
			<div class="post">
				<div class="prevContent"></div>
				<div class="nextContent"></div>
			</div>
		</div>
	</main>
<%@ include file="footer.jsp" %>
</body>
<script>
	const noticeCode = $("#noticeCode").val();
	$(document).ready(function(){
		getPrevContent(noticeCode);
		getNextContent(noticeCode);
	});
	
	// 이전글
	function getNextContent(noticeCode){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
	        let obj = JSON.parse(data);
	        $(".nextContent").append(
	        	"<div class='head after'>다음글</div>"
        		+ "<div class='anchorWrap'>"
        			+ "<a href='/user/noticeDetailView?noticeCode=" + obj.noticeCode + "'>" + obj.title + "</a>"
        		+ "</div>"
	        );
		}
		xhttp.open("get", "/user/getPrevContent?noticeCode=" + noticeCode, true);
		xhttp.send();
	}
	
	// 다음글
	function getPrevContent(noticeCode){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			$(".prevContent").append(
				"<div class='head before'>이전글</div>" 
				+ "<div class='anchorWrap'>" 
					+ "<a href='/user/noticeDetailView?noticeCode=" + obj.noticeCode + "'>" + obj.title + "</a>" 
				+ "</div>"
			);
		}
		xhttp.open("get", "/user/getNextContent?noticeCode=" + noticeCode, true);
		xhttp.send();
	}
	
	$(".menu1").on("click", function(){
		location.href = "/user/userNoticeBoard";
	});
	// 사이드바 메뉴2
	$(".menu2").on("click", function(){
		location.href = "/user/userQnaView";
	});
	
	$(".menu3").on("click", function(){
		location.href = "/user/theaterView";
	});
	
	// 목록으로 버튼
	$("#goListBtn").on("click", function(){
		location.href = "/user/userNoticeBoard";
	});
	
	$(document).ready(function(){
		if($("main").attr("id") == "noticeBoard"){
			$(".menu1").css("backgroundColor", "#FB4357");
			$(".menu1").css("color", "white");
		}
	});
	
	// 색깔
	$(".sideBarMenu").on("mouseover", function(){
		$(this).css("backgroundColor", "#FB4357");
		$(this).css("color", "white");
		if($("main").attr("id") == "noticeBoard"){
			$(".menu1").css("backgroundColor", "#FB4357");
			$(".menu1").css("color", "white");
		}
	});
		
	// 색깔
	$(".sideBarMenu").on("mouseleave", function(){
		$(this).css("backgroundColor", "white");
		$(this).css("color", "black");
		if($("main").attr("id") == "noticeBoard"){
			$(".menu1").css("backgroundColor", "#FB4357");
			$(".menu1").css("color", "white");
		}
	});
</script>
</html>