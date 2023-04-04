<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/theaterList.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- <link rel="stylesheet" href="/css/adminMenu.css"> -->
</head>
<body>
   <div class="gamut1">
 	<!-- 좌측메뉴 jsp -->
	<%@ include file="adminMenu.jsp"%>
      <div class="main_view1">

         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">영화관 조회</div>
               <table id="serch_tbl">
                  <tr>
                     <th>
                        <select name="serchType" id="serchType" size="1">
                           <option>-선택-</option>
                           <option value="theaterName">이름으로 검색</option>
                           <option value="theaterPlace">지역으로 검색</option>
                           <option value="theaterTel">연락처로 검색</option>
                        </select>
                        <span id="serchBox">
                           <input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
                        </span>
                        <button id="btn_serch" onclick="serchTheater();">검색</button>
                        <button onclick="location.href='theaterList'">초기화</button>
                     </th>	
                     
                  </tr>
               </table>
            </div>
         </div>

         <div class="easy_menu1">
            <div id="listBox">
               <table id="list_tbl" >
                  <thead id="thead">
                     <tr>
                        <!-- <th><input type="checkbox" id="allChk"></th> -->
                        <th id="tbl_code">영화관 코드</th>
                        <th id="tbl_place">지역</th>
                        <th id="tbl_name">상영관 이름</th>
                        <th id="tbl_tel">연락처</th>
                     </tr>
                  </thead>
                  <tbody id="tbody">
                     <c:forEach var="t" items="${tList }">
                        <tr>
                           <!-- <td><input type="checkbox" class="chk" value="${movie.movieCode }"></td> -->
                           <td>${t.theaterCode }</td>
                           <td>${t.theaterPlace }</td>
                           <td><a href="theaterUpdate?theaterCode=${t.theaterCode }">${t.theaterName }</a></td>
                           <td>${t.theaterTel }</td>
                        </tr>
                     </c:forEach>
					<tfoot id="tfoot1">
	                      <tr>
	                      	<th>
	                      	</th>
	                      	<th></th>
	                      	<th id="pageNum"></th>
	                      	
                           	<th><button onclick="theaterReg()">영화관 등록</button></th>
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
		
		function theaterReg(){
			location.href="theaterReg";
		}
	</script>
	<script>
		let totalPage = 0;
		let pNo = 1;
		$(document).ready(goPage(pNo), cntTheater());
		
		//영화관cnt
		function cntTheater(){
			
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
					//$("#pageNum").append("<span class='prev'> << </span>");
					for(let i = 0; i < 10; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " </span>");
					}
					$("#pageNum").append("<span class='next'> >> </span>");
				}
				$(".pageCnt").filter(":first").css("color", "red"); //첫페이지색깔
			}
			
			xhttp.open("GET", "theaterCnt", true); 
				
			xhttp.send();
			
		}
		//페이지 넘버를 클릭
		$(document).on("click", ".pageCnt", function(){
			/* alert("hi"); */
			$(this).css("color", "red"); //클릭된 번호 색깔
			$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
			let pageNum = $(this).text();
			goPage(pageNum);
		});
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
		function goPage(pNo){
			const xhttp = new XMLHttpRequest();
			$("#tbody").empty();
			$("#tfoot").empty();
			xhttp.onload = function() {
			let result = this.responseText; 
			let obj = JSON.parse(result);
			
		
			for(let i = 0; i < obj.length; i++){
				$("#tbody").append(
						"<tr>"+
							"<td>" + obj[i].theaterCode + "</td>"+
							"<td>" + obj[i].theaterPlace + "</td>"+
							"<td>" +
								"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
									obj[i].theaterName +
								"</a>" +
							"</td>" +
							"<td>" + obj[i].theaterTel + "</td>"+
						"</tr>");
			}	
			$("#tfoot").html("<tr>"+
						"<th></th>"+
						"<th></th>"+
						"<th></th>"+
						
						"<th>"+
							"<button id=theaterReg onclick='theaterReg()'>영화관등록</button>"+
						"</th>"+
					"</tr>");	
			}
					
			xhttp.open("GET", "goTPage?pageNum=" + pNo, true); 
				
			xhttp.send();
		}
		
	</script>
	<script>
	   let serchWord = $("#serchWord").val();
		//serchType에 따른 검색창 변화
		 $("#serchType").change(function(e){
			if($("#serchType option:selected").val() == "theaterName"){
	         $("#serchBox").html("<input type='text' id='serchWord' placeholder='영화관 이름을 입력해주세요.'>");
	      }else if($("#serchType option:selected").val() == "theaterPlace"){
	         $("#serchBox").html("<input type='text' id='serchWord' placeholder='지역명을 입력해주세요.'>");
	      }else if($("#serchType option:selected").val() == "theaterTel"){
	         $("#serchBox").html("<input type='text' id='serchWord' maxlength='13' placeholder='연락처를 입력해주세요.'>");
	      }
		});
	
	   function serchTheater(pNo=1){
		   
	      let serchWord = $("#serchWord").val();
	      
	      if($("#serchType option:selected").val() == "theaterName"){
	        //영화관 이름 조회
	         const xhttp = new XMLHttpRequest();
	         xhttp.onload = function() {
	        	 
	        	$("#tbody").empty();
	        	
	         	let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append(
								"<tr>"+
									"<td>" + obj[i].theaterCode + "</td>"+
									"<td>" + obj[i].theaterPlace + "</td>"+
									"<td>" +
										"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
											obj[i].theaterName +
										"</a>" +
									"</td>" +
									"<td>" + obj[i].theaterTel + "</td>"+
								"</tr>");
					}	
				}else{
					$("#tbody").html(
							"<tr>"+
								"<th colspan='4' style='height:300px;'> 해당 영화관은 존재 하지 않습니다. </th>"+
							"</tr>");
				}
	         }
	         
	         xhttp.open("GET", "theaterShcByName.do?name=" + serchWord + "&pageNum=" + pNo, true); 
	            
	         xhttp.send();
	         
	      }else if($("#serchType option:selected").val() == "theaterPlace"){
	    	  //영화관 지역 조회
	    	  //alert(pNo);
	    	  const xhttp = new XMLHttpRequest();
	          xhttp.onload = function() {
	        	  
	        	  $("#tbody").empty();
	        	  
		          let result = this.responseText; 
		          let obj = JSON.parse(result);
		          
					if(obj.length != 0){
						for(let i = 0; i < obj.length; i++){
							$("#tbody").append(
									"<tr>"+
										"<td>" + obj[i].theaterCode + "</td>"+
										"<td>" + obj[i].theaterPlace + "</td>"+
										"<td>" +
											"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
												obj[i].theaterName +
											"</a>" +
										"</td>" +
										"<td>" + obj[i].theaterTel + "</td>"+
									"</tr>");
						}	
					}else{
						$("#tbody").html(
								"<tr>"+
									"<th colspan='4' style='height:300px;'> 해당 영화관은 존재 하지 않습니다. </th>"+
								"</tr>");
					}
	          }
	                
	          xhttp.open("GET", "theaterShcByPlace.do?place=" + serchWord + "&pageNum=" + pNo, true); 
	             
	          xhttp.send();
	          
	      }else if($("#serchType option:selected").val() == "theaterTel"){
	    	  //영화관 연락처 조회
	    	  //alert(pNo)
	    	  const xhttp = new XMLHttpRequest();
	          xhttp.onload = function() {
	        	  
	        	  $("#tbody").empty();
	        	  
		          let result = this.responseText; 
		          let obj = JSON.parse(result);
		         
					if(obj.length != 0){
						for(let i = 0; i < obj.length; i++){
							$("#tbody").append(
									"<tr>"+
										"<td>" + obj[i].theaterCode + "</td>"+
										"<td>" + obj[i].theaterPlace + "</td>"+
										"<td>" +
											"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
												obj[i].theaterName +
											"</a>" +
										"</td>" +
										"<td>" + obj[i].theaterTel + "</td>"+
									"</tr>");
						}	
					}else{
						$("#tbody").html(
								"<tr>"+
									"<th colspan='4' style='height:300px;'> 해당 영화관은 존재 하지 않습니다. </th>"+
								"</tr>");
					}
	        	  }
	                
	          xhttp.open("GET", "theaterShcByTel.do?tel=" + serchWord + "&pageNum=" + pNo, true); 
	             
	          xhttp.send();
	      }
	   }
	</script>
	<script>
	//검색페이지네이션
	$("#btn_serch").on("click", getSrcCnt);
	function getSrcCnt(){
		
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
		if($("#serchType").val() == "theaterName"){
			
			xhttp.open("GET", "teaterNameCnt?name=" + $("#serchWord").val(), true); 
				
			xhttp.send();
			
			$(document).on("click", ".pageCnt", function(){
				/* alert("hi"); */
				$(this).css("color", "red"); //클릭된 번호 색깔
				$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
				let pageNum = $(this).text();
				serchTheater(pageNum);
			})
		}else if($("#serchType").val() == "theaterPlace"){
			xhttp.open("GET", "theaterPlaceCnt?place=" + $("#serchWord").val(), true); 
			
			xhttp.send();
			
			$(document).on("click", ".pageCnt", function(){
				$(this).css("color", "red"); //클릭된 번호 색깔
				$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
				let pageNum = $(this).text();
				serchTheater(pageNum);
			})
		}else if($("#serchType").val() == "theaterTel"){
			xhttp.open("GET", "theaterTelCnt?tel=" + $("#serchWord").val(), true); 
			
			xhttp.send();
			
			$(document).on("click", ".pageCnt", function(){
				$(this).css("color", "red"); //클릭된 번호 색깔
				$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
				let pageNum = $(this).text();
				serchTheater(pageNum);
			})
		}
	}
	</script>
	<script>
		//검색 유효성검사
		$("#btn_serch").on("click", function(){
			if($("#serchType").val() == "-선택-"){
				alert("검색 할 카테고리를 먼저 선택해주세요.");
				$("#serchType").css("border", "1px solid red");
			}
			if($("#serchWord").val() == ""){
				alert("검색어를 입력해주세요.");
				$("#serchWord").css("border", "1px solid red");
			}
		});
		
		//카테고리 선택 완료 시 테두리 red->lightgray
		$("#serchType").on("change", function(){
			$("#serchType").css("border", "1px solid lightgray");
		})
		//검색어 입력완료 시 테두리 red->lightgray
		$(document).on("change", "#serchWord", function(){
			$("#serchWord").css("border", "1px solid lightgray");
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
  		
		//연락처 숫자만 입력되도록
		$("#serchType").on("change", function(){
			if($("#serchType option:selected").val() == "theaterTel"){
				$("#serchWord").on("keyup", function(e){
					if(e.keyCode > 47 && e.keyCode < 58 ||
						e.keyCode === 8 || //backspace
						e.keyCode === 37 || //방향키
						e.keyCode === 39 || //방향키
						e.keyCode === 46 ||//delete키
						e.keyCode === 9 ||//tab키
						e.keyCode === 13){ //enter키 
							$("#price").css("border", "1px solid lightgray");
							this.value = autoHypenTel(this.value) ;  
					}else{
						/* alert($("#serchWord").val()); */
						$("#serchWord").val("");
						alert("숫자만 입력가능합니다.");
					}
				});
			}
		})
	</script>
	<c:if test="${param.insert_result == 1}">
		<script>
			alert("등록완료!");
		</script>
	</c:if>
	<c:if test="${param.insert_result == 0}">
		<script>
			alert("등록실패....");
		</script>
	</c:if>
	
	<c:if test="${param.update_result == 1}">
		<script>
			alert("수정완료!");
		</script>
	</c:if>
	<c:if test="${param.update_result == 0}">
		<script>
			alert("수정실패....");
		</script>
	</c:if>
	
	<c:if test="${param.del_result == 1}">
		<script>
			alert("삭제완료!");
		</script>
	</c:if>
	<c:if test="${param.del_result == 0}">
		<script>
			alert("삭제실패....");
		</script>
	</c:if>

</body>
</html>