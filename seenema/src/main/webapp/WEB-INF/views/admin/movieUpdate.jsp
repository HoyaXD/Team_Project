<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<link rel="stylesheet" href="/css/movieUpdate.css">
</head>
<body>
   <div class="gamut1">
 	<!-- 좌측메뉴 jsp -->
	<%@ include file="adminMenu.jsp"%>
      <div class="main_view1">
         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">영화정보수정</div>
            </div>
         </div>
         <div class="easy_menu1">
         
            <form action="movieUpdate.do" id="movieUpdate_form" method="post" enctype="multipart/form-data">
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">영화코드</div>
                        <div id="textbox"><input type="text" name="movieCode" id="movieCode" value="${movie.movieCode }" readonly></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">영화제목</div>
                        <div id="textbox"><input type="text" name="movieTitle" id="movieTitle" value="${movie.movieTitle }"></div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">장르</div>
                        <div id="textbox"><input type="text" value="${movie.genre }" id="genre" name="genre"></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">러닝타임</div>
                        <div id="textbox"><input type="text" value="${movie.runningTime }" id="runningTime" name="runningTime" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">감독</div>
                    <div id="textbox"><input type="text" value="${movie.director }" id="director" name="director"></div>
                </div>
                <div id="input_menu">
                    <div id="input_title">배우</div>
                    <div id="textbox"><input type="text" value="${movie.actors }" id="actors" name="actors"></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">관람연령</div>
                        <div id="textbox">
                            <select class="selectMenu" name="viewAge" id="viewAge" size="1">
                            	<c:if test="${movie.viewAge == 0 }">
                            		<option value="${movie.viewAge }">전체 관람가</option>
                            		<option>-선택-</option>
	                                <option value="0">전체관람가</option>
	                                <option value="12">12세 이상 관람가</option>
	                                <option value="15">15세 이상 관람가</option>
	                                <option value="19">청소년 관람불가</option>
                            	</c:if>
                            	<c:if test="${movie.viewAge == 12 || movie.viewAge == 15 }">
	                                <option value="${movie.viewAge }">${movie.viewAge }세 이상 관람가</option>
	                                <option>-선택-</option>
	                                <option value="0">전체관람가</option>
	                                <option value="12">12세 이상 관람가</option>
	                                <option value="15">15세 이상 관람가</option>
	                                <option value="19">청소년 관람불가</option>
                            	</c:if>
                            	<c:if test="${movie.viewAge == 19 }">
	                                <option value="${movie.viewAge }">청소년 관람불가</option>
	                                <option>-선택-</option>
	                                <option value="0">전체관람가</option>
	                                <option value="12">12세 이상 관람가</option>
	                                <option value="15">15세 이상 관람가</option>
	                                <option value="19">청소년 관람불가</option>
                            	</c:if>
                            </select>
                        </div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">개봉일</div>
                        <div id="textbox"><input type="date" value="${movie.releaseDate }" name="releaseDate" id="releaseDate"></div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">상영날짜</div>
                        <div id="textbox"><input type="date" value="${movie.start_date }" name="start_date" id="start_date">&nbsp;&nbsp;~</div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="textbox"><input type="date" value="${movie.end_date }" name="end_date" id="end_date"></div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">상영시간</div>
                        <div id="textbox">
                            <input type="time" id="sel_playingTime">
                        </div>
                    </span>
                    <span id="selected_time">
                        <div id="input_title" class="selected_time"></div>
                        <div id="textbox" class="selected_time_result" name="selected_time_result">
                           
                        </div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">상영관</div>
                            <div id="textbox">
                                <select class="selectMenu" id="theater" size="1">
                                    <option value="none">-선택-</option>
                                <c:forEach var="t" items="${theater }">
                                    <option value="${t.theaterName }">${t.theaterName }</option>
                                </c:forEach>
                            </select>
                        </div>
                    </span>
                    <span id="selected_theater">
                        <div id="input_title" class="selected_theater"></div>
                        <div id="textbox" class="selected_result">
                        
                        </div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">줄거리</div>
                    <div id="textbox"><textarea name="plot" id="plot">${movie.plot}</textarea></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">포스터 업로드</div>
                        <div id="textbox">
                            <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)" style="cursor: pointer;">
                            <label id=upload_btn for="photoFileName">
                                파일선택
                            </label>
                            <input type="hidden" name="postFileName" id="regied_photofile" value="${movie.postFileName }">
                        </div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">예고편 URL</div>
                        <div id="textbox"><input type="text" id="previewURL" value="${movie.previewURL}" name="previewURL"></div>
                    </span>
                </div>
                <div id="submitBox">
                	<div><input type="button" id="delBtn" value="삭제하기"></div>
                    <div><input type="submit" id="submitBtn" value="수정하기"></div>
                </div>
            </form>
            <div id="regied_content">
                <div id="regied_photo">
                    <img src="/resources/images/${movie.postFileName}" id="photo">
                </div>
                <div id="regied_preview">
                   
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
    	//상영날짜 유효성검사
		$("#end_date").on("change", function(){
			if($("#start_date").val() == ""){
				alert("상영 시작 날짜가 선택되지 않았습니다.");
				$("#start_date").css("border", "1px solid red");
			}
			if($("#start_date").val() > $("#end_date").val()){
				alert("상영 시작 일자가 마감 일자 보다 더 늦습니다. 다시 선택해주세요.");
				$("#start_date").val("");
				$("#end_date").val("");
				$("#start_date").css("border", "1px solid red");
				$("#end_date").css("border", "1px solid red");
			}
		});
      	$("#submitBtn").on("click", function(){
      		
			//유효성 검사 -영화 등록
			if($("#movieTitle").val() == ""){
				alert("영화 제목을 입력해주세요!");
				$("#movieTitle").css("border", "1px solid red");
				$("#movieTitle").focus();
				return false;
			}else if($("#movieTitle").val() != ""){
				$("#movieTitle").css("border", "1px solid lightgray");
			}
			
			if($("#genre").val() == ""){
				alert("장르를 입력해주세요!");
				$("#genre").css("border", "1px solid red");
				$("#genre").focus();
				return false;
			}else if($("#genre").val() != ""){
				$("#genre").css("border", "1px solid lightgray")
			}
			
			if($("#runningTime").val() == ""){
				alert("러닝타임을 입력해주세요!");
				$("#runningTime").css("border", "1px solid red");
				$("#runningTime").focus();
				return false;
			}else if($("#runningTime").val() != ""){
				$("#runningTime").css("border", "1px solid lightgray");
			}
			
			if($("#director").val() == ""){
				alert("감독 이름을 입력해주세요!");
				$("#director").css("border", "1px solid red");
				$("#director").focus();
				return false;
			}else if($("#director").val() != ""){
				$("#director").css("border", "1px solid lightgray");
			}
			
			if($("#actors").val() == ""){
				alert("배우 이름을 입력해주세요!");
				$("#actors").css("border", "1px solid red");
				$("#actors").focus();
				return false;
			}else if($("#actors").val() != ""){
				$("#actors").css("border", "1px solid lightgray");
			}
			
			if($("#viewAge").val() == "-선택-"){
				alert("관람 연령을 선택해주세요!");
				$("#viewAge").css("border", "1px solid red");
				$("#viewAge").focus();
				return false;
			}else if($("#viewAge").val() != "-선택-"){
				$("#viewAge").css("border", "1px solid lightgray");
			}
			
			if($("#releaseDate").val() == ""){
				alert("개봉일을 선택해주세요!");
				$("#releaseDate").css("border", "1px solid red");
				$("#releaseDate").focus();
				return false;
			}else if($("#releaseDate").val() != ""){
				$("#releaseDate").css("border", "1px solid lightgray");
			}
			
			if($("#start_date").val() == "" || $("#end_date").val() == ""){
				alert("상영날짜를 선택해주세요!");
				$("#start_date").css("border", "1px solid red");
				$("#end_date").css("border", "1px solid red");
				$("#start_date").focus();
				$("#end_date").focus();
				return false;
			}else if($("#start_date").val() != "" || $("#end_date").val() != ""){
				$("#start_date").css("border", "1px solid lightgray");
				$("#end_date").css("border", "1px solid lightgray");
			}
			
			if($("#theaterHidden").val() == undefined){
				alert("상영관을 선택해주세요.");
				$("#theater").css("border", "1px solid red");
				return false;
			}
			if($("#playingTimeHidden").val() == undefined){
				alert("상영시간을 선택해주세요.");
				$("#sel_playingTime").css("border", "1px solid red");
				return false;
			}
			
			if($("#plot").val() == ""){
				alert("줄거리를 입력해주세요.");
				$("#plot").css("border", "1px solid red");
				return false;
			}else if($("#plot").val() != ""){
				$("#plot").css("border", "1px solid lightgray");
			}
			
			if($("#regied_photofile").val() == ""){
				alert("포스터 이미지를 등록해주세요.");
				$("#upload_btn").css("border", "1px solid red");
				return false;
			}else if($("#regied_photofile").val() != ""){
				$("#upload_btn").css("border", "1px solid lightgray");
			}
			
			if($("#previewURL").val() == ""){
				alert("예고편 링크를 입력해주세요.");
				$("#previewURL").css("border", "1px solid red");
				return false;
			}
			else if($("#previewURL").val() != ""){
				$("#plot").css("border", "1px solid lightgray");
			}
			
			
		});
        //영화제목 입력완료하면 테두리 red-> lightgray
  		$("#movieTitle").on("change", function(){
  			if($("#movieTitle").val() != ""){
  				$("#movieTitle").css("border", "1px solid lightgray");
  			}
  		});
  		//장르 입력완료하면 테두리 red-> lightgray
  		$("#genre").on("change", function(){
  			if($("#genre").val() != ""){
  				$("#genre").css("border", "1px solid lightgray");
  			}
  		});
  		//러닝타임 입력완료하면 테두리 red-> lightgray
  		$("#runningTime").on("change", function(){
  			if($("#runningTime").val() != ""){
  				$("#runningTime").css("border", "1px solid lightgray");
  			}
  		});
  		//감독 입력완료하면 테두리 red-> lightgray
  		$("#director").on("change", function(){
  			if($("#director").val() != ""){
  				$("#director").css("border", "1px solid lightgray");
  			}
  		});
  		//감독 입력완료하면 테두리 red-> lightgray
  		$("#actors").on("change", function(){
  			if($("#actors").val() != ""){
  				$("#actors").css("border", "1px solid lightgray");
  			}
  		});
  		//관람연령 선택되면 테두리 red-> lightgray
  		$("#viewAge").on("change", function(){
  			if($("#viewAge").val() != "-선택-"){
  				$("#viewAge").css("border", "1px solid lightgray");
  			}
  		});
  		//개봉일 선택되면 테두리 red-> lightgray
  		$("#releaseDate").on("change", function(){
  			if($("#releaseDate").val() != ""){
  				$("#releaseDate").css("border", "1px solid lightgray");
  			}
  		});
		//상영일자에 날짜가 선택되면 테두리 red -> lightgray
		$("#start_date").on("change", function(){
			if($("#start_date").val() != ""){
				$("#start_date").css("border", "1px solid lightgray");
			}
		});
		$("#end_date").on("change", function(){
			if($("#end_date").val() != ""){
				$("#end_date").css("border", "1px solid lightgray");
			}
		});
		//영화관 선택이 되면 테두리 red -> lightgray
		$("#theater").on("change", function(){
			if($("#theater").val() != "none"){
				$("#theater").css("border", "1px solid lightgray");
			}
		});
		//상영시간이 선택되면 테두리 red->lightgray
		$("#sel_playingTime").on("change", function(){
			if($("#sel_playingTime").val() != "none"){
				$("#sel_playingTime").css("border", "1px solid lightgray");
			}
		})
		//영화포스터 파일이 입력되면 테두리 red->lightgray
		$("#photoFileName").on("change", function(){
			if($("#photoFileName").val() != "none"){
				$("#upload_btn").css("border", "1px solid lightgray");
			}
		})
		
		//러닝타임 숫자만 입력되도록
		$("#runningTime").on("keydown", function(e){
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
		
      	$("#delBtn").on("click", function(){
	        if (!confirm("영화 정보를 삭제하시겠습니까?")) {
	     
	        }else{
	        	const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
				let result = this.responseText; 
					
					if(result == 1){
						alert("삭제완료!");
						location.href="movieList";
					}else{
						alert("삭제실패..");
						location.href="movieList";
					}
				}
				
				xhttp.open("GET", "delMoviesByCodes.do?movieCodes=" + $("#movieCode").val(), true); 
					
				xhttp.send();
	        }
		});
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
		
        regied_preview();
        function regied_preview(){
            //alert($("#previewURL").val());
            if($("#previewURL").val() == ""){
                $("#regied_preview").text("-예고편 미리보기-");
            }else if($("#previewURL").val() != null){
               let url = $("#previewURL").val().replace('https://youtu.be/', 'https://www.youtube.com/embed/');
               $("#regied_preview").html('<iframe width="370" height="300" src="'+url+'?autoplay=1&controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>');
            }
        };
        $("#previewURL").on("keyup", function(){
        	 if($("#previewURL").val() == ""){
                 $("#regied_preview").text("-예고편 미리보기-");
             }else{
              	let url = $("#previewURL").val().replace('https://youtu.be/', 'https://www.youtube.com/embed/');
        		$("#regied_preview").html('<iframe width="370" height="300" src="'+url+'?autoplay=1&controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>');
             }
        });
        
        selected_theater();
        function selected_theater(){
        	let theaters = '${movie.theater}';
        	let theater_arr = theaters.split(",");
        	
        	$(".selected_theater").text("선택된 영화관");
        	for(let i = 0; i < theater_arr.length; i++){
        		$(".selected_result").append(
        				"<span id='theaterList'>"+
	        				"<button type='button' id='" + theater_arr[i] + "' class='theater_del' name='theater'>" 
	                       			+ theater_arr[i] + " X"+
	                    	"</button>"+
                    		"<input type='hidden' name='theater' id='theaterHidden' value='"+ theater_arr[i] +"'> "+
                    	"</span>");
        	}
        	
        }
        
        $("#theater").on("change", function(){
            $(".selected_theater").text("선택된 영화관");
            if($(".selected_result").text().includes($("#theater").val() + " X") == false && $("#theater").val() != "none"){
                $(".selected_result").append(
                		"<span id='theaterList'>"+
	                		"<button type='button' id='" + $("#theater").val() + "' class='theater_del' name='theater'>"+
	                        	$("#theater").val() +" X" +
	                         "</button>"+
	                         "<input type='hidden' name='theater' id='theaterHidden' value='"+$("#theater").val()+"'> "+
                         "</span>");
            }else if($("#theater").val() == "none"){
                
            }else{
                alert("이미 추가된 상영관 입니다.");
            }
        });
        
        $(".selected_result").on("click", ".theater_del", function(e){
        	if(e.target.tagName == "BUTTON"){
        		$("#theaterList").remove(); 
        		
        	}
        });
        
		/**/
		
		selected_playingTime();
        function selected_playingTime(){
        	let playingTimes = '${movie.playingTime}';
        	
        	let playingTime_arr = playingTimes.split(",");
        	
        	$(".selected_time").text("선택된 상영시간");
        	for(let i = 0; i < playingTime_arr.length; i++){
        		$(".selected_time_result").append(
        					"<span id='playingTimeList'>"+
        						"<button type='button' value='"+playingTime_arr[i]+"' id='playingTime_del'>"+
        							playingTime_arr[i] +
        						" X</button>"+
		                    	"<input type='hidden' name='playingTime' id='playingTimeHidden' value='"+playingTime_arr[i]+"'> "+
        					"</span>");
        	}
        	
        }
        
        $("#sel_playingTime").on("change", function(){
            $(".selected_time").text("선택된 상영시간");
            if($(".selected_time_result").text().includes($("#sel_playingTime").val() + " X") == false){
                $(".selected_time_result").append(
                		"<span id='playingTimeList'>"+
	                		"<button type='button' value='" + $("#sel_playingTime").val() + "' id='playingTime_del'>"+
	                        	$("#sel_playingTime").val() + " X"+
	                            "<input type='hidden' name='playingTime' id='playingTimeHidden' value='"+$("#sel_playingTime").val()+"'> "+
	                          "</button>"+
	                     "</span>"
                                            );
            }else{
                alert("이미 추가된 상영시간 입니다.");
            }
        });

        $(".selected_time_result").on("click", "#playingTime_del", function(e){
        	$("#playingTimeList").remove();
        });
   </script>
</body>
</html>