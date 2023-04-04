<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/11
  Time: 9:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화예매 - 시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    <link rel="stylesheet" href="/css/reservationMain.css">
    <style>
        .reservationInfo{
            display: flex;
            width: 1300px;
            height: 100px;
            color: white;
            /*justify-content: flex-start;*/
        }
        .ri_wrap{
            background-color: #343433;

        }
        sel_postFileName img{
            width: 30px;
            height: 80px;
        }
        input[type=submit]{
            margin-top: 10px;
            width: 100px;
            height: 100px;
            background-color: #cc1616;
            border: solid 1px red;
            border-radius: 8px;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }
        input[type=submit]:hover{
            background-color: #ff0000;
        }
        #sel_title{
            margin-bottom: 10px;
        }

        .info{
            /*padding-top: 40px;*/
        }
        #theaterInfoDiv{
            padding-top: 40px;
        }
        #timeInfoDiv{
            padding-top: 40px;
        }
    </style>
</head>
<body>
<div class="box">
    <%@ include file="../user/header.jsp"%>
<div class="content">
  <div id="reservationMain">
      <div class="item" id="movieList">
            <div class="listMenu">
                영화
            </div>
          <div class="movieListView">
                <c:forEach var="movie" items="${mlist }">
                    <div class="movie">
                        <span><img src="/images/${movie.viewAge }.png"></span>
                        <span class="movieTitle">${movie.movieTitle }</span>
                        <span><input type="hidden"value="${movie.movieCode }" class="movieCode"></span>
                        <span id="postFileName2"><input type="hidden"value="${movie.postFileName }"></span>
                    </div>
                </c:forEach>
          </div>
      </div>

      <div class="item" id="theaterList">
          <div class="listMenu">
              극장
          </div>
          <div class="theaterListView">
            <div class="theaterItems" id="place">
                <c:forEach var="theater" items="${tlist }">
                    <div class="place">
                       <span class="placeList">${theater.theaterPlace }</span>
                       <span>(${theater.cnt })</span><br>
                    </div>
                </c:forEach>
            </div>
              <div class="theaterItems" id="address">

              </div>
          </div>
      </div>
      <div class="item" id="dateList">
          <div class="listMenu">
            날짜
          </div>
          <div class="calendar">
              <ul id="calendar-list"></ul>
          </div>
      </div>
      <div class="item" id="timeList">
          <div class="listMenu">
              시간
          </div>
          <div class="timeItems">

          </div>

      </div>
  </div>
    <div id="hidden">
        <form action="reservationSeats" method="post" name="frm">
            <input type="hidden" name="movieCode" id="movieCode">
            <input type="hidden" name="movieTitle" id="movieTitle">
            <%--        <input type="text" name="postFileName" id="postFileName">--%>
            <input type="hidden" name="id" value="${sessionScope.logid}">
            <input type="hidden" name="theaterPlace" id="theaterPlace" placeholder="지역">
            <input type="hidden" name="theater" id="theater" placeholder="영화관">
            <input type="hidden" name="movieDate" id="movieDate" placeholder="날짜">
            <input type="hidden" name="reservationTime" id="reservationTime" placeholder="시간">


    </div>
    <div class="ri_wrap">
        <div class="reservationInfo">
            <div class="info" id="movieInfo">
                <span id="sel_postFileName"></span>
            </div>
            <div class="info" id="theaterInfoDiv">
                <p id="sel_title"></p>
                <span id="theaterInfo"></span>
                <span id="theaterInfo2"></span>
            </div>
            <div class="info" id="timeInfoDiv">
                <span id="timeInfo"></span>
                <span id="timeInfo2"></span>
            </div>
            <div class="info" id="pay"><input type="submit" value="좌석선택" onclick="return validateForm();"></div>
            </form>
      </div>
    </div>
</div>

</div>
<footer>
    <%@ include file="../user/footer.jsp"%>
