<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 관리자 좌측메뉴 css를 위한 자바스크립트 -->
<script type="text/javascript" src="/js/adminMenu.js"></script>
<!-- 관리자 메인메뉴 css를 위한 메인메뉴 -->
<link rel="stylesheet" href="/css/adMainEasyView.css">
<!-- 제이쿼리 -->
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<body>
	<div class="main_view">
		<div id="doToday_menu">
			<!-- <div id="doToday_title" style="height: 280px;"> -->
			<!-- 	<p style="margin: 20px 0 5px 45px;">오늘의 할일</p> 
				<hr>-->
			<div class="test">


				<div id="moview1">
					<div id="count_box" style="border-top:3px solid rgb(61, 131, 72); color:rgb(61, 131, 72); font-weight:bold;">
						<br>상영중인 영화
						<div id="todayMovieCount" style="font-size: 50px; "></div>
					</div>
					<div id="count_box" style="border-top:3px solid rgb(235, 134, 43); color:rgb(235, 134, 43); font-weight:bold;">
						<br>상영종료 대기<br>
						<div id="getTodayEndMovieCount" style="font-size: 50px;"></div>
					</div>
				</div>
				<div id="moview2">
					<div  id="count_box"  style="border-top:3px solid rgb(10, 70, 203); color:rgb(36, 99, 244); font-weight:bold;">
						<br>금일 예매<br> 
						<div id="getTodayReservationCount" style="font-size: 50px;"></div>
					</div>
					<div  id="count_box" style="border-top:3px solid rgb(173, 33, 35); color:rgb(173, 33, 35); font-weight:bold;">
						<br>금일 예매취소<br>
						<div id="getTodayReservationCancelCount" style="font-size: 50px;"></div>
					</div>
				</div>
				<div id="moview4">
					<div id="count_box"  style="border-top:3px solid rgb(10, 70, 203); color:rgb(36, 99, 244); font-weight:bold;">
						<br>금일 상품 판매<br>
						<div id="getTodayProductSalesCount" style="font-size: 50px;"></div>
						
					</div>
					<div id="count_box"  style="border-top:3px solid rgb(173, 33, 35); color:rgb(173, 33, 35); font-weight:bold;">
						<br>상품 구매 취소<br>
						<div id="getTodayProductCancelCount" style="font-size: 50px;"></div>
					</div>
				</div>
				<div id="moview3">
					<div  id="count_box"  style="border-top:3px solid rgb(235, 134, 43); color:rgb(235, 134, 43); font-weight:bold;">
						<br>답변 대기<br>
						<div id="getTodayQnaWaitingCount" style="font-size: 50px;"></div>
					</div>
					<div id="count_box"  style="border-top:3px solid rgb(61, 131, 72); color:rgb(61, 131, 72); font-weight:bold;">
						<br>답변 완료<br>
						<div id="getTodayQnaCompleteCount" style="font-size: 50px;"></div>
					</div>
				</div>
			</div>
			<!-- </div> -->
			<!-- <div id="chart_div"></div> -->
		</div>
		<div id="simpleView">
			<div style="margin-top: 15px; margin-right: 16px;">
				<div id="sm1">
					<h4>
						&nbsp;&nbsp;&nbsp;&nbsp;영화별 예매 <a id="alink" href="movieSalesPage">+ 더보기</a>
					</h4>
					<hr>
					<table>
						<thead>
							<tr>
								<th>제목</th>
								<th>예매 수</th>
							</tr>
						</thead>
						<tbody id="reservationMainViewCount">

						</tbody>
					</table>
				</div>
				<div id="sm2" style="margin-top: 15px;">
					<h4>
						&nbsp;&nbsp;&nbsp;&nbsp;문의 <a id="alink" href="qnaView">+ 더보기</a>
					</h4>
					<hr>
					<table>
						<thead>
							<tr>
								<th>제목</th>
								<th>ID</th>
							</tr>
						</thead>
						<tbody id="recentQna">

						</tbody>
					</table>
					<!-- <div id="qnaView_box"></div> -->
				</div>
			</div>

			<div style="margin-top: 15px; margin-left: 16px;">
				<div id="sm3">
					<h4>
						&nbsp;&nbsp;&nbsp;&nbsp;지점별 예매 내역 <a id="alink" href="movieSalesPage">+ 더보기</a>
					</h4>
					<hr>
					<table>
						
						<thead>
							<tr>
								<th>지점명</th>
								<th>예매 수</th>
							</tr>
						</thead>
						<tbody id="recentReservation">

						</tbody>
					</table>
					<!-- <div id="replyView_box"></div> -->
				</div>
				<div id="sm4" style="margin-top: 15px;">
					<h4>
						&nbsp;&nbsp;&nbsp;&nbsp;한줄평 <a id="alink" href="adminReplyView">+ 더보기</a>
						
					</h4>
					<hr>
					<!-- <div id="reservationView_box"> -->
					<table>
					<thead>
							<tr>
								<th>한줄평</th>
								<th>평점</th>
							</tr>
						</thead>
						<tbody id="recentReply">

						</tbody>
					</table>

					<!-- </div> -->
				</div>
			</div>
		</div>
	</div>
	<script>
	
	ready();
	
	function ready(){
		todayMovieCount();
		getTodayEndMovieCount();
		getTodayReservationCount();
		getTodayQnaWaitingCount();
		getTodayQnaCompleteCount();
		getTodayProductSalesCount();
		getTodayProductCancelCount();
		getTodayReservationCancelCount();
	}
		
		$(document).ready(
				function() {
					//qna출력
					$.ajax({
						url : "qnaMainView",
						type : "get",
						dataType : "text",

						success : function(data) {
							var bar = '|';
							let obj = JSON.parse(data);
							let i = 0;
							for (i; i < 6; i++) {
								var resultDate = obj[i].regiDate.substring(0,
										10);
								var resultTime = obj[i].regiDate.substring(11,
										16);
								$("#recentQna").append(
										"<tr><td>" + obj[i].title + "</td><td>"
												+ obj[i].id + "</td></tr>");
							}
						}
					});
					//reply출력
					$.ajax({
						url : "replyMainView",
						type : "get",
						dataType : "text",

						success : function(data) {
							var bar = '|';
							let obj = JSON.parse(data);
							let i = 0;
							for (i; i < 6; i++) {

								$("#recentReply").append(
										"<tr><td>" + obj[i].comment
												+ "</td><td>" + obj[i].rate
												+ "</td></tr>");
							}
						}
					});
					//최근예매내역출력
					$.ajax({
						url : "reservationMainView",
						type : "get",
						dataType : "text",

						success : function(data) {
							var bar = '|';
							let obj = JSON.parse(data);
							let i = 0;
							for (i; i < 6; i++) {

								$("#recentReservation").append(
										"<tr><td>" + obj[i].theaterPlace
												+ "</td><td>" + obj[i].total_count
												+ "</td></tr>");

							}
							/*   $("#reservationView_box").css("width", "200px;") */
						},
						error : function() {

						}
					});
					$.ajax({
						url : "reservationMainViewCount",
						type : "get",
						dataType : "text",

						success : function(data) {
							let obj = JSON.parse(data);
							let i = 0;
							for (i; i < 6; i++) {
								 $("#reservationMainViewCount").append(
										"<tr><td>" + obj[i].movieTitle
												+ "</td><td>" + obj[i].total_count
												+ "</td></tr>");

							}
						},
						error : function() {

						}
					});
					
					
				});
		
		function todayMovieCount() {
			$.ajax({
				url : "todayMainMovieCount",
				type : "get",
				dataType : "text",
				success : function(data) {
					$("#todayMovieCount").append(data);
				}
			});
		}
		
		function getTodayEndMovieCount() {
			$.ajax({
				url : "getTodayEndMovieCount",
				type : "get",
				dataType : "text",
				success : function(data) {
					$("#getTodayEndMovieCount").append(data);
				}
			});
		}

		function getTodayReservationCount() {
			$.ajax({
				url : "getTodayReservationCount",
				type : "get",
				dataType : "text",
				success : function(data) {
					$("#getTodayReservationCount").append(data);
				}
			});
		}
		
		function getTodayQnaWaitingCount(){
			$.ajax({
				url: "getTodayQnaWaitingCount",
				type : "get",
				dataType : "text",
				success : function(data){
					$("#getTodayQnaWaitingCount").append(data);
				}
			});
		}
		
		function getTodayQnaCompleteCount(){
			$.ajax({
				url: "getTodayQnaCompleteCount",
				type : "get",
				dataType : "text",
				success : function(data){
					$("#getTodayQnaCompleteCount").append(data);
				}
			});
		}
		
		function getTodayProductSalesCount(){
			$.ajax({
				url: "getTodayProductSalesCount",
				type : "get",
				dataType : "text",
				success : function(data){
					$("#getTodayProductSalesCount").append(data);
				}
			});
		}
		
		function getTodayProductCancelCount(){
			$.ajax({
				url: "getTodayProductCancelCount",
				type : "get",
				dataType : "text",
				success : function(data){
					$("#getTodayProductCancelCount").append(data);
				}
			});
		}
		
		function getTodayReservationCancelCount(){
			$.ajax({
				url: "getTodayReservationCancelCount",
				type : "get",
				dataType : "text",
				success : function(data){
					$("#getTodayReservationCancelCount").append(data);
				}
			});
		}
		
		
		
		
		
		
		
	</script>
</body>
