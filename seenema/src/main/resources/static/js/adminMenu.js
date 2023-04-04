/**
 * 
 */
//메뉴바 나오는 js
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
