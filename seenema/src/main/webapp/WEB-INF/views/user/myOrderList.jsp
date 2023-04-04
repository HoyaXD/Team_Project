<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제내역 - 시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/myOrderList.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<%@include file="header.jsp" %>
	<div id="member_top">
	    <div id="member_img">
	        <img src="/images/user.png">
	    </div>
	    <div class="member_info">
	        <span id="memberName">${member.name }님</span>
	        <span id="memberId">${member.id }</span>
	        <p>고객님은 ${member.grade }등급 입니다</p>
	    </div>
	</div>
	<div id="sel_menu">
	    <a href="myReservation"><div class="menu_option" id="option_left">내 예매내역</div></a>
	    <a href="myOrderList"> <div class="menu_option" id="option_center">내 결제내역</div></a>
	    <a href="myUpdate"><div class="menu_option" id="option_right">내 정보수정</div></a>
	</div>
	<div class="container">
		<main>
			<div class="buyListWrap">
				<div class="myOrderListTitle">나의️ 결제내역</div>
				<div class="searchBarWrap">
					<div id="searchContentChoice">
						<span>조회 내용</span>
						<button class="grayBtn on" value="0">전체조회</button>
						<button class="grayBtn" value="1">결제완료</button>
						<button class="grayBtn" value="-1">결제취소</button>
					</div>
					<div id="searchDateChoice">
						<span>조회 기간</span>
						<button class="grayBtn on" value="1">1개월</button>
						<button class="grayBtn" value="3">3개월</button>
						<button class="grayBtn" value="6">6개월</button>
					</div>
					<div class="calendar">
						<span>기간 선택</span>
						<input type="text" class="before" id="datepicker1" readonly>
						<label id="img" for="datepicker1"></label>
						 ~ 
						<input type="text" class="now" id="datepicker2" readonly>
						<label id="img" for="datepicker2"></label>
						<input type="button" id="searchBtn" value="조회하기">
					</div>
				</div>
				<div id="totalCountWrap">
					<div id="productNotice">※ (주문번호 또는 상품명을 클릭하면 결제내역 상세조회가 가능합니다.)</div>
					<!-- <div id="right">
						<span>총</span><span class="listSize">0</span><span>개</span>
					</div> -->
				</div>
				<ul id="itemList">
				<!-- 데이터 -->
				</ul>
				<div class="beforeAfterWrap">
					<!-- 페이지네이션 -->
				</div>
			</div>
		</main>
	</div>
	<%@include file="footer.jsp" %>
