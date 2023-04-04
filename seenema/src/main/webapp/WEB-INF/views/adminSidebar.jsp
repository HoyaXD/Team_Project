<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
* {
	padding: 0;
	margin: 0 auto;
	font-family: "Noto Sans KR", "Roboto", "dotum", "sans-serif";
}

ul, li {
	list-style: none;
}

a {
	text-decoration: none;
	color: inherit;
	cursor: pointer;
}

.header {
	float: left;
	width: 200px;;
	height: 100%;
	background: rgb(62, 61, 61);
	color: white;
}

.header .logo {
	width: 200px;;
	height: 100px;
}

.header nav {
	width: 200px;;
	height: 55px;
}

.header nav .mainmenu {
	width: 200px;;
	height: 50px;
	margin: 0 auto;
}

.header nav .mainmenu li {
	width: 200px;;
	height: 50px;
	text-align: center;
	line-height: 50px;
	background: cccccc;
}

.header nav .mainmenu li .submenu {
	display: none;
	position: relative;
	width: 200px;;
	height: 200px;
	top: -50px;
	left: 200px;;
	z-index: 3
}

.header nav .mainmenu li .submenu li {
	width: 200px;;
	height: 50px;
	text-align: center;
	line-height: 50px;
	background: rgba(62, 61, 61, 0.8);
	color: white;
}

.header nav .mainmenu li:hover {
	background: rgba(76, 76, 248);
	color: white;
}

.header nav .mainmenu li .submenu li:hover {
	background: rgba(76, 76, 248);
	color: white;
}

.gamut {
	width: 1300px;
	height: 1000px;
	border: 1px red solid;
}
/*
        .top_bar{
            
            width: 1093px;
            height: 100px;
            border: 1px blue solid;
            float: left;
        }*/
/*메인메뉴*/
.main_view {
	float: right;
	width: 1094px;
	height: 1000px;
	border: 1px solid green;
}

.main_view #doToday_menu {
	margin: 20px 0 0 45px;
	/*상 오른쪽 아래 왼쪽*/
	width: 1000px;
	height: 150px;
	border: 1px solid blue;
}

#doToday_title {
	width: 1000px;
	height: 20px;
	border-bottom: 1px solid skyblue;
}

.easy_menu {
	margin: 20px 0 0 45px;
	display: flex;
	flex-wrap: wrap;
	width: 1000px;
	height: 800px;
	border: 1px solid darkgreen;
}

.easy_menu #em_Box {
	flex: 3 3 35%;
	border: 1px solid red;
}

#em_title {
	/*상 오른쪽 아래 왼쪽*/
	margin: 10px 0 0 0;
	font-size: 20px;
	width: 483px;
}

#em_title hr {
	
}

#em_Box div {
	margin: 5px auto;
	width: 490px;
	height: 380px;;
	border: 1px solid orchid;
}
</style>
</head>
<body>
	<div class="gamut">

		<div class="header">
			<div class="logo">Seenema</div>
			<nav>
				<ul class="mainmenu">
					<li><a href="testadMGMT">관리자 메인</a>
						<ul class="submenu"></ul></li>
					<li>영화 관리
						<ul class="submenu">
							<li><a href="movieReg">영화등록</a></li>
							<li><a href="movieList">영화 목록 및 괸리</a></li>
						</ul>
					</li>
					<li>영화관 관리
						<ul class="submenu">
							<li><a href="theaterReg">영화관 등록</a></li>
							<li><a href="theaterList">영화관 목록 및 관리</a></li>
						</ul>
					</li>
					<li>매출 관리
						<ul class="submenu">
							<li>매출 현황1</li>
							<li>매출 현황2</li>
							<li>매출 현황3</li>
							<li>매출 현황4</li>
						</ul>
					</li>
					<li>상품 관리
						<ul class="submenu">
							<li>상품 등록</li>
							<li>상품 수정</li>
							<li>상품 3</li>
							<li>상품 4</li>
						</ul>
					</li>
					<li><a href="MemberMGMT">회원관리 관리</a></li>
					<li><a href="qnaView">Q&A 관리</a></li>
					<li><a href="adNoticeView">공지사항 관리</a></li>
					<li><a href="">한줄평 관리//만들어야됨</a></li>
				</ul>
			</nav>
		</div>
		<!--상단바-->
		<!--  <div class="top_bar">
            상단바
        </div> -->
		<div class="main_view">

			<div id="doToday_menu">
				<div id="doToday_title">
					<p style="margin: 30px 0 0 40px;">오늘의 할일, 밑에 몇 개인지 총합</p>
				</div>
				<div id="each_num">
					<div>상영중인 영화 4 금일 예매자 수 50 답변대기 7 문의 3</div>
				</div>
			</div>
			<div class="easy_menu"></div>


		</div>
	</div>

	<script>
		$(document).ready(function() {

			/* 메뉴바 slideUpDown */
			// 첫번째 메뉴바 클릭시 이동   
			$('.mainmenu > li').click(function() {
				var index = $(this).index();
				$('.submenu').eq(index).stop().slideDown();
				//eq(index)는 큰메뉴li
			})

			$('.mainmenu > li').mouseleave(function() {
				$('.submenu').stop().slideUp();
			});

		});
	</script>
</body>
</html>