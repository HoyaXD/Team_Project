<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/16
  Time: 2:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        .mainContainer{
        }
        .list_container{
            width: 700px;
            height: 230px;
        }
        .list_container button{
            margin-top: 10px;
            float: right;
        }
        .subContainer{
            width: 700px;
            height: 200px;
            border-bottom: solid 1px gray;
            border-top: solid 1px gray;
            margin-top: 30px;
        }
        .re_img{
            width: 170px;
            height: 190px;
            float: left;
        }
        .re_img img{
            width: 160px;
            height: 180px;
            margin-top: 10px;
            margin-left: 5px;
        }
        .re_info{
        }
        .info_top{
            margin-top: 15px;
            margin-left: 15px;
            padding-bottom: 15px;
            border-bottom: solid 1px #e1dbdb;
        }
        .info_top img{
            width: 15px;
            height: 15px;
        }
        .info_middle{
            padding-top: 15px;
            padding-bottom: 15px;
            border-bottom: solid 1px #e1dbdb;
        }
        .middle_right{
            float: right;
        }
        .info_bottom{
            padding-top: 15px;
            padding-bottom: 15px;
        }
        #title{
            margin-top: 15px;
            text-align: center;
            font-size: 30px;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="header.jsp"%>
</header>
<div class="mainContainer">
    <p id="title">예매내역</p>
    <c:forEach var="reservation" items="${list}">
    <div class="list_container">
        <div class="subContainer">
            <div class="re_img"><img src="/resources/imgs/titanic.jpeg"></div>
            <div class="re_info">
                <div class="info_top">
                    <span><img src="/images/12.png"></span>
                    <span>타이타닉</span>
                </div>
                <div class="info_middle">
                    <span>관람 일시 : 2022.02.14 10시 30분</span> <span class="middle_right">상영관 : 1관</span><br>
                    <span>관람 극장 : CGV 부산 서면</span> <span class="middle_right">관람좌석 :  A01, A02</span>
                </div>
                <div class="info_bottom">
                    <span>결제일자 : 2022.02.13 10시 30분</span> <span class="middle_right">매수 : 2</span><br>
                    <span>결제수단 : 카카오페이</span>
                </div>
            </div>
        </div>
        <button>예매 취소</button>
    </div>
    </c:forEach>


    <div class="list_container">
        <div class="subContainer">
            <div class="re_img"><img src="/resources/imgs/titanic.jpeg"></div>
            <div class="re_info">
                <div class="info_top">
                    <span><img src="/images/12.png"></span>
                    <span>타이타닉</span>
                </div>
                <div class="info_middle">
                    <span>관람 일시 : 2022.02.14 10시 30분</span> <span class="middle_right">상영관 : 1관</span><br>
                    <span>관람 극장 : CGV 부산 서면</span> <span class="middle_right">관람좌석 :  A01, A02</span>
                </div>
                <div class="info_bottom">
                    <span>결제일자 : 2022.02.13 10시 30분</span> <span class="middle_right">매수 : 2</span><br>
                    <span>결제수단 : 카카오페이</span>
                </div>
            </div>
        </div>
        <button>예매 취소</button>
    </div>
    <div class="list_container">
        <div class="subContainer">
            <div class="re_img"><img src="/resources/imgs/titanic.jpeg"></div>
            <div class="re_info">
                <div class="info_top">
                    <span><img src="/images/12.png"></span>
                    <span>타이타닉</span>
                </div>
                <div class="info_middle">
                    <span>관람 일시 : 2022.02.14 10시 30분</span> <span class="middle_right">상영관 : 1관</span><br>
                    <span>관람 극장 : CGV 부산 서면</span> <span class="middle_right">관람좌석 :  A01, A02</span>
                </div>
                <div class="info_bottom">
                    <span>결제일자 : 2022.02.13 10시 30분</span> <span class="middle_right">매수 : 2</span><br>
                    <span>결제수단 : 카카오페이</span>
                </div>
            </div>
        </div>
        <button>예매 취소</button>
    </div>
    <div class="list_container">
        <div class="subContainer">
            <div class="re_img"><img src="/resources/imgs/titanic.jpeg"></div>
            <div class="re_info">
                <div class="info_top">
                    <span><img src="/images/12.png"></span>
                    <span>타이타닉</span>
                </div>
                <div class="info_middle">
                    <span>관람 일시 : 2022.02.14 10시 30분</span> <span class="middle_right">상영관 : 1관</span><br>
                    <span>관람 극장 : CGV 부산 서면</span> <span class="middle_right">관람좌석 :  A01, A02</span>
                </div>
                <div class="info_bottom">
                    <span>결제일자 : 2022.02.13 10시 30분</span> <span class="middle_right">매수 : 2</span><br>
                    <span>결제수단 : 카카오페이</span>
                </div>
            </div>
        </div>
        <button>예매 취소</button>
    </div>


</div>
</body>
</html>
