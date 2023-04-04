<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세보기 페이지</title>
<link rel="stylesheet" href="/css/movieDetailView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
		<%@ include file="header.jsp" %>
	<div class="container">
		<main>
			<div class="movieInfoWrap">
				<!-- 영화 포스터 이미지 -->
				<div class="movieImage">
					<img src="/images/${movie.postFileName }">
				</div>
				<!-- 상단 영화 정보 박스 -->
				<div class="movieInfo">
					<div class="movieTitle">
						<div id="title">${movie.movieTitle }</div>
						<div id="titleReservationStatus">현재 상영중</div>
						<div id="titleDday">D-1</div>
					</div>
					<div class="reservationRate">예매율 33.4%</div>
					<div class="director_ActorInfoWrap">
						<div id="director_Actor">감독 : ${movie.director } / 배우 : ${movie.actors }</div>
						<div id="genre">장르 : ${movie.genre } / 관람연령 : ${movie.viewAge } / 러닝타임 : ${movie.runningTime }분</div>
						<div id="openDate">개봉일 : ${movie.releaseDate }</div>
					</div>
					<a class="reservBtn" href="/user/reservationMain?movieCode=${movie.movieCode }">예매하기</a>
				</div>
			</div>
			
			<!-- 상단 스크롤 메뉴바 -->
			<div class="movieContent">
				<ul class="tabMenu">
					<li class="item">
						<a href="#">주요정보</a>
					</li>
					<li class="item">
						<a href="#trailer">예고편</a>
					</li>
					<li class="item last">
						<a href="#replySectionTitle">평점/리뷰</a>
					</li>
				</ul>
			</div>
			<div class="summuryWrap">
				<p>${movie.plot }</p>
			</div>
			<!-- 구글 차트 -->
			<div class="graphWrap">
				<div class="genderWrap">
					<div class="chartTitle">성별 예매 분포</div>
					<div id="donutChartWrap">
						<div id="donutChart"></div>
					</div>
				</div>
				<div class="ageWrap">
					<div class="chartTitle">연령별 예매 분포</div>
					<div id="barChartWrap">
						<div id="barChart"></div>
					</div>
				</div>
			</div>
			<!-- 메인 예고편 -->
			<div class="trailerWrap">
				<div id="trailer">&nbsp;</div>
				<iframe width="780" height="400" src="${movie.previewURL.replace('https://youtu.be/', 'https://www.youtube.com/embed/') }?rel=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen>
				</iframe>
			</div>
			<!-- 댓글 컨텐츠 박스 -->
			<div class="replySection">
				<div id="replyTopWrap">
					<div id="replySectionTitle">한줄평</div>
					<input type="button" id="regReplyBtn" value="평점작성">
				</div>
				<!-- 댓글 작성 영역 -->
				<form name="replyForm" id="replyForm">
					<fieldset>
						<input type="radio" class="star" name="rate" value="5" id="rate5"><label for="rate5">★</label>
						<input type="radio" class="star" name="rate" value="4" id="rate4"><label for="rate4">★</label>
						<input type="radio" class="star" name="rate" value="3" id="rate3"><label for="rate3">★</label>
						<input type="radio" class="star" name="rate" value="2" id="rate2"><label for="rate2">★</label>
						<input type="radio" class="star" name="rate" value="1" id="rate1"><label for="rate1">★</label>
					</fieldset>
					<textarea id="comment" name="comment" maxlength="50" placeholder="운영원칙에 어긋나는 게시물로 판단되는 글은 제재 조치를 받을 수 있습니다."></textarea>
					<div id="textWrap">
						<div id="noticeComment">※ 이 댓글에 대한 법적 책임은 작성자에게 귀속됩니다.</div>
						<div class="commentCount">0자</div>
			        	<div class="textTotal">&nbsp;/&nbsp;50자</div>
					</div>
					<input type="hidden" name="id" id="id" value="${sessionScope.id }">
					<input type="hidden" id="movieCode" value="${movie.movieCode }">
				</form>
				<div class="replyList">
					<!-- 댓글 목록  -->
				</div>
				<div class="beforeAfterWrap">
					<!-- 페이지네이션 -->
				</div>
				<!-- 댓글 수정 박스 -->
				<div id="updateReplyBox">
					<div id="updateReplyBoxTop">
						<div id="updateReplyBoxTitle">한줄평 수정</div>
						<div id="closeBtn">X</div>
					</div>
					<div class="updateReplyBoxWriteSection">
						<div id="updateReplyBoxmovieTitle">${movie.movieTitle}</div>
						<form name="updateReplyForm" id="updateReplyForm">
							<fieldset>
								<input type="radio" class="star" name="updateRate" value="5" id="updateRate5"><label for="updateRate5">★</label>
								<input type="radio" class="star" name="updateRate" value="4" id="updateRate4"><label for="updateRate4">★</label>
								<input type="radio" class="star" name="updateRate" value="3" id="updateRate3"><label for="updateRate3">★</label>
								<input type="radio" class="star" name="updateRate" value="2" id="updateRate2"><label for="updateRate2">★</label>
								<input type="radio" class="star" name="updateRate" value="1" id="updateRate1"><label for="updateRate1">★</label>
							</fieldset>
							<textarea id="updateReplyFormComment" name="updateComment" maxlength="50" placeholder="운영원칙에 어긋나는 게시물로 판단되는 글은 제재 조치를 받을 수 있습니다."></textarea>
							<div id="updateReplyFormTextWrap">
								<div id="updateReplyFormNoticeComment">※ 이 댓글에 대한 법적 책임은 작성자에게 귀속됩니다.</div>
								<div class="updateReplyFormCommentCount">0자</div>
						       	<div class="updateReplyFormTextTotal">&nbsp;/&nbsp;50자</div>
							</div>
							<input type="hidden" id="updateBoxReplyCode" value="">
							<input type="hidden" name="id" id="uId">
						</form>
						<div id="updateReplyDoBtn">수정</div>
					</div>
				</div>
			</div>
			<div class="absoluteBtnWrap">
        		<a href="/user/reservationMain?movieCode=${movie.movieCode }" class="nowReservBtn">예매하기</a>	<!-- 범수행님 매핑 -->
        		<a href="#header" class="scrollTopBtn">↑</a>
       		</div>
		</main>
	</div>
	<%@ include file="footer.jsp" %>
