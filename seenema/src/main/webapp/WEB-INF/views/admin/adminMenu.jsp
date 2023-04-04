<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 제이쿼리 -->
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!-- 관리자 좌측메뉴 css -->
<link rel="stylesheet" href="/css/adMenu.css">	
<script type="text/javascript" src="/js/adminMenu.js"></script>

<body>
	<div class="header">
		<div class="logo"><img src="/images/logo3.png" style="width: 200px; height: 100px;"></div>
		<nav>
			<ul class="mainmenu">
				<li><a href="adminPage">관리자 메인</a>
					<ul class="submenu"></ul></li>
				<li>영화 관리
					<ul class="submenu">
						<li><a href="movieReg">영화등록</a></li>
						<li><a href="movieList">영화 목록 및 관리</a></li>
					</ul>
				</li>
				<li>영화관 관리
					<ul class="submenu">
						<li><a href="theaterReg">영화관 등록</a></li>
						<li><a href="theaterList">영화관 목록 및 관리</a></li>
					</ul>
				</li>
				<li><a href="adminReservationView">예매내역 관리</a>
				<ul class="submenu"></ul>
				</li>
				<li>상품 관리
					<ul class="submenu">
						<li><a href="productReg">상품 등록</a></li>
						<li><a href="productList">상품 목록 및 관리</a></li>
					</ul>
				</li>
				<li>매출 관리
					<ul class="submenu">			
						<li><a href="movieSalesPage">영화 및 영화관</a></li>
						<li><a href="adminProductSalesView">상품</a></li>
					</ul>
				</li>
				<li>이벤트
					<ul class="submenu">			
						<li><a href="adminEventRegi">이벤트 등록</a></li>
						<li><a href="adminEventView">이벤트 목록 및 관리</a></li>
					</ul>
				</li>
				<li><a href="MemberMGMT">회원 관리</a></li>
				<li><a href="qnaView">Q&A 관리</a></li>
				<li><a href="adNoticeView">공지사항 관리</a></li>
				<li><a href="adminReplyView">한줄평 관리</a></li>
			</ul>
		</nav>
	</div>
</body>