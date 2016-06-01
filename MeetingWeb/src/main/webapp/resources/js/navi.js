$(function() {
	/*$("#menu ul li").each(function(idx) {
		var index = idx - 2;
		$(this).on("mouseenter", function(evt) {
			if (idx > 1) {
				$("#menu .menu-btn-name").css("top", $(this).offset().top);
				$("#menu .menu-btn-name").eq(index).stop().animate({
					left : 64,
					opacity : 1.0
				}, 100);
			}
		});

		$(this, "#menu .menu-btn-name").on("mouseleave", function() {
			if (idx > 1) {
				$("#menu .menu-btn-name").eq(index).css({
					"opacity" : "0",
					"top" : "0",
					"left" : "0"
				})
			}
		});
	});*/
	
	var bool = false;
	$("#menu #menu-btn").on("click",function(){
		$("#menu .menu-btn-name").css({"opacity":"1","left":"64px","width":"144px"});
		if(bool == false) {
			$("#menu #menu-in").animate({width:"208px"});
			bool = true;
		} else {
			$("#menu .menu-btn-name").animate({width:"64px",left:"0px",opacity:"0"},function(){
				
			});
			$("#menu #menu-in").animate({width:"64px"});
			bool = false;
		}
	});
});