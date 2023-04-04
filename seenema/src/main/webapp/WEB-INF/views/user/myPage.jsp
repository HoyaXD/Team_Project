<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/15
  Time: 2:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="/css/myOrderList2.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <style>
    #member_top{
      margin-top: 20px;
      width: 1000px;
      display: flex;
      height: 180px;
      background-color: #e8e5dd;
    }
    #sel_menu{
      width: 1000px;
      height: 50px;
      border-top: solid 1px gray;
      border-right: solid 1px gray;
      border-left: solid 1px gray;
      margin-top: 15px;
      display: grid;
      grid-template-columns: 333px 333px 333px;
      margin-bottom: 20px;
    }
    .menu_option{
      line-height: 50px;
      width: 333px;
      text-align: center;
      border-bottom: solid 1px gray;
    }
    #option_center{
      border-right: solid 1px #e3dcdc;
      border-left: solid 1px #e3dcdc;
    }
    #option_right{
      border-right: solid 1px gray;
    }
    #member_img{
      width: 150px;
      float: left;
    }
    #member_img img{
      float: left;
      margin-top: 25px;
      width: 130px;
      height: 130px;
    }

    .container{
      display: none;
    }
    .member_info{
      width: 400px;
      margin-top: 50px;
      font-size: 24px;
    }
    #memberName{
      font-size: 36px;
      margin-right: 15px;
    }
    #memberId{
      color: #808080;
    }
  </style>
</head>
<body>
<header>
  <%@ include file="header.jsp"%>
</header>
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
  <a href="#"><div class="menu_option">내 예매내역</div></a>
  <div class="menu_option" id="option_center" onclick="viewOrder();">내 결제내역</div>
  <a href="#"><div class="menu_option" id="option_right">내 정보수정</div></a>
</div>

<%--결제내역--%>
<div class="container" id="order_container">
  <header>
    <input type="hidden" id="id" value="${sessionScope.logid }">
  </header>
    <div class="buyListWrap">
      <div class="myOrderListTitle">나의️ 결제내역</div>
      <div class="searchBarWrap">
        <div id="searchContentChoice">
          <span>조회 내용</span>
          <button class="grayBtn on" value="1">결제완료</button>
          <button class="grayBtn" value="0">결제취소</button>
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
        <div id="right">
          <span>총</span><span class="listSize"></span><span>개</span>
        </div>
      </div>
      <ul id="itemList">
        <!-- 데이터 -->
      </ul>
      </div>
    </div>

<%@ include file="footer.jsp"%>
<script>


  $('.menu_option').click(function (e){ //영화 제목 선택
    $('.container').css({
      "display":"none"
    })
    $('.menu_option').css({
      "background-color":"white",
      "color":"black"
    })

    $('.menu_option').parent( 'div' ).css({
      "background-color":"white",
      "color":"black"
    })

    $(e.target).css({
      "background-color":"#5c5c5c",
      "color":"white"
    });

    $(e.target).parent( 'div' ).css({
      "background-color":"#5c5c5c",
      "color":"white"
    });
  })

  $('#option_center').click(function (e){ //영화 제목 선택
    $('#order_container').css({
      "display":"block"
    })
  })

  $("#searchBtn").on("click", function(){
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function(){
      let data = this.responseText;
      let obj = JSON.parse(data);
      if(obj.length == 0){
        $("#itemList").empty();
        $("#itemList").append(
                "<li class='listHead'>"
                + "<div>구매일</div>"
                + "<div>주문번호</div>"
                + "<div>상품명</div>"
                + "<div>결제금액</div>"
                + "<div>상태</div>"
                + "</li>"
                + "<li>"
                + "<div id='emptyListWrap'>구매 내역이 존재하지 않습니다.</div>"
                + "</li>"
        );
      }else{
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
        $(obj).each(function(index){
          $("#itemList").append(
                  "<li class='item'>"
                  + "<div class='orderDate'>" + this.orderDate + "</div>"
                  + "<div><a href='/user/orderDetailView?orderNum=" + this.orderNum + "'>" + this.orderNum + "</a></div>"
                  + "<div><a href='/user/orderDetailView?orderNum=" + this.orderNum + "' class='productName'>" + this.productName + "</a></div>"
                  + "<div>" + this.totalPrice + "<span>원</span></div>"
                  + (this.status == 1? "<div class='useable'>사용가능</div>" : "<div class='unUseable'>환불완료</div>")
                  + "</li>"

          );
        });
        $(".listSize").text(obj.length);	// 총 ??개
      }
    }
    let id = $("#id").val();
    let startDate = $("#datepicker1").val();
    let endDate = $("#datepicker2").val();
    let status = $("#searchContentChoice > .grayBtn.on").val();
    //alert(status + "," + id + "," + startDate + "," + endDate);
    xhttp.open("post", "/user/order/searchGetOrderList.do", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send("id=" + id + "&startDate=" + startDate + "&endDate=" + endDate + "&status=" + status);
  });
  // 데이트 피커 초기값 세팅
  $(document).ready(function () {
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
    let day = new Date();
    let today = day.toISOString().substring(0,10);
    let oneMonthAgo = new Date(day.setMonth(day.getMonth() - 1)).toISOString().substring(0,10);
    //console.log(oneMonthAgo);
    //console.log(today);
    $("#datepicker1").val(oneMonthAgo);
    $("#datepicker2").val(today);
  });

  // 1개월 3개월 6개월 버튼
  $(document).on("click", "#searchDateChoice > button", function(){
    let month = $(this).val();
    let afterDate = new Date($("#datepicker2").val());
    afterDate.setMonth(afterDate.getMonth() - month);
    let beforeDate = afterDate.toISOString().substring(0,10)
    $("#datepicker1").val(beforeDate);
  });

  // 페이지 로드되면 리스트 보여주기
  $(function(){
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function(){
      let data = this.responseText;
      let obj = JSON.parse(data);
      if(obj.length == 0){
        $("#itemList").append(
                "<li class='listHead'>"
                + "<div>구매일</div>"
                + "<div>주문번호</div>"
                + "<div>상품명</div>"
                + "<div>결제금액</div>"
                + "<div>상태</div>"
                + "</li>"
                + "<li>"
                + "<div id='emptyListWrap'>구매 내역이 존재하지 않습니다.</div>"
                + "</li>"
        );
      }else{
        $("#itemList").html(
                "<li class='listHead'>"
                + "<div>구매일</div>"
                + "<div>주문번호</div>"
                + "<div>상품명</div>"
                + "<div>결제금액</div>"
                + "<div>상태</div>"
                + "</li>"
        );
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
        $(".listSize").text(obj.length);	// 총 ??개
      }
    }
    let id = $("#id").val();
    xhttp.open("get", "/user/order/getOrderList.do?id=" + id, true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhttp.send();
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
