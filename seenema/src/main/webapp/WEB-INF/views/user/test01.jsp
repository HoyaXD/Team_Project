<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #review-box{
            width: 80%;
            margin: 0 auto;
            background-color: rgba(238, 238, 238, 0.68);
        }

        #review-box .review:first-child{
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            border-top: 2px solid #333333;
            border-bottom: 2px solid #333333;
        }

        .review{
            margin: 10px 10px;
            display: flex;
            border-bottom: 1px solid #333333;
            border-top: 1px solid #333333;
        }

        .review-userId{
            width: 10%;
            text-align: center;
        }

        .review-productName{
            width: 10%;
        }

        .review-img{
            width: 15%;
        }

        .review-comment{
            width: 45%;
        }

        .review-score{
            width: 10%;
            text-align: center;
        }
        .review-date{
            width: 10%;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="review-box">
    <div class="review">
        <div class="review-userId">아이디</div>
        <div class="review-productName">물품</div>
        <div class="review-img">이미지</div>
        <div class="review-comment">내용</div>
        <div class="review-score">평점</div>
        <div class="review-date">날짜</div>
    </div>
    <c:forEach var="list" items="${list}">
        <div class="review">
            <input type="hidden" name="review_no" value="${list.review_no}">
            <div class="review-userId">${list.user_id}</div>
            <div class="review-productName">${list.product_name}</div>
            <div class="review-img">${list.review_img}</div>
            <div class="review-comment">${list.review_comment}</div>
            <div class="review-score">${list.review_score}</div>
            <div class="review-date">${list.review_date}</div>
        </div>
        <button class="review-updateBtn">수정</button>
        <button class="review-deleteBtn">삭제</button>
    </c:forEach>
</div>
</body>
<script>
    function clickDeleteBtn() {
        let test = document.querySelector('.review-deleteBtn');

        test.addEventListener('click',function (){
            let data = this.previousElementSibling.previousElementSibling.children[0].value;
            alert(data);
        });
		
        function clickDeleteBtn() {
        	  const deleteBtns = document.querySelectorAll('.review-deleteBtn');

        	  deleteBtns.forEach(function(btn) {
        	    btn.addEventListener('click', function() {
        	      const reviewNo = this.previousElementSibling.previousElementSibling.querySelector('input').value;
        	      const formData = new FormData();
        	      formData.append('review_no', reviewNo);

        	      const xhttp = new XMLHttpRequest();
        	      xhttp.onload = function() {
        	        const data = this.responseText;
        	        if (data == 1) {
        	          alert('삭제 되었습니다.');
        	        } else {
        	          alert('오류로 삭제가 안됐습니다.');
        	        }
        	      };
        	      xhttp.open('POST', '/review/delete.do', true);
        	      xhttp.send(formData);
        	    });
        	  });
        	}


        // const xhttp = new XMLHttpRequest();
        // xhttp.onload = function (){
        //     let data = this.responseText;
        //     if (data == 1){
        //         alert("삭제 되었습니다.");
        //     } else {
        //         alert("오류로 삭제가 안됐습니다.")
        //     }
        // }
        // xhttp.open("post","/review/delete.do",true);
        // xhttp.send(review_no);
    }
</script>
</html>
