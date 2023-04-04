<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/23
  Time: 2:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화예매 상세내역 - 시네마</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .mainContainer {
            margin-top: 70px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            margin-bottom: 100px;
        }

        .movie-details-container {
            width: 1000px;
            display: flex;
            align-items: center;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        .movie-poster {
            padding-top: 30px;
            padding-bottom: 30px;
            width: 500px;
            margin-right: 40px;
        }

        .movie-poster img {
            width: 300px;
            height: auto;
        }

        .movie-info {
            display: flex;
            flex-direction: column;
            width: 400px;

        }

        .movie-title {
            margin: 0 0 10px;
            font-size: 32px;
            font-weight: bold;
        }

        .movie-info p {
            margin: 0 0 10px;
            font-size: 20px;
            line-height: 1.5;
            text-align: center;
        }


        .total-price {
            font-weight: bold;
        }

        .cancel-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff5a5f;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background-color: #ff3b3f;
        }


        .total-price {
            font-weight: bold;
        }
        .cancel-btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff5a5f;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .cancel-btn:hover {
            background-color: #ff3b3f;
        }
        .mainContainer {
            text-align: center;
        }
        h1{
            margin-bottom: 50px;
        }
        .top{
            background-color: #4b4f56;
            color: white;
            width: 1000px;
            height: 50px;
            line-height: 50px;
            font-size: 30px;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 6;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            margin-right: 10px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            color: grey;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            margin-right: 8px;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .modal_top{
            width: 100%;
            height: 30px;
            background-color: #4b4f56;
            color: white;
            text-align: center;
            line-height: 30px;
        }
        .modal_text{
            padding: 20px;
        }
        .cancel-btn2{
            margin-top: 7px;
            margin-bottom: 7px;
            padding: 10px 20px;
            background-color: #4b4b48;
            color: #fff;
            width: 200px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .modal p{
            text-align: center;
        }

    </style>
</head>
<body>
    <%@ include file="header.jsp"%>
    <div class="mainContainer">
<%--        <h1>예매내역 상세조회</h1>--%>
    <c:if test="${reservation.status eq 1}">
        <div class="top">예매 내역</div>
    </c:if>
    <c:if test="${reservation.status ne 1}">
        <div class="top">취소 내역</div>
    </c:if>
        <div class="movie-details-container">
            <div class="movie-poster">
                <img src="/resources/images/${movie.postFileName }" alt="영화 포스터">
            </div>
            <div class="movie-info">
                <h2 class="movie-title">${reservation.movieTitle}</h2>
                <br>
                <p>예매번호 : ${reservation.ticketCode}</p>
                <p>예매일 : ${reservation.reservationDate}</p>
                <p class="showtime">상영일시: ${reservation.movieDate} ${reservation.reservationTime}</p>
                <p class="theater">상영관: ${reservation.theaterPlace}${reservation.theater}</p>
                <p class="ticket-info">관람인원: ${reservation.visitors}명 / 좌석: ${reservation.seats}</p>
                <p class="total-price">총 결제금액: <span id="totalPrice">${reservation.ticketPrice}</span>원</p>
                <p class="payment-method">결제수단: 카카오페이</p>
                <c:if test="${reservation.status eq 1}">
                    <p><button class="cancel-btn" onclick="openModal()">예매 취소</button></p>
                </c:if>

            </div>
        </div>
    </div>
    <div class="modal">
        <div class="modal-content">
            <div class="modal_top">유의사항
            <span class="close">&times;</span>
            </div>
            <div class="modal_text">
            환불 안내<br>
            신용카드<br>
            결제 후 3일 이내 취소 시 승인 취소 가능합니다.<br>
            3일 이후 예매 취소 시 영업일 기준 3일 ~ 7일 이내 카드사에서 환불됩니다.<br>
            체크카드<br>
            결제 후 3일 이내 취소 시 당일 카드사에서 환불 처리됩니다.<br>
            3일 이후 예매 취소 시 카드사에 따라 3일 ~ 10일 카드사에서 환불됩니다.<br>
            휴대폰 결제<br>
            결제 일자 기준 당월(1일 ~ 말일까지) 취소만 가능합니다.<br>
            익월 취소의 경우 씨네마 고객센터(1588-0000)로 문의 주시기 바랍니다.<br>
            모바일캐시비/티머니<br>
            모바일캐시비(선불형): 모바일캐시비 APP 선물함으로 취소금액이 충전됩니다.<br>
            모바일티머니(선불형): 환불 SMS 수신 후 URL 클릭하시면 모바일티머니 APP이 자동으로 실행되어 취소금액이 충전됩니다.<br>
            모바일캐시비/티머니(후불형): 취소금액은 환불되지 않고, 신용카드 대금에서 청구 취소됩니다. (취소일 7일 이내 카드사 청구내역에서 확인 가능합니다.)<br>
            모바일캐시비/티머니(플라스틱카드): 교통카드충전결제 APP 실행 후, [환불내역]에서 카드 태깅하여 카드로 충전됩니다.<br>
            예매 및 추가상품 구매 취소 안내<br>
            온라인 예매 및 추가상품 구매 취소는 상영 20분 전까지 가능하며, 20분 이전부터는 현장 취소만 가능합니다.<br>
            티켓에 표기된 상영시작시간 이후 환불은 불가합니다.<br>
            무대인사, 스페셜상영회, GV, 라이브뷰잉 등 특별 상영 회차의 예매 취소는 상영전일 23시 59분 59초까지만 취소 가능합니다.<br>
            온라인 예매 후 현장에서 티켓 발권 시 온라인으로 예매 취소는 불가능하며, 현장 취소만 가능합니다.<br>
            적립 예정 S.POINT는 영화 관람 다음 날 적립됩니다.<br>
            예고편과 광고 상영으로 실제 영화 시작 시간이 10분 정도 차이 날 수 있습니다.<br>
            SMS 수신을 이용하시면 예매내역을 휴대폰으로 받을 수 있습니다.<br>
            반드시 전체 취소만 가능하며, 예매나 추가상품 중 부분 취소는 불가능합니다.<br>
            추가상품 수령 완료 시 예매 및 상품 취소 모두 불가능합니다.<br>
            포토티켓 발권 완료 시 환불은 발권된 포토티켓 지참 후 해당 영화관에서만 가능합니다.<br>
            </div>
            <p><button class="cancel-btn2" onclick="location.href='cancelReservation.do?ticketCode='+${reservation.ticketCode}">예매 취소</button></p>
        </div>
    </div>
<%@include file="footer.jsp"%>
<script>
    // 상영일시를 Date 객체로 변환
    const movieDate = new Date('${reservation.movieDate} ${reservation.reservationTime}');

    // 현재시간을 구하기
    const now = new Date();

    // 상영일시와 현재시간 차이를 구하기 (밀리초 단위)
    const diffInMs = movieDate.getTime() - now.getTime();

    // 차이가 1시간 이전이면 버튼을 활성화, 그렇지 않으면 비활성화
    if (diffInMs > 1800000) { // 3600000 밀리초 = 1시간
                              // 버튼 활성화
        document.querySelector('.cancel-btn').disabled = false;
    } else {
        // 버튼 비활성화
        document.querySelector('.cancel-btn').disabled = true;
        // 취소버튼의 배경색을 회색으로 바꾸기
        document.querySelector('.cancel-btn').style.backgroundColor = 'gray';

// 호버 이벤트 제거
        document.querySelector('.cancel-btn').classList.remove('hover-class');

// 버튼 텍스트 변경
        document.querySelector('.cancel-btn').textContent = '취소불가';
        $(".movie-info").append(
            '<p>(취소는 상영시간 30분 전 까지만 가능합니다.)</p>'
        )
    }

    let totalPriceElement = document.getElementById("totalPrice");
    let totalPrice = totalPriceElement.innerHTML;
    totalPrice = parseInt(totalPrice).toLocaleString(); // 쉼표 추가
    totalPriceElement.innerHTML = totalPrice;
    // 모달창 열기
    function openModal() {
        document.querySelector('.modal').style.display = 'block';
    }

    // 모달창 닫기
    function closeModal() {
        document.querySelector('.modal').style.display = 'none';
    }

    // 모달창 닫기 버튼 클릭 이벤트
    document.querySelector('.close').addEventListener('click', closeModal);

    // 모달창 외부 클릭 이벤트
    window.addEventListener('click', function(event) {
        if (event.target == document.querySelector('.modal')) {
            closeModal();
        }
    });
</script>
</body>
</html>
