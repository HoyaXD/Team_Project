<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/20
  Time: 1:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입 완료 - 시네마</title>
  <link rel="stylesheet" href="/css/regMemberComplete.css">
</head>
<body>
<header>
  <%@ include file="header.jsp"%>
</header>
  <div class="container">
    <h1>회원가입을 축하합니다!</h1>
    <div id="imgDiv"><img src="/images/fireworks.png"></div>
    <p>회원가입이 정상적으로 완료되었습니다.</p>
    <button onclick="location.href='loginForm'">로그인 하기</button>
  </div>
<%@include file="footer.jsp"%>
</body>
</html>
