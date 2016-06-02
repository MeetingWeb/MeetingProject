$(function() {
	var link =  document.location.href;
	var c_width;
	if(link != "http://192.168.8.19:7777/NowMeetingWeb/web/main") {
		c_width = document.getElementById("menu").getBoundingClientRect().width;
	} else {
		c_width = document.getElementById("menu").getBoundingClientRect().width + 17;
	}
	
	var body_width = document.body.scrollWidth;

	$("#contents").css("height", window.innerHeight - 100).css("width", body_width - c_width);
	$("footer").css({
		"width" : body_width - c_width
	});
	$("#headernavi").css({
		"width" : body_width - c_width
	});

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