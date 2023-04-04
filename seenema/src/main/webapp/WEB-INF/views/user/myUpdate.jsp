<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/19
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>내 정보수정 - 시네마</title>
  <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <style>
    *{
      margin: 0 auto;
    }
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
    #sel_menu a{
      text-decoration-line: none;
      color: black;
    }
    #option_center{
      border-right: solid 1px #e3dcdc;
      border-left: solid 1px #e3dcdc;
    }
    #option_right{
      border-right: solid 1px gray;
      background-color: #5c5c5c;
      color: white;
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

    #update_form{
      width: 1000px;
    }
    /* 전체 테이블 스타일 */
    table {
      border-collapse: collapse;
      width: 100%;
      margin-bottom: 20px;
    }

    /* 테이블 셀 스타일 */
    th {
      padding: 10px;
      text-align: left;
      background-color: #eee;
      border: 1px solid #ddd;
    }

    td {
      padding: 10px;
      border: 1px solid #ddd;
    }

    /* 비밀번호 확인 메시지 스타일 */
    #pwCheckComment {
      margin-left: 10px;
    }

    #pwCheckComment.valid {
      color: green;
    }

    #pwCheckComment.invalid {
      color: red;
    }
    input[type="text"], input[type="password"] {
      background-color: #f7f7f7;
      color: #333;
      border: 1px solid #ccc;
      border-radius: 4px;
      padding: 8px;
      font-size: 14px;
      font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
      width: 250px;
      height: 30px;
      outline: none;
    }
    /* 버튼 스타일 */
    input[type="submit"] {

      background-color: #373837;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 150px;
      height: 50px;
      float: right;
    }

    input[type="submit"]:hover {
      background-color: #474847;
    }

    /* 라디오 버튼 스타일 */
    input[type="radio"] {
      margin-right: 10px;
    }

  </style>
</head>
<body>
  <%@ include file="header.jsp"%>
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
  <a href="myReservation"><div class="menu_option" id="option_left">내 예매내역</div></a>
  <a href="myOrderList"> <div class="menu_option" id="option_center">내 결제내역</div></a>
  <a href="myUpdate"><div class="menu_option" id="option_right">내 정보수정</div></a>

</div>
<div id="update_form">
  <table>

    <form action="update.do" method="post" name="frm">

      <tr>
        <th>아이디</th>
        <td id ="idcheck">
          <input type="text" name="id" value="${member.id }" readonly>
      </tr>
      <tr>
        <th>비밀번호 변경</th>
        <td><input type="password" name="pw" placeholder="영문과 숫자를 포함한 8자 이상, 20자 이하의 비밀번호를 입력해주세요. "></td>
      </tr>
      <tr>
        <th>비밀번호 변경 확인</th>
        <td>
          <input type="password" name="pw2" id="pwCheck">
          <span id="pwCheckComment"></span>
        </td>
      </tr>
      <tr>
        <th>이름</th>
        <td><input type="text" name="name" value="${member.name }" readonly> 개명하신 경우 고객센터로 문의해주세요</td>
      </tr>
      <tr>
        <th>전화번호</th>
        <td><input type="text" name="tel" value="${member.tel }"> </td>
      </tr>
      <tr>
        <th>성별</th>
        <c:if test="${member.gender eq '남자'}">
        <td>
          <input type="radio" value="남자" name="gender" checked onclick="return(false);">남자
          <input type="radio" value="여자" name="gender" onclick="return(false);">여자
        </td>
        </c:if>
        <c:if test="${member.gender eq '여자'}">
          <td>
            <input type="radio" value="남자" name="gender" onclick="return(false);">남자
            <input type="radio" value="여자" name="gender" checked onclick="return(false);">여자
          </td>
        </c:if>
      </tr>
      <tr>
        <th>생년월일</th>
        <td><input type="text" name="birthday" value="${member.birthday }" readonly></td>
      </tr>
      <tr>
        <td colspan="2"> <input type="submit" value="회원정보 수정" onclick="return check()"></td>
      </tr>
    </form>
  </table>
</div>
  <%@include file="footer.jsp"%>
<script>
  $('#pwCheck').focusout(function() {  //비밀번호 확인
    let passRule = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    let pw = document.frm.pw.value;
    if(document.frm.pw2.value != ""){
      if (pw.length < 8) {
        document.getElementById("pwCheckComment").innerHTML ="<span style='color:red'>비밀번호는 8글자 이상이어야 합니다.</span>";
      }else if (pw.length > 20) {
        document.getElementById("pwCheckComment").innerHTML ="<span style='color:red'>비밀번호는 20글자를 초과할 수 없습니다.</span>";
      }else if (!passRule.test(pw)) {
        document.getElementById("pwCheckComment").innerHTML ="<span style='color:red'>비밀번호는 특수문자,영문,숫자 모두 포함해야 합니다.</span>";
      }
      else if(document.frm.pw.value == document.frm.pw2.value){
        document.getElementById("pwCheckComment").innerHTML = "<span style='color:green'>비밀번호 일치</span>";
      } else {
        document.getElementById("pwCheckComment").innerHTML = "<span style='color:red'>비밀번호가 일치하지 않습니다</span>";
      }
    }
  });

  function check() {           //중복확인 유효성검사
    let pw = document.frm.pw.value;
    let pwRegExp = /^(?=.[a-zA-Z])(?=.\d)[a-zA-Z\d]{8,20}$/;
     if (document.frm.pw.value == "") {
      alert("비밀번호가 입력되지 않았습니다.");
      document.frm.pw.focus();
      return false;
    }
    //  else if (!pwRegExp.test(pw)) {
    //   alert("비밀번호는 영문과 숫자를 모두 포함하여 8자리 이상 20자리 이하로 입력해야 합니다.");
    //   return false;
    // }
     else if (document.frm.tel.value == "") {
      alert("전화번호가 입력되지 않았습니다.");
      document.frm.tel.focus();
      return false;
    }  else if(document.getElementById("pwCheckComment").innerText != "비밀번호 일치"){
      alert("비밀번호가 일치하지 않습니다");
      document.frm.pw.focus();
      return false;
    }
  }
</script>
</body>
</html>