<script>
	const movieCode = $("#movieCode").val();	//영화코드
	let totalPage = 0;
	let num = 1;
	$(document).ready(function(){
		getReplyList(num);
		getTotalPage();
	});
	
	// 댓글 총 갯수
	function getTotalPage(){
		console.log("시작전 : " + totalPage);
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			totalPage = Math.ceil(result / 10);
			console.log("시작후 : " + totalPage);
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
		xhttp.open("get", "getReplyCount.do?movieCode=" + movieCode, true);
		xhttp.send();
	}
	
	// 페이지 번호별 리스트
	$(document).on("click", ".pageCount", function(){
		//alert($(this).text());
		$(this).css("color", "red");	// 자기 자신한테만 색깔
		$(".pageCount").not(this).css("color", "black");	// 자기자신 빼고 색깔 X
		let pageNum = $(this).text(); // 클릭된 번호 파라미터
		getReplyList(pageNum);
	});
	
	// 이전 버튼
	$(document).on("click", ".prevBtn", function(){
		let prevPage = parseInt($(".pageCount").filter(":first").text(), 10) - 1;
		getReplyList(prevPage);
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
		getReplyList(nextPage);
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
	
	// 구글 차트 (도넛)
	google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    
    function drawChart() {
      	var data = google.visualization.arrayToDataTable([
        	['Task', 'Hours per Day'],
        	['남성', 129],	// 예매 인원중 성별만 다 가지고 오면됨
        	['여성', 111],	// 예매 인원중 성별만 다 가지고 오면됨
      	]);

      	var options = {
        	pieHole: 0.2,
      	};
      	var chart = new google.visualization.PieChart(document.getElementById('donutChart'));
    	chart.draw(data, options);
    }
	
    google.charts.load('current', {packages: ['corechart', 'bar']});
    google.charts.setOnLoadCallback(drawBasic);
	
    // 구글차트 막대
    function drawBasic() {
    	var data = new google.visualization.DataTable();
   			data.addColumn('string', '요일');
    		data.addColumn('number', '방문자수(명)');
    		data.addRows([
	    		['10대', 121],		// 데이터 넣기
		    	['20대', 222],
			    ['30대', 31],
			    ['40대', 44],
			    ['50대', 51]
    		]);
	    var options = {
		    hAxis: {
		    viewWindow: {
		    	min: [7, 30, 0],
		    	max: [17, 30, 0]
	    	}
	    	},
    	};
    	var chart = new google.visualization.ColumnChart(document.getElementById('barChart'));
    	chart.draw(data, options);

    }
    
	// 댓글 목록
	function getReplyList(num){
		const id = $("#id").val();
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			document.querySelector(".replyList").replaceChildren();
			if(obj.length == 0){
				$(".replyList").append(
						"<div class='noListBox'>댓글 목록이 존재하지 않습니다.</div>"
				);
			}else{
				$(obj).each(function(index){
					//console.log(obj[index].comment);
					let star;
					let unstar;
					let rate;
					if(obj[index].rate == "1"){
						star = "★";
						unstar = "★★★★";
						rate = "1";
					}else if(obj[index].rate == "2"){
						star = "★★";
						unstar = "★★★";
						rate = "2";
					}else if(obj[index].rate == "3"){
						star = "★★★";
						unstar = "★★";
						rate = "3";
					}else if(obj[index].rate == "4"){
						star = "★★★★";
						unstar = "★";
						rate = "4";
					}else{
						star = "★★★★★";
						rate = "5";
					}
					$(".replyList").append(
							"<div class='replyBox'>"
								+ "<input type='hidden' id='replyCode' value=" + this.replyCode + ">"
								+ "<div class='replyBoxTop'>"
								+ (rate != 5? 
										"<div id='replyStar'>" 
											+ "<span class='star'>" + star + "</span>" 
											+ "<span class='unstar'>" + unstar + "</span>" 
										+ "</div>" 
										+ "<div id='replyRate'></div>"
										: 
										"<div id='replyStar'>" 
											+ "<span class='star'>" + star + "</span>" 
										+ "</div>" 
										+ "<div id='replyRate'></div>")
									+ (id == this.id? "<div class='btnWrap'><div id='updateBtn'>수정</div><div id='deleteBtn'>삭제</div></div>" : "")
								+ "</div>"
								+ "<div id='replyComment'>" + this.comment + "</div>" 
								+ "<div class='replyBoxBottom'>"
									+ "<div id='replyId'>" + this.id + "</div>"
									+ "<div id='replyRegDate'>" + this.regDate + "</div>"
								+ "</div>"
							+ "</div>"
					);
				});
			}
		}
		xhttp.open("get", "/user/getReplyList.do?movieCode=" + movieCode + "&pageNum=" + num, true);
		xhttp.send();
	}
	
	// 댓글 등록
	$("#regReplyBtn").on("click", function(){
		if($("#id").val() == ""){
			if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?") == true){
				location.href = "/user/loginForm";
				$("#comment").val("");	// 댓글 내용 초기화
				$(".commentCount").text("0자");	// 댓글카운트 초기화
				$("input[type=radio]").prop("checked", false);	// 별점 초기화
			}else{
				return;
			}
		}
		if($("input[name='rate']:checked").val() == null){
			alert("평점을 선택해주세요!");
		}else if($("#comment").val() == ""){
			alert("한줄평을 입력해주세요!");
		}else{
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let result = parseInt(this.responseText, 10);
				if(result == 1){	// 댓글 등록 성공
					alert("댓글을 성공적으로 등록하였습니다!");
					$("#comment").val("");	// 댓글 내용 초기화
					$(".commentCount").text("0자");	// 댓글카운트 초기화
					$("input[type=radio]").prop("checked", false);	// 별점 초기화
					getReplyList(1);	// 댓글 목록 갱신
					getTotalPage();
				}else{	// 댓글 등록 실패
					alert("댓글등록에 실패했습니다.");
				}
			}
			let id = $("#id").val();
			let rate = $(".star:checked").val();
			let comment = $("#comment").val();
			
			xhttp.open("post", "/user/regReply.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("id=" + id + "&movieCode=" + movieCode + "&comment=" + comment + "&rate=" + rate);
		}
	});
	
	// 댓글 글자수 카운트
	$("#comment").keyup(function(e){
		let comment = $(this).val();
		if(comment.length == 0 || comment == ""){
			// 코멘트 입력 X
			$(".commentCount").text("0자");
		}else{
			$(".commentCount").text(comment.length + "자");
		}
	});
	
	// 댓글 수정박스 글자수 카운트
	$("#updateReplyFormComment").keyup(function(e){
		let comment = $(this).val();
		if(comment.length == 0 || comment == ""){
			// 코멘트 입력 X
			$(".updateReplyFormCommentCount").text("0자");
		}else{
			$(".updateReplyFormCommentCount").text(comment.length + "자");
		}
	});
	
	// 댓글 수정박스 열기	
	$(document).on("click", "#updateBtn", function(e){
		let replyCode = e.target.parentElement.parentElement.parentElement.children[0].value;
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			$("#updateReplyFormComment").val(obj.comment);
			$("#updateRate" + obj.rate).prop("checked", true);
			$("#updateReplyBox").css("display", "block");
			$("#updateBoxReplyCode").val(replyCode);
			$("#uId").val(obj.id);
		}
		xhttp.open("post", "/user/getReplyInfo.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("replyCode=" + replyCode);
	});
	
	// 댓글 수정박스 닫기
	$("#closeBtn").on("click", function(){
		$("#updateReplyBox").css("display", "none");
		$("#updateReplyFormComment").val("");
		$("input[name='updateRate']").prop("checked", false);
		$("#updateBoxReplyCode").val("");
	});
	
	// 댓글 수정 실행
	$("#updateReplyDoBtn").on("click", function(){
		if($("#updateReplyFormComment").val() == ""){
			alert("코멘트를 입력해주세요!");
			return;
		}else if($("input[name='updateRate']:checked").val() == null){
			alert("평점을 선택해주세요!");
			return;
		}else{
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let data = this.responseText;
				let result = parseInt(data, 10);
				if(result == 1){
					alert("댓글 수정 성공!");
					$("#updateReplyBox").css("display", "none");
					$("#updateReplyFormComment").val("");
					//$("#updateRate" + obj.rate).prop('checked', false);
					$("#updateBoxReplyCode").val("");
					getReplyList(1);	// 댓글 목록 갱신
					getTotalPage();		// 페이지네이션 초기화
				}else{
					alert("댓글 수정 실패!");
				}
			}
			let rate = $("#updateReplyForm .star:checked").val();
			let comment = $("#updateReplyFormComment").val();
			let replyCode = $("#updateBoxReplyCode").val();
			//console.log("평점 : " + rate + "\n코멘트 : " + comment + "\n댓글 코드 : " + replyCode);
			
			xhttp.open("post", "updateReply.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("rate=" + rate + "&comment=" + comment + "&replyCode=" + replyCode);
		}
	});
	
	// 댓글 삭제
	$(document).on("click", "#deleteBtn", function(e){
		if(confirm("댓글을 삭제하시겠습니까?") == true){
			const replyCode = e.target.parentElement.parentElement.parentElement.children[0].value;
			replyCode;
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let result = this.responseText;
				if(result == "1"){
					alert("댓글을 삭제 완료하였습니다");
					getReplyList(1);
					getTotalPage();	// 페이지네이션 초기화
				}else{
					alert("댓글 삭제 실패");
				}
			}
			xhttp.open("post", "/user/deleteReply.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("replyCode=" + replyCode);
		}
	});
	// 스크롤 부드럽게
	$(document).on('click', 'a[href^="#"]', function (event) {
	    event.preventDefault();	// 기능 차단
	    $('html, body').animate({
	        scrollTop: $($.attr(this, 'href')).offset().top
	    }, 300);
	});
</script>
</body>
</html>