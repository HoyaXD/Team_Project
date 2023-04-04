<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Reservation View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<style>
#doToday_menu{
	font-size: 15px;
}

#each_num select{
   text-align: center;
   height: 25px;
   border-radius: 3px;
   border: none;
   border: 1px solid lightgray;
   outline: none;
   
   padding-left: 5px;
   transition: 0.4s;
}
#each_num input[type=text]{
   width: 200px;
   height: 25px;
   border-radius: 3px;
   border: none;
   border: 1px solid lightgray;
   outline: none;
   padding-left: 5px;
   transition: 0.4s;
}
#each_num input[type=text]{
   width: 130px;
   height: 25px;
   border-radius: 3px;
   border: none;
   border: 1px solid lightgray;
   outline: none;
   padding-left: 5px;
   transition: 0.4s;
}
#each_num button{
   width: 45px;
   height: 25px;
   border-radius: 3px;
   cursor: pointer;
   background-color: RGB(246, 246, 246);
   
   border: 1px solid black;
}
#each_num input[type=text]:hover, #each_num input[type=text]:active,
#each_num input[type=text]:focus, #each_num input[type=text]:hover,
#each_num input[type=text]:focus, #each_num input[type=text]:active{
   border: 1px solid black;
}
</style>
</head>
<body>
	<div class="gamut">

		<%@ include file="adminMenu.jsp"%>

		<!--상단바-->
		<!--  <div class="top_bar">
            상단바
        </div> -->
		<div class="main_view">

			<div id="doToday_menu">
				<div id="doToday_title" style="width: 970px; height: 30px;">
					<p style="margin: 30px 0 0 40px;">회원 예매 내역 관리</p>
				</div>
				<div id="each_num">
					<select id="choiceMenu">
						<option value="reservationyAll">검색 메뉴 선택</option>
						<option value="reservationId">아이디로 검색</option>
						<option value="reservationCode">예매코드으로 검색</option>
						<option value="reservationTitle">영화제목으로 검색</option>
						<option value="reservationDate">예매일자로 검색</option>
					</select> <input type="text" id="keyC" placeholder="검색어 입력"> <input
						type="button" id="search_btn" value="검색"> <input
						type="button" id="reset_btn" value="초기화">
				</div>
			</div>
			<div class="easy_menu">
				<div id="table_box">
					<table id="table">
						<thead>
							<tr>
								<th>예매코드</th>
								<!-- ticketCode  -->
								<th>영화제목</th>
								<!-- movieTitle  -->
								<th>지점</th>
								<!-- theater  -->
								<th>예매일자</th>
								<!-- reservationDate  -->
								<th>아이디</th>
								<!-- id  -->

							</tr>
						</thead>
						<tbody id="reservationTbody">

							<!-- tbody에서 출력 -->


						</tbody>
					</table>
					
					<div id="span_box">
					 <span id="prev_btn"><<</span> 
						<span id="pageNum"></span>
						 <span id="next_btn">>></span> 
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		//reservationAllView();
		//초기화 버튼 
		$(document).on("click", "#reset_btn", function(e) {
			location.reload();
		});
		
		$(document).ready(function(e){
			$("#search_btn").click();
		});
		let currentPage = 1;
		let totalPage = 0;
		let searchUrl = '';
		const pageSize = 10;
		
		$(document).on("click", "#search_btn", function(e){
		    const optionSelected = $("#choiceMenu option:selected").val();
		    const searchKeyword = $("#keyC").val().trim();
		    searchUrl = getSearchUrl(optionSelected);

		    // 전체 검색 결과 수 가져오기
		    $.ajax({
		        type: "GET",
		        url: getSearchCountUrl(optionSelected),
		        data: { searchKeyword: searchKeyword },
		        success: function(data) {
		            totalPage = Math.ceil(data / pageSize);
		            currentPage = 1;
		            search();
		            renderPageNumber();
		        },
		        error: function() {
		            alert("실패");
		        }
		    });
		});
		
		function search() {
		    const optionSelected = $("#choiceMenu option:selected").val();
		    const searchKeyword = $("#keyC").val().trim();
		    const start = (currentPage - 1) * pageSize;
		    
		    // 검색 결과 가져오기
		  
		    $.ajax({
		        type: "GET",
		        url: searchUrl,
		        data: { searchKeyword, start},
		        success: function(data) {
		            renderView(data);
		            renderPageNumber();

		        },
		        error: function() {
		            alert("실패");
		        }
		    });
		}
		
		function getSearchUrl(optionSelected){
		    switch(optionSelected){
		    
		    	 case "reservationyAll":
	           		return "reservationAllView";  
		        case "reservationId":
		            return "reservationId";
		        case "reservationCode":
		            return "reservationCode";
		        case "reservationTitle":
		            return "reservationTitle";
		        case "reservationDate":
		            return "reservationDate";
		        default:
		            throw new Error("getSearchUrl 메서드 에러발생");
		    }
		}
		
		function getSearchCountUrl(optionSelected) {
		    switch(optionSelected){
			      case "reservationyAll":
	           		return "reservationAllCount";  
		        case "reservationId":
		            return "reservationIdCount";
		        case "reservationCode":
		            return "reservationCodeCount";
		        case "reservationTitle":
		            return "reservationTitleCount";
		        case "reservationDate":
		            return "reservationDateCount";
		        default:
		            throw new Error("getSearchCountUrl 메서드 에러발생");
		    }
		}
		
		function renderView(tbodyAmount){
		    const $tbody = $("#reservationTbody");
		    $tbody.empty();
		    tbodyAmount.forEach(memberReservation => {
		        const $tr = $("<tr>");
		        $tbody.append($tr);
		        $tr.append("<td>" + memberReservation.ticketCode + "</td>");
		        $tr.append("<td>" + memberReservation.movieTitle + "</td>");
		        $tr.append("<td>" + memberReservation.theater + "</td>");
		        $tr.append("<td>" + memberReservation.movieDate + "</td>");
		        $tr.append("<td>" + memberReservation.id + "</td>");
		        $tbody.append($tr);
		    });
		}
		
		$(document).on("click", "#pageNum span", function(e){
		    currentPage = parseInt($(this).text()); // 클릭한 페이지 번호를 현재 페이지로 설정
		    search();
		});
		

		
		function renderPageNumber() {
			  const $pageNum = $("#pageNum");
			  $pageNum.empty();

			  let startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
			  let endPage = startPage + 9;
			  if (endPage > totalPage) {
			    endPage = totalPage;
			  }

			  if (startPage > 1) {
			    const $prev = $("<span>");
			    $prev.attr("id", "prevPage");
			    $pageNum.append($prev);
			  }

			  for (let i = startPage; i <= endPage; i++) {
			    const $span = $("<span>");
			    $span.text(i);
			    if (i === currentPage) {
			        $span.css({"color": "red", "font-weight" : "bold"}); // 현재 페이지 번호의 색깔을 변경
			      }
			    $pageNum.append($span);
			  }

			  if (endPage < totalPage) {
			    const $next = $("<span>");
			    $next.attr("id", "nextPage");
			    $pageNum.append($next);
			  }

			  // 기존 이벤트 핸들러 삭제 후 재등록
			  $pageNum.off("click", "span");
			  $pageNum.on("click", "span", function(e) {
				
			    const clickedPageStr = $(this).text();
			    if (clickedPageStr === '') return;

			    const clickedPage = parseInt(clickedPageStr);
			    if (isNaN(clickedPage)) return;

			    if (clickedPage === currentPage) return;

			    currentPage = clickedPage;
			    search();
			  });
			}
		
		$(document).on("click", "#pageNum span", function(e){
		    
		    if (clickedPageStr === '') return;
		    
		    const clickedPage = parseInt(clickedPageStr);
		    if (isNaN(clickedPage)) return;
		    
		    if (clickedPage === currentPage) return;
		    currentPage = clickedPage;
		    search();
		});

		$(document).on("click", "#prev_btn", function(e) {
			  if (currentPage > 1) {
				currentPage = parseInt($("#pageNum").children().eq(1).text());
			    currentPage -= 10;
			    if (currentPage < 1) currentPage = 1;
			    search();
			    renderPageNumber();
			  }
			});

			$(document).on("click", "#next_btn", function(e) {
			  if (currentPage < totalPage) {
				currentPage = parseInt($("#pageNum").children().first().text());
			    currentPage += 10;
			    if (currentPage > totalPage) currentPage = totalPage;
			    search();
			    renderPageNumber();
			  }
			});

	</script>
</body>
</html>