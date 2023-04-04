<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/productReg.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
</head>
<body>
   <div class="gamut1">
    <%@ include file="adminMenu.jsp"%>
      <div class="main_view1">

         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">제품 등록</div>
            </div>
         </div>
         <div class="easy_menu1">
            <form action="productReg.do" id="productReg_form" method="post" enctype="multipart/form-data">
                <div id="input_menu">
                    <div id="input_title">제품명</div>
                    <div id="textbox"><input type="text" name="productName" id="productName"></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">카테고리</div>
                        <div id="textbox">
                            <select class="selectMenu" name="category" id="category" size="1">
                                <option>-선택-</option>
                                <option value="snack">snack</option>
                                <option value="ticket">ticket</option>
                                <option value="best">best</option>
                                <option value="ect">ect</option>
                            </select>
                        </div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">가격</div>
                        <div id="textbox">
                        	<input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="price" id="price">
                       		
                       	</div>
                        
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">제품정보</div>
                    <div id="textbox"><textarea name="productInfo" id="productInfo"></textarea></div>
                </div>
                <div id="input_menu_1">
                        <div id="input_title">제품 이미지 업로드</div>
                        <div id="textbox">
                            <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)" style="cursor: pointer;">
                            <label id=upload_btn for="photoFileName">
                                파일선택
                            </label>
                        </div>
                </div>
                <div id="submitBox">
                    <div><input type="submit" id="submitBtn" value="등록하기"></div>
                </div>
            </form>
            <div id="regied_content">
                <div id="regied_photo">
                    -제품 이미지 미리보기-
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
      //상품이미지 미리보기
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
    </script>
	<script>
		//유효성검사
		$("#submitBtn").on("click", function(){
			if($("#productName").val() == ""){
				alert("제품명을 입력해주세요.");
				$("#productName").css("border", "1px solid red");
				$("#productName").focus(); 
				return false;
			}else if($("#productName").val() != ""){
				$("#productName").css("border", "1px solid lightgray");
			}
			
			if($("#category").val() == "-선택-"){
				alert("카테고리를 선택해주세요.");
				$("#category").css("border", "1px solid red");
				$("#category").focus(); 
				return false;
			}else if($("#category").val() != "-선택-"){
				$("#category").css("border", "1px solid lightgray");
			}
			
			if($("#price").val() == ""){
				alert("가격을 입력해주세요.");
				$("#price").css("border", "1px solid red");
				$("#price").focus(); 
				return false;
			}else if($("#price").val() != ""){
				$("#price").css("border", "1px solid lightgray");
			}
			
			if($("#productInfo").val() == ""){
				alert("제품정보를 입력해주세요.");
				$("#productInfo").css("border", "1px solid red");
				$("#productInfo").focus(); 
				return false;
			}else if($("#productInfo").val() != ""){
				$("#productInfo").css("border", "1px solid lightgray");
			}
			
			if($("#photoFileName").val() == ""){
				alert("제품 이미지를 등록해주세요.");
				$("#upload_btn").css("border", "1px solid red");
				$("#upload_btn").focus(); 
				return false;
			}else if($("#photoFileName").val() != ""){
				$("#upload_btn").css("border", "1px solid lightgray");
			}
		});
		//가격에 숫자만 입력되도록
		$("#price").on("keydown", function(e){
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
		//제품명 입력완료하면 테두리 red-> lightgray
		$("#productName").on("change", function(){
			if($("#productName").val() != ""){
				$("#productName").css("border", "1px solid lightgray");
			}
		});
		//카테고리 선택완료하면 테두리 red-> lightgray
		$("#category").on("change", function(){
			if($("#category").val() != ""){
				$("#category").css("border", "1px solid lightgray");
			}
		});
		
		//가격 입력완료하면 테두리 red-> lightgray
		$("#price").on("change", function(){
			if($("#price").val() != ""){
				$("#price").css("border", "1px solid lightgray");
			}
		});
		
		//제품정보 입력완료하면 테두리 red-> lightgray
		$("#productInfo").on("change", function(){
			if($("#productInfo").val() != ""){
				$("#productInfo").css("border", "1px solid lightgray");
			}
		});
		
		//제품이미지 등록완료하면 테두리 red-> lightgray
		$("#photoFileName").on("change", function(){
			if($("#photoFileName").val() != ""){
				$("#upload_btn").css("border", "1px solid lightgray");
			}
		});
	</script>
</body>
</html>