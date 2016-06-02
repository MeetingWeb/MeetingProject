var body_height = $(window).height();
$(function() {
	var link =  document.location.href;
	var c_width;
	
	var body_width = $(window).width();
	
	if(link != "http://192.168.8.19:7777/NowMeetingWeb/web/main") {
		body_width;
	} else {
		c_width = document.getElementById("menu").getBoundingClientRect().width;
	}
	
	$("#map").css("height",body_height - 64);
	//$("#contents").css("height", body_height - 64)/*.css("width", body_width - 64);*/
	/*$("#headernavi").css({
		"width" : body_width - 64
		"padding-left":"64px"
	});*/
	
	// ///////////////////////////////////////////////////////////
	var flip = 0;
	var flip2 = 0;
	$("#loginbtn").click(function() {
		$("#login-form").toggle(flip++ % 2 == 0);
		$("#joinform").css('display', 'none');
		flip2 = 0;

	});

	$("#joinbtn").click(function() {
		$("#joinform").toggle(flip2++ % 2 == 0);
		$("#loginform").css('display', 'none');
		flip = 0;
	});

	$("#login-btn").on("click", function() {
		//location.href="/user/login";
		$("form[name=loginForm]").submit();
	});
	
	$("#logoutbtn").on("click",function() {
		location.href="../logout";
	});
});
$("#menu").height()
console.log($(window).height());