</footer>
<script>

    $(document).ready(function() {
        // URL에서 movieCode 값을 가져옴
        const urlParams = new URLSearchParams(window.location.search);
        const movieCode = urlParams.get('movieCode');

        // movieCode 값과 같은 값을 가진 input 요소와 그 형제 요소인 movieTitle 요소를 찾아서 클릭 이벤트 발생
        $(".movie input[value='" + movieCode + "']").parent().prev().click();

    });






    $('#calendar-list').on("click", ".cal_list", function (e) {  //날짜 선택시 css, hidden에 값 넣기
        $('#movieDate').val($(e.target).text());
        $('#timeInfo').text($(e.target).text());
        $('#timeInfo2').text("");
        document.getElementById("reservationTime").value = "";
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });

        // 시간 정보 div 요소 삭제.
        $('.timeItems').empty();

        let movieCode = $('#movieCode').val();
        $.ajax({
            url: "loadPlayingTime.do",
            type: "GET",
            data: { movieCode: movieCode },
            success: function(response) {
                var timeArray = response.split(",");
                var timeList = $(".timeItems");
                for (var i = 0; i < timeArray.length; i++) {
                    var timeStr = timeArray[i].trim();
                    var timeDiv = $("<div>").addClass("time").text(timeStr);
                    var dateTimeStr = $('#movieDate').val() + ' ' + timeStr;
                    if (moment(dateTimeStr, 'YYYY-MM-DD hh:mm A').isBefore(moment())) {
                        timeDiv.css({ "opacity": 0.5, "cursor": "not-allowed" });
                    } else {
                        timeDiv.click(function (e){
                            $('#reservationTime').val($(e.target).text());
                            $('#timeInfo2').text($(e.target).text());
                            $('.time').css({
                                "background-color":"#e8e5dd",
                                "color":"black"
                            })
                            $(e.target).css({
                                "background-color":"#5c5c5c",
                                "color":"white"
                            });
                        });
                    }
                    timeList.append(timeDiv);
                }
                $('.time').css({
                    "background-color":"#e8e5dd",
                    "color":"black"
                });
                $('.time').css({
                    "display" : "inline-block"
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("Error:", textStatus, errorThrown);
            }
        });


    })


    $('.movieTitle').click(function (e){ //영화 제목 선택
        $('#movieCode').val($(e.target).next().children().val()); //영화코드에 값넣기
        $('#postFileName').val($(e.target).nextAll('#postFileName2').children().val()); //파일네임에 값넣기
        $('#sel_postFileName').html('<img src ="/resources/images/'+$(e.target).nextAll('#postFileName2').children().val()+'" width="90px" height="130px">');
        $('#movieTitle').val($(e.target).text()); //영화제목에 값넣기
        $('#sel_title').text($(e.target).text()); //영화제목에 값넣기
        $('#timeInfo').text("");//영화시간초기화
        $('#timeInfo2').text("");
        $('#theaterInfo').text("");
        $('#theaterInfo2').text("");
        $("#address").empty();
        $('.timeItems').empty();
        document.getElementById("theaterPlace").value = "";
        document.getElementById("theater").value = "";
        document.getElementById("movieDate").value = "";
        document.getElementById("reservationTime").value = "";



        const calendarList = document.getElementById('calendar-list');

// 기존에 생성된 달력 삭제
        while (calendarList.firstChild) {
            calendarList.removeChild(calendarList.firstChild);
        }

        $('.placeList').css({
            "background-color":"#dedad2",
            "color":"black"
        });

        $('.placeList').parent( 'div' ).css({
            "background-color":"#dedad2",
            "color":"black"
        })

        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.time').css({
            "display" : "none"
        })

        $('.movieTitle').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.movieTitle').parent( 'div' ).css({
            "background-color":"#e8e5dd",
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

    $(document).on("click", ".clickable", function (e) {  // 영화관 클릭
        $('#theater').val($(e.target).text().trim()); //영화관에 값넣기
        $('#theaterInfo2').text($(e.target).text()); //영화관에 값넣기
        $('#timeInfo').text("");//영화시간초기화
        $('#timeInfo2').text("");
        document.getElementById("movieDate").value = "";
        document.getElementById("reservationTime").value = "";
        $('.time').css({
            "background-color": "#e8e5dd",
            "color": "black"
        })
        $('.cal_list').css({
            "background-color": "#e8e5dd",
            "color": "black"
        })

        $('.clickable').css({
            "background-color": "#e8e5dd",
            "color": "black"
        })
        $(e.target).css({
            "background-color": "#5c5c5c",
            "color": "white"
        });

        $('.time').css({
            "display": "none"
        })

        var today = new Date();

        var year = today.getFullYear();
        var month = ('0' + (today.getMonth() + 1)).slice(-2);
        var day = ('0' + today.getDate()).slice(-2);

        var dateString = year + '-' + month  + '-' + day; //오늘 날짜 구하기

        let d = new Date();
        let sel_month = 1; //
        d.setMonth(d.getMonth() + sel_month );

        let year2    = d.getFullYear();
        let month2   = ('0' + (d.getMonth() +  1 )).slice(-2);
        let day2     = ('0' + d.getDate()).slice(-2);
        dt = year2+"-"+month2+"-"+day2;
        //한달 뒤 날짜 구하기

        const startDate = new Date(dateString); // 시작 날짜 설정 (오늘)
        const endDate = new Date(dt); // 마지막 날짜 설정 (한달 뒤)

        const calendarList = document.getElementById('calendar-list');

        // 기존에 생성된 달력 삭제
        while (calendarList.firstChild) {
            calendarList.removeChild(calendarList.firstChild);
        }

        // 새로운 달력 생성
        for (let date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
            const listItem = document.createElement('li');
            listItem.className = "cal_list";
            listItem.style.cursor = "pointer"; // 스타일 속성 추가
            const dateText = document.createTextNode(date.toISOString().slice(0, 10));
            listItem.appendChild(dateText);
            calendarList.appendChild(listItem);
        }
    });



    $(document).on("click", ".placeList",function (e){ // 선택된 영화지역에 있는 상영관 보여주기
        $('#theaterPlace').val($(e.target).text()); //영화지역에 값넣기
        $('#theaterInfo').text($(e.target).text()); //영화지역에 값넣기
        $('#theaterInfo2').text("");
        $('#timeInfo').text("");//영화시간초기화
        $('#timeInfo2').text("");
        document.getElementById("theater").value = "";
        document.getElementById("movieDate").value = "";
        document.getElementById("reservationTime").value = "";
        $('.theater').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.placeList').css({
            "background-color":"#dedad2",
            "color":"black"
        });

        $('.placeList').parent( 'div' ).css({
            "background-color":"#dedad2",
            "color":"black"
        })
        $(e.target).css({
            "background-color":"#e8e5dd",
        });

        $(e.target).parent( 'div' ).css({
            "background-color":"#e8e5dd",
        });

        $('.time').css({
            "display" : "none"
        })
        let movieCode = $('#movieCode').val();
        var place = $(e.target).text();

        $.ajax({
            url: "getTheaterList.do?place=" + place,
            type: "get",
            dataType: "json",
            success: function (data) {
                let parse = data;
                let i = 0;
                $("#address").empty();
                for (i; i < parse.length; i++) {
                    $("#address").append(
                        '<div class="theater" style="height: 30px; line-height: 30px; cursor: not-allowed; color: #cccccc"> ' +
                        parse[i].theaterName + '</div>');
                }

                $.ajax({
                    url: "getScreenTheater.do",
                    type: "get",
                    data: {
                        movieCode: movieCode
                    },
                    dataType: "json",
                    success: function (data) {
                        let theaterList = data;
                        let i = 0;
                        for (i; i < theaterList.length; i++) {
                            let theaterName = theaterList[i].theaterName;
                            let $theater = $("#address").find('.theater:contains(' + theaterName + ')');
                            if ($theater.length) {
                                $theater.css('color', 'black');
                                $theater.css('cursor', 'pointer');
                                $theater.addClass('clickable');
                            }
                        }
                    },
                    error: function () {
                        // alert("영화를 먼저 선택해주세요");
                    }
                });
            },
            error: function () {
                // alert("영화를 먼저 선택해주세요");

            }
        });



    });




    function validateForm() {     //유효성검사
        var movieTitle = document.getElementById("movieTitle");
        var id = document.getElementsByName("id")[0];
        var theaterPlace = document.getElementById("theaterPlace");
        var theater = document.getElementById("theater");
        var movieDate = document.getElementById("movieDate");
        var reservationTime = document.getElementById("reservationTime");

        if (id.value === "") {
            if (confirm("로그인이 필요한 서비스입니다. 로그인하시겠습니까?")) {
                window.location.href = "loginForm"; // 로그인 페이지 경로
            }
            return false;
        }
        else if (movieTitle.value === "") {
            alert("영화를 선택해주세요");
            return false;
        }

        else if (theaterPlace.value === "") {
            alert("상영관 지역을 선택해주세요");
            return false;
        }
        else if (theater.value === "") {
            alert("상영관을 선택해주세요");
            return false;
        }
        else if (movieDate.value === "") {
            alert("날짜를 선택해주세요");
            return false;
        }
        else if (reservationTime.value === "") {
            alert("상영 시간을 선택해주세요");
            return false;
        }
        return true;
    }

</script>
</body>
</html>
