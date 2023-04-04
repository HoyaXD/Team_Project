<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/16
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>좌석예매 - 시네마</title>
    <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<%--    <link rel="stylesheet" href="/css/reservationSeats.css">--%>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <style>
        .seat.reserved {
            background-color: #c7c5c5;
            cursor: not-allowed;
            color: white;
            width: 50px;
            height: 50px;
        }

        *{
            margin: 0 auto;
        }

        #screen{
            width: 800px;
            height: 50px;
            background-color: #ada8a8;
            text-align: center;
            line-height: 50px;
            font-size: 36px;
            margin-bottom: 40px;
            background-image: linear-gradient(45deg, #ccc 25%, transparent 25%, transparent 75%, #ccc 75%, #ccc);
            background-size: 7px 7px;
            background-clip: content-box;

        }

        #seats-container {
            width: 800px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .seat {
            background-color: #595858;
            color: white;
            margin-bottom: 10px;
            width: 50px;
            height: 50px;
            border-radius: 5px;
            border: 2px solid #ccc;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .seat.selected {
            background-color: #f13f3f;
            color: #fff;
        }

        #seats-label {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
            font-weight: bold;
        }

        #seats-label span {
            margin: 0 5px;
        }

        #seats-top {
            width: 800px;
            display: flex;
            align-items: center;
            padding: 20px;
            border-radius: 10px;
        }

        /* 인원 선택 영역 */
        #select_people {
        }

        #select_people select {
            margin-left: 10px;
            padding: 5px;
            border: none;
            background-color: #f1f1f1;
            border-radius: 5px;
        }

        #select_people label {
            font-weight: bold;
            margin-top: 10px;
        }

        /* 예매 정보 영역 */
        .reservation_info {
            font-size: 16px;
        }

        #reservation_info span {
            font-weight: bold;
        }

        /* 결제 버튼 */
        .buyNowBtn {
            display: inline-block;
            padding: 10px;
            background-color: #ee1919;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            width: 80px;
            height: 50px;
            line-height: 50px;
            font-size: 18px;
        }

        .buyNowBtn:hover {
            background-color: #ff0202;
        }
        .mainContainer{
            background-color: #e8e5dd;
            width: 1000px;
            padding-bottom: 50px;
        }
        .seats_title{
            width: 1000px;
            background-color: #4b4f56;
            color: white;
            text-align: center;
            height: 50px;
            margin-top: 30px;
            line-height: 50px;
            font-size: 30px;
        }
        #youth_label{
            margin-top: 5px;
        }
        #youth{
            margin-top: 3px;

        }
        .modal {
            position: fixed;
            z-index: 6;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            font-size: 24px;
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
            height: 40px;
            background-color: #4b4f56;
            color: white;
            text-align: center;
            line-height: 40px;
        }
        .modal_text{
            padding: 20px;
        }
        .cancel-btn2{
            margin-top: 7px;
            margin-bottom: 7px;
            padding: 10px 20px;
            background-color: #e82c2c;
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
        .movieImg img{
            width: 160px;
            height: 200px;
        }
        #regBtn{
            display: none;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="header.jsp"%>
</header>
<div class="mainContainer">
    <div class="seats_title">
        인원 / 좌석
    </div>
    <div id="seats-top">

        <div class="movieImg">
            <img src="/resources/images/${movie.postFileName }">
        </div>
        <div id="select_people">
            <label for="adults">성인</label> &nbsp;&nbsp;
            <select id="adults">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select><br>

            <label for="youth" id="youth_label">청소년</label>
            <select id="youth">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>

        </div>
        <div class="reservation_info">
            ${reservation.movieTitle}<br><br>
            ${reservation.theaterPlace} ${reservation.theater}<br><br>
            ${reservation.movieDate} ${reservation.reservationTime}<br><br>
                남은좌석 : <span id="remaining_seats"></span><br><br>
            가격 : <span id="totalPrice">0</span> 원<br>
        </div>
        <form action="reservation.do" method="post" name="frm">
            <input type="hidden" name="movieCode" id="movieCode" value="${reservation.movieCode}">
            <input type="hidden" name="ticketCode" id="ticketCode" >
            <input type="hidden" name="movieTitle" id="movieTitle" value="${reservation.movieTitle}">
            <input type="hidden" name="id" value="${sessionScope.logid }">
            <input type="hidden" name="theaterPlace" id="theaterPlace" value="${reservation.theaterPlace}">
            <input type="hidden" name="theater" id="theater" value="${reservation.theater}">
            <input type="hidden" name="ticketPrice" id="ticketPrice" value="${reservation.ticketPrice}">
            <input type="hidden" name="movieDate" id="movieDate" value="${reservation.movieDate}">
            <input type="hidden" name="reservationTime" id="reservationTime" value="${reservation.reservationTime}">
            <input type="hidden" name="visitors" id="visitors">
            <input type="hidden" name="seats" id="seats">
            <input type="submit" value="예매등록 테스트" id="regBtn" onclick="return f();">
            <div class="buyNowBtn" >결제하기</div>
        </form>
    </div>
        <input type="hidden" name="rows" value="${theater.seat_row }" id="rows">
        <input type="hidden" name="cols" value="${theater.seat_column }" id="cols">
        <input type="hidden" name="viewAge" value="${movie.viewAge }" id="viewAge">


    <div class="seats_container">
    <div id="screen">SCREEN</div>
    <div id="seats-container"></div>
    </div>
</div>
<c:if test="${movie.viewAge == 15}">
<div class="modal">
    <div class="modal-content">
        <div class="modal_top">관람등급 안내
            <span class="close">&times;</span>
        </div>

        <div class="modal_text">
            본 영화는 <span style="color: #da6e21;">[15세 이상 관람가]</span> 입니다.<br>
            만 15세 미만 고객은 만 19세 이상 성인 보호자 동반 시 관람이 가능합니다.<br>
            연령확인 불가 시 입장이 제한될 수 있습니다.<br><br>

            ※연령확인 수단 지참: 학생증, 모바일 학생증, 청소년증, 여권<br>
            (사진, 캡쳐본 불가)<br>
        </div>
        <p><button class="cancel-btn2">동의하고 예매하기</button></p>
    </div>
</div>
</c:if>
<c:if test="${movie.viewAge == 19}">
<div class="modal">
    <div class="modal-content">
        <div class="modal_top">관람등급 안내
            <span class="close">&times;</span>
        </div>

        <div class="modal_text">
            본 영화는 <span style="color: red;">[청소년 관람불가]</span> 입니다.<br>
            관람 시 신분증을 꼭 지참해 주세요.<br>

            ※신분증: 주민등록증/운전면허증/여권/모바일 신분증(PASS, 정부24 등)<br>
            (신분증 사진 불가)<br>

            만 18세 미만(영/유아 포함)은 보호자가 있어도 관람하실 수 없으며,<br>
            만 18세 이상이더라도「초중등교육법」에 따라<br>
            재학 중인 학생은 관람이 불가합니다.<br>
        </div>
        <p><button class="cancel-btn2">동의하고 예매하기</button></p>
    </div>
</div>
</c:if>
<footer>

    <%@ include file="footer.jsp"%>
</footer>


<script>
    let selectedSeats = []; //선택한 좌석을 저장할 배열

    $(document).ready(function() {
        var data = {
            movieCode: $('#movieCode').val(),
            theater: $('#theater').val(),
            movieDate: $('#movieDate').val(),
            reservationTime: $('#reservationTime').val()
        };
        //이미 예매된좌석 불러오기
        $.ajax({
            type: 'POST',
            url: 'loadSeats',
            data: data,
            success: function(result) {
                // 예약된 좌석 배열을 저장할 변수 선언.
                const reservedSeats = [];

                // 예약된 좌석을 `,`로 split하여 배열에 저장.
                for (let i = 0; i < result.length; i++) {
                    const seats = result[i].split(',');
                    reservedSeats.push(...seats);
                }

                //좌석 행, 열 정해주기
                let rows = document.getElementById("rows").value;
                let cols = document.getElementById("cols").value;

                $('#remaining_seats').text((rows*cols - reservedSeats.length) + " / " + rows*cols);

                //좌석배치 생성
                function generateSeatLayout(rows, cols) {
                    const seatLayout = [];

                    for (let i = 0; i < rows; i++) {
                        const row = [];

                        for (let j = 0; j < cols; j++) {
                            const seat = String.fromCharCode(65 + j) + (i + 1);
                            row.push(seat);
                        }

                        seatLayout.push(row);
                    }

                    return seatLayout;
                }

                // 좌석배치 생성
                function renderSeatLayout(seatLayout) {
                    const seatsContainer = document.getElementById('seats-container');
                    seatsContainer.innerHTML = '';

                    for (let i = 0; i < seatLayout.length; i++) {
                        const row = seatLayout[i];
                        const rowEl = document.createElement('div');

                        for (let j = 0; j < row.length; j++) {
                            const seatEl = document.createElement('div');
                            seatEl.classList.add('seat');
                            seatEl.dataset.seat = row[j];
                            seatEl.innerText = row[j];

                            // 좌석이 예약되었는지 확인하고, 예약되었다면 reserved 클래스 추가
                            if (reservedSeats.includes(row[j])) {
                                seatEl.classList.add('reserved');
                            } else {
                                seatEl.addEventListener('click', () => {
                                    if (seatEl.classList.contains('selected')) {
                                        seatEl.classList.remove('selected');
                                        selectedSeats = selectedSeats.filter(s => s !== row[j]);
                                        seats.value = "";
                                        for (let i = 0 ; i <selectedSeats.length; i++){
                                            if(i != selectedSeats.length -1){
                                                seats.value += selectedSeats[i] + ",";
                                            }else {
                                                seats.value += selectedSeats[i];
                                            }
                                        }

                                    } else {
                                        if(parseInt(adultsInput.value) + parseInt(youthInput.value) == 0){
                                            alert('인원수를 먼저 선택해주세요.');
                                        }
                                        else if (selectedSeats.length < parseInt(adultsInput.value) + parseInt(youthInput.value)) {
                                            seatEl.classList.add('selected');
                                            selectedSeats.push(row[j]);
                                            seats.value = "";
                                            for (let i = 0 ; i <selectedSeats.length; i++){
                                                if(i != selectedSeats.length -1){
                                                    seats.value += selectedSeats[i] + ",";
                                                }else {
                                                    seats.value += selectedSeats[i];
                                                }
                                            }

                                        } else {
                                            alert('선택한 인원수를 초과하였습니다.');
                                        }
                                    }
                                });
                            }

                            rowEl.appendChild(seatEl);
                        }

                        seatsContainer.appendChild(rowEl);
                    }
                }
                let seatLayout = generateSeatLayout(rows, cols);
                renderSeatLayout(seatLayout);

            },
            error: function(xhr, status, error) {
                console.error(xhr, status, error);
            }
        });
    });



    document.getElementById('ticketCode').value =new Date().getTime();
    //성인 청소년 선택
    let adultsInput = document.getElementById('adults');
    let youthInput = document.getElementById('youth');
    let visitors = document.getElementById('visitors');
    let seats = document.getElementById('seats');

    function f(){
        if(visitors.value != selectedSeats.length){
            alert("선택하신 인원 수와 좌석수가 일치하지 않습니다. 인원수와 좌석을다시 확인해주세요");
            return false;
        }else {
            return true;
        }
    }

    $("#adults").on("change", function(){ //옵션값 변경 시 가격 자동 계산
        if(parseInt(adultsInput.value) + parseInt(youthInput.value) >6){
            alert('성인과 청소년을 합쳐 최대 6명까지 선택 가능합니다');
            adultsInput.value = 0;
        }
        //selected value


        document.getElementById('totalPrice').innerText = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('ticketPrice').value = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('visitors').value = parseInt(adultsInput.value) + parseInt(youthInput.value); //인원수에 값넣기


        let totalPriceElement = document.getElementById("totalPrice");
        let totalPrice = totalPriceElement.innerHTML;
        totalPrice = parseInt(totalPrice).toLocaleString(); // 쉼표 추가
        totalPriceElement.innerHTML = totalPrice;
    });

    $("#youth").on("change", function(){  //옵션값 변경 시 가격 자동 계산
        let viewAge = document.getElementById("viewAge").value;

        if(viewAge == 19){
            alert("청소년은 관람하실 수 없습니다.");
            youthInput.value = 0;
            return false;
        }

        if(parseInt(adultsInput.value) + parseInt(youthInput.value) >6){
            alert('성인과 청소년을 합쳐 최대 6명까지 선택 가능합니다');
            youthInput.value = 0;
        }
        //selected value
        document.getElementById('totalPrice').innerText = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('ticketPrice').value = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('visitors').value = parseInt(adultsInput.value) + parseInt(youthInput.value); //인원수에 값넣기

        let totalPriceElement = document.getElementById("totalPrice");
        let totalPrice = totalPriceElement.innerHTML;
        totalPrice = parseInt(totalPrice).toLocaleString(); // 쉼표 추가
        totalPriceElement.innerHTML = totalPrice;
    });






    const IMP = window.IMP;
    IMP.init("imp58206540");

    // 결제 하기
    $(document).on("click", ".buyNowBtn", function(){
        if(visitors.value == 0){
            alert("인원수와 좌석이 선택되지 않았습니다");
            return false;
        }
        if(visitors.value != selectedSeats.length){
            alert("선택하신 인원 수와 좌석수가 일치하지 않습니다. 인원수와 좌석을다시 확인해주세요");
            return false;
        }
        let ticketCode = parseInt(new Date().getTime(), 10);	// 주문번호
        let movieTitle = document.getElementById('movieTitle').value;	// 영화제목
        let ticketPrice = document.getElementById('ticketPrice').value;	// 결제 금액
        let userName = document.getElementById('name').value;	//유저 이름

        IMP.request_pay({
            pg: "html5_inicis",
            pay_method: "card",
            merchant_uid: ticketCode,   // 주문번호
            name: movieTitle,
            amount: ticketPrice,  //ticketPrice로 수정해야함
            buyer_name: userName,
        },  function (rsp) { // callback
            if (rsp.success) {
                // 결제 성공
                document.frm.submit();
            } else {
                // 결제 실패
                alert("결제를 취소하였습니다.");
                console.log(rsp);
            }
        });
    });


    // 모달창 닫기
    function closeModal() {
        document.querySelector('.modal').style.display = 'none';
    }

    function historyBack(){
        history.back();
    }

    // 모달창 닫기 버튼 클릭 이벤트
    document.querySelector('.close').addEventListener('click', historyBack);
    document.querySelector('.cancel-btn2').addEventListener('click', closeModal);

    // 모달창 외부 클릭 이벤트
    // window.addEventListener('click', function(event) {
    //     if (event.target == document.querySelector('.modal')) {
    //         closeModal();
    //     }
    // });



</script>
</body>
</html>
