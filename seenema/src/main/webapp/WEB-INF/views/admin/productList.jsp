<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/productList.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>
    <!-- 등록된 영화 리스트 조회/삭제 페이지 -->
   <div class="gamut1">
	    <%@ include file="adminMenu.jsp"%>
	    
	    <div class="main_view1">
	
	       <div id="doToday_menu">
	          <div id="main_header">
	             <div id="menu_title">제품 조회</div>
	             <table id="serch_tbl">
	                <tr>
	                   <th>
	                      <select name="serchType" id="serchType" size="1">
	                         <option>-선택-</option>
	                         <option value="productName">상품명으로 검색</option>
	                         <option value="price">가격 검색</option>
	                         <option value="category">카테고리 검색</option>
	                      </select>
	                      <span id="serchBox">
	                         <input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
	                      </span>
	                      <button id="btn_serchProduct" onclick="serchProduct();">검색</button>
	                      <button onclick="location.href='productList'">초기화</button>
	                   </th>
	                </tr>
	             </table>
	          </div>
	       </div>
	
	       <div class="easy_menu1">
	          <div id="listBox">
	             <table id="list_tbl">
	                <thead id="thead">
	                    <tr>
	                        <th></th><th></th><th></th><th></th><th></th><th></th>
	                        <th>
	                            <select id="sort" size="1">
	                                <option value="null">-정렬-</option>
	                                <option value="best">베스트</option>
	                                <option value="snack">스낵</option>
	                                <option value="ticket">영화관람권</option>
	                                <option value="lowPrice">낮은 가격 순</option>
	                                <option value="highPrice">높은 가격 순</option>
	                                <option value="lowCnt">판매량 낮은 순</option>
	                                <option value="highCnt">판매량 높은 순</option>
	                            </select>
	                        </th>
	                    </tr>
	                    <tr>
	                      <th id="list_chkbox"><input type="checkbox" id="allChk"></th>
	                      <th id="list_code">제품코드</th>
	                      <th id="list_img">이미지</th>
	                      <th id="list_name">제품이름</th>
	                      <th id="list_category">카테고리</th>
	                      <th id="list_price">가격</th>
	                      <th id="list_cnt">판매량</th>
	                    </tr>
	                </thead>
	                <tbody id="tbody">
	                   <c:forEach var="p" items="${pList }">
	                      <tr>
	                        <td><input type="checkbox" class="chk" value="${p.productCode }"></td>
	                        <td>${p.productCode}</td>
	                        <td><img src="/resources/${p.productImage }" width="60px"></td>
	                        <td><a href="productUpdate?productCode=${p.productCode}">${p.productName}</a></td>
	                        <td>${p.category }</td>
	                        <td>${p.price}</td>
	                        <td style="color:blue">${p.productSales}</td>
	                      </tr>
	                   </c:forEach>
	                  </tbody>
	                   <tfoot id="tfoot1">
	                      <tr>
	                      	<th>
	                      		<button id="js_del">선택삭제</button>
	                      	</th>
	                      	<th id="pageNum" colspan="5"></th>
	                      	<th> <button id="productReg" onclick="location.href='productReg'">제품등록</button></th>
	                      </tr>
	                   </tfoot>
	                   
	                   
	             </table>
	             <input type="hidden" id="cnt">
	             <input type="hidden" id="currentPage" value="1">
	           
	          </div>
	       </div>
	    </div>
   </div>

	<script>
	
		let totalPage = 0;
		let pNo = 1;
		$(document).ready(goPage(pNo), cntProduct());
		
		//게시글 총 개수
		function cntProduct(){
			
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
					//$("#pageNum").append("<span class='prev'> 이전 </span>");
					for(let i = 0; i < 10; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " </span>");
					}
					$("#pageNum").append("<span class='next'> >> </span>");
				}
				$(".pageCnt").filter(":first").css("color", "red"); //첫페이지색깔
			}

			xhttp.open("GET", "getCnt", true); 
				
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
    					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
                        "<th>"+
                        	"<select id='sort' size='1'>"+
                                "<option value='null'>-정렬-</option>"+
 
                                "<option value='lowPrice'>낮은 가격 순</option>"+
                                "<option value='highPrice'>높은 가격 순</option>"+
                                "<option value='lowCnt'>판매량 낮은 순</option>"+
                                "<option value='highCnt'>판매량 높은 순</option>"+
                            "</select>"+
                        "</th>"+
                    "</tr>"+
					"<tr>"+
						"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
						"<th id='list_code'>제품코드</th>"+
						"<th id='list_img'>이미지</th>"+
						"<th id='list_name'>제품이름</th>"+
						"<th id='list_category'>카테고리</th>"+
						"<th id='list_price'>가격</th>"+
						"<th id='list_cnt'>판매량</th>"+
					"</tr>");
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append(
							"<tr>"+
	                        	"<td><input type='checkbox' class='js_chk' name='js_chk' value='"+obj[i].productCode+"'></td>"+
	                        	"<td>"+obj[i].productCode+"</td>"+
	                        	"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
	                        	"<td><a href='productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</a></td>"+
	                        	"<td>"+obj[i].category+"</td>"+
	                        	"<td>"+obj[i].price+"</td>"+
	                        	"<td style='color:blue'>"+obj[i].productSales+"</td>"+
	                     	"</tr>");
				}
				
			}
					
			xhttp.open("GET", "goPage?pageNum=" + pNo, true); 
				
			xhttp.send();
		}
	</script>
	
	<script>
		//상품조회
		$("#serchType").on('change', function(e){
			if($("#serchType").val() == "price"){
				$("#serchBox").html(
						"<input type='text' id='start' placeholder='가격을 입력해주세요.'> ~ "+
						"<input type='text' id='end' placeholder='가격을 입력해주세요.'>");
			}else{
				$("#serchBox").html(
						 "<input type='text' id='serchWord' placeholder='검색어를 입력해주세요.'>");
			}
		});
		
		function serchProduct(num=1){
			/* alert(num); */
			let serchType = $("#serchType").val();
			let serchWord = $("#serchWord").val();
			
			if(serchType == "productName"){
				//이름으로 상품조회
				
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					if(obj.length != 0){
						
						$("#thead").html("<tr>"+
                        					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
					                        "<th>"+
					                        	"<select id='src_sort' size='1'>"+
					                                "<option value='null'>-정렬-</option>"+
					                                "<option value='lowPrice'>낮은 가격 순</option>"+
					                                "<option value='highPrice'>높은 가격 순</option>"+
					                                "<option value='lowCnt'>판매량 낮은 순</option>"+
					                                "<option value='highCnt'>판매량 높은 순</option>"+
					                            "</select>"+
					                        "</th>"+
					                    "</tr>"+
										"<tr>"+
											"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
											"<th id='list_code'>제품코드</th>"+
											"<th id='list_img'>이미지</th>"+
											"<th id='list_name'>제품이름</th>"+
											"<th id='list_category'>카테고리</th>"+
											"<th id='list_price'>가격</th>"+
											"<th id='list_cnt'>판매량</th>"+
										"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue;'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);//tbody
						}//for
						
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html(
									"<tr>"+
										"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
									"</tr>");
						
						$("#tfoot1").html(
								"<tr>"+
									"<th>"+
										"<button id='js_del'>선택삭제</button>"+
									"</th>"+
									"<th id='pageNum' colspan='5'></th>"+
									"<th><button id='productReg' onclick='location.href='productReg''>제품등록</button></th>"+
								"</tr>");
					};//if
				}//func
				xhttp.open("GET", "getListByName.do?productName=" + serchWord + "&pageNum=" + num, true); 
					
				xhttp.send();
				
			}else if(serchType == "price"){
				//가격으로 상품조회
				//alert($("#start").val());
				if(parseInt($("#start").val()) > parseInt($("#end").val())){
					alert("시작 금액대가 더 큽니다. 가격대를 다시 확인해주세요 !");
					$("#start").focus();
					return true;
				}
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						$("#thead").html("<tr>"+
            					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
		                        "<th>"+
		                        	"<select id='src_sort' size='1'>"+
		                                "<option value='null'>-정렬-</option>"+
		                                "<option value='lowPrice'>낮은 가격 순</option>"+
		                                "<option value='highPrice'>높은 가격 순</option>"+
		                                "<option value='lowCnt'>판매량 낮은 순</option>"+
		                                "<option value='highCnt'>판매량 높은 순</option>"+
		                            "</select>"+
		                        "</th>"+
		                    "</tr>"+
							"<tr>"+
								"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
								"<th id='list_code'>제품코드</th>"+
								"<th id='list_img'>이미지</th>"+
								"<th id='list_name'>제품이름</th>"+
								"<th id='list_category'>카테고리</th>"+
								"<th id='list_price'>가격</th>"+
								"<th id='list_cnt'>판매량</th>"+
							"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						
					};
					
				}
				xhttp.open("GET", "getListByPrice.do?start=" + $("#start").val() + "&end=" + $("#end").val() + "&pageNum=" + num, true); 
					
				xhttp.send();
			}else if(serchType == "category"){
				//카테고리검색
				
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						$("#thead").html("<tr>"+
            					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
		                        "<th>"+
		                        	"<select id='src_sort' size='1'>"+
		                                "<option value='null'>-정렬-</option>"+
		                                "<option value='lowPrice'>낮은 가격 순</option>"+
		                                "<option value='highPrice'>높은 가격 순</option>"+
		                                "<option value='lowCnt'>판매량 낮은 순</option>"+
		                                "<option value='highCnt'>판매량 높은 순</option>"+
		                            "</select>"+
		                        "</th>"+
		                    "</tr>"+
							"<tr>"+
								"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
								"<th id='list_code'>제품코드</th>"+
								"<th id='list_img'>이미지</th>"+
								"<th id='list_name'>제품이름</th>"+
								"<th id='list_category'>카테고리</th>"+
								"<th id='list_price'>가격</th>"+
								"<th id='list_cnt'>판매량</th>"+
							"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						
					};
					
				}
				xhttp.open("GET", "getListByCategory.do?category=" + serchWord + "&pageNum=" + num, true); 
					
				xhttp.send();
			}//else if
		}//function
		</script>
		
		<script>
		//검색페이지네이션
		$("#btn_serchProduct").on("click", getSrcCnt);
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
					//$("#pageNum").append("<span class='prev'> 이전 </span>");
					for(let i = 0; i < 10; i++){
						$("#pageNum").append("<span class='pageCnt'> " + (i+1) + " </span>");
					}
					$("#pageNum").append("<span class='next'> >> </span>");
				}
				$(".pageCnt").filter(":first").css("color", "red"); //첫페이지색깔
			}
			if($("#serchType").val() == "productName"){
				xhttp.open("GET", "productNameCnt?productName=" + $("#serchWord").val(), true); 
					
				xhttp.send();
				
				$(document).on("click", ".pageCnt", function(){
					/* alert("hi"); */
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					serchProduct(num=pageNum);
				})
			}else if($("#serchType").val() == "price"){
				xhttp.open("GET", "productByPriceCnt?start=" + $("#start").val() + "&end=" + $("#end").val(), true); 
				
				xhttp.send();
				
				$(document).on("click", ".pageCnt", function(){
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					serchProduct(num=pageNum);
				})
			}else if($("#serchType").val() == "category"){
				xhttp.open("GET", "productByCategoryCnt?category=" + $("#serchWord").val(), true); 
				
				xhttp.send();
				
				$(document).on("click", ".pageCnt", function(){
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					serchProduct(num=pageNum);
				})
			}
		}
		
		</script>
		<script>
		//상품등록페이지로 이동
		function goProductRegPage(){
			location.href="productReg";
		}
		
		//전체 선택
		$("#allChk").on("change", allChk);
		
		let all = document.querySelector("#allChk");
		let chks = document.querySelectorAll(".chk");
		function allChk(){
			for(let i = 0; i < chks.length; i++){
				chks[i].checked = all.checked;
			}
		};
		
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
				if (!confirm("선택된 상품을 삭제하시겠습니까?")) {
	            
		        }else{
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
								location.href="productList";
							}else{
								alert("삭제실패..");
								location.href="productList";
							}
						}
						
						xhttp.open("GET", "products_delete.do?productCodes=" + checked_val, true); 
							
						xhttp.send();
				        
					}//if
	        	}//confirm
			}//if button js_del
		}//function
		
		//상품등록페이지로 이동
		function goProductReg(){
			location.href="productReg";
		}
	</script>
	<script>
		//메인 sort
		$(document).on("change", $("#sort"), sort);
		$(document).on("change", "#sort", sortCnt);
		
		function sort(e, sNum=1){
			
			if(e.target.id == "sort"){
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let sort_vlue = $("#sort").val();
					let _sort_vlue = "";
					
					if(sort_vlue == "lowPrice"){
						_sort_vlue = "낮은 가격 순"
					}else if(sort_vlue == "highPrice"){
						_sort_vlue = "높은 가격 순"
					}else if(sort_vlue == "lowCnt"){
						_sort_vlue = "낮은 판매량 순"
					}else if(sort_vlue == "highCnt"){
						_sort_vlue = "높은 판매량 순"
					};
					
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						
						$("#thead").html("<tr>"+
                        					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
					                        "<th>"+
					                            "<select id='sort' size='1'>"+
					                            	"<option value='"+sort_vlue+"'>"+_sort_vlue+"</option>"+
					                                "<option value='null'>-정렬-</option>"+

					                                "<option value='lowPrice'>낮은 가격 순</option>"+
					                                "<option value='highPrice'>높은 가격 순</option>"+
					                                "<option value='lowCnt'>판매량 낮은 순</option>"+
					                                "<option value='highCnt'>판매량 높은 순</option>"+
					                            "</select>"+
					                        "</th>"+
					                    "</tr>"+
										"<tr>"+
											"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
											"<th id='list_code'>제품코드</th>"+
											"<th id='list_img'>이미지</th>"+
											"<th id='list_name'>제품이름</th>"+
											"<th id='list_category'>카테고리</th>"+
											"<th id='list_price'>가격</th>"+
											"<th id='list_cnt'>판매량</th>"+
										"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						$("#tfoot1").html(
								"<tr>"+
									"<th>"+
										"<button id='js_del'>선택삭제</button>"+
									"</th>"+
									"<th id='pageNum' colspan='5'></th>"+
									"<th><button id='productReg' onclick='goProductRegPage()'>제품등록</button></th>"+
								"</tr>");
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						$("#tfoot1").html(
								"<tr>"+
									"<th>"+
										"<button id='js_del'>선택삭제</button>"+
									"</th>"+
									"<th id='pageNum' colspan='5'></th>"+
									"<th><button id='productReg' onclick='goProductRegPage()'>제품등록</button></th>"+
								"</tr>");
					};
					
				}
				if($("#sort").val() == "lowPrice"){
					//낮은 가격 순으로 정렬
					xhttp.open("GET", "getListByLowPrice?pageNum="+sNum, true); 
					
					xhttp.send();
				}else if($("#sort").val() == "highPrice"){
					//높은 가격 순으로 정렬
					xhttp.open("GET", "getListByHighPrice", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "lowCnt"){
					//판매량 낮은 순으로 정렬
					xhttp.open("GET", "getListByLowSales", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "highCnt"){
					//판매량 높은 순으로 정렬
					xhttp.open("GET", "getListByHighSales", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "null"){
					
				}
			}//e.target if
			
			
		}//sort function
	
		//sort 페이지네이션
		function sortCnt(){
			/* alert("hi"); */
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText;
				totalPage = Math.ceil(result / 10); //총 페이지
				/* alert(totalPage); */
				
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
			if($("#sort").val() == "lowPrice"){
				
				xhttp.open("GET", "listByLowPriceCnt", true); 
					
				xhttp.send();
				
				$(document).on("click", ".pageCnt", function(){
					
					$(this).css("color", "red"); //클릭된 번호 색깔
					$(".pageCnt").not(this).css("color", "black"); //클릭되지 않은 번호 색깔
					let pageNum = $(this).text();
					sort(sNum=pageNum);
				
				}) 
			}
		}
	</script>
	<script>
		//검색 sort
		
		$(document).on('change', $("#src_sort"), src_sort);
		
		function src_sort(e){
			let serchWord = $("#serchWord").val();
			
			if(e.target.id == "src_sort"){
				let sort_vlue = $("#src_sort").val();
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let _sort_vlue = "";
					
					if(sort_vlue == "lowPrice"){
						_sort_vlue = "낮은 가격 순"
					}else if(sort_vlue == "highPrice"){
						_sort_vlue = "높은 가격 순"
					}else if(sort_vlue == "lowCnt"){
						_sort_vlue = "낮은 판매량 순"
					}else if(sort_vlue == "highCnt"){
						_sort_vlue = "높은 판매량 순"
					};
					
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						
						$("#thead").html("<tr>"+
                        					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
					                        "<th>"+
					                            "<select id='src_sort' size='1'>"+
					                            	"<option value='"+sort_vlue+"'>"+_sort_vlue+"</option>"+
					                                "<option value='null'>-정렬-</option>"+
					                                
					                                "<option value='lowPrice'>낮은 가격 순</option>"+
					                                "<option value='highPrice'>높은 가격 순</option>"+
					                                "<option value='lowCnt'>판매량 낮은 순</option>"+
					                                "<option value='highCnt'>판매량 높은 순</option>"+
					                            "</select>"+
					                        "</th>"+
					                    "</tr>"+
										"<tr>"+
											"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
											"<th id='list_code'>제품코드</th>"+
											"<th id='list_img'>이미지</th>"+
											"<th id='list_name'>제품이름</th>"+
											"<th id='list_category'>카테고리</th>"+
											"<th id='list_price'>가격</th>"+
											"<th id='list_cnt'>판매량</th>"+
										"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						
					}else if(obj.length === 0){
						$("#thead").html("<tr>"+
            					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
		                        "<th>"+
		                            "<select id='src_sort' size='1'>"+
		                            	"<option value='"+sort_vlue+"'>"+_sort_vlue+"</option>"+
		                                "<option value='null'>-정렬-</option>"+
		                           
		                                "<option value='lowPrice'>낮은 가격 순</option>"+
		                                "<option value='highPrice'>높은 가격 순</option>"+
		                                "<option value='lowCnt'>판매량 낮은 순</option>"+
		                                "<option value='highCnt'>판매량 높은 순</option>"+
		                            "</select>"+
		                        "</th>"+
		                    "</tr>"+
							"<tr>"+
								"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
								"<th id='list_code'>제품코드</th>"+
								"<th id='list_img'>이미지</th>"+
								"<th id='list_name'>제품이름</th>"+
								"<th id='list_category'>카테고리</th>"+
								"<th id='list_price'>가격</th>"+
								"<th id='list_cnt'>판매량</th>"+
							"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						
					};
					
				}
					if($("#src_sort").val() == "lowPrice"){
					//낮은 가격 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNamePrice?productName=" + serchWord + "&price=low", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPricePrice?start="+ $("#start").val() + "&end=" + $("#end").val() + "&price=low", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryPrice?category=" + serchWord + "&price=low", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "highPrice"){
					//높은 가격 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNamePrice?productName=" + serchWord + "&price=high", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPricePrice?start="+ $("#start").val() + "&end=" + $("#end").val() + "&price=high", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryPrice?category=" + serchWord + "&price=high", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "lowCnt"){
					//판매량 낮은 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameSales?productName=" + serchWord + "&sales=low", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceSales?start="+ $("#start").val() + "&end=" + $("#end").val() + "&sales=low", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategorySales?category=" + serchWord + "&sales=low", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "highCnt"){
					//판매량 높은 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameSales?productName=" + serchWord + "&sales=high", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceSales?start="+ $("#start").val() + "&end=" + $("#end").val() + "&sales=high", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategorySales?category=" + serchWord + "&sales=high", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "null"){
					
				}
			}//e.target if
		}//src_sort function
	</script>
	<script>
		//검색 유효성검사
		$("#btn_serchProduct").on("click", function(){
			if($("#serchType").val() == "-선택-"){
				alert("검색 할 카테고리를 먼저 선택해주세요.");
				$("#serchType").css("border", "1px solid red");
				goPage(1);
			}
			if($("#serchWord").val() == ""){
				alert("검색어를 입력해주세요.");
				$("#serchWord").css("border", "1px solid red");
				goPage(1);
			}
			if($("#start").val() == "" || $("#end").val() == ""){
				alert("가격을 입력해주세요.");
				$("#start").css("border", "1px solid red");
				$("#end").css("border", "1px solid red");
				goPage(1);
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
		
		//가격 입력완료 시 테두리 red->lightgray
		$(document).on("change", "#start", function(){
			if($("start").val() != ""){
				$("#start").css("border", "1px solid lightgray");
				
			}
		});
		$(document).on("change", "#end", function(){
			if($("end").val() != ""){
				$("#end").css("border", "1px solid lightgray");
			}
		});
		
		//가격검색 숫자만 입력되도록
		$(document).on("keyup", "#start", function(e){
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
						$("#start").val("");
						alert("숫자만 입력가능합니다.");
					}
		});
		$(document).on("keyup", "#end", function(e){
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
				$("#end").val("");
				alert("숫자만 입력가능합니다.");
			}
		});
	</script>
<c:if test="${param.insert_result == 1 }">
	<script>
		alert("등록완료!")
	</script>
</c:if>
<c:if test="${param.insert_result == 0 }">
	<script>
		alert("등록실패....")
	</script>
</c:if>
<c:if test="${param.update_result == 1 }">
	<script>
		alert("수정완료!");
	</script>
</c:if>
<c:if test="${param.update_result == 0 }">
	<script>
		alert("수정실패...");
	</script>
</c:if>
<c:if test="${param.del_result == 1 }">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0 }">
	<script>
		alert("삭제실패...");
	</script>
</c:if>

</body>
</html>