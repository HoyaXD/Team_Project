<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A - 시네마</title>
<link rel="stylesheet" href="/css/userQnaView.css">
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
			<div class="wrap">
				<div class="pageSmallTitle">SEENEMA에 대한 궁금한점을 올려주세요!</div>
				<div class="regQnaBtnWrap">
					<span id="regQnaBtn">질문등록</span>
				</div>
			</div>
			<div class="tableWrap">
				<table class="qnaTable">
					<thead>
						<tr>
							<th class="noticeCodeTh">접수번호</th>
							<th class="noticeTitleTh">제목</th>
							<th class="noticeRegUserTh">작성자</th>
							<th class="noticeRegidateTh">등록일</th>
							<th class="answerStatusTh">답변상태</th>
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
<script>
	let totalPage = 0;
	let num = 1;
	const id = $("#id").val();
	
	$(document).ready(function(){
		$(".menu2").css("backgroundColor", "#FB4357");
		$(".menu2").css("color", "white");
		getQnaList(num);
		getTotalPage();
	});
	
	// Q&A목록
	function getQnaList(num){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let list = JSON.parse(data);
			
			$("tbody").empty();
			$(list).each(function(index){
				$("tbody").append(
					"<tr>"
						+ "<td>" + list[index].qcode + "</td>"
						+ "<td>"
							+ "<a class='qCode' href='/user/qnaDetailView?qcode=" + list[index].qcode + "'>" + list[index].title + "</a>" 
						+ "</td>"
						+ "<td>" + list[index].id + "</td>"
						+ "<td>" + list[index].regiDate.substring(0, 10) + "</td>"
						+ (list[index].status == 0 ? "<td>답변대기</td>" : "<td>답변완료</td>")
					+ "</tr>"
				);
			});
		}
		xhttp.open("get", "/user/getQnaList.do?pageNum=" + num, true);
		xhttp.send();
	}
	
	// 댓글 총 갯수
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
		xhttp.open("get", "getQnaCount.do?", true);
		xhttp.send();
	}
	
	// 페이지 번호별 리스트
	$(document).on("click", ".pageCount", function(){
		//alert($(this).text());
		$(this).css("color", "red");	// 자기 자신한테만 색깔
		$(".pageCount").not(this).css("color", "black");	// 자기자신 빼고 색깔 X
		let pageNum = $(this).text(); // 클릭된 번호 파라미터
		getQnaList(pageNum);
	});
	
	// 이전 버튼
	$(document).on("click", ".prevBtn", function(){
		let prevPage = parseInt($(".pageCount").filter(":first").text(), 10) - 1;
		getQnaList(prevPage);
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
		getQnaList(nextPage);
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
	// 유효성 검사
	$(document).on("click", "a.qCode", function(e){
		//href='/user/qnaDetailView?qcode=
		if(id == ""){
			e.preventDefault();	// 이벤트 무효
			if(confirm("로그인 후 이용가능합니다.\n로그인 하시겠습니까?")){
				location.href = "/user/loginForm";
			}
			return;
		}else if(e.target.parentElement.nextElementSibling.innerText != id){
			e.preventDefault();	// 이벤트 무효
			alert("본인이 문의한 게시글만 확인이 가능합니다.");
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
	
	$("#regQnaBtn").on("click", function(){
		location.href = "/user/regQnaView";
	});
	
	
</script>
</body>
</html>