<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세페이지 - 시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/orderDetailView.css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
<input type="hidden" id="hiddenOrderNum" value="${orderNum }">
	<%@include file="header.jsp" %>
	<div class="container">
		<main>
			<ul class="items">
				<li class="item">
					<div class="dateOrderNumWrap">
						<div class="dateTitle">구매일</div>
						<div class="date"></div>
						<div class="orderNumTitle">주문번호</div>
						<div class="orderNum"></div>
						<div class="refundCode" style="display:none;"></div>
						<div class="allCancleBtnWrap"><button id="allCancleBtn" type="button">결제취소</button></div>
					</div>
				</li>
			</ul>
			
			<ul class="paymentWrap">
				<li class="item">
					<div class="paymentProductDetailWrap">
						<div class="titleLine" id="paymentProductInfoTitle">구매상품 정보</div>
						<div id="productInfoTh">
							<div id="productNameTh">상품명</div>
							<div id="priceTh">판매금액</div>
							<div id="countTh">수량</div>
							<div id="totalPriceTh">구매금액</div>
						</div>
						<div class="info">
							<div class="wrap">
								<img id="productImg" src="">
								<div class="nameWrap">
									<div id="productName"></div>
									<div id="productInfo"></div>
								</div>
							</div>
							<div>
								<span class="oneProductPrice"></span><span>원</span>
							</div>
							<div>
								<span class="paymentCount"></span><span>개</span>
							</div>
							<div>
								<span class="paymentTotalPrice"></span><span>원</span>
							</div>
						</div>
					</div>
				</li>
			</ul>
			
			<ul class="useInfoWrap">
				<!-- loop -->
			</ul>
			
			<ul class="paymentBottom">
				<li class="item">
					<div class="paymentInfoWrap">
					<div class="titleLine">결제 정보</div>
					<div class="wrap paymentInfo">
						<div class="title">총 결제금액</div>
						<div class="paymentInfoPrice">
							<span class="paymentBottomTotalPrice">5000</span><span>원</span>
						</div>
					</div>
					</div>
				</li>
			</ul>
			<div class="noticeBox">
				<div class="noticeTitle">
					<div>기프티콘 취소/환불안내</div>
					<div>미성년자 권리보호 안내</div>
					<div>분쟁 해결</div>
				</div>
				<div class="noticeContent">
					<p>
						- 구매하신 기프티콘 상품의 취소/환불을 원하실 경우에는 다음 내용을 참고해주세요.<br><br>
						<strong>※ 청약 철회</strong><br>
						- 기프티콘을 사용하기 이전에 청약 철회 가능<br>
						<strong>※ 청약 철회를 할 수 없는 경우</strong><br>
						- 이미 사용된 교환권에 대해서는 취소/환불 불가<br><br>
						<strong>※ 청약 철회 대상자</strong><br>
						- 이미 사용된 교환권에 대해서는 취소/환불 불가<br><br>
						<strong>※ 청약 철회 방법</strong><br>
						- 마이 페이지 > 결제내역조회 > 해당 주문 상세내역에서 취소 선택<br>
						- 기프티콘은 구매일로 부터 60일 이내 결제취소 가능<br><br>
						- 미성년자인 고객께서 계약을 체결하시는 경우 법정대리인이<br>
						&nbsp;&nbsp;그 계약에 동의하지 아니하면 미성년자 본인 또는 법정대리인이 그 계약을 취소할 수 있습니다.
						<br><br>
						- 회사는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해의 보상 등에 관한 처리를 위하여<br> 
						&nbsp;&nbsp;&nbsp;SEENEMA 고객센터(1111-2222)를 설치 운영하고 있습니다.
					</p>
				</div>
			</div>
		</main>
	</div>
	<%@include file="footer.jsp" %>
</body>
<script>
	$(document).ready(getList());
	function getList(){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			
			$(".date").text(obj.searchDate);
			$(".orderNum").text(obj.orderNum);
			$(".refundCode").text(obj.refundCode);
			$("#productImg").attr("src", obj.productImage);
			$("#productName").text(obj.productName);
			$("#productInfo").text(obj.productInfo);
			$(".oneProductPrice").text(obj.price.toLocaleString('ko-KR'));
			$(".paymentCount").text(obj.count);
			$(".paymentTotalPrice").text(obj.totalPrice.toLocaleString('ko-KR'));
			$(".paymentBottomTotalPrice").text(obj.totalPrice.toLocaleString('ko-KR'));
			$("#allCancleBtn").val(obj.orderNum);
			$(".useInfoWrap").empty();
			for(let i = 0; i < obj.count; i++){
				$(".useInfoWrap").append(
					"<li class='item itemBox'>"
						+ "<div class='titleLine'>사용 정보</div>"
						+ "<div class='line itemLine'>"
							+ "<div class='title'>주문자</div>"
							+ "<div id='userId'>" + obj.userName + "</div>"
						+ "</div>"
						+ "<div class='line'>"
							+ "<div class='title'>상품명</div>"
							+ "<div>" + obj.productName + "</div>"
						+ "</div>"
						+ "<div class='line'>"
							+ "<div class='title'>금액</div>"
							+ "<div><span id='paymentOnePrice'>" + obj.price.toLocaleString('ko-KR') + "</span><span>원</span></div>"
						+ "</div>"
						+ "<div class='line'>"
							+ "<div class='title'>상태</div>"
							+ (obj.status == 1 ? 
								"<div class='wrap'>"
									+ "<div class='status' style='color: green;'>사용가능</div>"
								+ "</div>"
								: 
								"<div class='wrap'>"
									+ "<div class='status' style='color: red;'>환불완료</div>"
								+ "</div>"	
							)
						+ "</div>"
					+ "</li>"
				);
				if(obj.status == -1){
					$("#allCancleBtn").css("display", "none");
				}
			}
		}
		let orderNum = $("#hiddenOrderNum").val();
		//alert(orderNum);
		xhttp.open("get", "/user/order/getDetail.do?orderNum=" + orderNum, true);
		xhttp.send();
	}
	
	// 환불 실행
	$("#allCancleBtn").on("click", function(){
		if(confirm("결제를 취소하시겠습니까?") == true){
			
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let result = parseInt(this.responseText, 10);
				if(result == 1){
					alert("결제를 취소하였습니다.");
					getList();
				}else{
					alert("결제취소 실패");
				}
			}
			let orderNum = $(this).val();
			xhttp.open("post", "/user/order/refund.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("orderNum=" + orderNum);
		}
	});
</script>
</html>