<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" href="/css/movieList.css">

</head>
<body>
<!-- 등록된 영화 리스트 조회/삭제 페이지 -->
   <div class="gamut1">
		<!-- 좌측메뉴 jsp -->
	  <%@ include file="adminMenu.jsp"%>
  
      <div class="main_view1">

         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">영화조회</div>
               <table id="serch_tbl">
                  <tr>
                     <th>
                        <select name="serchType" id="serchType" size="1">
                           <option>-선택-</option>
                           <option value="MovieTitle">영화제목으로 검색</option>
                           <option value="MovieDate">개봉일로 검색</option>
                           <option value="MovieTitleDate">제목+개봉일로 검색</option>
                        </select>
                        <span id="serchBox">
                           <input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
                        </span>
                        <button id="btn_serchMovie" onclick="serchMovie();">검색</button>
                        <button onclick="location.href='movieList'">초기화</button>
                     </th>	
                     
                  </tr>
               </table>
            </div>
         </div>

         <div class="easy_menu">
            <div id="listBox">
               <table id="list_tbl">
                  <thead id="thead">
                     <tr>
                        <th><input type="checkbox" id="allChk"></th>
                        <th>영화코드</th>
                        <th>포스터</th>
                        <th>제목</th>
                        <th>개봉일</th>
                        <th>상영시작일</th>
                        <th>상영마감일</th>
                     </tr>
                  </thead>
                  <tbody id="tbody">
                     <c:forEach var="movie" items="${mList }">
                        <tr>
                           <td><input type="checkbox" class="chk" value="${movie.movieCode }"></td>
                           <td>${movie.movieCode }</td>
                           <td><a href="movieUpdate?movieCode=${movie.movieCode }"><img src="/resources/images/${movie.postFileName }" width="50px" height="60px"></a>
                           <td><a href="movieUpdate?movieCode=${movie.movieCode }">${movie.movieTitle }</a></td>
                           <td>${movie.releaseDate }</td>
                           <td style='color:blue;'>${movie.start_date }</td>
                           <td style='color:red;'>${movie.end_date }</td>
                        </tr>
                     </c:forEach>
					<tfoot id="tfoot1">
						<tr>
							<th>
								<button id="js_del">선택삭제</button>
							</th>
							<th id="pageNum" colspan="5"></th>
							<th> 
								<button id="movieReg" onclick="location.href='movieReg'">영화등록</button>
							</th>
						</tr>
	                </tfoot>
               </table>
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
 		let totalPage = 0;
		let pNo = 1;
		$(document).ready(goPage(pNo), cntMovie());
		
		//영화cnt
		function cntMovie(){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText;
				totalPage = Math.ceil(result / 10); //총 페이지
				
				if(totalPage == 0){
				//게시글이 없으면 페이지네이션 숨김
					$("#pageNum").empty();
				}else if(totalPage < 10){
				//페이지 10이하 이면 이전 버튼 숨김
					$("#pageNum").empty();
					for(let i = 0; i < totalPage; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " <span>")
					}
				}else{
				//페이지 10이상 이면
					$("#pageNum").empty();
					
					for(let i = 0; i < 10; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " </span>");
					}
					$("#pageNum").append("<span class='next'> >> </span>");
				}
				$(".pageCnt").filter(":first").css("color", "red"); //첫페이지색깔
			}
			
			xhttp.open("GET", "movieCnt", true); 
				
			xhttp.send();
			
		}
		//페이지 넘버를 클릭
		$(document).on("click", ".pageCnt", function(){
			/* alert("hi"); */
			$(this).css("color", "red"); //클릭된 번호 색깔
			$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
			let pageNum = $(this).text();
			goPage(pageNum);
		})
		//이전버튼
		$(document).on("click", ".prev", function(){
			
			let prevPage = parseInt($(".pageCnt").filter(":first").text(), 10) - 1;
			goPage(prevPage);
			$("#pageNum").empty();
			$("#pageNum").append("<span class='prev'> << </span>");
			for(let i = 0; i < 10; i++){
				$("#pageNum").append("<span class='pageCnt'> " + (prevPage + i - 9) + " </span>");
			}
			$("#pageNum").append("<span class='next'> >> </span>");
			$(".pageCnt").filter(":last").css("color", "red");
			if($(".pageCnt").filter(":first").text() == 1){
				$(".prev").remove();
			}
		});
		//다음버튼
		$(document).on("click", ".next", function(){
			let nextPage = parseInt($(".pageCnt").filter(":last").text(), 10) + 1;
			goPage(nextPage)
			$("#pageNum").empty();
			
			if(totalPage - nextPage < 10){ //마지막페이지가 10페이지 미만
				let leng = totalPage - nextPage + 1;
				$("#pageNum").append("<span class='prev'> << </span>");
				for(let i = 0; i < leng; i++){
					$("#pageNum").append("<span class='pageCnt'> " + (nextPage + i) + "</span>");
				}
				$(".pageCnt").filter(":first").css("color", "red");
			}else{ //페이지가 더남았다면..?
				$("#pageNum").append("<span class='prev'> << </span>");
				for(let j = 0; j < 10; j++){
					$("#pageNum").append("<span class='pageCnt'> " + (nextPage + j) + "</span>");
				}
				$("#pageNum").append("<span class='next'> >> </span>");
				
				$(".pageCnt").filter(":first").css("color", "red");
			}
		})
		//페이지네이션 페이지 이동
		
		function goPage(pNo){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText; 
				let obj = JSON.parse(result);
				$("#thead").empty();
				$("#tbody").empty();
				
				$("#thead").html("<tr>"+
						"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
						"<th>영화코드</th>"+
						"<th>포스터</th>"+
						"<th>제목</th>"+
						"<th>개봉일</th>"+
						"<th>상영시작일</th>"+
						"<th>상영마감일</th>"+
					"</tr>");
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append("<tr>"+
								"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
								"<td>"+obj[i].movieCode+"</td>"+
								"<td><img src='/resources/images/"+obj[i].postFileName+"' width='50px'></td>"+
								"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
								"<td>"+obj[i].releaseDate+"</td>"+
	                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
							"</tr>");
				}
			
			}
					
			xhttp.open("GET", "goMPage?pageNum=" + pNo, true); 
				
			xhttp.send();
		}
	</script>
	<script>
		//전체선택
		$("#allChk").on("change", allChk);
		
		const all = document.querySelector("#allChk");
		const chks = document.querySelectorAll(".chk");
		
		function allChk(){
			for(let i = 0; i < chks.length; i++){
				chks[i].checked = all.checked;
			}
		};
		
		//선택삭제
		$("#btn_delMovies").on("click", movies_delete);
		
		function movies_delete(){
			 if (!confirm("선택된 영화 정보를 삭제하시겠습니까?")) {
			     
		    }else{
				let chked = new Array();
				
				for(let i = 0; i < chks.length; i++){
					if(chks[i].checked){
						chked.push(chks[i].value);
					}
				}
				
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
				
				xhttp.open("GET", "movies_delete.do?movieCodes="+chked, true); 
					
				xhttp.send();
				}
			}
	</script>
	<script>
	//serchType에 따른 검색창 변화
	 $("#serchType").change(function(e){
		 if($("#serchType option:selected").val() == "MovieTitle"){
			 $("#serchBox").html("<span>"+
					 				"<input type='text' id='serchWord' placeholder='영화 제목을 입력해주세요.'>"+
					 			"</span>");
			 
		 }else if($("#serchType option:selected").val() == "MovieDate"){
			
			 $("#serchBox").html("<span id='in_serch_box'>"+
					 				"<input type='date' id='start' name='start'> ~ "+
					 				"<input type='date' id='end' name='end'>"+
					 			"</span>"); 
		 }else if($("#serchType option:selected").val() == "MovieTitleDate"){
			 $("#serchBox").html("<span id='in_serch_box'>"+
					 					"<input type='text' id='serchWord' name='serchWord' placeholder='영화 제목을 입력해주세요.'>"+
		 								"&nbsp;<input type='date' id='start' name='start'> ~ "+
		 								"<input type='date' id='end' name='end'>"+
		 						"</span>"); 
		 }
	});
	
	function serchMovie(mNo = 1){
		let serchWord = $("#serchWord").val();
		let startDate = $("#start").val();
		let endDate = $("#end").val();
		//alert(mNo)
		if($("#serchType option:selected").val() == "MovieTitle"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#thead").empty();
				$("#tbody").empty();
				
				let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					$("#thead").html("<tr>"+
										"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
										"<th>영화코드</th>"+
										"<th>포스터</th>"+
										"<th>제목</th>"+
										"<th>개봉일</th>"+
										"<th>상영시작일</th>"+
										"<th>상영마감일</th>"+
									"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
												"<td>"+obj[i].movieCode+"</td>"+
												"<td><img src='/resources/images/"+obj[i].postFileName+"' width='50px'></td>"+
												"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
												"<td>"+obj[i].releaseDate+"</td>"+
	                                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
											"</tr>");
					}
							
				}else if(obj.length === 0){
					$("#thead").html("<tr>"+
							"<th style='width:120px'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th style='width:83px'>영화코드</th>"+
							"<th style='width:75px'>포스터</th>"+
							"<th style='width:221px'>제목</th>"+
							"<th style='width:127px'>개봉일</th>"+
							"<th style='width:122px'>상영시작일</th>"+
							"<th style='width:122px'>상영마감일</th>"+
						"</tr>");
					$("#tbody").html("<tr>"+
											"<th colspan='7' style='height:300px;'> 해당 영화는 존재 하지 않습니다. </th>"+
									"</tr>");
					
				}
			}	//onload
			xhttp.open("GET", "serchMvByTitle.do?movieTitle=" + serchWord + "&pageNum=" + mNo, true); 
			
			xhttp.send();
			
		 }else if($("#serchType option:selected").val() == "MovieDate"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					$("#thead").html("<tr>"+
										"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
										"<th>영화코드</th>"+
										"<th>포스터</th>"+
										"<th>제목</th>"+
										"<th>개봉일</th>"+
										"<th>상영시작일</th>"+
										"<th>상영마감일</th>"+
									"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
												"<td>"+obj[i].movieCode+"</td>"+
												"<td><img src='/resources/images/"+obj[i].postFileName+"' width='50px'></td>"+
												"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
												"<td>"+obj[i].releaseDate+"</td>"+
	                                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
											"</tr>");
					}
						
				}else if(obj.length === 0){
					$("#thead").html("<tr>"+
							"<th style='width:120px'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th style='width:83px'>영화코드</th>"+
							"<th style='width:75px'>포스터</th>"+
							"<th style='width:221px'>제목</th>"+
							"<th style='width:127px'>개봉일</th>"+
							"<th style='width:122px'>상영시작일</th>"+
							"<th style='width:122px'>상영마감일</th>"+
						"</tr>");
					$("#tbody").html("<tr>"+
											"<th colspan='7' style='height:300px;'> 해당 영화는 존재 하지 않습니다. </th>"+
									"</tr>");
					
				}
			}	//onload
			xhttp.open("GET", "serchMvByDate.do?startDate=" + startDate+ "&endDate=" + endDate + "&pageNum=" + mNo, true); 
			
			xhttp.send();
				
		 }else if($("#serchType option:selected").val() == "MovieTitleDate"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					$("#thead").html("<tr>"+
										"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
										"<th>영화코드</th>"+
										"<th>포스터</th>"+
										"<th>제목</th>"+
										"<th>개봉일</th>"+
										"<th>상영시작일</th>"+
										"<th>상영마감일</th>"+
									"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
												"<td>"+obj[i].movieCode+"</td>"+
												"<td><img src='/resources/images/"+obj[i].postFileName+"' width='50px'></td>"+
												"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
												"<td>"+obj[i].releaseDate+"</td>"+
	                                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
											"</tr>");
					}
					
				}else if(obj.length === 0){
					$("#thead").html("<tr>"+
							"<th style='width:120px'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th style='width:83px'>영화코드</th>"+
							"<th style='width:75px'>포스터</th>"+
							"<th style='width:221px'>제목</th>"+
							"<th style='width:127px'>개봉일</th>"+
							"<th style='width:122px'>상영시작일</th>"+
							"<th style='width:122px'>상영마감일</th>"+
						"</tr>");
					$("#tbody").html("<tr>"+
											"<th colspan='7' style='height:300px;'> 해당 영화는 존재 하지 않습니다. </th>"+
									"</tr>");
					
				}
			}	//onload
			xhttp.open("GET", "serchMvByTitleDate.do?startDate=" + startDate+ "&endDate=" + endDate + "&movieTitle=" + serchWord + "&pageNum=" + mNo, true); 
		 
			xhttp.send();
		 }//else
	}//function
	</script>
	<script>
		//serch 영화 cnt
		$("#btn_serchMovie").on("click", getSrcCnt);
		function getSrcCnt(e){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText;
				totalPage = Math.ceil(result / 10); //총 페이지
				//alert(totalPage);
				if(totalPage == 0){
				//게시글이 없으면 페이지네이션 숨김
					$("#pageNum").empty();
				}else if(totalPage < 10){
				//페이지 10이하 이면 이전 버튼 숨김
					$("#pageNum").empty();
					for(let i = 0; i < totalPage; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " <span>")
					}
				}else{
				//페이지 10이상 이면
					$("#pageNum").empty();
					//$("#pageNum").append("<span class='prev'> << </span>");
					for(let i = 0; i < 10; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " </span>");
					}
					$("#pageNum").append("<span class='next'> >> </span>");
				}
				$(".pageCnt").filter(":first").css("color", "red"); //첫페이지색깔
			}
			
			if($("#serchType").val() == "MovieTitle"){
				xhttp.open("GET", "titleCnt?movieTitle=" + $("#serchWord").val(), true); 
					
				xhttp.send();
				//페이지 넘버를 클릭
				$(document).on("click", ".pageCnt", function(){
					/* alert("hi"); */
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					serchMovie(pageNum);
				})
			}else if($("#serchType").val() == "MovieDate"){
				xhttp.open("GET", "dateCnt?start=" + $("#start").val() + "&end=" + $("#end").val(), true); 
				
				xhttp.send();
				//페이지 넘버를 클릭
				$(document).on("click", ".pageCnt", function(){
					
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					/* alert(pageNum); */
					serchMovie(pageNum);
				});
			}else if($("#serchType").val() == "MovieTitleDate"){
				xhttp.open("GET", "titleDateCnt?startDate=" + $("#start").val() + "&endDate=" + $("#end").val() + "&movieTitle=" + $("#serchWord").val(), true); 
				
				xhttp.send();
				//페이지 넘버를 클릭
				$(document).on("click", ".pageCnt", function(){
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					/* alert(pageNum); */
					serchMovie(pageNum);
				});
			}
			
		}
		
		//이전버튼
		$(document).on("click", ".prev", function(){
			
			let prevPage = parseInt($(".pageCnt").filter(":first").text(), 10) - 1;
			goPage(prevPage);
			$("#pageNum").empty();
			$("#pageNum").append("<span class='prev'> << </span>");
			for(let i = 0; i < 10; i++){
				$("#pageNum").append("<span class='pageCnt'> " + (prevPage + i - 9) + " </span>");
			}
			$("#pageNum").append("<span class='next'> >> </span>");
			$(".pageCnt").filter(":last").css("color", "red");
			if($(".pageCnt").filter(":first").text() == 1){
				$(".prev").remove();
			}
		});
		//다음버튼
		$(document).on("click", ".next", function(){
			let nextPage = parseInt($(".pageCnt").filter(":last").text(), 10) + 1;
			goPage(nextPage)
			$("#pageNum").empty();
			
			if(totalPage - nextPage < 10){ //마지막페이지가 10페이지 미만
				let leng = totalPage - nextPage + 1;
				$("#pageNum").append("<span class='prev'> << </span>");
				for(let i = 0; i < leng; i++){
					$("#pageNum").append("<span class='pageCnt'> " + (nextPage + i) + "</span>");
				}
				$(".pageCnt").filter(":first").css("color", "red");
			}else{ //페이지가 더남았다면..?
				$("#pageNum").append("<span class='prev'> << </span>");
				for(let j = 0; j < 10; j++){
					$("#pageNum").append("<span class='pageCnt'> " + (nextPage + j) + "</span>");
				}
				$("#pageNum").append("<span class='next'> >> </span>");
				$(".pageCnt").filter(":first").css("color", "red");
			}
		})
		//페이지네이션 페이지 이동
		
		function goPage(pNo){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText; 
				let obj = JSON.parse(result);
				$("#thead").empty();
				$("#tbody").empty();
				
				$("#thead").html("<tr>"+
						"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
						"<th>영화코드</th>"+
						"<th>포스터</th>"+
						"<th>제목</th>"+
						"<th>개봉일</th>"+
						"<th>상영시작일</th>"+
						"<th>상영마감일</th>"+
					"</tr>");
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append("<tr>"+
								"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
								"<td>"+obj[i].movieCode+"</td>"+
								"<td><img src='/resources/images/"+obj[i].postFileName+"' width='50px'></td>"+
								"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
								"<td>"+obj[i].releaseDate+"</td>"+
		             			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
		            			"<td style='color:red'>"+obj[i].end_date+"</td>"+
							"</tr>");
				}
			
			}
					
			xhttp.open("GET", "goMPage?pageNum=" + pNo, true); 
				
			xhttp.send();
		}
	</script>
	<script>
		//조회 전체 선택
		 $("#thead").on('click', $('#js_allChk'), function(){
			if($('input:checkbox[name="js_allChk"]').prop("checked") == true){
				 $('input:checkbox[name="js_chk"]').each(function() {
				     	this.checked = true;
				     	
				 });
			}else if($('input:checkbox[name="js_allChk"]').prop("checked") == false){
				 $('input:checkbox[name="js_chk"]').each(function() {
				     	this.checked = false;
				 });
			}
		});
		
		//조회 선택 삭제
		
		$("#tfoot1").on("click", "#js_del", serchDelete);
		function serchDelete(e){
			if(e.target.id == "js_del"){
		        if (!confirm("선택된 영화 정보를 삭제하시겠습니까?")) {
		            
		        } else {
		            
					let checked_val = new Array();
					
					$('input:checkbox[name="js_chk"]').each(function() {
				     	if(this.checked){ //체크박스 체크되면
				     		checked_val.push(this.value); //체크박스 value를 배열에 담음
				     	};
					 });
					
					if(e.target.id == "js_del"){
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
						
						xhttp.open("GET", "delMoviesByCodes.do?movieCodes=" + checked_val, true); 
							
						xhttp.send();
					}
		        }
			}
		}
		//영화등록페이지로 이동
		function goMovieReg(){
			location.href="movieReg";
		}
	</script>
	<script>
		//검색 유효성 검사
		$("#btn_serchMovie").on("click", function(){
			if($("#serchType").val() == "-선택-"){
				alert("검색 할 카테고리를 먼저 선택해주세요.");
				$("#serchType").css("border", "1px solid red");
				
			}
			if($("#serchWord").val() == ""){
				alert("검색어를 입력해주세요.");
				$("#serchWord").css("border", "1px solid red");
				goPage(1);
			}
			
			if($("#start").val() > $("#end").val()){
				alert("검색 할 시작 날짜가 더 늦습니다. 다시 확인해주세요.");
				$("#start").css("border", "1px solid red");
				goPage(1);
			}
			
			if($("#start").val() == "" || $("#end").val() == ""){
				alert("검색 할 날짜를 선택해주세요.");
				$("#start").css("border", "1px solid red");
				$("#end").css("border", "1px solid red");
				goPage(1);
			}
			
		});
		
		//카테고리 선택완료시 테두리 red->lightgray
		$("#serchType").on("change", function(){
			$("#serchType").css("border", "1px solid lightgray");
		});
		
		//검색어 입력완료 시 테두리 red->lightgray
		$(document).on("change", "#serchWord", function(){
			$("#serchWord").css("border", "1px solid lightgray");
		});
		
		//개봉일 선택완료 시 테두리 red -> lightgray
		$(document).on("change", "#start", function(){
			$("#start").css("border", "1px solid lightgray");
		});
		$(document).on("change", "#end", function(){
			$("#end").css("border", "1px solid lightgray");
		});
	</script>
	

<c:if test="${param.insert_result == 1 }">
	<script>
		alert("등록완료!");
	</script>
</c:if>
<c:if test="${param.insert_result == 0 }">
	<script>
		alert("등록실패..");
	</script>
</c:if>
<c:if test="${param.del_result == 1 }">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0 }">
	<script>
		alert("삭제실패..");
	</script>
</c:if>
<c:if test="${param.update_result == 1 }">
	<script>
		alert("수정성공!");
	</script>
</c:if>
<c:if test="${param.update_result == 0 }">
	<script>
		alert("수정실패..");
	</script>
</c:if>
</body>
</html>