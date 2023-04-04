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
</head>

<body>
<table border="1" id="bar_chart_div">
	<tr>
		<th>제목</th>
		<th>예매율</th>
	</tr>
	<c:forEach var="m" items="${mList }">
	<tr>
		<td id=title> ${m.movieTitle }</td>
		<td id=mCnt> ${m.cnt }</td>
		
	</tr>
	</c:forEach>
</table>
<input type="button" onclick="loadDoc()" value="조회">
<table border="1">
	<tr>
		<th>제품코드</th>
		<th>제품이름</th>
	</tr>
	
	<tbody id="ptbody">
	
	</tbody>
	
</table>
<div style="background-color:blue; width:500px; height:500px"><img src="/resources/images/logo4.png"></div>
<div id=chart_div style="width:400px; height:400px"></div>

<span id="pagenum"></span>
  
	<script>
		let mTitle = document.querySelectorAll("#title");
		let mHit = document.querySelectorAll("#mCnt");
		
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawVisualization);
		
		function drawVisualization() {
			  // Some raw data (not necessarily accurate)
			
			
		  var data = new google.visualization.DataTable();
		  data.addColumn('string', '영화');
		  data.addColumn('number', '예매량');
		 
		
		  let arr = new Array();
			
		  for(let i = 0; i < mHit.length; i++){
			  movieTitles = mTitle[i].innerText;
			  movieHits = parseInt(mHit[i].innerText);
			  arr[i] = [movieTitles, movieHits];
			  
		  }
			  data.addRows(arr);

		  var options = {
			    title : '영화 예매율',
			    //vAxis: {title: '예매율'},
			    hAxis: {title: '영화'},
			    seriesType: 'bars',
			    animation: { //차트가 뿌려질때 실행될 애니메이션 효과
                    startup: true,
                    duration: 1000,
                    easing: 'linear' },
			    series: {1: {type: 'line'}},
			    colors:['skyblue', 'red'],
			    annotations: {
                    textStyle: {
                      fontSize: 15,
                      bold: true,
                      italic: true,
                      color: '#871b47',
                      auraColor: '#d799ae',
                      opacity: 0.8
                    }
               }
			
			   
		  };
		
		  var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
		  chart.draw(data, options);
		}
	</script>
	<script>
	

	</script>
</body>
</html>