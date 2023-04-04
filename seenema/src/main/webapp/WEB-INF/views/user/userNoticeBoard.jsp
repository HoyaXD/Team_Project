<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 - 시네마</title>
<link rel="stylesheet" href="/css/userNoticeBoard.css">
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
		<div class="noticeSection">
			<div class="tableWrap">
				<div class="pageBigTitle">공지 / 뉴스</div>
				<div class="wrap">
					<div class="pageSmallTitle">SEENEMA의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</div>
					<div class="searchWrap">
						<select id="select">
							<option value="">메뉴를 선택해주세요</option>
							<option value="title">제목으로 검색</option>
							<option value="contents">내용으로 검색</option>
						</select>
						<input id="keyword" type="text">
						<input id="searchBtn" type="button" value="검색">
					</div>
				</div>
				<table>
					<thead>
						<tr>
							<th class="noticeCodeTh">공지번호</th>
							<th class="noticeTitleTh">제목</th>
							<th class="noticeRegidateTh">등록일</th>
							<th class="noticeHitTh">조회수</th>
						</tr>
					</thead>
					<tbody>
						<!-- 데이터 -->
					</tbody>
				</table>
			</div>
			<div class="beforeAfterWrap">
				<!-- 페이지네이션 -->
			</div>
		</div>
	</main>
