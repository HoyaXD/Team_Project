<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<link rel="stylesheet" href="/css/movieSalesPage.css">
</head>
<body>
     <div class="gamut1">
 	<!-- 좌측메뉴 jsp -->
	<%@ include file="adminMenu.jsp"%>
      <div class="main_view1">

         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">영화 매출 조회</div>
            </div>
         </div>

         <div class="easy_menu1">
           <div id="list1_menu">
                <div id="list_title"><!-- 영화예매top5 -->
                  	<span id="sales_title"></span>
                </div>
                <div id="tbl_box">
	                <table id="movie_sales_tbl">
	                    <thead id="movie_sales_tbl_thead">
	                        <tr>
	                            <th>순위</th><th>제목</th><th>예매율</th>
	                        </tr>
	                    </thead>
	                    <tbody id="movie_sales_tbl_tbody">
	                        <tr>
	                            <td></td>
	                            <td></td>
	                            <td></td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
	            
                <div id="list3_menu"><!-- 영화관별예매top5 -->
                    <div id="list_title">
                       <span id="sales_title3"></span>
                    </div>
                    <div id="tbl_box">
	                    <table id="movie_sales_tbl">
		                    <thead>
		                        <tr>
		                            <th>순위</th><th>영화관</th><th>예매율</th>
		                        </tr>
		                    </thead>
		                    <tbody id="theater_sales_tbl_tbody">
		                        <tr>
		                            <td></td>
		                            <td></td>
		                            <td></td>
		                        </tr>
		                    </tbody>
	                	</table>
                    </div>
                </div><!-- list3 -->
                <div id="list1_menu_2">
                	<div id="list_title">
                       성별에 따른 예매율
                    </div>
                    <div id="chart">
                    	<div id="genderCntGraph" style="width:400px; height:200px"></div>
                    </div>
                    <table id="gender_sales_tbl">
                    	<thead id="genderTbl_thead">
	                    	<tr>
	                    		<td colspan="3">성별에 따른 선호 영화</td>
	                    	</tr>
	                    	<tr>
	                    		<th>성별</th>
	                    		<th>영화</th>
	                    		<th>예매율</th>
	                    	</tr>
                    	</thead>
                    	<tbody id="genderTbl_tbody">
                    	</tbody>
                    	<tbody id="genderTbl_tbody1_1" style="display:none;">
                    		<tr>
                    			<th colspan="3">남성 선호 영화 <span id="btn_box"><button id="btn_x"> ✕ </button></span></th>
                    			
                    		</tr>
                    		<tr>
                    			<th>순위</th>
                    			<th>영화</th>
                    			<th>예매율</th>
                    		</tr>
                    	</tbody>
                    	<tbody id="genderTbl_tbody2">
                    	</tbody>
                    	<tbody id="genderTbl_tbody2_2" style="display:none;">
                    		<tr>
                    			<th colspan="3">여성 선호 영화  <span id="btn_box"><button id="btn_x2"> ✕ </button></span></th>
                    			
                    		</tr>
                    		<tr>
                    			<th>순위</th>
                    			<th>영화</th>
                    			<th>예매율</th>
                    		</tr>
                    	</tbody>
                    </table>
                   
                    <div id="gender_tbl_notice">
                    	⬆️ 성별을 클릭하시면 전체보기가 실행됩니다.
                    </div>
                </div>
            </div><!-- list1 -->
            <div id="list2_menu"><!-- 영화 총 예매량 -->
                <div id="list_title">
                   	<span id="sales_title2"></span> 
                </div>
                <div id="chart">
                    <div id="movie_chart_today" style="width:495px; height: 295px;"></div>
                </div>
                <div id="list4_menu">
                	 <div id="list_title">
                   		<span id="sales_title4"></span> <!-- 영화관 별 예매량 -->
                	</div>
					<div id="chart">
						<div id="theaterCntGraph" style="width:520px; height: 295px;"></div>
					</div>
                </div><!-- list4 -->
               <div id="list5_menu">
                	<div id="list_title">
                   		장르 별 예매량
                	</div>
					<div id="chart">
						<div id="genreCntGraph" style="width:500px; height: 295px;"></div>
					</div>
					<table id="genre_tbl">
           				<tr>
           					<th>장르</th><th>영화</th><th>예매율</th>
           				</tr>
           				<tbody id="genre_tbl_tbody">
           				
           				</tbody>
           			</table>
                </div><!-- list4 -->
            </div><!-- list2 -->
         </div>
      </div>
	</div>
	
	<div class="popup_movieInfo" style="display:none;">
		<table id="popup_tbl">
			<tbody id="popup_tbl_tbody">
			</tbody>
		</table>
	</div>
	<div class="popup_theaterInfo" style="display:none;">
		<table id="popup_theaterInfo_tbl">
			<tbody id="theaterInfo_tbody">
			</tbody>
		</table>
	</div>
    <input type="hidden" id="getAllMovieCnt">
    <input type="hidden" id="maleReservedCnt">
    <input type="hidden" id="femaleReservedCnt">
    <script>
    	
        $(document).ready(function() {
            /* 메뉴바 slideUpDown */
            // 첫번째 메뉴바 클릭시 이동   
            $('.mainmenu > li').click(function() {
                var index = $(this).index();
                $('.submenu').eq(index).stop().slideDown();
                //eq(index)는 큰메뉴li
            })
        
            $('.mainmenu > li').mouseleave(function() {
                $('.submenu').stop().slideUp();
            });
        
        });
        
        function theaterReg(){
            location.href="theaterReg";
        }
        
        //오늘 날짜 불러오기
        let today = new Date();   
        let year = today.getFullYear(); // 년도
        let month = today.getMonth() + 1;  // 월
        let date = today.getDate();  // 날짜
        let day = today.getDay();  // 요일
        
        $("#sales_title").html(month + "월 영화 예매율 TOP 5")
        $("#sales_title2").html(month + "월 영화 총 예매량")
        $("#sales_title3").html(month + "월 영화관 별 총 예매율")
        $("#sales_title4").html(month + "월 영화관 별 총 예매량")
    </script>
    <script>
    	//한달 전체 영화 관람객수
    	 $(document).ready(getAllMovieCnt);
    	function getAllMovieCnt() {
	        const xhttp = new XMLHttpRequest();
	
	        xhttp.onload = function() {
	            let result = this.responseText;
	            $("#getAllMovieCnt").val(result);
	        }
	
	        if(month < 10) { // 10월 미만인 달은 0을 붙여줌
	            xhttp.open("GET", "getAllMovieCnt?year=" + year + "&month=0" + month, true); 
	            xhttp.send();
	        } else {
	            xhttp.open("GET", "getAllMovieCnt?year=" + year + "&month=" + month, true); 
	            xhttp.send();
	        }
	    }
    	
    	
	    $(document).ready(topFive);
		//영화 top5 테이블
	    function topFive() {
	        const xhttp = new XMLHttpRequest();
	
	        xhttp.onload = function() {
	            let result = this.responseText; 
	            let obj = JSON.parse(result);
	           	
	            $("#movie_sales_tbl_tbody").empty();
	            
				let allMovieCnt = parseInt($("#getAllMovieCnt").val());
				
	            for(let i = 0; i < obj.length; i++) {
	            	
	            	let visitors = parseInt(obj[i].visitors);
	            	let visitor_rate = visitors / allMovieCnt * 100;
	            	
	                $("#movie_sales_tbl_tbody").append(
	                    "<tr>"+
	                    	"<td>"+
	                    		"<input type='hidden' id='movie_sales_tbl_movieCode' value='"+obj[i].movieCode+"'>"+
	                        	(i+1) +
	                        "</td>"+
	                        "<td class='tbody_title'><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>" + obj[i].movieTitle + "</a></td>"+
	                        "<td class='tbody_rate'>" + Math.round(visitor_rate) + "%</td>"+
	                    "</tr>"
	                );
	            }
	           
	        }
	
	        if(month < 10) { // 10월 미만인 달은 0을 붙여줌
	            xhttp.open("GET", "topFive?year=" + year + "&month=0" + month, true); 
	            xhttp.send();
	        } else {
	            xhttp.open("GET", "topFive?year=" + year + "&month=" + month, true); 
	            xhttp.send();
	        }
	    }
		//제목에 마우스오버 시 영화정보 출력
	    $(document).on("mouseover", ".tbody_title", mouseOverEventMovie)
	    $(document).on("mouseover", ".tbody_title", function(e){
	    	
	    	let sWidth = window.innerWidth;
			let sHeight = window.innerHeight;

			let oWidth = $(".popup_movieInfo").width();
			let oHeight = $(".popup_movieInfo").height();

			// 레이어가 나타날 위치를 셋팅한다.
			let divLeft = e.clientX + 10;
			let divTop = e.clientY + 5;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			/* if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight; */

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$(".popup_movieInfo").css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
				
	    });
		//성별 테이블 마우스오버시 영화정보출력
		$(document).on("mouseover", "#movie_info", mouseOverEventMovie);
		$(document).on("mouseover", "#movie_info", function(e){
	    	
	    	let sWidth = window.innerWidth;
			let sHeight = window.innerHeight;

			let oWidth = $(".popup_movieInfo").width();
			let oHeight = $(".popup_movieInfo").height();

			// 레이어가 나타날 위치를 셋팅한다.
			let divLeft = e.clientX + 50;
			let divTop = e.clientY + 500;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			/* if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight; */

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$(".popup_movieInfo").css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
	    });
		
		//성별테이블 mouseleave시 popup hide
		$(document).on("mouseleave", "#movie_info", function(){
			$(".popup_movieInfo").css("display", "none");
		});
		
		//마우스오버시 영화정보출력
	    function mouseOverEventMovie(e){
			let movieCode = e.target.previousElementSibling.children[0].value;
			
	    	const xhttp = new XMLHttpRequest();
	    	xhttp.onload = function() {
	    		$("#popup_tbl_tbody").empty();
	    		let result = this.responseText; 
	    		let obj = JSON.parse(result);
	    		$("#popup_tbl_tbody").append(
	    				"<tr>"+
	    					"<th colspan='2' id='poster'>"+
	    					"<img src='/resources/images/"+obj.postFileName+"' width='150px;' height='200px;'>"+
	    					"</th>"+
	    				"</tr>"+
	    				"<tr>"+
	    					"<th colspan='2'>"+obj.movieTitle+
	    				"</tr>"+
	    				"<tr>"+
	    					"<th>장르</th>"+
	    					"<td>"+obj.genre+"</td>"+
	    				"</tr>");
	    		if(obj.viewAge == 0){
	    			$("#popup_tbl_tbody").append(
	    					"<tr>"+
	    						"<th>상영등급</th>"+
	    						"<td>전체관람가</th>"+
	    					"</tr>");
	    		}else{
	    			$("#popup_tbl_tbody").append(
	    					"<tr>"+
	    						"<th>상영등급</th>"+
	    						"<td>"+obj.viewAge+"세 관람가</th>"+
	    					"</tr>");
	    		}
	    		$("#popup_tbl_tbody").append(
    					"<tr>"+
    						"<th>상영기간</th>"+
    						"<td>"+obj.start_date+" ~ "+obj.end_date+"</th>"+
    					"</tr>");
	    	}
	    			
	    	xhttp.open("GET", "movieListByCode?movieCode=" + movieCode, true); 
	    		
	    	xhttp.send();
	    }
	    
	   $(document).on("mouseleave", ".tbody_title", function(e){
	    	$(".popup_movieInfo").css("display", "none");
	    }); 
	    
	    $(document).ready(allMovieList);
	    //한달 모든 영화 관람객
	    function allMovieList() {
	    	const xhttp = new XMLHttpRequest();
	    	xhttp.onload = function() {
	    	let result = this.responseText; 
	    		let obj = JSON.parse(result);
	    		let mTitle = new Array();
	    		let mCnt = new Array();
	    		
				for(let i = 0; i < obj.length; i++){
					mTitle[i] = obj[i].movieTitle;
					mCnt[i] = obj[i].visitors;
				}
				
	            drawVisualization(mTitle, mCnt);
	    	}
	    			
	    	if(month < 10){ //10월 미만인 달은 0을 붙여줌
				
	    		xhttp.open("GET", "allMovies?year=" + year + "&month=0" + month, true); 
	    			
	    		xhttp.send();
			}else{
				xhttp.open("GET", "allMovies?year=" + year + "&month=" + month, true); 
				
	    		xhttp.send();
			}
	    }
	    
	    function drawVisualization(mTitle, mCnt) {
	        // 영화 한달 예매율 총 그래프
	        google.charts.load('current', {'packages':['corechart']});
	        google.charts.setOnLoadCallback(function() {
	            var data = new google.visualization.DataTable();
	            data.addColumn('string', '영화');
	            data.addColumn('number', '예매량');
	            data.addColumn({type: 'string', role: 'annotation'});
	            data.addColumn({type: 'string', role: 'style'});
	            

				
	            let arr = new Array();
	
	            for(let i = 0; i < mTitle.length; i++){
	                movieTitles = mTitle[i];
	                movieHits = parseInt(mCnt[i]);
	                if(i < 3){
		                arr[i] = [movieTitles, movieHits, movieHits.toString(), "lightcoral"];
	                }else if(i < 5){
	                	arr[i] = [movieTitles, movieHits, movieHits.toString(), "lightskyblue"];
	                }else{
	                	arr[i] = [movieTitles, movieHits, movieHits.toString(), "gray"];
	                }
	            }
	            
	            data.addRows(arr);
	            
	            var options = {
	                seriesType: 'bars',
	                animation: {
	                    startup: true,
	                    duration: 1000,
	                    easing: 'linear' 
	                },
	                legend : 'none',
	                series: {1: {type: 'line'}},
	                chartArea: {'width': '90%', 'height': '69%'}
	            };
	
	            var chart = new google.visualization.ColumnChart(document.getElementById('movie_chart_today'));
	            chart.draw(data, options);
	        });
	    }
	</script>
 	<script>
 		$(document).ready(theaterTopfive);
 		//영화관 별 예매율 top5
 		function theaterTopfive() {
	    	const xhttp = new XMLHttpRequest();
	    	xhttp.onload = function() {
	    	let result = this.responseText; 
	    		let obj = JSON.parse(result);
	    		$("#theater_sales_tbl_tbody").empty();
	    		let theaters = new Array();
	    		let visitors = new Array();
	    		let allVisitors = parseInt($("#getAllMovieCnt").val());
	    		
				for(let i = 0; i < obj.length; i++){
					let	visitorByTheater = parseInt(obj[i].visitors);
					let visitors_rate = visitorByTheater / allVisitors * 100;
					$("#theater_sales_tbl_tbody").append(
							"<tr>"+
								"<td><input type='hidden' value='"+obj[i].theaterCode+"'>"+
								(i+1)+"</td>"+
								"<td id='theater_sales_tbl_theater'><a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>"+obj[i].theater+"</a></td>"+
								"<td>"+Math.round(visitors_rate)+"%</td>"+
							"</tr>");
					
					
					theaters[i] = obj[i].theater;
					visitors[i] = obj[i].visitors;
					theaterCntGraph(theaters, visitors)
				}
				
	    	}
	    	if(month < 10){ //10월 미만인 달은 0을 붙여줌
				
	    		xhttp.open("GET", "getTheaterTopfive?year=" + year + "&month=0" + month, true); 
	    			
	    		xhttp.send();
			}else{
				xhttp.open("GET", "getTheaterTopfive?year=" + year + "&month=" + month, true); 
				
	    		xhttp.send();
			}
	    }
 		
 		function theaterCntGraph(theaters, visitors) {
	        // 총 영화관 한달 영화예매량 그래프
	
	        google.charts.load('current', {'packages':['corechart']});
	        google.charts.setOnLoadCallback(function() {
	            // Some raw data (not necessarily accurate)
	            var data = new google.visualization.DataTable();
	            data.addColumn('string', '영화');
	            data.addColumn('number', '예매량');
	            data.addColumn({type: 'string', role: 'annotation'});
	            data.addColumn({type: 'string', role: 'style'});
	            
	            let arr = new Array();
	
	            for(let i = 0; i < theaters.length; i++){
	            	theaterName = theaters[i];
	            	tVisitors = parseInt(visitors[i]);
	            	if(i < 3){
		                arr[i] = [theaterName, tVisitors, tVisitors.toString(), "lightcoral"];
	            	}else if(i < 5){
	            		 arr[i] = [theaterName, tVisitors, tVisitors.toString(), "lightskyblue"];
	            	}else{
	            		arr[i] = [theaterName, tVisitors, tVisitors.toString(), "gray "];
	            	}
	            }
	            data.addRows(arr);
	
	            var options = {
	                seriesType: 'bars',
	                animation: { 
	                    startup: true,
	                    duration: 1000,
	                    easing: 'linear' 
	                },
	                legend : 'none',
	                series: {1: {type: 'line'}},
	                
	                chartArea: {'width': '90%', 'height': '80%'}
	            };
	
	            var chart = new google.visualization.ComboChart(document.getElementById('theaterCntGraph'));
	            chart.draw(data, options);
	        });
	    }
 		
 		//마우스 오버 시 영화관 정보 출력
 		$(document).on("mouseover", "#theater_sales_tbl_theater", theaterInfo)
 		$(document).on("mouseover", "#theater_sales_tbl_theater", function(e){
 			let sWidth = window.innerWidth;
			let sHeight = window.innerHeight;

			let oWidth = $(".popup_theaterInfo").width();
			let oHeight = $(".popup_theaterInfo").height();

			// 레이어가 나타날 위치를 셋팅한다.
			let divLeft = e.clientX + 10;
			let divTop = e.clientY + 5;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			/* if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight; */

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$(".popup_theaterInfo").css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
				
 		});
 		
 		function theaterInfo(e){
 			let theaterCode = e.target.parentElement.children[0].children[0].value;
 			
 			const xhttp = new XMLHttpRequest();
 			xhttp.onload = function() {
 				$("#theaterInfo_tbody").empty();
 				let result = this.responseText; 
				let obj = JSON.parse(result);
				$("#theaterInfo_tbody").append(
	    				"<tr>"+
	    					"<th colspan='2'>"+
	    					"<img src='/resources/images/"+obj.theaterImage+"' width='250px;' height='200px;'>"+
	    					"</th>"+
	    				"</tr>"+
	    				"<tr>"+
	    					"<th colspan='2'>"+obj.theaterName+
	    				"</tr>"+
	    				"<tr>"+
	    					"<th>지역</th>"+
	    					"<td>"+obj.theaterPlace+"</td>"+
	    				"</tr>"+
	    				"<tr>"+
	    					"<th>주소</th>"+
	    					"<td>"+obj.theaterAddress+"</td>"+
	    				"</tr>"+
	    				"<tr>"+
	    					"<th>연락처</th>"+
	    					"<td>"+obj.theaterTel+"</td>"+
	    				"</tr>");
	    				/* "<tr>"+
	    					"<th>총 좌석</th>"+
	    					"<td>"+(parseInt(obj.seat_column)+parseInt(obj.seat_row))+"</td>"+
	    				"</tr>"); */
	    		
 			}
 					
 			xhttp.open("GET", "theaterInfo?theaterCode=" + theaterCode, true); 
 				
 			xhttp.send();
 		};
 		
 		$(document).on("mouseleave", "#theater_sales_tbl_theater", function(){
 			$(".popup_theaterInfo").css("display", "none");
 		});
 	</script>
    <script>
    	$(document).ready(maleReservedCnt, femaleReservedCnt);
    	let genderCnt = new Array();
    	//성별에 따른 예매율 - 남
    	function maleReservedCnt(){
    		
    		const xhttp = new XMLHttpRequest();
	    	xhttp.onload = function() {
	    	let result = this.responseText; 
	    		let obj = JSON.parse(result);
	    		
	    		let maleAllCnt = 0;
	    		
	    		for(let i = 0; i < obj.length; i++){
	    			
	    			maleAllCnt = parseInt(maleAllCnt) + parseInt(obj[i].reservationCnt);
	    		}
	    		//예매율 테이블
	    		let maleLike = parseInt(obj[0].reservationCnt) / maleAllCnt * 100;
	    		$("#genderTbl_tbody").append(
	    				"<tr>"+
	    					"<td id='tbl_male_cnt'>"+
	    						"남"+
	    						"<input type='hidden' value='"+obj[0].movieCode+"'>"+
	    					"</td>"+
	    					"<td id='movie_info'><a href='movieUpdate?movieCode="+obj[0].movieCode+"'>"+obj[0].movieTitle+"</a></td>"+
	    					"<td>"+Math.round(maleLike)+"%</td>"+
	    				"</tr>");
	    		
	    		$("#maleReservedCnt").val(maleAllCnt);
	    		let maleReservedCnt = parseInt($("#maleReservedCnt").val());

	    		//genderTbl_tbody1_1
	    		for(let j = 0; j < obj.length; j++){
	    			let cnt_rate = parseInt(obj[j].reservationCnt) / maleReservedCnt * 100;
	    			$("#genderTbl_tbody1_1").append(
	    					"<tr>"+
		    					"<td>"+
		    						(j+1)+
		    						"<input type='hidden' value='"+obj[j].movieCode+"'>"+
		    					"</td>"+
		    					"<td id='movie_info'><a href='movieUpdate?movieCode="+obj[j].movieCode+"'>"+obj[j].movieTitle+"</a></td>"+
		    					"<td>"+Math.round(cnt_rate)+"%</td>"+
	    					"</tr>");
	    		}
	    		
	    		//성별 클릭시 전체테이블
	    		$("#tbl_male_cnt").click(function(){
	    			if($("#genderTbl_tbody1_1").css("display") == 'none'){
		    			$("#genderTbl_thead").hide();
		    			$("#genderTbl_tbody").hide();
		    			$("#genderTbl_tbody2").hide();
		    			$("#gender_tbl_notice").hide();
		    			$("#genderTbl_tbody1_1").show();
		    			$(".gamut1").css("height", "1600px");
		    			$("html, body").stop().animate({ scrollTop : "+=160" });
	    			}
	    		});
	    		
	    		
	    	}
	    	if(month < 10){
		    	xhttp.open("GET", "genderReservedCnt?gender=남자"+ "&year="+year + "&month=0"+month, true); 
	    			
	    		xhttp.send();
	    	}else{
	    		xhttp.open("GET", "genderReservedCnt?gender=남자"+ "&year="+year + "&month="+month, true); 
    			
	    		xhttp.send();
	    	}
    	}
	    
    	setTimeout(femaleReservedCnt, 100);
    	
    	//성별에 따른 예매율 - 여
		function femaleReservedCnt(){
    		
    		const xhttp = new XMLHttpRequest();
	    	xhttp.onload = function() {
	    	let result = this.responseText; 
	    		let obj = JSON.parse(result);
	    		
	    		let femaleAllCnt = 0;
	    		for(let i = 0; i < obj.length; i++){
	    			femaleAllCnt = parseInt(femaleAllCnt) + parseInt(obj[i].reservationCnt);
	    			
	    		}
	    		$("#femaleReservedCnt").val(femaleAllCnt);
	    		
	    		let _maleCnt = parseInt($("#maleReservedCnt").val());
	    		let _femaleCnt = parseInt($("#femaleReservedCnt").val());
	    		let totalCnt = _maleCnt + _femaleCnt;
				
	    		
	    		let maleCnt = Math.round(_maleCnt / totalCnt * 100);
	    		let femaleCnt = Math.round(_femaleCnt / totalCnt * 100);
	    		
	    		cntPieChartByGender(maleCnt, femaleCnt);
	    		
	    		//예매율 테이블
	    		let femaleLike = parseInt(obj[0].reservationCnt) / femaleAllCnt * 100;
	    		$("#genderTbl_tbody2").append(
	    				"<tr>"+
	    					"<td id='tbl_female_cnt'>"+
	    						"여"+
	    						"<input type='hidden' value='"+obj[0].movieCode+"'>"+
	    					"</td>"+
	    					"<td id='movie_info'><a href='movieUpdate?movieCode="+obj[0].movieCode+"'>"+obj[0].movieTitle+"</a></td>"+
	    					"<td>"+Math.round(femaleLike)+"%</td>"+
	    				"</tr>");
	    		
	    		//genderTbl_tbody2_1
	    		for(let j = 0; j < obj.length; j++){
	    			let cnt_rate = parseInt(obj[j].reservationCnt) / _femaleCnt * 100;
	    			$("#genderTbl_tbody2_2").append(
	    					"<tr>"+
		    					"<td>"+
		    						(j+1)+
		    						"<input type='hidden' value='"+obj[j].movieCode+"'>"+
		    					"</td>"+
		    					"<td id='movie_info'><a href='movieUpdate?movieCode="+obj[j].movieCode+"'>"+obj[j].movieTitle+"</a></td>"+
		    					"<td>"+Math.round(cnt_rate)+"%</td>"+
	    					"</tr>");
	    		}
	    		//성별 클릭시 전체테이블
	    		$("#tbl_female_cnt").click(function(){
	    			if($("#genderTbl_tbody2_2").css("display") == 'none'){
		    			$("#genderTbl_thead").hide();
		    			$("#genderTbl_tbody").hide();
		    			$("#genderTbl_tbody2").hide();
		    			$("#gender_tbl_notice").hide();
		    			$("#genderTbl_tbody2_2").show();
		    			$(".gamut1").css("height", "1600px");
		    			$("html, body").stop().animate({ scrollTop : "+=160" });
	    			}
	    			
	    		});
	    	}
	    	if(month < 10){
	    		xhttp.open("GET", "genderReservedCnt?gender=여자" + "&year="+year + "&month=0"+month, true); 
	    			
	    		xhttp.send();
	    	}else{
	    		xhttp.open("GET", "genderReservedCnt?gender=여자" + "&year="+year + "&month="+month, true); 
    			
	    		xhttp.send();
	    	}
    	};
    	
		//x버튼 누르면 성별전체보기 닫기
		$("#btn_x").click(function(){
			$("#genderTbl_thead").show();
			$("#genderTbl_tbody").show();
			$("#genderTbl_tbody2").show();
			$("#gender_tbl_notice").show();
			$("#genderTbl_tbody1_1").hide();
			$(".gamut1").css("height", "1500px");
			$('html, body').animate({ scrollTop: "-=80"}, 500);
        });
		$("#btn_x2").click(function(){
			$("#genderTbl_thead").show();
			$("#genderTbl_tbody").show();
			$("#genderTbl_tbody2").show();
			$("#gender_tbl_notice").show();
			$("#genderTbl_tbody2_2").hide();
			$(".gamut1").css("height", "1500px");
			$('html, body').animate({ scrollTop: "-=80"}, 500);
		});
        
    	//성별에 따른 파이차트
 		function cntPieChartByGender(maleCnt, femaleCnt) {
	        // 총 영화관 한달 영화예매량 그래프
	
	        google.charts.load('current', {'packages':['corechart']});
	        google.charts.setOnLoadCallback(function() {
	            var data = new google.visualization.DataTable();
	            data.addColumn('string', '성별');
	            data.addColumn('number', '예매율');
	            
	            
	            let arr = new Array();
				arr[0] = ["남", maleCnt];
				arr[1] = ["여", femaleCnt];
	            
	            data.addRows(arr);
	
	            var options = {
	                seriesType: 'pie',
	                is3D: true,
	                fontSize: '15',
	                colors: ['#0299C6', '#DD4477'],
	                series: {1: {type: 'line'}},
	                chartArea: {'width': '100%', 'height': '80%'},
	            
	            };
	
	            var chart = new google.visualization.PieChart(document.getElementById('genderCntGraph'));
	            chart.draw(data, options);
	        });
	    }
	    
    </script>
    <script>
    	//장르 추출
    	$(document).ready(allGenre);
    	function allGenre(){
    		const xhttp = new XMLHttpRequest();
    		xhttp.onload = function() {
    			let result = this.responseText; 
				let obj = JSON.parse(result);
				let genres = new Array();
				let reservationCnt = new Array();
				
				let mystery = 0;
				let thriller = 0;
				let anime = 0;
				let docu = 0;
				let action = 0;
				let adven = 0;
				let sf = 0;
				let drama = 0;
				let concert = 0;
				let music = 0;
				let rommance = 0;
				let fantasy = 0;
				let melo = 0;
				let horror = 0;
				
				
				for(let i = 0; i < obj.length; i++){
					const genre = obj[i].genre;
					if(genre.includes("미스터리") == true){
						mystery += 1;
						genres[0] = "미스터리";
						reservationCnt[0] = mystery;
					}
					if(genre.includes("스릴러") == true){
						thriller += 1;
						genres[1] = "스릴러";
						reservationCnt[1] = thriller;
					}
					if(genre.includes("애니메이션") == true){
						anime += 1;
						genres[2] = "애니메이션";
						reservationCnt[2] = anime;
					}
					if(genre.includes("다큐멘터리") == true){
						docu += 1;
						genres[3] = "다큐멘터리";
						reservationCnt[3] = docu;
					}
					if(genre.includes("액션") == true){
						action += 1;
						genres[4] = "액션";
						reservationCnt[4] = action;
					}
					if(genre.includes("어드벤처") == true){
						adven += 1;
						genres[5] = "어드벤처";
						reservationCnt[5] = adven;
					}
					if(genre.includes("sf") == true || genre.includes("SF") == true){
						sf += 1;
						genres[6] = "sf";
						reservationCnt[6] = sf;
					}
					if(genre.includes("드라마") == true){
						drama += 1;
						genres[7] = "드라마";
						reservationCnt[7] = drama;
					}
					if(genre.includes("콘서트") == true){
						concert += 1;
						genres[8] = "콘서트";
						reservationCnt[8] = concert;
					}
					if(genre.includes("뮤지컬") == true){
						music += 1;
						genres[9] = "뮤지컬";
						reservationCnt[9] = music;
					}
					if(genre.includes("로맨스") == true){
						rommance += 1;
						genres[10] = "로맨스";
						reservationCnt[10] = rommance;
					}
					if(genre.includes("판타지") == true){
						fantasy += 1;
						genres[11] = "판타지";
						reservationCnt[11] = fantasy;
					}
					if(genre.includes("멜로") == true){
						melo += 1;
						genres[12] = "멜로";
						reservationCnt[12] = melo;
					}
					if(genre.includes("호러") == true){
						horror += 1;
						genres[13] = "호러";
						reservationCnt[13] = horror;
					}
					
				}
				cntPieChartByGenre(genres, reservationCnt);
				for(let i = 0; i < genres.length; i++){
					if(genres[i] != undefined){
						$("#genre_tbl_tbody").append(
								"<tr>"+
									"<td>" + genres[i] + "</td>"+
									
								"</tr>");
					}
				}
    		}
    				
    		xhttp.open("GET", "allGenre", true); 
    			
    		xhttp.send();
    	}
    	
    	function cntPieChartByGenre(genres, reservationCnt) {
	        // 총 영화관 한달 영화예매량 그래프
	        google.charts.load('current', {'packages':['corechart']});
	        google.charts.setOnLoadCallback(function() {
	            var data = new google.visualization.DataTable();
	            data.addColumn('string', '장르');
	            data.addColumn('number', '예매율');
				
	            let arr = new Array();
	            for(let i = 0; i < genres.length; i++){
					arr[i] = [genres[i], reservationCnt[i]];
	            }
				
	            data.addRows(arr);
	
	            var options = {
	                seriesType: 'pie',
	                is3D: true,
	                fontSize: '15',
	                series: {1: {type: 'line'}},
	                chartArea: {'width': '100%', 'height': '80%'}
	            };
				
	            var chart = new google.visualization.PieChart(document.getElementById('genreCntGraph'));
	            chart.draw(data, options);
	        });
	    }
    	
    	
    </script>
</body>
</body>
</html>