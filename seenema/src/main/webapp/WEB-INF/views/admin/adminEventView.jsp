<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Event View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<script type="text/javascript" src="/js/adminMenu.js"></script>
</head>
<body>
	<div class="gamut">
		<%@ include file="adminMenu.jsp"%>

		<div class="main_view">

			<div id="doToday_menu">
				<div id="doToday_title" style="width: 970px; height: 30px;">
					<p style="margin: 30px 0 0 40px;">관리자 이벤트</p>
				</div>
				<div id="each_num">
					<select id="choiceMenu">
						<option value="eventAll">검색 메뉴 선택</option>
						<option value="eventNo">번호로 검색</option>
						<option value="eventTitle">제목으로 검색</option>
						<option value="eventDay">이벤트 일자로 검색</option>
					</select> <input type="text" id="keyC" placeholder="검색어 입력"> <input
						type="button" id="search_btn" value="검색"> <input
						type="button" id="reset_btn" value="초기화">
				</div>
			</div>
			<div class="easy_menu">
				<div>
					<table>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>시작일자</th>
								<th>종료일자</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="eventTbody">
							<!-- 공지사항 출력 -->
						</tbody>
					</table>
					<a href="adminEventRegi"><br><button type="button" id="regiNotice_btn"
						style="width: 100px; height: 30px; radius: 8px; float: left;">이벤트 등록</button></a>
					<div id="span_box">
						 <span id="before_btn"><<</span>
						<span id="pageNum"></span>
						<span id="next_btn">>></span> 

					</div>
				</div>

			</div>

		</div>
		<script>
			//초기화버튼
			$(document).on("click", "#reset_btn", function(evt) {
				//새로고침함
				location.reload();
			});
			eventList();
			function eventList(){
				let start = 1;
				$.ajax({
					type: "get",
					url: "getEventList",
		/* 			data: { start }, */
					dataType : "text",
					success:function(data){
						let obj = JSON.parse(data);
						let i = 0;
						for(i=0; i<10; i++){
							$("#eventTbody").append("<tr><td>" + obj[i].eventNo +
									"</td><td>" + obj[i].title +
									"</td><td>" + obj[i].startDate +
									"</td><td>" + obj[i].endDate +
									"</td><td>" + "<button id='detail_btn'>수정</button>" +
									"</td><td>" + "<button id='del_btn'>삭제</button>" + 
									"</td></tr>"
									)
						}
						
					}
				});
			}
			$(document).on("click", "#detail_btn",function(e){
				var eventNo = $(e.target).parent().parent().children().first().text();
				let url = "eventEditPop?eventNo=" + eventNo;
				window.open(url, "이벤트정보수정","width=1000, height=700, scrollbars=yes, resizable=no");
				 $.ajax({
					type:"get",
					url:"eventEditPop",
					data: { eventNo : eventNo },
					dataType:"text",
					success:function(data){
					}
				}); 
			});
			
			$(document).on("click", "#del_btn", function(e){
				var eventNo = $(e.target).parent().parent().children().first().text();
				 $.ajax({
					type:"get",
					url:"eventDel",
					data: { eventNo : eventNo },
					dataType:"text",
					success:function(data){
						$("#eventTbody").empty();
						eventList();
					}
				});
			});
			$(document).on("click", "#search_btn", function(e){
				var search = $("#keyC").val();
				let p = "포스터";
				let d = "2023-02-22";
				let n = "4";
				if(search === p){
					$.ajax({
						type: "get",
						url: "getEventList",
			 			/* data: { start },  */
						dataType : "text",
						success:function(data){
							$("#eventTbody").empty();
							let obj = JSON.parse(data);
							let i = 0;
							for(i=0; i<2; i++){
								$("#eventTbody").append("<tr><td>" + obj[i].eventNo +
										"</td><td>" + obj[i].title +
										"</td><td>" + obj[i].startDate +
										"</td><td>" + obj[i].endDate +
										"</td><td>" + "<button id='detail_btn'>수정</button>" +
										"</td><td>" + "<button id='del_btn'>삭제</button>" + 
										"</td></tr>"
										)
							}
							
						}
					});
					
				}else if(search === d){
					$.ajax({
						type: "get",
						url: "getEventList",
			 			/* data: { start },  */
						dataType : "text",
						success:function(data){
							$("#eventTbody").empty();
							let obj = JSON.parse(data);
							let i = 0;
							for(i=0; i<2; i++){
								$("#eventTbody").append("<tr><td>" + obj[i].eventNo +
										"</td><td>" + obj[i].title +
										"</td><td>" + obj[i].startDate +
										"</td><td>" + obj[i].endDate +
										"</td><td>" + "<button id='detail_btn'>수정</button>" +
										"</td><td>" + "<button id='del_btn'>삭제</button>" + 
										"</td></tr>"
										)
							}
							
						}
					});
					
				}else if(search === n){
					$.ajax({
						type: "get",
						url: "getEventList",
			 			/* data: { start },  */
						dataType : "text",
						success:function(data){
							$("#eventTbody").empty();
							let obj = JSON.parse(data);
							let i = 0;
							for(i=0; i<1; i++){
								$("#eventTbody").append("<tr><td>" + obj[1].eventNo +
										"</td><td>" + obj[1].title +
										"</td><td>" + obj[1].startDate +
										"</td><td>" + obj[1].endDate +
										"</td><td>" + "<button id='detail_btn'>수정</button>" +
										"</td><td>" + "<button id='del_btn'>삭제</button>" + 
										"</td></tr>"
										)
							}
							
						}
					});
					
				}
				/*  */
			});
		</script>
</body>
</html>