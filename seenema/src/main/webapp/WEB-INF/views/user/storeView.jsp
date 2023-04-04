<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 목록 - 시네마</title>
<link rel="stylesheet" href="/css/storeView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<%@include file="header.jsp" %>
	<div class="blackColor">
		<div class="topImageWrap">
			<img id="topImage" src="/images/storeTop.png">
		</div>
	</div>
	<div class="contents">
		<nav class="navBar"><!-- 상단 메뉴바 -->
			<ul class="menuBar">
				<li id="bestMenu">
					<a class="menu" id="best" href="#bestScroll">베스트</a>
				</li>
				<li id="ticketMenu">
					<a class="menu" id="ticket" href="#ticketScroll">관람권</a>
				</li>
				<li id="snackMenu">
					<a class="menu" id="snack" href="#snackScroll">스낵/음료</a>
				</li>
			</ul>
		</nav><!-- 상단 메뉴바 -->
		
		<!-- 베스트 -->
		<div class="bestWrap">
			<div id="bestScroll">&nbsp;</div>
			<div class="sectionTitle">베스트 상품</div>
			<div class="itemWrap">
				<c:forEach var="item" items="${list }">
					<c:choose>
						<c:when test="${item.category eq 'package' or item.category eq 'ticket' or item.productName eq '콜라 M'}">
							<a href="/user/productDetailView?productCode=${item.productCode }" class="item item1">
								<img src="${item.productImage }">
								<div class="itemInfo">
									<div class="itm_tit">
										<h4>${item.productName }</h4>
										<p>${item.productInfo }</p>
										<div class="price">
											<fmt:formatNumber value="${item.price }" pattern="#,###" />원
										</div>
									</div>
								</div>
							</a>
						</c:when>
					</c:choose>
				</c:forEach>
			</div>
		</div>
		
		<!-- 관람권 -->
		<div class="ticketWrap">
			<div id="ticketScroll">&nbsp;</div>
			<div class="sectionTitle">관람권</div>
			<div class="itemWrap">
				<c:forEach var="item" items="${list }">
					<c:if test="${item.category eq 'ticket' }">
						<a href="/user/productDetailView?productCode=${item.productCode }" class="item item1">
							<img src="${item.productImage }">
							<div class="itemInfo">
								<div class="itm_tit">
									<h4>${item.productName }</h4>
									<p>${item.productInfo }</p>
									<div class="price">
										<fmt:formatNumber value="${item.price }" pattern="#,###" />원
									</div>
								</div>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<!-- 스낵, 음료 -->
		<div class="snackWrap">
			<div id="snackScroll">&nbsp;</div>
			<div class="sectionTitle">스낵/음료</div>
			<div class="itemWrap">
				<c:forEach var="item" items="${list }">
					<c:if test="${item.category eq 'snack'}">
						<a href="/user/productDetailView?productCode=${item.productCode }" class="item item1">
							<img src="${item.productImage }">
							<div class="itemInfo">
								<div class="itm_tit">
									<h4>${item.productName }</h4>
									<p>${item.productInfo }</p>
									<div class="price">
										<fmt:formatNumber value="${item.price }" pattern="#,###" />원
									</div>
								</div>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="absoluteBtnWrap">
        	<a href="/user/reservationMain" class="nowReservBtn">예매하기</a>
        	<a href="#header" class="scrollTopBtn">↑</a>
        </div>
	</div>
	<%@ include file="footer.jsp" %>
<script>
	// 스크롤 부드럽게
	$(document).on('click', 'a[href^="#"]', function (event) {
	    event.preventDefault();	// 기능 차단
	    $('html, body').animate({
	        scrollTop: $($.attr(this, 'href')).offset().top
	    }, 300);
	});
	
	// 스크롤에 따라 보더
	$(window).scroll(function () { 
		let scrollY = $(document).scrollTop(); 
		if(scrollY < 1370){
			$("#best").css("border-bottom", "3px solid black");
			$("#best").css("color", "black");
			$("#ticket").css("border-bottom", "none");
			$("#ticket").css("color", "gray");
		}else if(scrollY > 1880){
			$("#ticket").css("border-bottom", "none");
			$("#ticket").css("color", "gray");
			$("#snack").css("border-bottom", "3px solid black");
			$("#snack").css("color", "black");
			
		}else{
			$("#best").css("border-bottom", "none");
			$("#best").css("color", "gray");
			$("#ticket").css("border-bottom", "3px solid black");
			$("#ticket").css("color", "black");
			$("#snack").css("border-bottom", "none");
			$("#snack").css("color", "gray");
		}
	    console.log(scrollY); //스크롤 y축 좌표
	});
</script>
</body>
</html>
