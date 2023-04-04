<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 - 시네마</title>
<link rel="stylesheet" href="/css/myCart.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
	<%@include file="header.jsp" %>
	<div class="container">
	<div class="topTitle">나의 장바구니</div>
		<ul id="itemList">
			<!-- 데이터 -->
		</ul>
		<div class="bottomWrap">
			<div class="selectDeleteBtn"><div>선택상품 삭제</div><div class="selectedCount"></div></div>
			<div class="priceInfoWrap">
				<div class="chong">총 결제금액&nbsp;</div>
				<div class="calcPriceWrap">
					<div id="totalPrice">0</div><div>원</div>
				</div>
			</div>
		</div>
		<div class="btnWrap">
			<div class="buyBtn">구매하기</div>
		</div>
	</div>
	<%@include file="footer.jsp" %>
<script>
	// 리스트 출력
	$(document).ready(getCartList());
	
	function getCartList(){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let list = JSON.parse(data);
			$("#itemList").empty();
			if(list.length == 0){
				$("#itemList").append(
					"<li class='listHead'>"
						+ "<div class='checkBox'>"
							+ "<input type='checkbox' class='emptyListCheckBox' id='checkAll'><label class='emptyListCheckBox' for='checkAll'>✓</label>"
						+ "</div>"
						+ "<div>상품명</div>"
						+ "<div>판매금액</div>"
						+ "<div>수량</div>"
						+ "<div>구매금액</div>"
						+ "<div>선택</div>"
					+ "</li>"
					+ "<li>"
						+ "<div id='emptyListWrap'>장바구니 내역이 존재하지 않습니다.</div>"
					+ "</li>"
				);
				$("#totalPrice").text(0);	// 총 가격 초기화
				$(".bottomWrap").css("display", "none");
				$(".buyBtn").css("display", "none");
			}else{
				$("#itemList").append(
					"<li class='listHead'>"
						+ "<div class='checkBox'>"
							+ "<input type='checkbox' id='checkAll' checked><label for='checkAll'>✓</label>"
						+ "</div>"
						+ "<div>상품명</div>"
						+ "<div>판매금액</div>"
						+ "<div>수량</div>"
						+ "<div>구매금액</div>"
						+ "<div>선택</div>"
					+ "</li>"
				);
				$(".selectedCount").empty();
				$(list).each(function(index){
					$("#itemList").append(
						"<li class='item'>"
							+ "<div class='checkBox'>"
								+ "<input type='checkbox' id='chck" + index + "' class='check' value='" + index + "' checked>"
								+ "<input type='hidden' class='inputProductCode' value='" + this.productCode + "'>"
								+ "<input type='hidden' class='inputProductName' value='" + this.productName + "'>"
								+ "<input type='hidden' class='inputProductInfo' value='" + this.productInfo + "'>"
								+ "<input type='hidden' class='inputPrice' value='" + this.price + "'>"
								+ "<input type='hidden' class='inputProductCount' value='" + this.productCount + "'>"
								+ "<input type='hidden' class='inputTotalPrice' value='" + this.productCount * this.price + "'>"
								+ "<label for='chck" + index + "'>✓</label>"
							+ "</div>"
							+ "<div>"
								+ "<img id='productImage' src='" + this.productImage + "'>"
							+ "</div>"
							+ "<div class='titleInfoWrap'>"
								+ "<div id='productName'>" + this.productName + "</div>"
								+ "<div id='productInfo'>" + this.productInfo + "</div>"
							+ "</div>"
							+ "<div>"
								+ "<span class='price price" + index + "'>" + parseInt(this.price, 10).toLocaleString('ko-KR') + "</span>"
								+ "<span class='won'>원</span>"
							+ "</div>"
							+ "<div class='countWrap'>"
								+ "<div class='wrap'>"
									+ "<div class='count'>" + this.productCount + "</div>"
									+ "<div class='upDownBtnWrap'>"
										+ "<div class='plusBtn'>▲</div>"
										+ "<div class='minusBtn'>▼</div>"
									+ "</div>"
								+ "<div class='applyBtn'>변경</div>"
								+ "</div>"
							+ "</div>"
							+ "<div class='oneProductTotalPriceWrap'>"
								+ "<span class='prodTotalprice price" + index + "'>" + parseInt(this.totalPrice, 10).toLocaleString('ko-KR') + "</span>"
								+ "<span class='won'>원</span>"
							+ "</div>"
							+ "<div class='buyNowWrap'>"
								+ "<button class='buyNowBtn' type='button'>바로구매</button>"
							+ "</div>"
							+ "<div>"
								+ "<div class='deleteBtn'>X</div>"
							+ "</div>"
						+ "</li>"
					);
				});
				/* for(let i = 0; i < list.length; i++){
					let p = parseInt($(".price" + i).text(), 10);
					$(".price" + i).text(p.toLocaleString('ko-KR'));
				} */
				$("#totalPrice").text(0);	// 총 가격 초기화
				// 처음에 전부 체크인 상태로 로드
				let checks = $(".check");
				let totalPrice = parseInt($("#totalPrice").text().split(",").join(""), 10);
				
				$(".selectedCount").append("&nbsp;(" + checks.length + ")");	// 선택삭제 버튼 옆 갯수
				for(let i = 0; i < checks.length; i++){
					let price = parseInt(checks[i].parentElement.children[4].value, 10);
					let count = parseInt(checks[i].parentElement.children[5].value, 10);
					totalPrice += price * count;
				}
				$("#totalPrice").text(totalPrice.toLocaleString('ko-KR'));
			}
		}
		let id = $("#id").val();
		xhttp.open("post", "/user/cart/getCartList.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("id=" + id);
	}
	
	const IMP = window.IMP;
	IMP.init("imp58206540");
	
	// 일괄구매
	$(document).on("click", ".buyBtn", function(){
		let checks = $(".check:checked");
		let totalPrice = 0;	// 총 금액
		let productCodes = new Array();	// 제품코드 배열
		let prices = new Array();	// 제품수량 배열
		let counts = new Array();	// 제품수량 배열
		let productList = "";
		let orderNum = new Date().getTime();	// 주문번호
		let	id = $("#id").val();	// 유저 아이디
		let userName = $("#name").val();
		for(let i = 0; i < checks.length; i++){
			let productCode = parseInt(checks[i].parentElement.children[1].value, 10);
			let price = parseInt(checks[i].parentElement.children[4].value, 10);
			let count = parseInt(checks[i].parentElement.children[5].value, 10);
			if(i > 0){
				productList += "," + checks[i].parentElement.children[2].value;
			}else{
				productList += checks[i].parentElement.children[2].value;
			}
			totalPrice += price * count;
			
			productCodes.push(productCode);	// 제품코드 배열에 담기
			prices.push(price);			// 제품 가격 배열에 담기
			counts.push(count);			// 수량 배열에 담기
			console.log("제품 코드 : " + productCode + "\n금액 : " + price + "\n수량 : " + count);
		}
		IMP.request_pay({
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: orderNum,   // 주문번호
			name: productList,
			amount: totalPrice,
			buyer_name: userName, 
		},  function (rsp) { // callback
				if (rsp.success) {
			  		// 결제 성공
					//console.log(rsp);
			  		let refundCode = rsp.imp_uid;
					const xhttp = new XMLHttpRequest();
			  		xhttp.onload = function(){
			  			let result = parseInt(this.responseText, 10);
			  			if(result == 1){
				  			//alert("결제가 완료되었습니다.");
				  			successRemoveList(productCodes, id);
			  			}else{
			  				alert("결제 실패하였습니다.");
			  			}
			  		}
			  		xhttp.open("post", "/user/order/buyProducts.do", true);
			  		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  		xhttp.send("orderNum=" + orderNum + "&productCodes=" + productCodes + "&prices=" + prices + "&counts=" + counts + "&id=" + id + "&userName=" + userName + "&refundCode=" + refundCode);
				} else {
			  		// 결제 실패
			  		alert("결제 실패");
					console.log(rsp);
				}
			});
	});
	
	// 상품 선택 구매 후 장바구니 목록 삭제
	function successRemoveList(productCodes, id){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			if(result == 1){
				alert("결제가 완료되었습니다.\n결제내역은 마이페이지의 결제내역을 확인해주세요.");
				getCartList();
			}else{
				alert("주문 실패...");
			}
		}
		xhttp.open("post", "/user/cart/selectDelete.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("productCodes=" + productCodes + "&id=" + id);
	}
	
	// 개별 구매
	$(document).on("click", ".buyNowBtn", function(){
		let orderNum = parseInt(new Date().getTime(), 10);	// 주문번호
		let productCode = $(this).parent().parent().children().eq(0).children().eq(1).val();	// 제품코드
		let productName = $(this).parent().parent().children().eq(0).children().eq(2).val();	// 제품명
		let price = parseInt($(this).parent().parent().children().eq(0).children().eq(4).val(), 10);	// 제품 단가
		let count = parseInt($(this).parent().parent().children().eq(0).children().eq(5).val(), 10);	// 제품수량
		let totalPrice = parseInt($(this).parent().parent().children().eq(0).children().eq(6).val(), 10);	// 결제 금액
		let	id = $("#id").val();	// 유저 아이디
		let userName = $("#name").val();
		// console.log(
		//	"주문 번호 : " + orderNum + "\n제품코드 : " + productCode + "\n제품명 : " + productName + "\n제품 단가 : " + price
		//	+ "\n수량 : " + count + "\n총 결제 금액 : " + totalPrice + "\n아이디 : " + id
		//);
		IMP.request_pay({
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: orderNum,   // 주문번호
			name: productName,
			amount: 100,
			buyer_name: userName,
		},  function (rsp) { // callback
				if (rsp.success) {
			  		// 결제 성공
					//console.log(rsp);
			  		const xhttp = new XMLHttpRequest();
			  		xhttp.onload = function(){
			  			let result = parseInt(this.responseText, 10);
			  			if(result == 1){
				  			//alert("결제가 완료되었습니다.");
				  			success(productCode, id);
			  			}else{
			  				alert("결제 실패하였습니다.");
			  			}
			  		}
			  		xhttp.open("post", "/user/order/buy.do", true);
			  		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  		xhttp.send("orderNum=" + orderNum + "&productCode=" + productCode + "&price=" + price + "&count=" + count + "&id=" + id + "&userName=" + userName);
				} else {
			  		// 결제 실패
			  		alert("결제를 취소하였습니다.");
					console.log(rsp);
				}
			});
	});
	
	// 개별 주문 완료건 장바구니에서 삭제 실행
	function success(productCode, id){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			if(result == 1){
				alert("결제가 완료되었습니다.\n결제내역은 마이페이지의 결제내역을 확인해주세요.");
				getCartList();
			}
		}
		xhttp.open("post", "/user/cart/deleteProduct.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  		xhttp.send("productCode=" + productCode + "&id=" + id);
	}
	
	
	// 전체 체크(금액계산)
	$(document).on("click", "#checkAll", function(){
		$("#totalPrice").text(0);
		let checks = $(".check");
		let totalPrice = parseInt($("#totalPrice").text().split(",").join(""), 10);
		if($(this).is(":checked")){
    		checks.prop("checked", true);	// 0221 추가 선택 삭제버튼 옆 갯수
			$(".selectedCount").append("&nbsp;(" + checks.length + ")");
    		for(let i = 0; i < checks.length; i++){
    			let price = parseInt(checks[i].nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value, 10);
    			let count = parseInt(checks[i].nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value, 10);
    			totalPrice += price * count;
    		}
			//console.log("전체 체크(O) : " + totalPrice);
		}else{
			checks.prop("checked", false);
			$(".selectedCount").empty();
			totalPrice = 0;
			//console.log("전체 체크(X) : " + totalPrice);
		}
		let check = $(".check:checked").length;
		$(".selectedCount").empty();
		$(".selectedCount").append(
			"&nbsp;(" + check + ")"
		);
		$("#totalPrice").text(totalPrice.toLocaleString('ko-KR'));
	});
	
	// 개별 체크(금액 계산)
	$(document).on("click", ".check", function(){
		let totalPrice = parseInt($("#totalPrice").text().split(",").join(""), 10);
		if($(this).is(":checked")){
			if($(".check:checked").length == $(".check").length){
				$("#checkAll").prop("checked", true);
			}else{
				$("#checkAll").prop("checked", false);
			}
			//$(".checkAll").prop("checked", true);
			let price = parseInt($(this).next().next().next().next().val(), 10);
			let count = parseInt($(this).next().next().next().next().next().val(), 10);
			totalPrice += price * count;
			//console.log("개별 체크(O) : " + totalPrice);
		}else{
			$("#checkAll").prop("checked", false);
			let price = parseInt($(this).next().next().next().next().val(), 10);
			let count = parseInt($(this).next().next().next().next().next().val(), 10);
			totalPrice -= price * count;
			//console.log("개별 체크(X) : " + totalPrice);
		}
		//console.log(totalPrice);
		$("#totalPrice").text(totalPrice.toLocaleString('ko-KR'));
	});
	
	// 상품 개별 삭제버튼
	$(document).on("click", ".deleteBtn", function(e){
		if(confirm("해당 상품을 삭제하시겠습니까?") == true){
			let productCode = e.target.parentElement.parentElement.children[0].children[1].value;	// 제품코드
			let id = $("#id").val();	// 회원 아이디
			let minPrice = parseInt(e.target.parentElement.parentElement.children[0].children[6].value, 10);
			const params = {
					"productCode": productCode,
					"id": id
			};
			$.ajax({
				type: "post",
				url: "/user/cart/deleteProduct.do",
				data: params,
				success: function(data){
					let result = parseInt(data, 10);
					if(result == 1){
						alert("해당상품을 장바구니에서 삭제하였습니다.");
						getCartList();
					}else{
						alert("실패");
					}
				},
				error: function(){
					alert("오류");
				}
			});
		}
	});
	
	// 상품 수량 (-)
	$(document).on("click", ".minusBtn", function(){
		let nowCount = parseInt($(this).parent().prev().text(), 10);	// 현재 수량
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount != 1){
			returnCount--;
			$(this).parent().prev().text(returnCount);  // 반복이니까 자기자신 기준으로
		}
		
	});
	
	// 상품 수량 (+)
	$(document).on("click", ".plusBtn", function(){
		let nowCount = parseInt($(this).parent().prev().text(), 10);
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount < 5){
			returnCount++;
			$(this).parent().prev().text(returnCount);	// 반복이니까 자기자신 기준으로
		}
	});
	
	// 수량변경 실행
	$(document).on("click", ".applyBtn", function(){
		let count = parseInt($(this).parent().children().eq(0).text(), 10);
		let id = $("#id").val();
		let productCode = $(this).parent().parent().parent().children().eq(0).children().eq(1).val();
		//console.log("아이디 : " + id + "\n코드 : " + productCode + "\n수량 : " + count);
		const cart = {
			"productCode": productCode,
			"id": id,
			"count": count
		};
		$.ajax({
			type: "post",
			url: "/user/cart/updateProductCount.do",
			data: cart,
			success: function(data){
				let result = parseInt(data, 10);
				if(result == 1){
					alert("수량이 변경되었습니다.");
					getCartList();
				}else{
					alert("수량변경을 실패하였습니다.");
				}
			},
			error: function(){
				alert("오류");
			}
		});
	});
	// 선택삭제
	$(document).on("click", ".selectDeleteBtn", function(){
		if(confirm("선택하신 상품을 삭제하시겠습니까?") == true){
			let checks = $(".check");
			let productCodes = new Array();
			let id = $("#id").val();
			
			for(let i = 0; i < checks.length; i++){
				if(checks[i].checked){
					//console.log(checks[i].nextElementSibling.value);
					productCodes.push(checks[i].nextElementSibling.value);
				}
			}
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let data = this.responseText;
				if(data == "1"){
					alert("선택한 상품을 장바구니에서 삭제하였습니다.");
					getCartList();
				}else{
					alert("상품삭제 실패");
				}
			}
			xhttp.open("post", "/user/cart/selectDelete.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("productCodes=" + productCodes + "&id=" + id);
		}
	});
	
	// 버튼에 선택된 상품 갯수 보여주기
	$(document).on("click", ".check", function(){
		let checks = $(".check:checked").length;
		if(checks == 0){
			$(".selectedCount").empty();
			return;
		}else{
			$(".selectedCount").empty();
			$(".selectedCount").append(
				"&nbsp;(" + checks + ")"
			);
		}
	});
	
	$("#myOrderBtn").on("click", function(){
		location.href = "/user/myOrderList";
	});
</script>
</body>
</html>