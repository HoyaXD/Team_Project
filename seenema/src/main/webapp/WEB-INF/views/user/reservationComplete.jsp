<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/23
  Time: 2:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
            margin: 20px auto;
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
        .top_img{
            width: 200px;
            height: 100px;
        }


    </style>
</head>
<body>
<%@ include file="header.jsp"%>
<div class="mainContainer">

    <h1>예매해주셔서 감사합니다!</h1><br>
    <h3>예매내역은 마이페이지에서 확인 가능합니다.</h3>

    <div class="movie-details-container">
        <div class="movie-poster">
            <img src="/resources/images/${movie.postFileName }" alt="영화 포스터">
        </div>
        <div class="movie-info">
            <h2 class="movie-title">${reservation.movieTitle}</h2>
            <br>
            <p>예매번호 : ${reservation.ticketCode}</p>
            <p class="showtime">상영일시: ${reservation.movieDate} ${reservation.reservationTime}</p>
            <p class="theater">상영관: ${reservation.theaterPlace}${reservation.theater}</p>
            <p class="ticket-info">관람인원: ${reservation.visitors}명 / 좌석: ${reservation.seats}</p>
            <p class="total-price">총 결제금액: <span id="totalPrice">${reservation.ticketPrice}</span>원</p>
            <p class="payment-method">결제수단: 카카오페이</p>
        </div>
    </div>

</div>
<%@include file="footer.jsp"%>

<script>
    let totalPriceElement = document.getElementById("totalPrice");
    let totalPrice = totalPriceElement.innerHTML;
    totalPrice = parseInt(totalPrice).toLocaleString(); // 쉼표 추가
    totalPriceElement.innerHTML = totalPrice;
</script>
</body>
</html>
