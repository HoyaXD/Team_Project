<%@page import="org.green.seenema.vo.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 상세 - 시네마</title>
<link rel="stylesheet" href="/css/productDetailView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
	<%@include file="header.jsp" %>
	<div class="container">
		<main>
			<section class="section sectionTop">
				<img src="${product.productImage }">
				<div class="productDetail">
					<table>
						<tbody id="tbody">
							<tr>
								<%-- <th class="pCode">${product.productCode }</th> --%>
								<td style="display:none;">
									<input type="hidden" id="hiddenProductCode" name="productCode" value="${product.productCode }">
									<input type="hidden" id="hiddenProductName" name="productName" value="${product.productName }">
									<input type="hidden" id="hiddenProductprice" name="price" value="${product.price }">
								</td>
								<td colspan="2" class="productName">${product.productName }</td>
							</tr>
							<tr>
								<th>가격</th>
								<td class="productPrice"><span id="productPrice">${product.price }</span><span>원</span></td>
							</tr>
							<tr>
								<th>구성품</th>
								<td class="fontGray productInfo">${product.productInfo }</td>
							</tr>
							<tr>
								<th>구매제한</th>
								<td class="fontGray">구매제한 없음</td>
							</tr>
							<tr>
								<th>유효기한</th>
								<td class="fontGray">24개월</td>
							</tr>
						</tbody>
					</table>
					<div class="productCountBox">
						<div class="minusBtn">-</div>
						<div class="count">1</div>
						<div class="plusBtn">+</div>
					</div>
					<div class="showTotalPriceWrap">
						<div class="chong">총 상품금액</div><div id="totalPrice">${product.price }</div><span id="won">원</span>
					</div>
					<c:if test="${product.category != 'ticket' }">
					<div class="cartBuyBtnWrap">
						<div class="addCartBtn">장바구니에 담기</div>
						<div class="buyBtn">구매하기</div>
					</div>
					</c:if>
					<c:if test="${product.category eq 'ticket' }">
					<div class="buyTicketWrap">
						<div class="buyTicketBtn">구매하기</div>
					</div>
					</c:if>
				</div>
			</section>
			<section class="sectionBottom">
				<div class="noticeInfo">
					<p>
						<strong>이용안내</strong><br><br>
						• 극장 사정에 따라 일부 메뉴 제공이 어려울 수 있습니다.<br><br>
						• 해당 기프트콘은 오프라인 매점에서 실제 상품으로 교환할 수 있는 온라인 상품권입니다.<br><br>
						• 구매 후 전송받으신 기프트콘은,사용가능한 SEENEMA의 매점에서 지정된 해당 상품으로만 교환이 가능합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;해당 상품 내에서 팝콘 혹은 음료, 스낵 변경 시 추가 비용이 발생합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;교환 완료한 상품의 환불 및 반품은 불가합니다.<br><br>
						• 유효기간 연장을 신청하는 경우, 유효기간은 발급일로부터 5년 이내 횟수 제한 없이 기간 연장 가능하며,<br>
						&nbsp;&nbsp;&nbsp;&nbsp;1회 연장 시 3개월(92일) 단위로 유효기간이 연장됩니다.<br>  
						&nbsp;&nbsp;&nbsp;&nbsp;단, 이벤트 경품 및 프로모션 상품의 경우 유효기간 연장이 불가할 수 있습니다.<br><br>
						• 매점상품 기프트콘은 극장 매점에서 상품 교환 후 수령한 영수증으로 SEENEMA ONE 적립이 가능합니다.<br><br>
						• 상기 이미지는 실제와 다를 수 있습니다.<br><br>
						<strong>취소/환불</strong><br><br>
						• 구매자는 최초 유효기간 이내에 결제금액의 100%에 대해 결제취소/환불이 가능하며, 최초 유효기간 만료 후에는 수신자가 결제금액의 90%에 대해 환불 요청 가능합니다.<br><br>
						• 단, 이미 사용된 기프트콘에 대해서는 결제취소/환불 신청이 불가합니다. <br><br>
						• 결제취소는 홈페이지 > 마이페이지 > 결제내역의 해당 주문 상세내역에서 가능합니다.<br><br>
						• 수신자는 선물받은 기프트콘의 수신거절을 요청할 수 있으며, 이 경우 구매자에게 취소 및 환불에 대한 안내가 이루어집니다.<br><br> 
						• 결제취소 가능 기간이 경과한 후 수신자가 수신거절을 요청할 경우 구매자에게 기프트콘이 재발송됩니다.<br><br>
						• SEENEMA고객센터 9292-9292<br><br>
						<strong>미성년자 권리보호 안내</strong><br><br>
						• 미성년자인 고객께서 계약을 체결하시는 경우 법정대리인이 그 계약에 동의하지 아니하면 미성년자 본인 또는 법정대리인이 그 계약을 취소할 수 있습니다.<br><br>
						<strong>분쟁 해결</strong><br><br>
						1) 회사는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해의 보상 등에 관한 처리를 위하여<br>
						&nbsp;&nbsp;&nbsp;&nbsp;SEENEMA고객센터(9292-9292)를 설치 운영하고 있습니다.<br><br>
						2) 회사는 고객센터를 통하여 이용자로부터 제출되는 불만사항 및 의견을 처리합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보합니다.<br><br>
						3) 전자상거래 분쟁(청약철회등)과 관련한 이용자의 피해구제는 이용약관 및 전자상거래법 등 관련 법령에 따릅니다.<br>
					</p>
				</div>
			</section>
		</main>
	</div>
	<%@include file="footer.jsp" %>
