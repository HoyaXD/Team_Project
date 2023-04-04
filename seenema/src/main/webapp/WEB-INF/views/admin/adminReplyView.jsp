<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Reply View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
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
					<p style="margin: 30px 0 0 40px;">한줄평 페이지</p>
				</div>
				<div id="each_num">
					<select id="choiceMenu">
						<option value="replyAll">검색 메뉴 선택</option>
						<option value="replyId">아이디로 검색</option>
						<option value="replyMovieCode">영화코드으로 검색</option>
						<option value="replyRate">별점으로 검색</option>
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
								<th>영화코드</th>
								<th>영화제목</th>
								<th>한줄평</th>
								<th>아이디</th>
								<th>별점</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="replyTbody">

							<!-- tbody에서 출력 -->


						</tbody>
					</table>
					 <div id="span_box">
						<span id="before_btn"><<</span>
						<div id="pageNum"></div>
						<span id="next_btn">>></span>
					</div> 
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).on("click", "#reset_btn", function(e) {
			location.reload() ;
		});
		replyListView();
		function replyListView() {
			$(document)
					.ready(
							function() {
								$
										.ajax({
											url : "replyListView",
											type : "get",
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#before_btn").hide();
												
												for (i; i < 10; i++) {

													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td>'
																			+ obj[i].movieCode
																			+ '</td><td>'
																			
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:200px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}
												//페이지 번호나옴
												$("#pageNum").empty();

												if (obj.length > 100) {
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
												}else if(obj.length < 100){
													for (let j = 1; j < obj.length / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#next_btn").hide();
													$("#before_btn").hide();
												}
												$("#pageNum").children()
												.first().click();
												//페이지 번호 끝
											},
											error : function() {
												alert("Q&A 목록 출력 실패!");
											}

										});
							});
		}

		//검색창
		$(document)
				.on(
						"click",
						"#search_btn",
						function(e) {
							var replyAll = "replyAll";
							var replyId = "replyId";
							var replyMovieCode = "replyMovieCode";
							var replyRate = "replyRate";

							if ($("#choiceMenu option:selected").val() == replyId) {
								var id = $("#keyC").val();

								$
										.ajax({
											type : "GET",
											url : "replyIdListView",
											data : {
												id : id
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);

												let obj = JSON.parse(str);
												let i = 0;
												$("#replyTbody").empty();
												for (i; i < 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}
												//페이지 번호나옴
												$("#pageNum").empty();

												if (obj.length > 100) {
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
												}else if(obj.length < 100){
													for (let j = 1; j < obj.length / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#next_btn").hide();
													$("#before_btn").hide();
												}
												$("#pageNum").children()
												.first().click();
												//페이지 번호 끝
											},

											error : function() {
												alert("리플 목록 출력 실패!");
											}
										});
								//영화코드
							} else if ($("#choiceMenu option:selected").val() == replyMovieCode) {
								var movieCode = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "replyMovieCodeListView",
											data : {
												movieCode : movieCode
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#replyTbody").empty();
												for (i; i < 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}
												//페이지 번호나옴
												$("#pageNum").empty();

												if (obj.length > 100) {
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
												}else if(obj.length < 100){
													for (let j = 1; j < obj.length / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#next_btn").hide();
													$("#before_btn").hide();
												}
												$("#pageNum").children()
												.first().click();
												//페이지 번호 끝
											},

											error : function() {
												alert("리플 목록 출력 실패!");
											}
										});
								//내용검색
							} else if ($("#choiceMenu option:selected").val() == replyRate) {
								var rate = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "replyRateListView",
											data : {
												rate : rate
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#replyTbody").empty();
												for (i; i < 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}
												//페이지 번호나옴
												$("#pageNum").empty();

												if (obj.length > 100) {
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
												}else if(obj.length < 100){
													for (let j = 1; j < obj.length / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#next_btn").hide();
													$("#before_btn").hide();
												}
												$("#pageNum").children()
												.first().click();
												//페이지 번호 끝
											},

											error : function() {
												alert("리플 목록 출력 실패!");
											}
										});
							}
						});

		//페이지네이션
		$(document)
				.on(
						"click",
						"span",
						function(e) {
							var replyAll = "replyAll";
							var replyId = "replyId";
							var replyMovieCode = "replyMovieCode";
							var replyRate = "replyRate";
							var pagenum = $(e.target);
							$("span").css({
								"color" : "black",
								"font-weight" : "normal"
							});
							pagenum.css({
								"color" : "red",
								"font-weight" : "bolder"
							});
							//선택 하지않고 페이지 번호를 눌렀을 시 
							if ($("#choiceMenu option:selected").val() == replyAll) {
								$("#replyTbody").empty();
								$
										.ajax({

											url : "replyListView",
											type : "get",
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}

											},
											error : function() {
												alert("Q&A 목록 출력 실패!");
											}
										});
								//id로 검색
							} else if ($("#choiceMenu option:selected").val() == replyId) {
								var id = $("#keyC").val();

								$("#replyTbody").empty();
								$
										.ajax({

											url : "replyIdListView",
											type : "get",
											data : {
												id : id
											},
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}

											},
											error : function() {
												alert("Q&A 목록 출력 실패!");
											}
										});
								//영화코드로 검색
							} else if ($("#choiceMenu option:selected").val() == replyMovieCode) {
								var movieCode = $("#keyC").val();

								$("#replyTbody").empty();
								$
										.ajax({

											url : "replyMovieCodeListView",
											type : "get",
											data : {
												movieCode : movieCode
											},
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}

											},
											error : function() {
												alert("Q&A 목록 출력 실패!");
											}
										});
								//별점으로 검색
							} else if ($("#choiceMenu option:selected").val() == replyRate) {
								var rate = $("#keyC").val();

								$("#replyTbody").empty();
								$
										.ajax({

											url : "replyRateListView",
											type : "get",
											data : {
												rate : rate
											},
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													$("#replyTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].replyCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieCode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].movieTitle
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].comment
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].rate
																			+ '</td><td>'
																			+ '<button id="rdel_btn" style="width:70px;">삭제</button>'
																			+ '</td></tr>')//포문 끝

												}

											},
											error : function() {
												alert("Q&A 목록 출력 실패!");
											}
										});

							}

						});
		//이전버튼 누를 시
		$(document)
				.on(
						"click",
						"#before_btn",
						function(e) {
							var replyAll = "replyAll";
							var replyId = "replyId";
							var replyMovieCode = "replyMovieCode";
							var replyRate = "replyRate";
							if ($("#choiceMenu option:selected").val() == replyAll) {

								$
										.ajax({
											url : "replyCount",
											type : "get",
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum")
														.children().first()
														.text());
												$("#pageNum").empty();
												if (firstNum - 10 == 1) {
													//첫페이지니깐 이전버튼 숨김
													$("#before_btn").hide();
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
												}

												//아니라면
												else {
													$("#next_btn").show();
													for (let j = firstNum - 10; j < firstNum; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}

													$("#pageNum")
															.children()
															.first()
															.click();
												}

											},
											error : function() {
												alert("실패");
											}

										});
								//이전 눌렀을 시 아이디 
							} else if ($("#choiceMenu option:selected")
									.val() == replyId) {
								var replyId = $("#keyC").val();

								$
										.ajax({
											url : "replyIdCount",
											type : "get",
											data : {
												id : replyId
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum")
														.children().first()
														.text());
												$("#pageNum").empty();
												if (firstNum - 10 == 1) {
													//첫페이지니깐 이전버튼 숨김
													$("#before_btn").hide();
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
													$("#next_btn").show();
												}
												//아니라면
												else {
													$("#next_btn").show();
													for (let j = firstNum - 10; j < firstNum; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							} else if ($("#choiceMenu option:selected")
									.val() == replyMovieCode) {
								var movieCode = $("#keyC").val();

								$
										.ajax({
											url : "noticeContentsCount",
											type : "get",
											data : {
												movieCode : movieCode
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum")
														.children().first()
														.text());
												$("#pageNum").empty();
												if (firstNum - 10 == 1) {
													//첫페이지니깐 이전버튼 숨김
													$("#before_btn").hide();
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
													$("#next_btn").show();
												}
												//아니라면
												else {
													$("#next_btn").show();
													for (let j = firstNum - 10; j < firstNum; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							}else if ($("#choiceMenu option:selected")
									.val() == replyRate) {
								var rate = $("#keyC").val();

								$
										.ajax({
											url : "replyRateCount",
											type : "get",
											data : {
												rate : rate
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum")
														.children().first()
														.text());
												$("#pageNum").empty();
												if (firstNum - 10 == 1) {
													//첫페이지니깐 이전버튼 숨김
													$("#before_btn").hide();
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
													$("#next_btn").show();
												}
												//아니라면
												else {
													$("#next_btn").show();
													for (let j = firstNum - 10; j < firstNum; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum")
															.children()
															.first()
															.click();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							}

						});
		//다음버튼 누를 시 
		$(document)
				.on(
						"click",
						"#next_btn",
						function(e) {
							var replyAll = "replyAll";
							var replyId = "replyId";
							var replyMovieCode = "replyMovieCode";
							var replyRate = "replyRate";
							
							if ($("#choiceMenu option:selected").val() == replyAll) {
								$
										.ajax({
											url : "replyCount",
											type : "get",
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($("#pageNum").children().last().text());
												$("#pageNum").empty();
												$("#before_btn").show();
												
												if (lastNum + 11 < obj / 10 + 1) {
												
													for (let j = lastNum + 1; j < lastNum + 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.click();
													
												} else if (lastNum + 11 > obj / 10 + 1) {
													
													for (let j = lastNum + 1; j < obj / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});
							} else if ($("#choiceMenu option:selected")
									.val() == replyId) {
								var replyId = $("#keyC").val();

								$
										.ajax({
											url : "replyIdCount",
											type : "get",
											data : {
												id : replyId
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum")
														.children().last()
														.text());
												$("#pageNum").empty();
												$("#before_btn").show();
												if (lastNum + 11 < obj / 10 + 1) {
													for (let j = lastNum + 1; j < lastNum + 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.click();
												} else if (lastNum + 11 > obj / 10 + 1) {
													for (let j = lastNum + 1; j < obj / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							} else if ($("#choiceMenu option:selected")
									.val() == noticeContents) {
								var movieCode = $("#keyC").val();

								$
										.ajax({
											url : "replymovieCodeCount",
											type : "get",
											data : {
												movieCode : movieCode
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum")
														.children().last()
														.text());
												$("#pageNum").empty();
												$("#before_btn").show();
												if (lastNum + 11 < obj / 10 + 1) {
													for (let j = lastNum + 1; j < lastNum + 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.click();
												} else if (lastNum + 11 > obj / 10 + 1) {
													for (let j = lastNum + 1; j < obj / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});
							}
							else if ($("#choiceMenu option:selected")
									.val() == replyRateCount) {
								var rate = $("#keyC").val();

								$
										.ajax({
											url : "replyRateCount",
											type : "get",
											data : {
												rate : rate
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum")
														.children().last()
														.text());
												$("#pageNum").empty();
												$("#before_btn").show();
												if (lastNum + 11 < obj / 10 + 1) {
													for (let j = lastNum + 1; j < lastNum + 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.click();
												} else if (lastNum + 11 > obj / 8 + 1) {
													for (let j = lastNum + 1; j < obj / 8 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum")
															.children()
															.first()
															.trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});
							}
						});
		
		
		
		
		
		//삭제
		$(document).on(
				"click",
				"#rdel_btn",
				function(e) {
					var replyCode = $(e.target).parent().parent().children()
							.first().text();
					$.ajax({
						url : "replyDel",
						type : "get",
						data : {
							replyCode : replyCode
						},
						success : function() {

						},
						error : function() {
							alert(replyCode + "의 한줄평이 삭제되었습니다.");
							$("#replyTbody").empty();
							replyListView();

						}
					});
				});
	</script>
</body>
</html>