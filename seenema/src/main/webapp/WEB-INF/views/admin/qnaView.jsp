<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Q&A View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<style>
.ans_modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

#ans_box {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 1000px;
	height: 400px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}
#ans_box > #text_box{
	position: relative;
	float:left;
}
#text_box button{
	width: 50px;
	height: 30px;
}
#ans_btn{
	border-radius: 3px;
}
#qnaRegi_btn{
	border-radius: 3px;
}

</style>
</head>
<body>
	<div class="gamut">
		<!-- 좌측메뉴 jsp -->
		<%@ include file="adminMenu.jsp"%>
		<!--상단바-->
		<div class="main_view">

			<div id="doToday_menu">
				<div id="doToday_title" style="width: 970px; height: 30px;">
					<p style="margin: 30px 0 0 40px;">Q&A 페이지</p>
				</div>
				<div id="each_num">
					<select id="choiceMenu">
						<option value="qnaAll">검색 선택</option>
						<option value="qnaId">아이디로 검색</option>
						<option value="qnaTitle">제목으로 검색</option>
						<option value="qnaContents">내용으로 검색</option>
					</select> <input type="text" id="keyC" placeholder="검색어 입력"> <input
						type="button" id="search_btn" value="검색"> <input
						type="button" id="reset_btn" value="초기화">
				</div>
			</div>

			<!-- 모달창 -->
			<div class="ans_modal">
				<div id="ans_box">
					Q&A답변
					<button id="close_modal">❌</button>
					<div id="text_box"></div>
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
								<th>아이디</th>
								<th>답변상황</th>
								<th>등록시간</th>
								<th>답변</th>
							</tr>
						</thead>
						<tbody id="qnaTbody">

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
		qnaListView();
		function qnaListView() {
			$(document)
					.ready(
							function() {
								$
										.ajax({

											url : "qnaList",
											type : "get",
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
									
													for (i; i < 10; i++) {
														//regidate가 타입이 timestamp라서 10번째까지 잘라줌
														 var resultDate = obj[i].regiDate.substring(0, 10);
														    $("#qnaTbody")
														        .append(
														            '<tr><td>'
														            + obj[i].qcode
														            + '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
														            + obj[i].title
														            + '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
														            + obj[i].contents
														            + '</td><td>'
														            + obj[i].id
														            + '</td><td>'
														            + obj[i].status // 수정
														            + '</td><td>'
														            + resultDate
														            + '</td><td>'
														            + '<button id="ans_btn" style="width:70px;">답변하기</button>'
														            + '</td></tr>'
														        )
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
													$("#before_btn").hide();
												}else if (obj.length < 100) {
													for (let j = 1; j < obj.length / 10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#before_btn").hide();
													$("#next_btn").hide();
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

		//페이지네이션
		$(document)
				.on(
						"click",
						"span",
						function(e) {
							var qnaAll = "qnaAll";
							var qnaId = "qnaId";
							var qnaTitle = "qnaTitle";
							var qnaContents = "qnaContents";
							var pagenum = $(e.target);
							$("span").css({"color":"black", "font-weight":"normal"});
							pagenum.css({"color":"red","font-weight":"bolder"});
							//선택하지않고 페이지번호를 눌렀을 때
							if ($("#choiceMenu option:selected").val() == qnaAll) {

								$("#qnaTbody").empty();
								$
										.ajax({

											url : "qnaList",
											type : "get",
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
																			+ '</td></tr>')//포문 끝

												}
											
											},

											error : function() {
												alert("Q&A 목록 출력 실패!");
											}

										});
								//id검색시
							} else if ($("#choiceMenu option:selected").val() == qnaId) {
		                        var id = $("#keyC").val();

								$("#qnaTbody").empty();
								$
										.ajax({

											url : "qnaIdSearch",
											type : "get",
											data : {
			                                    id : id
			                                 },
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 01;

												for (i; i < e.target.innerText * 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
																			+ '</td></tr>')//포문 끝

												}
											
											},

											error : function() {
												alert("Q&A 목록 출력 실패!");
											}

										});

								//제목검색시
							} else if ($("#choiceMenu option:selected").val() == qnaTitle) {
								
		                        var title = $("#keyC").val();

								$("#qnaTbody").empty();
								$
										.ajax({

											url : "qnaTitleSearch",
											type : "get",
											data : {
			                                    title : title
			                                 },
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
																			+ '</td></tr>')//포문 끝

												}
											
											},

											error : function() {
												alert("Q&A 목록 출력 실패!");
											}

										});

								//내용검색시
							} else if ($("#choiceMenu option:selected").val() == qnaContents) {
								
		                        var contents = $("#keyC").val();

								$("#qnaTbody").empty();
								$
										.ajax({

											url : "qnaContentsSearch",
											type : "get",
											data : {
												contents : contents
			                                 },
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;

												for (i; i < e.target.innerText * 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
																			+ '</td></tr>')//포문 끝

												}
											
											},

											error : function() {
												alert("Q&A 목록 출력 실패!");
											}

										});

							}

						});

		//답변버튼 누르면 모달창 나옴
		$(document)
				.on(
						"click",
						"#ans_btn",
						function(e) {

							var targetNum = $(e.target).parent().parent()
									.children().first().text();
							$(".ans_modal").css('display', 'block');

							//qcode보냄
							$
									.ajax({
										url : "qnaOneList",
										type : "get",
										data : {
											qcode : targetNum
										},
										datatype : "JSON",
										success : function(data) {
											let str = JSON.stringify(data);
											let obj = JSON.parse(str);
											var resultDate = obj.regiDate
													.substring(0, 10);
											var resultTime = obj.regiDate
													.substring(11, 16);
											
											$("#text_box").empty();
											$("#text_box")
													.append(
															'<br><div style="width:450px; text-align:left;"><span id="regiQcode">문의번호 : '+ obj.qcode + '</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + '제목 : ' + obj.title + '</div><br>'
														  + '<div style="width:450px; text-align:left;">작성자 : '+ obj.id + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + '등록시간 : '+  resultDate + '&nbsp;&nbsp;&nbsp;' + resultTime +'</div><br>'
														
														  + '<div style="width:450px; text-align:left;">내용</div><br>'
																	+ '<textarea style="width:450px; height:241px; resize: none;" readonly;>'
																	+ obj.contents
																	+ '\n\n'
																	
																	);
											$("#text_box").after('<br><br>'+'<textarea id="text_val" style="width:450px; height:350px; resize: none;" readonly;>' + obj.answer);
											$("#text_box").after('<button id="qnaRegi_btn">답변등록</button>');

										},
										error : function() {
										}
									});
						});
		
		//답변등록
		$(document).on("click", "#qnaRegi_btn", function(e){
			var qcode2 = $("#regiQcode").text();
			var qcode = parseInt(qcode2.substr(7));
			var contents = $("#text_val").val();
			 $.ajax({
				type : "post",
				url : "qnaAdminAnswer",
				data : { qcode : qcode,
					answer : contents },
			 
			 	dataType : "text",
			 	success : function(data){
			 		(qcode + "의 문의글에 답변하였습니다.");
			 		$(".ans_modal").css('display', 'none');
					location.reload();

			 	}
			}); 
		});
		//모달창안에 x버튼
		$(document).on("click", "#close_modal", function(e) {
			$(".ans_modal").css('display', 'none');
		});

		//검색창
		$(document)
				.on(
						"click",
						"#search_btn",
						function(e) {

							var qnaId = "qnaId";
							var qnaTitle = "qnaTitle";
							var qnaContents = "qnaContents";

							if ($("#choiceMenu option:selected").val() == qnaId) {
								var id = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "qnaIdSearch",
											data : {
												id : id
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#qnaTbody").empty();
												for (i; i < 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
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
													$("#next_btn").show();
													$("#before_btn").hide();
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
								//제목검색
							} else if ($("#choiceMenu option:selected").val() == qnaTitle) {
								var title = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "qnaTitleSearch",
											data : {
												title : title
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#qnaTbody").empty();
												for (i; i < 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
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
													$("#next_btn").show();
													$("#before_btn").hide();
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
								//내용검색
							} else if ($("#choiceMenu option:selected").val() == qnaContents) {
								var contents = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "qnaContentsSearch",
											data : {
												contents : contents
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#qnaTbody").empty();
												for (i; i < 10; i++) {
													//regidate가 타입이 timestamp라서 10번째까지 잘라줌
													var resultDate = obj[i].regiDate
															.substring(0, 10);

													$("#qnaTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].qcode
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].title
																			+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis; resize: none;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].status
																			+ '</td><td>'
																			+ resultDate
																			+ '</td><td>'
																			+ '<button id="ans_btn" style="width:70px;">답변하기</button>'
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
													$("#next_btn").show();
													$("#before_btn").hide();

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
							}
						});
		
		//이전버튼 누를 시
		$(document)
				.on(
						"click",
						"#before_btn",
						function(e) {
							var qnaAll = "qnaAll";
							var qnaId = "qnaId";
							var qnaTitle = "qnaTitle";
							var qnaContents = "qnaContents";
							if ($("#choiceMenu option:selected").val() == qnaAll) {

								$
										.ajax({
											url : "qnaCount",
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
									.val() == qnaId) {
								var qnaId = $("#keyC").val();

								$
										.ajax({
											url : "qnaIdCount",
											type : "get",
											data : {
												id : qnaId
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
									.val() == qnaTitle) {
								var qnaTitle = $("#keyC").val();

								$
										.ajax({
											url : "qnaTitleCount",
											type : "get",
											data : {
												title : qnaTitle
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
									.val() == qnaContents) {
								var qnaContents = $("#keyC").val();

								$
										.ajax({
											url : "qnaContentsCount",
											type : "get",
											data : {
												contents : qnaContents
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
							var qnaAll = "qnaAll";
							var qnaId = "qnaId";
							var qnaTitle = "qnaTitle";
							var qnaContents = "qnaContents";
							
							if ($("#choiceMenu option:selected").val() == qnaAll) {
								$
										.ajax({
											url : "qnaCount",
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
									.val() == qnaId) {
								var qnaId = $("#keyC").val();

								$
										.ajax({
											url : "qnaIdCount",
											type : "get",
											data : {
												id : qnaId
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
									.val() == qnaTitle) {
								var qnaTitle = $("#keyC").val();

								$
										.ajax({
											url : "qnaTitleCount",
											type : "get",
											data : {
												title : qnaTitle
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
									.val() == qnaContents) {
								var qnaContents = $("#keyC").val();

								$
										.ajax({
											url : "qnaContentsCount",
											type : "get",
											data : {
												contents : qnaContents
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
						});
		
		
		//초기화버튼
		$(document).on("click", "#reset_btn", function(evt) {
			location.reload();
		});
	</script>

</body>
</html>