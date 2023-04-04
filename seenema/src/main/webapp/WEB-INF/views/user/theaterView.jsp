<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영관 - 시네마</title>
<link rel="stylesheet" href="/css/theaterView.css">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a44befbc59e365ba93544825866b81d8&libraries=services&async=true"></script>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
	<main id="theaterView">
		<div class="sideBar">
			<div class="sideBarMenu menu1">공지 / 뉴스</div>
			<div class="sideBarMenu menu2">Q&A</div>
			<div class="sideBarMenu menu3">상영관</div>
			<div class="ad ad1">
				<img src="/images/ad1.jpeg">
			</div>
			<div class="ad ad2">
				<img src="/images/ad2.png">
			</div>
		</div>
		<div class="theaterWrap">
			<div class="pageBigTitle">상영관</div>
			<div class="pageSmallTitle">SEENEMA의 상영관을 한눈에!</div>
			<div class="ticketImage">
				<div class="theaterTopWrap">
					<div class="place">서울</div>
					<div class="place">인천</div>
					<div class="place">대전</div>
					<div class="place">대구</div>
					<div class="place">부산</div>
					<div class="place">울산</div>
					<div class="place">광주</div>
				</div>
				<div class="theaterBottomWrap">
					<div class="wrap seoulWrap">
						<div class="item on">강남 스타플렉스</div>
					</div>
					<div class="wrap incheonWrap">
						<div class="item">부평 마장</div>
					</div>
					<div class="wrap daejeonWrap">
						<div class="item"></div>
					</div>
					<div class="wrap daeguWrap">
						<div class="item"></div>
					</div>
					<div class="wrap busanWrap">
						<div class="item">nc백화점</div>
						<div class="item">메가박스부산대</div>
						<div class="item">서면상상마당</div>
						<div class="item">메가박스상상마당</div>
						<div class="item">그린영화관</div>
					</div>
					<div class="wrap ulsanWrap">
						<div class="item"></div>
					</div>
					<div class="wrap kwangjuWrap">
						<div class="item"></div>
					</div>
				</div>
			</div>
			<div class="placeTitle"></div>
			<div id="map" style="width:100%;height:350px;"></div>
			<div class="theaterPhotoWrap">
				<img class="theaterPhoto" src=""><!-- 사진로드 -->
				<div class="infoWrap">
					<div class="infoPlace"></div>
					<div class="theaterName"></div>
					<div class="theaterAddress"></div>
					<div class="tel"></div>
					<div class="seats"></div>
				</div>
			</div>
		</div>
	</main>
<%@ include file="footer.jsp" %>
<script>
	let theaterName = "강남 스타플렉스";	// 초기화
	let theaterAddress = "서울특별시 강남구 강남대로 438 스타플렉스";
	
	//페이지가 시작되면
	$(document).ready(function(){
		$(".menu3").css("backgroundColor", "#FB4357");
		$(".menu3").css("color", "white");
		getTheaterInfo(theaterName);	// 영화관 정보 가져오기
	});
	
	// 영화관 정보
	function getTheaterInfo(theaterName){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let obj = JSON.parse(this.responseText);
			//console.log(obj);
			let theaterName = obj.theaterName;		// 영화관 이름
			theaterAddress = obj.theaterAddress;	// 영화관 주소
			let theaterPlace = obj.theaterPlace;	// 영화관 지역
			let theaterTel = obj.theaterTel;		// 영화관 번호
			let seat_row = obj.seat_row;			// 영화관 행 갯수
			let seat_column = obj.seat_column;		// 영화관 열 갯수
			
			$(".placeTitle").text("SEENEMA " + theaterName);
			$(".theaterPhoto").attr("src", "/resources/images/" + obj.theaterImage);
			$(".infoPlace").text("지역 : " + theaterPlace);
			$(".theaterName").text("상영관 : " + theaterName);
			$(".theaterAddress").text("주소 : " + theaterAddress);
			$(".tel").text("전화번호 : " + theaterTel);
			$(".seats").text("좌석 : " + seat_row * seat_column + "석");
			getMap(theaterAddress, theaterName);	// 지도
		}
		xhttp.open("get", "/user/getTheaterInfo.do?theaterName=" + theaterName, true);
		xhttp.send();
	}
	
	function getMap(theaterAddress, theaterName) {
	    var container = document.getElementById("map");
	    var options = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567),
	        level: 3
	    };
	    var map = new kakao.maps.Map(container, options);

	    // 주소-좌표 변환 객체를 생성합니다
	    var geocoder = new kakao.maps.services.Geocoder();

	    // 주소로 좌표를 검색합니다
	    geocoder.addressSearch(theaterAddress, function(result, status) {

	        // 정상적으로 검색이 완료됐으면
	        if (status === kakao.maps.services.Status.OK) {

	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	            let latitude = result[0].y;
				let longitude = result[0].x;
	            // 결과값으로 받은 위치를 마커로 표시합니다
	            var marker = new kakao.maps.Marker({
	                map: map,
	                position: coords
	            });

	            // 인포윈도우로 장소에 대한 설명을 표시합니다
	            var infowindow = new kakao.maps.InfoWindow({
	                content: 
	                	'<div style="width:200px;text-align:center;padding:6px 0;">' 
		                	+ '<div class="markerName">' + theaterName + '</div>'
		                	+ '<div>' + theaterAddress + '</div>'
		                	+ '<span><a class="anchor" href="https://map.kakao.com/link/map/'+ theaterName + ',' + latitude + ',' + longitude+'" style="color:black; font-size:10pt;" target="_blank"> [큰지도보기]</a></span>'
		            		+ '<span><a class="anchor" href="https://map.kakao.com/link/to/'+ theaterName + ',' + latitude + ',' + longitude+'" style="color:black; font-size:10pt;" target="_blank"> [길찾기]</a></span>'
	                	+ '</div>'
	            });
	            infowindow.open(map, marker);

	            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	            map.setCenter(coords);
	        }
	    });
	}

	
	$(".item").on("click", function(){
		$(this).addClass("on");
		$(".item").not(this).removeClass("on");
		theaterName = $(this).text();
		getTheaterInfo(theaterName);
	});
	
	// 사이드바 메뉴2
	$(".menu1").on("click", function(){
		location.href = "/user/userNoticeBoard";
	});
	
	$(".menu2").on("click", function(){
		location.href = "/user/userQnaView";
	});
	
	$(".menu3").on("click", function(){
		location.href = "/user/theaterView";
	});
</script>
</body>
</html>