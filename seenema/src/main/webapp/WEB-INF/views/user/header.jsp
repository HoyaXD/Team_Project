<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <style>
    *{
      /* margin: 0 auto; */
      padding: 0;
    }
    header ul, li{
      list-style: none;
      text-align: center;
    }
    header #header_top{
      width: 1300px;
      height: 140px;
      margin: 0 auto;
    }
    #top_after{
      border: 1px solid #d2cece;

    }
    header #top_logo{
      display: inline-block;
      float: left;
    }
    header #top_logo img{
      width: 300px;
      height: 120px;
    }
    header .top_menu{
      display: inline-block;
      float: right;
      margin-right: 60px;
    }
    header .top_menu li{
      font-size: 12px;
      margin-top: 60px;
      float:right;
      margin-left:40px;
    }
    header .top_menu img{
      width: 36px;
      height: 36px;
    }
    header a{
      text-decoration-line: none;
      color: black;
      /*border: 1px solid red;*/
    }
    header .menu_wrap {

      width: 1300px;
      height: 40px;
      margin: 0 auto;
      text-align: center;
      z-index: 3;
      position: relative;
      /*border: 1px solid blue;*/
    }
    header .menu_wrap li{

      margin-top: 10px;
      float: left;
      margin-right: 80px;
      font-size: 18px;
      /*border: 1px solid yellow;*/
    }

    header .nav_active{
      position: absolute;
      z-index: 2;
      /*width: 3000px;*/
      width: 100%;
      /* left: 100px; */
      height: 230px;
      background-color: white;
      border-bottom: solid 1px grey;
      display: none;
    }
    header .nav_active li{
      margin-top: 25px;
    }
    header .active_title{
      font-size: 18px;
      font-weight: bold;
      color: black;
    }
    header .nav_flex{
      width: 1300px;
      margin: 0 auto;
      z-index: 1;
      text-align: left;
    }
    header .under_menu{
      position: relative;
    }
    header .active_menu{
      display: inline-block;
      z-index: 3;
      border-right: solid 1px #d2cece;
      width: 250px;
      margin-right: 50px;
    }
    header #active_movie{

      /*margin-left: 20px;*/
    }

    header .active_menu li{
      text-align: left;
    }
    header #active_board{
      border: none;
    }
    header .active_a{
      background-color: white;
    }
    header .wrap_after{
      border: solid 1px red;
    }


  </style>
</head>
<body>

  <header id="header">
    <div id="header_top">
      <a href="/"><div id="top_logo"><img src="/images/logo3.png"></div></a>
      <div class="top_menu">
        <ul>
          <c:if test="${sessionScope.logid == null }">
          <li><a href="#"><img src="/images/service.png"><br>고객센터</a>
          <li><a href="/user/regAgree"><img src="/images/join.png"><br>회원가입</a>
          <li><a href="/user/loginForm"><img src="/images/login.png"><br>로그인</a>
            </c:if>
            <c:if test="${sessionScope.logid != null }">
            <li><a href="#"><img src="/images/service.png"><br>고객센터</a>
            <li><a href="/user/myCart"><img src="/images/cart.png"><br>장바구니</a>
            <li id="mypage"><a href="/user/myReservation"><img src="/images/my.png"><br>마이페이지</a>
            <li><a href="/user/logout"><img src="/images/login.png"><br>로그아웃</a>
            </c:if>
        </ul>
      </div>
    </div>
    <div id="top_after"></div>
    <div class = "under_menu">
      <div class = "menu_wrap">
        <ul class="dep1">
          <li><a href="#">영화</a></li>
          <li><a href="/user/reservationMain">예매</a></li>
          <li><a href="/user/storeView">스토어</a></li>
          <li><a href="/user/userNoticeBoard">게시판</a></li>
        </ul>
      </div>
      <div class="wrap_after"></div>
      <div class="active_a">
        <div class = "nav_active">
          <div class="nav_flex">
            <div id="active_movie" class="active_menu">
              <ul>
                <a href="#"><li class="active_title">영화</li></a>
                <a href="#"><li>무비차트</li></a>
                <a href="#"><li>아트하우스</li></a>
                <a href="#"><li>icecon</li></a>
              </ul>
            </div>
            <div id="active_reservation" class="active_menu">
              <ul>
                <a href="/user/reservationMain"><li class="active_title">예매</li></a>
                <a href="/user/reservationMain"><li>빠른 예매</li></a>
                <a href="/user/myReservation"><li>내 예매내역</li></a>
                <a href="#"><li>상영 일정</li></a>
              </ul>
            </div>
            <div id="active_store" class="active_menu">
              <ul>
                <a href="/user/storeView"><li class="active_title">스토어</li></a>
                <a href="#"><li>베스트</li></a>
                <a href="#"><li>관람권</li></a>
                <a href="#"><li>스낵 / 음료</li></a>
              </ul>
            </div>
            <div id="active_board" class="active_menu">
              <ul>
                <a href="/user/userNoticeBoard"><li class="active_title">게시판</li></a>
                <a href="/user/userNoticeBoard"><li>공지 / 뉴스</li></a>
                <a href="#"><li>Q&A</li></a>
                <a href="#"><li>상영관</li></a>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
<input type="hidden" id="id" value="${sessionScope.logid }">
<input type="hidden" id="name" value="${sessionScope.name }">
<input type="hidden" id="tel" value="${sessionScope.tel }">
<input type="hidden" id="stamp" value="${sessionScope.stamp }">
  </header>
<script>

  $(".dep1").hover(()=>{
      $(".nav_active").slideDown(500);
  });

  $('.under_menu').mouseleave(function (){
    $(".nav_active").slideUp(300);
  })
</script>
</body>
</html>
