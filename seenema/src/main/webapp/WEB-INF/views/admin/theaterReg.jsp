<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/theaterReg.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
</head>
<body>
	  <div class="gamut1">
	   <!-- 좌측메뉴 jsp -->
		<%@ include file="adminMenu.jsp"%>
	    <div class="main_view1">
	
	       <div id="doToday_menu">
	          <div id="main_header">
	             <div id="menu_title">영화관 등록</div>
	          </div>
	       </div>
	       <div class="easy_menu1">
	          <form action="theaterReg.do" id="theaterReg_Form" method="post" enctype="multipart/form-data">
	              <div id="input_menu_1">
	                  <span id="menu_inMenu">
	                      <div id="input_title">영화관 지역</div>
	                      <div id="textbox">
	                          <select class="selectMenu" name="theaterPlace" id="theaterPlace" size="1">
	                              <option>-선택-</option>
	                              <option value="서울특별시">서울특별시</option>
	                              <option value="인천광역시">인천광역시</option>
	                              <option value="대전광역시">대전광역시</option>
	                              <option value="대구광역시">대구광역시</option>
	                              <option value="부산광역시">부산광역시</option>
	                              <option value="울산광역시">울산광역시</option>
	                              <option value="광주광역시">광주광역시</option>
	                          </select>
	                      </div>
	                  </span>
	                  <span id="menu_inMenu">
	                      <div id="input_title">영화관 이름</div>
	                      <div id="textbox"><input type="text" name="theaterName" id="theaterName"></div>
	                  </span>
	              </div>
	              <div id="input_menu">
	                  <div id="input_title">주소</div>
	                  <div id="textbox"><input type="text" name="theaterAddress" id="theaterAddress"></div>
	              </div>
	            
	              <div id="input_menu">
	                  <div id="input_title"></div>
	                  <div id="textbox"><input type="button" id="map_preview" value="지도 미리 보기"></div>
	                  <input type="hidden" id="flag" value="0">
	              </div>
	              <div id="input_menu">
	                  <div id="input_title">연락처</div>
	                  <div id="textbox"><input type="text" name="theaterTel" id="theaterTel" maxlength="13" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></div>
	              </div>
	             <div id="input_menu_1">
	                  <span id="menu_inMenu">
	                      <div id="input_title">좌석 행</div>
	                     <select class="selectMenu" name="seat_column" id="seat_column" size="1">
	                              <option>-선택-</option>
	                     </select>
	                  </span>
	                  <span id="menu_inMenu">
	                      <div id="input_title">좌석 열</div>
	                       <select class="selectMenu" name="seat_row" id="seat_row" size="1">
	                              <option>-선택-</option>
	                     </select>
	                  </span>
	              </div>
	             
	              <div id="input_menu">
	                  <div id="input_title">영화관 사진 업로드</div>
	                  <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)" style="cursor: pointer;">
	                  <label id=upload_btn for="photoFileName">
	                      파일선택
	                  </label>
	              </div>
	              <div id="submitBox">
	                  <div><input type="submit" id="submitBtn" value="등록하기"></div>
	              </div>
	          </form>
	          <div id="regied_content">
	              <div id="regied_photo">
	                  <div id="regied_text">-사진 미리보기-</div>
	              </div>
	              <div id="regied_map_preview">
	                  <div id="regied_text">-지도 미리보기-</div>
	              </div>
	          </div>
	       </div>
	    </div>
	 </div>
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
    </script>
    <script>
     	//영화관이미지 미리보기
	    function setThumbnail(event) {
	        let reader = new FileReader();
	
	        reader.onload = function(event) {
	            let img = document.createElement("img");
	            img.setAttribute("src", event.target.result);
	            img.setAttribute("width", "370");
	            img.setAttribute("height", "450");
	            $("#regied_photo").html(img);
	        };
	        reader.readAsDataURL(event.target.files[0]);
	    }
  	</script>
  	<script>
  		//좌석에 1~20 숫자넣기
  		$(document).ready(setSeat);
  		function setSeat(){
  			for(let i = 1; i < 21; i++){
  				let option = $("<option value="+i+">"+i+"</option>");
		  		$("#seat_column").append(option);
  			}
  			
  			for(let j = 1; j < 21; j++){
  				let option2 = $("<option value="+j+">"+j+"</option>");
		  		$("#seat_row").append(option2);
  			}
  			
  		}
  		//유효성 검사
  		$("#submitBtn").on("click", function(){
  			if($("#theaterPlace").val() == "-선택-"){
  				alert("영화관 지역을 선택해주세요");
  				$("#theaterPlace").css("border", "1px solid red");
  				$("#theaterPlace").focus();
  				return false;
  			}else if($("#theaterPlace").val() != "-선택-"){
  				$("#theaterPlace").css("border", "1px solid lightgray");
  			}
  			if($("#theaterName").val() == ""){
  				alert("영화관 이름을 입력해주세요");
  				$("#theaterName").css("border", "1px solid red");
  				$("#theaterName").focus();
  				return false;
  			}else if($("#theaterName").val() != ""){
  				$("#theaterName").css("border", "1px solid lightgray");
  			}
  			if($("#theaterAddress").val() == ""){
  				alert("영화관 주소를 입력해주세요");
  				$("#theaterAddress").css("border", "1px solid red");
  				$("#flag").val("0");
  				$("#theaterAddress").focus();
  				return false;
  			}else if($("#theaterAddress").val() != ""){
  				$("#theaterAddress").css("border", "1px solid lightgray");
  			}
  			if($("#flag").val() == "0"){
  				alert("지도 미리보기를 눌러 위치를 확인해주세요!");
  				$("#map_preview").css("border", "1px solid red");
  				return false;
  			}else if($("#flag").val() == "1"){
  				$("#map_preview").css("border", "1px solid lightgray");
  			}
  			if($("#theaterTel").val() == ""){
  				alert("영화관 연락처를 입력해주세요");
  				$("#theaterTel").css("border", "1px solid red");
  				$("#theaterTel").focus();
  				return false;
  			}else if($("#theaterTel").val() != ""){
  				$("#theaterTel").css("border", "1px solid lightgray");
  			}
  			if($("#seat_column").val() == "-선택-"){
  				alert("좌석(행)을 선택해주세요");
  				$("#seat_column").css("border", "1px solid red");
  				$("#seat_column").focus();
  				return false;
  			}else if($("#seat_column").val() != "-선택-"){
  				$("#seat_column").css("border", "1px solid lightgray");
  			}
  			if($("#seat_row").val() == "-선택-"){
  				alert("좌석(열)을 선택해주세요");
  				$("#seat_row").css("border", "1px solid red");
  				$("#seat_row").focus();
  				return false;
  			}else if($("#seat_row").val() != "-선택-"){
  				$("#seat_row").css("border", "1px solid lightgray");
  			}
  			if($("#photoFileName").val() == ""){
  				alert("영화관 사진을 선택해주세요");
  				$("#upload_btn").css("border", "1px solid red");
  				$("#upload_btn").focus();
  				return false;
  			}else if($("#photoFileName").val() != ""){
  				$("#upload_btn").css("border", "1px solid lightgray");
  			}
  			
  			
  		});
  		//지도 미리보기 유효성검사
  		$("#map_preview").on("click", function(){
  			if($("#theaterAddress").val() == ""){
  				alert("영화관 주소를 입력 해주세요");
  				$("#theaterAddress").css("border", "1px solid red");
  				$("#theaterAddress").focus();
  				return false;
  			}
  		})
  		
  		//영화관지역 선택완료하면 테두리 red->lightgray
  		$("#theaterPlace").on("change", function(){
  			if($("#theaterPlace").val() != ""){
  				$("#theaterPlace").css("border", "1px solid lightgray");
  			}
  		});
  		
  		//제목 입력완료하면 테두리 red-> lightgray
  		$("#theaterName").on("change", function(){
  			if($("#theaterName").val() != ""){
  				$("#theaterName").css("border", "1px solid lightgray");
  			}
  		})
  		
  		//주소 입력완료하면 테두리 red-> lightgray
  		$("#theaterAddress").on("change", function(){
  			if($("#theaterAddress").val() != ""){
  				$("#theaterAddress").css("border", "1px solid lightgray");
  			}
  		});
  		
  		//연락처 입력완료하면 테두리 red-> lightgray
  		$("#theaterTel").on("change", function(){
  			if($("#theaterTel").val() != ""){
  				$("#theaterTel").css("border", "1px solid lightgray");
  			}
  		})
  		
  		//좌석 선택완료하면 테두리 red->lightgray
  		$("#seat_row").on("change", function(){
  			if($("#seat_row").val() != ""){
  				$("#seat_row").css("border", "1px solid lightgray");
  			}
  		});
  		$("#seat_column").on("change", function(){
  			if($("#seat_column").val() != ""){
  				$("#seat_column").css("border", "1px solid lightgray");
  			}
  		});
  	
  		//영화관 사진 업로드 완료하면 테두리 red->lightgray
  		$("#upload_btn").on("change", function(){
  			if($("#photoFileName").val() != ""){
  				$("#upload_btn").css("border", "1px solid lightgray");
  			}
  		});
  		//연락처 하이픈 자동 삽입
  		let autoHypenTel = function(str){
  	      str = str.replace(/[^0-9]/g, '');
  	      let tmp = '';
  	      if( str.length < 4){
  	          return str;
  	      }else if(str.length < 7){
  	          tmp += str.substr(0, 3);
  	          tmp += '-';
  	          tmp += str.substr(3);
  	          return tmp;
  	      }else if(str.length < 11){
  	          tmp += str.substr(0, 3);
  	          tmp += '-';
  	          tmp += str.substr(3, 3);
  	          tmp += '-';
  	          tmp += str.substr(6);
  	          return tmp;
  	      }else{              
  	          tmp += str.substr(0, 3);
  	          tmp += '-';
  	          tmp += str.substr(3, 4);
  	          tmp += '-';
  	          tmp += str.substr(7);
  	          return tmp;
  	      }
  	  
  	      return str;
  		}
  		
		$("#theaterTel").on("keyup", function(){
			this.value = autoHypenTel(this.value) ;  
		});
		
		//연락처 숫자만 입력되도록
		$("#theaterTel").on("keydown", function(e){
			if(e.keyCode > 47 && e.keyCode < 58 ||
				e.keyCode === 8 || //backspace
				e.keyCode === 37 || //방향키
				e.keyCode === 39 || //방향키
				e.keyCode === 46 ||//delete키
				e.keyCode === 9 ||//tab키
				e.keyCode === 13){ //enter키
					$("#price").css("border", "1px solid lightgray");
			}else{
				alert("숫자만 입력가능합니다.");
			}
		});
  	</script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e2cb63af5ce21e3e335968b15d8713a&libraries=services"></script>
	<script>
	//카카오지도 api
	$("#map_preview").on("click", map_preview);
	function map_preview(){
		$("#flag").val("1");
		$("#map_preview").css("border", "1px solid lightgray");
		
		let theaterName = $("#theaterName").val();
		let theaterTel = $("#theaterTel").val();
		let theaterAddress = $("#theaterAddress").val();
		
		var mapContainer = document.getElementById('regied_map_preview'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
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
	        	
	            content: '<div style="width:150px">'+
	            			'<div style="color:black; text-align:center;">'+
	            				theaterName+
	            			'</div>'+
	            			'<span><a href="https://map.kakao.com/link/map/'+theaterName+','+latitude+','+ longitude+'" style="color:blue; font-size:10pt;" target="_blank"> <큰지도보기></a></span>'+
	            		'<span><a href="https://map.kakao.com/link/to/'+theaterName+','+latitude+','+ longitude+'" style="color:blue; font-size:10pt;" target="_blank"> <길찾기></a></span></div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
		    } 
		});    
	};
	</script>


</body>
</html>