<%@ include file="footer.jsp" %>
</body>
<script>
	let totalPage = 0;
	let num = 1;
	
	// 페이지가 시작되면
	$(document).ready(function(){
		getNoticeList(num);
		getTotalPage();
		$(".menu1").css("backgroundColor", "#FB4357");
		$(".menu1").css("color", "white");
	});
	
	// 검색
	$("#searchBtn").on("click", function(){
		//alert($("#select").val());
		if($("#select").val() == ""){
			alert("메뉴를 선택해주세요.");
			return;
		}else if($("#keyword").val() == ""){
			alert("키워드를 입력해주세요.")
		}else{
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let list = JSON.parse(this.responseText);
				//console.log(obj);
				$("tbody").empty();
				if(list.length == 0){
					$("tbody").append(
						"<tr class='emptyWrap'><td colspan='4'>검색 조건에 맞는 공지가 존재하지 않습니다.</td></tr>"	
					);
				}else{
					$(list).each(function(index){
						$("tbody").append(
								"<tr>"
									+ "<td class='noticeCode'>" + list[index].noticeCode + "</td>"
									+ "<td class='noticeTitle'>" 
										+ "<a href='/user/noticeDetailView?noticeCode=" + list[index].noticeCode + "'>" + list[index].title + "</a>" 
									+ "</td>"
									+ "<td class='noticeRegidate'>" + list[index].regiDate + "</td>"
									+ "<td class='noticeHit'>" + list[index].hit + "</td>"
								+ "</tr>"
						);
					});
				}
				getSearchTotalPage();
			}
			let select = $("#select").val();
			let keyword = $("#keyword").val();
			let pageNum = 1;
			xhttp.open("get", "getSearchNoticeList.do?select=" + select + "&keyword=" + keyword + "&pageNum=" + pageNum, true);
			xhttp.send();
		}
	});
	
	function getSearchList(pageNum){
		if($("#select").val() == ""){
			alert("메뉴를 선택해주세요.");
			return;
		}else if($("#keyword").val() == ""){
			alert("키워드를 입력해주세요.")
		}else{
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let list = JSON.parse(this.responseText);
				//console.log(obj);
				$("tbody").empty();
				if(list.length == 0){
					$("tbody").append(
						"<tr class='emptyWrap'><td colspan='4'>검색 조건에 맞는 공지가 존재하지 않습니다.</td></tr>"	
					);
				}else{
					$(list).each(function(index){
						$("tbody").append(
								"<tr>"
									+ "<td class='noticeCode'>" + list[index].noticeCode + "</td>"
									+ "<td class='noticeTitle'>" 
										+ "<a href='/user/noticeDetailView?noticeCode=" + list[index].noticeCode + "'>" + list[index].title + "</a>" 
									+ "</td>"
									+ "<td class='noticeRegidate'>" + list[index].regiDate + "</td>"
									+ "<td class='noticeHit'>" + list[index].hit + "</td>"
								+ "</tr>"
						);
					});
				}
			}
			let select = $("#select").val();
			let keyword = $("#keyword").val();
			xhttp.open("get", "getSearchNoticeList.do?select=" + select + "&keyword=" + keyword + "&pageNum=" + pageNum, true);
			xhttp.send();
		}
	}
	
	// 사이드바 메뉴2
	$(".menu1").on("click", function(){
		location.href = "/user/userNoticeBoard";
	});
	$(".menu2").on("click", function(){
		location.href = "/user/userQnaView";
	});
	$(".menu3").on("click", function(){
		location.href = "/user/theaterView";
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
	
	// 공지 목록
	function getNoticeList(num){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let list = JSON.parse(data);
			$("tbody").empty();
			$(list).each(function(index){
				$("tbody").append(
						"<tr>"
							+ "<td class='noticeCode'>" + list[index].noticeCode + "</td>"
							+ "<td class='noticeTitle'>" 
								+ "<a href='/user/noticeDetailView?noticeCode=" + list[index].noticeCode + "'>" + list[index].title + "</a>" 
							+ "</td>"
							+ "<td class='noticeRegidate'>" + list[index].regiDate + "</td>"
							+ "<td class='noticeHit'>" + list[index].hit + "</td>"
						+ "</tr>"
				);
			});
		}
		xhttp.open("get", "/user/getNoticeList.do?pageNum=" + num, true);
		xhttp.send();
	}
	
	// 공지 페이지 갯수
	function getTotalPage(){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			totalPage = Math.ceil(result / 20);
			//alert(totalPage);
			if(totalPage == 0){
				$(".beforeAfterWrap").empty();
			}else if(totalPage < 10){
				// 10페이지 이하일 경우 초기 세팅
				$(".beforeAfterWrap").empty();
				$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
				for(let i = 0; i < totalPage; i++){
					$(".beforeAfterWrap").append("<div class='pageCount'>" + (i + 1) + "</div>");
				}
				$(".pageCount").filter(":first").css("color", "red"); // 첫페이지 색깔 on
				$(".prevBtn").addClass("noBtn");
				$(".noBtn").removeClass("prevBtn");
			}else{
				// 만약 10페이지 이상일경우 다음버튼이랑 같이 출력(초기 페이지라 이전버튼 필요 X) css 박스 움직이는거 생각하기
				$(".beforeAfterWrap").empty();
				$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
				for(let i = 0; i < 10; i++){
					$(".beforeAfterWrap").append("<div class='pageCount'>" + (i + 1) + "</div>");
				}
				$(".beforeAfterWrap").append("<div class='nextBtn'>>></div>");	// 다음버튼
				$(".pageCount").filter(":first").css("color", "red"); // 첫페이지 색깔 on
				$(".prevBtn").addClass("noBtn");
				$(".noBtn").removeClass("prevBtn");
			}
		}
		xhttp.open("get", "getNoticeCount.do?", true);
		xhttp.send();
	}
	
	function getSearchTotalPage(){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			totalPage = Math.ceil(result / 20);
			//alert(totalPage);
			if(totalPage == 0){
				$(".beforeAfterWrap").empty();
			}else if(totalPage < 10){
				// 10페이지 이하일 경우 초기 세팅
				$(".beforeAfterWrap").empty();
				$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
				for(let i = 0; i < totalPage; i++){
					$(".beforeAfterWrap").append("<div class='pageCount'>" + (i + 1) + "</div>");
				}
				$(".pageCount").filter(":first").css("color", "red"); // 첫페이지 색깔 on
				$(".prevBtn").addClass("noBtn");
				$(".noBtn").removeClass("prevBtn");
			}else{
				// 만약 10페이지 이상일경우 다음버튼이랑 같이 출력(초기 페이지라 이전버튼 필요 X) css 박스 움직이는거 생각하기
				$(".beforeAfterWrap").empty();
				$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
				for(let i = 0; i < 10; i++){
					$(".beforeAfterWrap").append("<div class='pageCount'>" + (i + 1) + "</div>");
				}
				$(".beforeAfterWrap").append("<div class='nextBtn'>>></div>");	// 다음버튼
				$(".pageCount").filter(":first").css("color", "red"); // 첫페이지 색깔 on
				$(".prevBtn").addClass("noBtn");
				$(".noBtn").removeClass("prevBtn");
			}
		}
		
		let select = $("#select").val();
		let keyword = $("#keyword").val();
		
		xhttp.open("get", "getSearchCount.do?select=" + select + "&keyword=" + keyword, true);
		xhttp.send();
	}
	
	// 페이지 번호별 리스트
	$(document).on("click", ".pageCount", function(){
		//alert($(this).text());
		$(this).css("color", "red");	// 자기 자신한테만 색깔
		$(".pageCount").not(this).css("color", "black");	// 자기자신 빼고 색깔 X
		let pageNum = $(this).text(); // 클릭된 번호 파라미터
		let sel = $("#select").val();
		if(sel == ""){
			getNoticeList(pageNum);
		}else{
			getSearchList(pageNum);
		}
	});
	
	// 이전 버튼
	$(document).on("click", ".prevBtn", function(){
		let prevPage = parseInt($(".pageCount").filter(":first").text(), 10) - 1;
		getNoticeList(prevPage);
		$(".beforeAfterWrap").empty();
		$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
		for(let i = 0; i < 10; i++){
			$(".beforeAfterWrap").append("<div class='pageCount'>" + (prevPage + i - 9) + "</div>");
		}
		$(".beforeAfterWrap").append("<div class='nextBtn'>>></div>");
		$(".pageCount").filter(":last").css("color", "red");
		if($(".pageCount").filter(":first").text() == "1"){
			$(".prevBtn").addClass("noBtn");
			$(".noBtn").removeClass("prevBtn");
		}
	});
	
	// 다음버튼
	$(document).on("click", ".nextBtn", function(){
		let nextPage = parseInt($(".pageCount").filter(":last").text(), 10) + 1;
		getNoticeList(nextPage);
		$(".beforeAfterWrap").empty();
		
		if(totalPage - nextPage < 10){
			let leng = totalPage - nextPage + 1;
			$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
			for(let i = 0; i < leng; i++){
				$(".beforeAfterWrap").append("<div class='pageCount'>" + (nextPage + i) + "</div>");
			}
			$(".pageCount").filter(":first").css("color", "red");
		}else{
			$(".beforeAfterWrap").append("<div class='prevBtn'><<</div>");
			for(let j = 0; j < 10; j++){
				$(".beforeAfterWrap").append("<div class='pageCount'>" + (nextPage + j) + "</div>");
			}
			$(".beforeAfterWrap").append("<div class='nextBtn'>>></div>");
			$(".pageCount").filter(":first").css("color", "red");
		}
	});
</script>
</html>