<script>
	const price = parseInt($("#productPrice").text(), 10);	// 이 페이지 상품의 가격(정수타입으로 파싱)
	const id = $("#id").val();
	const IMP = window.IMP;
	IMP.init("imp58206540");
	
	// 티켓일경우 바로구매
	$(document).on("click", ".buyTicketBtn", function(){
		pay();
	});
	
	// 바로구매
	$(document).on("click", ".buyBtn", function(){
		pay();
	});
	
	// 결제
	function pay(){
		if($("#id").val() == ""){
			if(confirm("로그인 후 이용가능한 서비스입니다.\n로그인 하시겠습니까?") == true){
				location.href = "/user/loginForm";
			}else{
				return;
			}
		}
		let orderNum = parseInt(new Date().getTime(), 10);	// 주문번호
		let productCode = $("#hiddenProductCode").val();	// 제품코드
		let productName = $("#hiddenProductName").val();	// 제품명
		let price = parseInt($("#hiddenProductprice").val(), 10);	// 제품 단가
		let count = parseInt($(".count").text(), 10);	// 제품수량
		let totalPrice = price * count;	// 결제 금액
		let	id = $("#id").val();	// 유저 아이디
		let userName = $("#name").val();	//유저 이름
		//alert(totalPrice);
		IMP.request_pay({
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: orderNum,   // 주문번호
			name: productName,
			amount: totalPrice,
			buyer_name: userName,
		},  function (rsp) { // callback
				if (rsp.success) {
			  		// 결제 성공
					console.log(rsp);
			  		let refundCode = rsp.imp_uid;
			  		const xhttp = new XMLHttpRequest();
			  		xhttp.onload = function(){
			  			let result = parseInt(this.responseText, 10);
			  			if(result == 1){
				  			alert("결제가 완료되었습니다.\n결제내역은 마이페이지의 결제내역을 확인해주세요.");
				  			sendSms(orderNum);
			  			}else{
			  				alert("결제 실패하였습니다.");
			  			}
			  		}
			  		xhttp.open("post", "/user/order/buy.do", true);
			  		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  		xhttp.send("orderNum=" + orderNum + "&productCode=" + productCode + "&price=" + price + "&count=" + count + "&id=" + id + "&userName=" + userName + "&refundCode=" + refundCode);
				} else {
			  		// 결제 실패
			  		alert("결제를 취소하였습니다.");
					console.log(rsp);
				}
			});
	}
	
	//결제완료 문자보내기
	function sendSms(orderNum){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			// 굳이 결과를 안보여줘도 될듯...?
		}
		xhttp.open("post", "/user/send-one", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("orderNum=" + orderNum);
	}
	
	// 문서 로드되면 쉼표찍어서 보여주기
	$(document).ready(function(){
		$("#productPrice").text(price.toLocaleString('ko-KR'));
		$("#totalPrice").text(price.toLocaleString('ko-KR'));
	});
	
	// 상품 수량 (-)
	$(".minusBtn").on("click", function(){
		let nowCount = parseInt($(".count").text(), 10);	// 현재 수량
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount != 1){
			returnCount--;
			$(".count").text(returnCount);
			//console.log($(".count").text());
		}
		let totalPrice = (price * returnCount).toLocaleString('ko-KR'); // 쉼표찍기
		$("#totalPrice").text(totalPrice);	// 계산된 값 넣음
	});
	
	
	// 상품 수량 (+)
	$(".plusBtn").on("click", function(){
		let nowCount = parseInt($(".count").text(), 10);
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount < 5){
			returnCount++;
			$(".count").text(returnCount);
			//console.log($(".count").text());
		}
		let totalPrice = (price * returnCount).toLocaleString('ko-KR');	// 쉼표찍기
		$("#totalPrice").text(totalPrice);	// 계산된 값 넣음
	});
	
	// 장바구니 담기
	$(".addCartBtn").on("click", function(){
		if($("#id").val() == ""){
			if(confirm("로그인 후 이용가능한 서비스입니다.\n로그인 하시겠습니까?") == true){
				location.href = "/user/loginForm";
			}else{
				return;
			}
		}
		//const totalPriceStr = $("#totalPrice").text();
		//const priceStr = $("#productPrice").text();
		//console.log(totalPriceStr);
		//let price = priceStr.split(",").join("");	// 제품 판매가
		//let pInfo = $(".productInfo").text();		// 제품 구성
		
		let pCode = $("#hiddenProductCode").val();				// 제품 코드
		let pCount = $(".count").text();			// 제품 개수
		//console.log(totalPrice);
		//console.log("제품 코드 : " + pCode + "\n제품명 : " + pName + "\n제품 판매가 : " + price + "\n제품 구성 : " + pInfo + "\n장바구니에 담을 제품 갯수 : " + pCount + "\n총 가격 : " + totalPrice);
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let result = parseInt(data, 10);
			if(result == 1){
				if(confirm("장바구니에 등록되었습니다.\n확인하시겠습니까?") == true){
					location.href = "/user/myCart?id=" + id;
				}
			}else if(result == -1){
				if(confirm("이미 장바구니에 존재하는 상품입니다.\n장바구니로 이동하시겠습니까?") == true){
					location.href = "/user/myCart?id=" + id;
				}
			}
		}
		xhttp.open("post", "/user/cart/addCart.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("productCode=" + pCode + "&productCount=" + pCount + "&id=" + id);
	});
</script>
</body>
</html>