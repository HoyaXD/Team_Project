<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Notice View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<script type="text/javascript" src="/js/adminMenu.js"></script>
<style>
.notice_modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}
#text_box{
	text-align: left;
}
#text_box text{
	padding-top: 5px;
}
textarea{
	border-top: 1px black solid;

}
#notice_box input{
	border-top: 1px black solid;
	width: 564px;
	height: 25px;
	margin-top:5px;
}

#notice_box {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 600px;
	height: 500px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}

.reginotice_modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

#reginotice_box {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 550px;
	height: 530px;
	padding: 40px;
	text-align: left;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}

#regi_btn {
	width: 80px;
	height: 30px;
	text-align: center;
}

textarea {
	font-size: 15px;
}

#close_modal {
	float: right;
	font-size: 20px;
	font-weight: 20;
	border-radius: 100px;
	"
}
#noEdit_btn{
	width: 50px;
	border-radius: 3px;
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
		<div class="reginotice_modal">
			<div id="reginotice_box" style="margin-left: 40px;">
				공지사항 등록
				<button id="close_modal">❌</button>
				<div id="regitext_box" style="margin-top: 30px;">
					<form id="regi_frm" method="post">
				<div id="radio_box">
					<p><label>중요도</label>
					<input type="radio" name="importance" value="0">낮음
					<input type="radio" name="importance" value="1">높음</p>
				</div>
				<br>
					<!-- 인풋박스 -->
						<label>제목</label><br> <input type="text" name="title"
							id="regiTitle"
							style="width: 550px; height: 30px; font-size: 20px;"> <br>
						<br> <label>내용</label><br>
						<textarea name="contents" id="regiContents"
							style="width: 550px; height: 300px; resize: none;"></textarea>
						<br> <br> <input type="button" id="regi_btn"
							value="등록하기">
					</form>
				</div>
			</div>
		</div>

		<div class="notice_modal">
		
			<div id="notice_box">
				공지사항 수정
				<button id="close_modal">❌</button>
				<div id="text_box"></div>
			</div>
		</div>

		<div class="main_view">

			<div id="doToday_menu">
				<div id="doToday_title" style="width: 970px; height: 30px;">
					<p style="margin: 30px 0 0 40px;">
						관리자 공지사항
						
					</p>
				</div>
				<div id="each_num">
					<select id="choiceMenu">
						<option value="noticeAll">검색 메뉴 선택</option>
						<option value="noticeCode">번호로 검색</option>
						<option value="noticeTitle">제목으로 검색</option>
						<option value="noticeContents">내용으로 검색</option>
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
								<th>내용</th>
								<th>등록일자</th>
								<th>조회수</th>
								<th>수정</th>
								<th>삭제
								<th>
							</tr>
						</thead>
						<tbody id="noTbody">
							<!-- 공지사항 출력 -->
						</tbody>
					</table>
					<br>
					<button type="button" id="regiNotice_btn"
							style="width: 100px; height: 30px; radius: 8px; float:left;">공지사항 등록</button>
					<div id="span_box">
 						<span id="before_btn"><<</span>
 						<div id="pageNum"></div>
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
			//시작시 이전버튼 숨김
			$("#before_btn").hide();

			noticeListView();

			//이전버튼 누를 시
			$(document)
					.on(
							"click",
							"#before_btn",
							function(e) {
								var noticeAll = "noticeAll";
								var noticeTitle = "noticeTitle";
								var noticeContents = "noticeContents";
								if ($("#choiceMenu option:selected").val() == noticeAll) {

									$
											.ajax({
												url : "noticeCount",
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
										.val() == noticeTitle) {
									var noticeTitle = $("#keyC").val();

									$
											.ajax({
												url : "noticeTitleCount",
												type : "get",
												data : {
													title : noticeTitle
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
										.val() == noticeContents) {
									var noticeContents = $("#keyC").val();

									$
											.ajax({
												url : "noticeContentsCount",
												type : "get",
												data : {
													contents : noticeContents
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
								var noticeAll = "noticeAll";
								var noticeTitle = "noticeTitle";
								var noticeContents = "noticeContents";
								
								if ($("#choiceMenu option:selected").val() == noticeAll) {
									$
											.ajax({
												url : "noticeCount",
												type : "get",
												dataType : "text",
												success : function(data) {
													let obj = JSON.parse(data);
													var lastNum = parseInt($("#pageNum").children().last().text());
													$("#pageNum").empty();
													$("#before_btn").show();
													
													if (lastNum + 11 < obj / 8 + 1) {
													
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
								} else if ($("#choiceMenu option:selected")
										.val() == noticeTitle) {
									var noticeTitle = $("#keyC").val();

									$
											.ajax({
												url : "noticeTitleCount",
												type : "get",
												data : {
													title : noticeTitle
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
													if (lastNum + 11 < obj / 8 + 1) {
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

								} else if ($("#choiceMenu option:selected")
										.val() == noticeContents) {
									var noticeContents = $("#keyC").val();

									$
											.ajax({
												url : "noticeContentsCount",
												type : "get",
												data : {
													contents : noticeContents
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
													if (lastNum + 11 < obj / 8 + 1) {
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

			//공지사항 목록 출력
			function noticeListView() {
				$(document)
						.ready(
								function() {
									$
											.ajax({
												url : "adNoticeList",
												type : "get",
												dataType : "text",

												success : function(data) {
													let str = JSON
															.stringify(data);
													let obj = JSON.parse(data);
													let i = 0;

													for (i; i < 10; i++) {
														$("#noTbody")
																.append(
																		'<tr><td style="height:50px;">'
																				+ obj[i].noticeCode
																				+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].title
																				+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].contents
																				+ '</td><td style="height:50px;">'
																				+ obj[i].regiDate
																				+ '</td><td style="height:50px;">'
																				+ obj[i].hit
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noEditModal_btn">수정</button>'
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noDel_btn">삭제</button>'
																				+ '</td></tr>'

																)
													}
													//페이지 번호나옴
													$("#pageNum").empty();
													//데이터가 80개보다 크다면 10개 출력
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
														
													}
													$("#pageNum").children()
															.first().click();
													//페이지 번호 끝
												},
												error : function() {
													alert("공지사항 출력 실패!");
												}
											});
								});
			}

			//수정
			$(document)
					.on(
							"click",
							"#noEditModal_btn",
							function(e) {
								var targetNum = $(e.target).parent().parent()
										.children().first().text();
								$(".notice_modal").css('display', 'block');

								//모달창에 출력
								$
										.ajax({
											url : "selectNotice",
											type : "get",
											data : {
												noticeCode : targetNum
											},
											dataType : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(data);
												$("#text_box").empty();
												$("#text_box")
														.append(
																'<form id="edit_frm" method="post">' + '<br>'
																		+ '공지글 번호'
																	    + "&nbsp;&nbsp;&nbsp;" + obj[0].noticeCode 
																		+ "&nbsp;&nbsp;&nbsp;" + '등록일자'
																		+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + '' + obj[0].regiDate + '<br>'										
																		+ '제목' 
																		+ '<input type="text" name="title" id="title" value="' + obj[0].title + '"><br>'
																		+ '내용' + '<br>'
																		+ '<textarea name="contents" id="contents" value="' + '" style="width:600px; height:350px; resize: none;">'
																		+ obj[0].contents
																		+ '</textarea><br>'
																		+ '<input type="button" value="수정" id="noEdit_btn" style="margin-left:260px; width:50px;">'
																		+ '</form>')

											},
											error : function() {
												alert("공지사항 출력 실패!");
											}
										});
							});
			//페이지네이션
			$(document)
					.on(
							"click",
							"span",
							function(e) {
								var noticeAll = "noticeAll";
								var noticeCode = "noticeCode";
								var noticeTitle = "noticeTitle";
								var noticeContents = "noticeContents";
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
								if ($("#choiceMenu option:selected").val() == noticeAll) {
									$("#noTbody").empty();
									$
											.ajax({

												url : "adNoticeList",
												type : "get",
												datatype : "text",

												success : function(data) {
													let str = JSON
															.stringify(data);
													let obj = JSON.parse(str);
													let i = (e.target.innerText) * 10 - 10;

													for (i; i < e.target.textContent * 10; i++) {
														$("#noTbody")
																.append(
																		'<tr><td style="height:50px;">'
																				+ obj[i].noticeCode
																				+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].title
																				+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].contents
																				+ '</td><td style="height:50px;">'
																				+ obj[i].regiDate
																				+ '</td><td style="height:50px;">'
																				+ obj[i].hit
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noEditModal_btn">수정</button>'
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noDel_btn">삭제</button>'
																				+ '</td></tr>'

																)//포문 끝

													}

												},
												error : function() {
													alert("Q&A 목록 출력 실패!");
												}
											});

									//제목 페이지네이션
								} else if ($("#choiceMenu option:selected")
										.val() == noticeTitle) {
									var noticeTitle = $("#keyC").val();
									$("#noTbody").empty();
									$
											.ajax({

												url : "noticeTitleSearch",
												type : "get",
												data : {
													title : noticeTitle
												},
												datatype : "text",

												success : function(data) {
													let str = JSON
															.stringify(data);
													let obj = JSON.parse(str);
													let i = (e.target.innerText) * 10 - 10;

													for (i; i < e.target.innerText * 10; i++) {
														$("#noTbody")
																.append(
																		'<tr><td style="height:50px;">'
																				+ obj[i].noticeCode
																				+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].title
																				+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].contents
																				+ '</td><td style="height:50px;">'
																				+ obj[i].regiDate
																				+ '</td><td style="height:50px;">'
																				+ obj[i].hit
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noEditModal_btn">수정</button>'
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noDel_btn">삭제</button>'
																				+ '</td></tr>'

																)//포문 끝

													}

												},
												error : function() {
													alert("Q&A 목록 출력 실패!");
												}
											});

								} else if ($("#choiceMenu option:selected")
										.val() == noticeContents) {
									var noticeContents = $("#keyC").val();
									$("#noTbody").empty();
									$
											.ajax({

												url : "noticeContentsSearch",
												type : "get",
												data : {
													contents : noticeContents
												},
												datatype : "text",

												success : function(data) {
													let str = JSON
															.stringify(data);

													let obj = JSON.parse(str);

													let i = (e.target.innerText) * 10 - 10;

													for (i; i < e.target.innerText * 10; i++) {
														$("#noTbody")
																.append(
																		'<tr><td style="height:50px;">'
																				+ obj[i].noticeCode
																				+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].title
																				+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].contents
																				+ '</td><td style="height:50px;">'
																				+ obj[i].regiDate
																				+ '</td><td style="height:50px;">'
																				+ obj[i].hit
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noEditModal_btn">수정</button>'
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noDel_btn">삭제</button>'
																				+ '</td></tr>'

																)//포문 끝

													}

												},
												error : function() {
													alert("Q&A 목록 출력 실패!");
												}
											});
								}
							});

			//검색창
			$(document)
					.on(
							"click",
							"#search_btn",
							function(e) {
								$("#before_btn").hide();
								$("#next_btn").show();
								var noticeAll = "noticeAll";
								var noticeCode = "noticeCode";
								var noticeTitle = "noticeTitle";
								var noticeContents = "noticeContents";
								if ($("#choiceMenu option:selected").val() == noticeCode) {
									var noticeCode = $("#keyC").val();

									$
											.ajax({
												type : "GET",
												url : "noticeCodeSearch",
												data : {
													noticeCode : noticeCode
												},
												dataType : "JSON",

												success : function(data) {
													let str = JSON
															.stringify(data);
													//alert(str);
													let obj = JSON.parse(str);
													let i = 0;

													$("#noTbody").empty();
													$("#pageNum").empty();
													$("#noTbody")
															.append(
																	'<tr><td style="height:50px;">'
																			+ obj[0].noticeCode
																			+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[0].title
																			+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[0].contents
																			+ '</td><td style="height:50px;">'
																			+ obj[0].regiDate
																			+ '</td><td style="height:50px;">'
																			+ obj[0].hit
																			+ '</td><td style="height:50px;">'
																			+ '<button id="noEditModal_btn">수정</button>'
																			+ '</td><td style="height:50px;">'
																			+ '<button id="noDel_btn">삭제</button>'
																			+ '</td></tr>'

															)//포문 끝
												},

												error : function() {
													alert("Q&A 목록 출력 실패!");
												}
											});

								} else if ($("#choiceMenu option:selected")
										.val() == noticeTitle) {
									var noticeTitle = $("#keyC").val();
									$
											.ajax({
												type : "GET",
												url : "noticeTitleSearch",
												data : {
													title : noticeTitle
												},
												dataType : "JSON",

												success : function(data) {
													let str = JSON
															.stringify(data);

													let obj = JSON.parse(str);
													let i = 0;
													$("#pageNum").empty();
													$("#noTbody").empty();

													for (i; i < 10; i++) {
														$("#noTbody")
																.append(
																		'<tr><td style="height:50px;">'
																				+ obj[i].noticeCode
																				+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].title
																				+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].contents
																				+ '</td><td style="height:50px;">'
																				+ obj[i].regiDate
																				+ '</td><td style="height:50px;">'
																				+ obj[i].hit
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noEditModal_btn">수정</button>'
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noDel_btn">삭제</button>'
																				+ '</td></tr>'

																)//포문 끝

													}
													$("#pageNum").empty();

													if (obj.length > 100) {
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
													//페이지 번호 끝
												},
												error : function() {
													alert("Q&A 목록 출력 실패!");
												}
											});

								} else if ($("#choiceMenu option:selected")
										.val() == noticeContents) {
									var noticeContents = $("#keyC").val();

									$
											.ajax({
												type : "GET",
												url : "noticeContentsSearch",
												data : {
													contents : noticeContents
												},
												dataType : "JSON",

												success : function(data) {
													let str = JSON
															.stringify(data);

													let obj = JSON.parse(str);
													let i = 0;

													$("#noTbody").empty();
													$("#pageNum").empty();
													for (i; i < 10; i++) {
														$("#noTbody")
																.append(
																		'<tr><td style="height:50px;">'
																				+ obj[i].noticeCode
																				+ '</td><td style="max-width:150px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].title
																				+ '</td><td style="max-width:300px; height:50px; overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																				+ obj[i].contents
																				+ '</td><td style="height:50px;">'
																				+ obj[i].regiDate
																				+ '</td><td style="height:50px;">'
																				+ obj[i].hit
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noEditModal_btn">수정</button>'
																				+ '</td><td style="height:50px;">'
																				+ '<button id="noDel_btn">삭제</button>'
																				+ '</td></tr>'

																)//포문 끝

													}
													$("#pageNum").empty();

													if (obj.length > 100) {
														for (let j = 1; j < 11; j++) {
															$("#pageNum")
																	.append(
																			"<span>"
																					+ j
																					+ "</span>");
														}
													}
													$("#pageNum").children()
															.first().click();
													//페이지 번호 끝
												},
												error : function() {
													alert("Q&A 목록 출력 실패!");
												}
											});
								}
							});

			//모달창안에 x버튼
			$(document).on("click", "#close_modal", function(e) {
				$(".notice_modal").css('display', 'none');
				$(".reginotice_modal").css('display', 'none');
			});

			//공지사항 삭제
			$(document).on(
					"click",
					"#noDel_btn",
					function(e) {
						var targetNum = $(e.target).parent().parent()
								.children().first().text();
						$.ajax({
							url : "noticeDel",
							type : "get",
							data : {
								noticeCode : targetNum
							},
							success : function(data) {
								$("#noTbody").empty();
								noticeListView();
							},
							error : function() {
							}
						});
					});

			//수정버튼누르면 실행
			$(document).on("click", "#noEdit_btn", function(e) {
				var form = $("#edit_frm").serialize();

				$.ajax({

					type : "post",
					url : "editNotice",
					data : form,
					dataType : "json",
					success : function(json) {
						$("#noTbody").empty();
						noticeListView();
					},
					error : function(request, status, error) {
						//리턴을 안줘서 수정성공시 여기서 출력
						$(".notice_modal").css('display', 'none');
						$("#noTbody").empty();
						noticeListView();
					}

				});
			});

			//등록버튼 클릭
			$(document).on("click", "#regiNotice_btn", function(e) {
				$(".reginotice_modal").css('display', 'block');
			});

			//공지사항 등록
			$(document).on("click", "#regi_btn", function(e) {
				var form = $("#regi_frm").serialize();
				$.ajax({
					url : "regiNotice",
					type : "post",
					data : form,
					dataType : "json",
					success : function(json) {
						$("#noTbody").empty();
						noticeListView();
					},
					error : function(request, status, error) {
						//리턴을 안줘서 수정성공시 여기서 출력
						$(".reginotice_modal").css('display', 'none');
						$("#noTbody").empty();
						noticeListView();
					}

				});
			});
		</script>
</body>
</html>