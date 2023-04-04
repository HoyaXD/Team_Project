<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/10
  Time: 4:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인폼 - 시네마</title>
    <link rel="stylesheet" href="/css/loginForm.css">
</head>
<body>
    <div class="logImg" onclick="location.href='/'" style="cursor: pointer;">
        <img src="/images/logo3.png">
    </div>
    <div class="login-container">
        <div class="content">
            <form action="login.do" method="post" name="frm">
                <input type="text" name="id" placeholder="아이디" class="form-control" id="form-id">
                <input type="password" name="pw" placeholder="비밀번호" class="form-control">
                <button type="submit" class="submit-btn">로그인</button>
            </form>
            <div id="submit_after"></div>
            <a href="regAgree"><button class="submit-btn" id="regMem">회원가입</button></a>

        </div>
    </div>

<script>
    function check(){
        if (document.frm.id.value == "") {
            alert("아이디가 입력되지 않았습니다.");
            document.frm.id.focus();
            return false;
        } else if (document.frm.pw.value == "") {
            alert("비밀번호가 입력되지 않았습니다.");
            document.frm.pw.focus();
            return false;
        }else{
            return true;
        }
    }
</script>
</body>
</html>
