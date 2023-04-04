<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/10
  Time: 5:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 - 시네마</title>
    <style>
        table {
            border-collapse: collapse;
            margin: auto;
            width: 50%;
            font-family: Arial, sans-serif;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            width: 250px;
        }

        input[type="text"], input[type="password"], input[type="date"] {
            width: 460px;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            height: 50px;
        }

        input[type="submit"] {
            background-color: #373837;
            color: white;
            /*padding: 14px 20px;*/
            /*margin: 8px 0;*/
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 460px;
            height: 50px;
            font-size: 24px;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            background-color: #474847;
        }

        h1{
            margin-top: 20px;
            text-align: center;
        }
        .logImg img{
            width: 350px;
            height: 150px;
        }
        .mainContainer{
            margin: 0 auto;
            width: 780px;
            text-align: center;
            display:flex;
            justify-content:center;
            align-items:center;
            flex-direction:column;
        }
        .input_title{
            margin-top: 13px;
            width: 460px;
            margin-left: 15px;
            padding-left: 5px;
            text-align: left;
            margin-bottom: 10px;
            font-weight: bold;
        }
        #gender{
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            width: 460px;
            height: 50px;
            font-size: 16px;
            padding-left: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="mainContainer">
    <div class="logImg" onclick="location.href='/'" style="cursor: pointer;">
        <img src="/images/logo3.png">
    </div>

        <form action="reg.do" method="post" name="frm" style="width: 100%; max-width: 500px;">

                <div class="input_title">아이디</div>
                    <div><input type="text" name="id" placeholder="6글자 이상, 영문과 숫자로 이루어진 아이디를 입력해주세요." id="idcheck"></div>
                    <div class="input_title"><span id="idCheckComment"></span></div>

                <div class="input_title">비밀번호</div>
            <div><input type="password" name="pw" placeholder="영문과 숫자를 포함한 8자 이상, 20자 이하의 비밀번호를 입력해주세요. "></div>

                <div class="input_title">비밀번호 재확인</div>

                    <div><input type="password" name="pw2" id="pwCheck"></div>
                        <div class="input_title"><span id="pwCheckComment"></span></div>

            <div class="input_title">이름</div>
            <div><input type="text" name="name"></div>

            <div class="input_title">전화번호</div>
            <div><input type="text" name="tel"></div>

            <div class="input_title">성별</div>

            <div>
                <select id="gender" name="gender">
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                </select>
            </div>

            <div class="input_title">생년월일</div>
            <div><input type="date" name="birthday"></div>
            <div><input type="submit" value="가입하기" onclick="return check()"></div>
        </form>
</div>


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

    $('#idcheck').focusout(function (){ // 아이디입력 후 중복확인 메서드 실행
        const id = document.frm.id.value;
        if (document.frm.id.value == "") {
            $('#idCheckComment').text("");
        }else if (id.length < 6) {
            document.getElementById("idCheckComment").innerHTML ="<span style='color:red'>아이디는 6글자 이상이어야 합니다.</span>";
        }else if (id.length > 12) {
            document.getElementById("idCheckComment").innerHTML ="<span style='color:red'>아이디는 12글자를 초과할 수 없습니다.</span>";
        }else if (!/^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/.test(id)) {
            document.getElementById("idCheckComment").innerHTML ="<span style='color:red'>아이디는 특수문자를 포함할 수 없고 영문과 숫자를 모두 포함해야 합니다.</span>";
        }else {
            idcheck();
        }
    })

    function idcheck() {  // 아이디 중복체크

        let param = document.frm.id.value;
        let url = "idcheck.do?id=" + param;
        const xhttp = new XMLHttpRequest();
        xhttp.onload = function () {
            if (this.responseText == 1) {
                document.getElementById("idCheckComment").innerHTML = "사용가능";
            } else {
                document.getElementById("idCheckComment").innerHTML = "사용불가";
            }
            document.getElementById("idCheckComment").innerHTML = this.responseText;
        }
        xhttp.open("GET", url, true);
        xhttp.send(); //submit
    }

    function check() {           //중복확인 유효성검사

        if (document.frm.id.value == "") {
            alert("아이디가 입력되지 않았습니다.");
            document.frm.id.focus();
            return false;
        } else if (document.frm.pw.value == "") {
            alert("비밀번호가 입력되지 않았습니다.");
            document.frm.pw.focus();
            return false;
        } else if (document.frm.name.value == "") {
            alert("이름이 입력되지 않았습니다.");
            document.frm.name.focus();
            return false;
        } else if (document.frm.tel.value == "") {
            alert("전화번호가 입력되지 않았습니다.");
            document.frm.tel.focus();
            return false;
        } else if (document.frm.tel.value.length != 11) {
            alert("전화번호를 다시 확인해주세요");
            document.frm.tel.focus();
            return false;
        }else if (document.getElementById("idCheckComment").innerText != "사용가능") {
            alert("아이디 중복체크를 하세요.");
            document.frm.id.focus();
            return false;
        } else if(document.getElementById("pwCheckComment").innerText != "비밀번호 일치"){
            alert("비밀번호가 일치하지 않습니다");
            document.frm.pw.focus();
            return false;
        }else {
            return true;
        }
    }
</script>
</body>
</html>