<script>
	const id = $("#id").val();
	let totalPage = 0;	// 총 페이지 수
	let pageNum = 1;	// 페이지 번호

	$(document).ready(function(){
		//데이트 피커 초기화
		$.datepicker.setDefaults($.datepicker.regional['ko']); 
	    $("#datepicker1").datepicker({
	         nextText: '다음 달',
	         prevText: '이전 달', 
	 		 showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다.
	 		 currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	 		 closeText: '닫기',  // 닫기 버튼 패널
	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         dateFormat: "yy-mm-dd",
	         maxDate: 0                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
	    });
	    $("#datepicker2").datepicker({
	         nextText: '다음 달',
	         prevText: '이전 달', 
	 		 showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다.
	 		 currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	 		 closeText: '닫기',  // 닫기 버튼 패널
	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         dateFormat: "yy-mm-dd",
	         maxDate: 0,
	         onClose: function(selectedDate) {    
	              //시작일(startDate) datepicker가 닫힐때
	              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	             $("#datepicker1").datepicker("option", "maxDate", selectedDate);
	         }  
	    });
	    // 값 대입
	    let day = new Date();
	    let today = day.toISOString().substring(0,10);
	    let oneMonthAgo = new Date(day.setMonth(day.getMonth() - 1)).toISOString().substring(0,10);
	    $("#datepicker1").val(oneMonthAgo);
	    $("#datepicker2").val(today);
	    
	    // 목록,페이지네이션 함수호출
		getOrderList(pageNum);
		getTotalPage();
	});
	
	// 페이지 갯수
	function getTotalPage(){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			//alert("총 갯수 : " + result);
			totalPage = Math.ceil(result / 10);
			if(totalPage === 0){
				$(".beforeAfterWrap").empty();
			}else if(totalPage < 10){
				// 10페이지 이하일 경우 초기 세팅
				$(".beforeAfterWrap").empty();
				$(".beforeAfterWrap").append("<div class='prevBtn'>이전</div>");
				for(let i = 0; i < totalPage; i++){
					$(".beforeAfterWrap").append("<div class='pageCount'>" + (i + 1) + "</div>");
				}
				$(".pageCount").filter(":first").css("color", "red"); // 첫페이지 색깔 on
				$(".prevBtn").addClass("noBtn");
				$(".noBtn").removeClass("prevBtn");
			}else{
				// 만약 10페이지 이상일경우 다음버튼이랑 같이 출력(초기 페이지라 이전버튼 필요 X) css 박스 움직이는거 생각하기
				$(".beforeAfterWrap").empty();
				$(".beforeAfterWrap").append("<div class='prevBtn'>이전</div>");
				for(let i = 0; i < 10; i++){
					$(".beforeAfterWrap").append("<div class='pageCount'>" + (i + 1) + "</div>");
				}
				$(".beforeAfterWrap").append("<div class='nextBtn'>다음</div>");	// 다음버튼
				$(".pageCount").filter(":first").css("color", "red"); // 첫페이지 색깔 on
				$(".prevBtn").addClass("noBtn");
				$(".noBtn").removeClass("prevBtn");
			}
		}
		let status = $("#searchContentChoice > .grayBtn.on").val();
		xhttp.open("get", "/user/order/getOrderCount.do?id=" + id + "&status=" + status, true);
		xhttp.send();
	}
	
	// 페이지 번호별 리스트
	$(document).on("click", ".pageCount", function(){
		$(this).css("color", "red");	// 자기 자신한테만 색깔
		$(".pageCount").not(this).css("color", "black");	// 자기자신 빼고 색깔 X
		pageNum = $(this).text(); // 클릭된 번호 파라미터
		let status = $("#searchContentChoice > .grayBtn.on").val();
		if(status === 0){
			getOrderList(pageNum);
		}else{
			getSearchList(pageNum);
		}
	});
	
	// 이전 버튼
	$(document).on("click", ".prevBtn", function(){
		let status = $("#searchContentChoice > .grayBtn.on").val();
		let prevPage = parseInt($(".pageCount").filter(":first").text(), 10) - 1;
		if(status == 0){
			getOrderList(prevPage);
		}else{
			getSearchList(prevPage);
		}
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
		let status = $("#searchContentChoice > .grayBtn.on").val();
		let nextPage = parseInt($(".pageCount").filter(":last").text(), 10) + 1;
		if(status == 0){
			getOrderList(nextPage);
		}else{
			getSearchList(nextPage);
		}
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
	//전체목록
	function getOrderList(pageNum){
		//alert(pageNum);
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			//console.log(data);
			let obj = JSON.parse(data);
			//console.log(obj.length);
			$("#itemList").empty();
			$("#itemList").html(
					"<li class='listHead'>"
						+ "<div>구매일</div>"
						+ "<div>주문번호</div>"
						+ "<div>상품명</div>"
						+ "<div>결제금액</div>"
						+ "<div>상태</div>"
					+ "</li>"
			);
			if(obj.length == 0){
				$("#itemList").append("<li><div id='emptyListWrap'>구매 내역이 존재하지 않습니다.</div></li>")//구매내역 X
				$(".beforeAfterWrap").empty();
			}else{
				$(obj).each(function(index){
					$("#itemList").append(
							 "<li class='item'>"
								+ "<div class='orderDate'>" + this.orderDate + "</div>"
								+ "<div>"
									+ "<a href='/user/orderDetailView?orderNum=" + this.orderNum + "'>" + this.orderNum + "</a>"
								+ "</div>"
								+ "<div>" 
									+ "<a href='/user/orderDetailView?orderNum=" + this.orderNum + "' class='productName'>" + this.productName + "</a>" 
								+ "</div>"
								+ "<div>" + this.totalPrice.toLocaleString('ko-KR') + "<span>원</span></div>"
								+ (this.status == 1? "<div class='useable'>사용가능</div>" : "<div class='unUseable'>환불완료</div>")
							+ "</li>"
							
					);
				});
			}
		}
		xhttp.open("get", "/user/order/getOrderList.do?id=" + id + "&pageNum=" + pageNum, true);
		xhttp.send();
	}
	
	$("#searchBtn").on("click", function() {
		//alert("조회");
		let status = $("#searchContentChoice > .grayBtn.on").val();
		if(status === 0){
			getOrderList(pageNum);
			getTotalPage();
		}else{
		    getSearchList(pageNum); // pageNum 값 전달
		    getTotalPage();
		}
	});
	
	// 목록 상태값에따라 조회
	function getSearchList(pageNum){
		//alert(pageNum);
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			$("#itemList").empty();
			$("#itemList").html(
					"<li class='listHead'>"
						+ "<div>구매일</div>"
						+ "<div>주문번호</div>"
						+ "<div>상품명</div>"
						+ "<div>결제금액</div>"
						+ "<div>상태</div>"
					+ "</li>"
			);
			if(obj.length == 0){
				$("#itemList").append("<li><div id='emptyListWrap'>구매 내역이 존재하지 않습니다.</div></li>")//구매내역 X
				$(".beforeAfterWrap").empty();
			}else{
				$(obj).each(function(index){
					$("#itemList").append(
							 "<li class='item'>"
								+ "<div class='orderDate'>" + this.orderDate + "</div>"
								+ "<div>"
									+ "<a href='/user/orderDetailView?orderNum=" + this.orderNum + "'>" + this.orderNum + "</a>"
								+ "</div>"
								+ "<div>" 
									+ "<a href='/user/orderDetailView?orderNum=" + this.orderNum + "' class='productName'>" + this.productName + "</a>" 
								+ "</div>"
								+ "<div>" + this.totalPrice.toLocaleString('ko-KR') + "<span>원</span></div>"
								+ (this.status == 1? "<div class='useable'>사용가능</div>" : "<div class='unUseable'>환불완료</div>")
							+ "</li>"
					);
				});
			}
		}
		let startDate = $("#datepicker1").val();
		let endDate = $("#datepicker2").val();
		let status = $("#searchContentChoice > .grayBtn.on").val();
		//alert(pageNum);
		xhttp.open("post", "/user/order/searchGetOrderList.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("id=" + id + "&startDate=" + startDate + "&endDate=" + endDate + "&status=" + status + "&pageNum=" + pageNum);
	}
	
	// 1개월 3개월 6개월 버튼
	$(document).on("click", "#searchDateChoice > button", function(){
		let month = $(this).val();
		let afterDate = new Date($("#datepicker2").val());
		afterDate.setMonth(afterDate.getMonth() - month);
		let beforeDate = afterDate.toISOString().substring(0,10)
		$("#datepicker1").val(beforeDate);
	});
	
	// 조회 내용 선택
	$("#searchContentChoice > button").on("click", function(){
		$("#searchContentChoice > button").not(this).removeClass("on");	// 선택된 태그 on 클래스 제
		$(this).addClass("on");	// 자기자신만 on
	});
	
	// 조회 기간 선택
	$("#searchDateChoice > button").on("click", function(){
		$("#searchDateChoice > button").not(this).removeClass("on");
		$(this).addClass("on");
	});
</script>
</body>
</html>