// JavaScript Document



/* 아바서치 스크롤탑값에 의한 움직임 */
$(document).ready(function(){
	
	var scene01Num = 1;
	$(".img div").css({opacity:0});

	$(window).scroll(function(){
		var scrollTop = $(document).scrollTop();
		
		if (scrollTop > 140 && scene01Num == 1) {
			scene01Num = 0;
			$(".img > .img01").delay(0).css({top:0}).stop(0).animate({
				opacity:1,
			    top:"200px"
			}, 1000 );
			$(".img > .img03").delay(0).css({top:"190px"}).stop(0).animate({
				opacity:1,
			    top:"440px"
			}, 2000 );
			$(".img > .img02").delay(0).css({top:0}).stop(0).animate({
				opacity:1,
			    top:"220px"
			}, 1000 );
			$(".img > .img04").delay(0).css({top:"200px"}).stop(0).animate({
				opacity:1,
			    top:"460px"
			}, 2000 );
		}
		
		
	});

	$(window).resize(function () {
		if($(window).width() > 1550){

		}
	});
	
	
	
});
















