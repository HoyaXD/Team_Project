<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A - 시네마</title>
<link rel="stylesheet" href="/css/qnaDetailView.css">
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
		<div class="section">
			<div class="pageBigTitle">Q&A</div>
			<div class="pageSmallTitle">SEENEMA에 대한 궁금한점을 올려주세요!</div>
			<div class="qnaInfoWrap">
				<input type="hidden" id="qCode" value="${qna.qcode }">
				<div class="qnaInfoWrapTop">
					<div class="qnaTitle">${qna.title }</div>
					<c:set var="formattedDate" value="${fn:substring(qna.regiDate, 0, 10)}"/>
					<div class="qnaRegDate">
						<span>등록일&nbsp;</span>
						<span class="bold">${formattedDate}</span>
					</div>
					<div class="deleteQnaBtnWrap">
						<div id="deleteQnaBtn">삭제</div>
					</div>
				</div>
				<div class="qnaInfoContent">
					<p>${qna.contents }</p>
				</div>
				<div class="adminAnswerTitle">[관리자 답변]</div>
				<div class="adminAnswer">
				<c:if test="${qna.answer != null}">
					<p>
						${qna.answer }
					</p>
				</c:if>
				<c:if test="${qna.answer eq null}">
					<div style="color: gray;">등록된 답변이 없습니다<br>최대한 신속하게 답변해드리도록 하겠습니다.</div>
				</c:if>
				</div>
			</div>
			<div class="goBtnWrap">
				<span id="goListBtn">목록으로</span>
			</div>
		</div>
	</main>
<%@ include file="footer.jsp" %>
</body>
<script>
	const qCode = $("#qCode").val()
	const noticeCode = $("#noticeCode").val();
	
	// 문의글 삭제
	$("#deleteQnaBtn").on("click", function(){
		if(confirm("문의글을 삭제하시겠습니까?") == true){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let result = parseInt(this.responseText, 10);
				if(result == 1){
					alert("문의글을 성공적으로 삭제하였습니다!");
					location.href = "/user/userQnaView";
				}else{
					alert("삭제 실패");
				}
			}
			xhttp.open("get", "deleteQna.do?qCode=" + qCode, true);
			xhttp.send();
		}
	});
	
	// 사이드바 메뉴1
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
		location.href = "/user/userQnaView";
	});
	
	$(document).ready(function(){
		if($("main").attr("id") == "qnaBoard"){
			$(".menu2").css("backgroundColor", "#FB4357");
			$(".menu2").css("color", "white");
		}
	});
	
	// 색깔
	$(".sideBarMenu").on("mouseover", function(){
		$(this).css("backgroundColor", "#FB4357");
		$(this).css("color", "white");
		if($("main").attr("id") == "qnaBoard"){
			$(".menu2").css("backgroundColor", "#FB4357");
			$(".menu2").css("color", "white");
		}
	});
	
	// 색깔
	$(".sideBarMenu").on("mouseleave", function(){
		$(this).css("backgroundColor", "white");
		$(this).css("color", "black");
		if($("main").attr("id") == "qnaBoard"){
			$(".menu2").css("backgroundColor", "#FB4357");
			$(".menu2").css("color", "white");
		}
	});
</script>
</html>