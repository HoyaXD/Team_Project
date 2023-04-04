<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/16
  Time: 3:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
  <head>
    <title>Title</title>
      <style>
          footer {
              background-color: #333;
              color: #fff;
              height: 150px;
              display: flex;
              justify-content: space-evenly;
              align-items: center;
          }

          .footer-row {
              display: flex;
              flex-direction: row;
          }

          .footer-row p {
              margin: 0 10px;
              font-size: 14px;
              text-align: center;
          }

      </style>
  </head>
  <footer>
      <div class="footer-row">
          <p>회사소개</p>
          <p>이용약관</p>
          <p>편성기준</p>
          <p>법적고지</p>
          <p>개인정보 처리방침</p>
          <p>대표이사 정승호</p>
      </div>
  </footer>


</html>
