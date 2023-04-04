<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Member Management View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
<script type="text/javascript" src="/js/adminMenu.js"></script>
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
					<p style="margin: 30px 0 0 40px;">회원 관리</p>
				</div>
				<div id="each_num">
					<select id="choiceMenu">
						<option value="userAll">검색 선택</option>
						<option value="userId">아이디로 검색</option>
						<option value="userName">이름으로 검색</option>
						<option value="userGrade">등급으로 검색</option>
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
								<th>아이디</th>
								<th>비밀번호</th>
								<th>이름</th>
								<th>성별</th>
								<th>연락처</th>
								<th>생년월일</th>
								<th>등급</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody id="tbodyView">
							<tr>
								<!-- tbody에서 출력 -->

							</tr>
						</tbody>
					</table>
					<div id="span_box">
						<span id="before_btn"><<</span>
						<span id="pageNum"></span>
						<span id="next_btn">>></span>
					</div>
				</div>

			</div>
		</div>
	</div>

	<script>
		listView();

		//비동기를 하여 계속 해서 보이게끔 하기
		function listView() {
			$(document)
					.ready(
							function() {
								$("#before_btn").hide();

								$
										.ajax({
											url : "MemberListView",
											type : "get",
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;

												for (i; i < 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
												//페이지 번호나옴
												$("#pageNum").empty();

												if (obj.length > 100) {//obj.length / 8 + 1
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
												//페이지 번호 끝
												//첫페이지실행
												$("#pageNum").children()
														.first().click();
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});
							});
		}

		//이전버튼 누를 시
		$(document)
				.on(
						"click",
						"#before_btn",
						function(e) {
						
							var userAll = "userAll";
							var userId = "userId";
							var userName = "userName";
							var userGrade = "userGrade";
							if ($("#choiceMenu option:selected").val() == userAll) {

								$
										.ajax({
											url : "memberCount",
											type : "get",
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum").children()
														.first().text());
												$("#pageNum").empty();
												if (firstNum - 10 == 1) {
													//첫페이지니깐 이전버튼 숨김
													$("#before_btn").hide();
													$("#next_btn").show();
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													$("#pageNum").children()
															.first().click();
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

													$("#pageNum").children()
															.first().click();
												}

											},
											error : function() {
												alert("실패");
											}

										});
								//이전 눌렀을 시 아이디 
							} else if ($("#choiceMenu option:selected").val() == userId) {
								var id = $("#keyC").val();

								$
										.ajax({
											url : "memberIdCount",
											type : "get",
											data : {
												id : id
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum").children()
														.first().text());
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
													$("#pageNum").children()
															.first().click();
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
													$("#pageNum").children()
															.first().click();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							} else if ($("#choiceMenu option:selected").val() == userName) {
								var name = $("#keyC").val();

								$
										.ajax({
											url : "memberNameCount",
											type : "get",
											data : {
												name : name
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum").children()
														.first().text());
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
													$("#pageNum").children()
															.first().click();
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
													$("#pageNum").children()
															.first().click();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							}else if ($("#choiceMenu option:selected").val() == userGrade) {
								var grade = $("#keyC").val();

								$
										.ajax({
											url : "memberGradeCount",
											type : "get",
											data : {
												grade : grade
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var firstNum = parseInt($(
														"#pageNum").children()
														.first().text());
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
													$("#pageNum").children()
															.first().click();
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
													$("#pageNum").children()
															.first().click();
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
							var userAll = "userAll";
							var userId = "userId";
							var userName = "userName";
							var userGrade = "userGrade";
							if ($("#choiceMenu option:selected").val() == userAll) {
								$
										.ajax({
											url : "memberCount",
											type : "get",
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum").children()
														.last().text());
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
													$("#pageNum").children()
															.first().click();
												} else if (lastNum + 11 > obj / 10 + 1) {
													for (let j = lastNum + 1; j < obj / 8 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});
							} else if ($("#choiceMenu option:selected").val() == userId) {
								var id = $("#keyC").val();

								$
										.ajax({
											url : "memberIdCount",
											type : "get",
											data : {
												id : id
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum").children()
														.last().text());
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
													$("#pageNum").children()
															.first().click();
												} else if (lastNum + 11 > obj / 10 + 1) {
													for (let j = lastNum + 1; j < obj / 8 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});

							} else if ($("#choiceMenu option:selected").val() == userName) {
								var name = $("#keyC").val();

								$
										.ajax({
											url : "memberNameCount",
											type : "get",
											data : {
												name : name
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum").children()
														.last().text());
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
													$("#pageNum").children()
															.first().click();
												} else if (lastNum + 11 > obj / 10 + 1) {
													for (let j = lastNum + 1; j < obj / 8 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().trigger(
																	"click");
													$("#next_btn").hide();
												}
											},
											error : function() {
												alert("실패");
											}

										});
							}else if ($("#choiceMenu option:selected").val() == userGrade) {
								var grade = $("#keyC").val();

								$
										.ajax({
											url : "memberGradeCount",
											type : "get",
											data : {
												grade : grade
											},
											dataType : "text",
											success : function(data) {
												let obj = JSON.parse(data);
												var lastNum = parseInt($(
														"#pageNum").children()
														.last().text());
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
													$("#pageNum").children()
															.first().click();
												} else if (lastNum + 11 > obj / 10 + 1) {
													for (let j = lastNum + 1; j < obj / 8 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().trigger(
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

		//수정버튼을 누르면 수정창이 나온다.
		$(document)
				.on(
						"click",
						".adjm_btn",
						function(e) {

							var target = $(e.target).parent().parent()
									.children().first().text();
							let id = target;

							let url = "memEditPop?id=" + id;
							window
									.open(url, "회원정보수정",
											"width=500, height=700, scrollbars=yes, resizable=no");

							$.ajax({

								url : "PopOneList",
								type : "get",
								datatype : "text",

								success : function(data) {

									let obj = JSON.stringify(data);
									let parse = JSON.parse(obj);
									let i = 0;

									for (i; i < parse.length; i++) {

									}
								}

							});

						});

		//삭제버튼 누르면 삭제하기
		$(document).on(
				"click",
				".del_btn",
				function(e) {
					var target = $(e.target).parent().parent().children()
							.first().text();
					$.ajax({
						url : "MemberDel",
						type : "get",
						data : {
							id : target
						},

						success : function() {
						},
						error : function() {
							$("#tbodyView").empty();
							listView();
						}
					});
				});

		//검색기능을 이용하여 목록출력
		$(document)
				.on(
						"click",
						"#search_btn",
						function(e) {

							var userId = "userId";
							var userName = "userName";
							var userGrade = "userGrade";
							$("#pageNum").hide();

							//아이디로 회원목록 출력
							if ($("#choiceMenu option:selected").val() == userId) {
								var form = $("#keyC").val();

								$
										.ajax({

											type : "GET",
											url : "memberView/MemberIdView",
											data : {
												id : form
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												//한명의 회원목록 수정창을 닫음
												//회원목록을 보여주는 창을 새로고침
												let i = 0;
												$("#pageNum").empty();
												$("#tbodyView").empty();
												for (i; i < 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
												//첫페이지실행
										
												$("#pageNum").empty();
												if (obj.length > 100) {
													$("#next_btn").show();
												
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().click();
													//수정하려면 여기서 
												}else if (obj.length < 100){
													$("#next_btn").hide();
													$("#before").hide();
													for (let j = 1; j < obj.length/10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().click();

												}
												//페이지 번호 끝
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}

										});
								//이름으로 회원목록 출력

							} else if ($("#choiceMenu option:selected").val() == userName) {
								var name = $("#keyC").val();
								$
										.ajax({

											type : "GET",
											url : "memberView/MemberNameView",
											data : {
												name : name
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												//한명의 회원목록 수정창을 닫음
												//회원목록을 보여주는 창을 새로고침
												let i = 0;
												$("#tbodyView").empty();
												for (i; i < 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
												$("#pageNum").empty();
												//첫페이지실행
												
												if (obj.length > 100) {
													$("#next_btn").show();
												
													for (let j = 1; j < 11; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().click();
													//수정하려면 여기서 
												}else if (obj.length < 100){
													$("#next_btn").hide();
													$("#before").hide();
													for (let j = 1; j < obj.length/10 + 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().click();

												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});

								//등급으로 회원목록 출력
							} else if ($("#choiceMenu option:selected").val() == userGrade) {
								var grade = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "memberView/MemberGradeView",
											data : {
												grade : grade
											},
											dataType : "JSON",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = 0;
												$("#tbodyView").empty();
												for (i; i < 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
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
													//첫페이지실행
													$("#pageNum").children()
															.first().click();
												}else if (obj.length < 100){
													$("#next_btn").hide();
													$("#before").hide();
													for (let j = 1; j < obj.length/10+ 1; j++) {
														$("#pageNum")
																.append(
																		"<span>"
																				+ j
																				+ "</span>");
													}
													//첫페이지실행
													$("#pageNum").children()
															.first().click();

												}
												//페이지 번호 끝
											},
											error : function() {
												alert("회원 목록 출력 실패!");
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
							var userAll = "userAll";
							var userId = "userId";
							var userName = "userName";
							var userGrade = "userGrade";
							var pagenum = $(e.target);
							$("span").css({
								"color" : "black",
								"font-weight" : "normal"
							});
							pagenum.css({
								"color" : "red",
								"font-weight" : "bolder"
							});
							if ($("#choiceMenu option:selected").val() == userAll) {

								$
										.ajax({
											url : "MemberListView",
											type : "get",
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;
												$("#tbodyView").empty();

												for (i; i < e.target.innerText * 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});

							} else if ($("#choiceMenu option:selected").val() == userId) {
								var id = $("#keyC").val();
								$
										.ajax({
											url : "memberView/MemberIdView",
											type : "get",
											data : {
												id : id
											},
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;
												$("#tbodyView").empty();

												for (i; i < e.target.innerText * 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});
							} else if ($("#choiceMenu option:selected").val() == userName) {
								var name = $("#keyC").val();

								$
										.ajax({
											url : "memberView/MemberNameView",
											type : "get",
											data : {
												name : name
											},
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;
												$("#tbodyView").empty();

												for (i; i < e.target.innerText * 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});
							} else if ($("#choiceMenu option:selected").val() == userGrade) {
								var grade = $("#keyC").val();

								$
										.ajax({
											url : "memberView/MemberGradeView",
											type : "get",
											data : {
												grade : grade
											},
											datatype : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(str);
												let i = (e.target.innerText) * 10 - 10;
												$("#tbodyView").empty();

												for (i; i < e.target.innerText * 10; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ obj[i].id
																			+ '</td><td>'
																			+ obj[i].pw
																			+ '</td><td>'
																			+ obj[i].name
																			+ '</td><td>'
																			+ obj[i].gender
																			+ '</td><td>'
																			+ obj[i].tel
																			+ '</td><td>'
																			+ obj[i].birthday
																			+ '</td><td>'
																			+ obj[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}

											},
											error : function() {
												alert("회원 목록 출력 실패!");	
											}
										});
							}
						});

		$(document).on("click", "#reset_btn", function(evt) {
			location.reload();
		});
	</script>
</body>
</html>
