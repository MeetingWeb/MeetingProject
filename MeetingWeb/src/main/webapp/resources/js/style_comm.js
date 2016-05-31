$(function() {
	var c_width = document.getElementById("menu").getBoundingClientRect().width;
	var body_width = document.body.scrollWidth - 17;
	console.log(body_width);
	$("#contents").css("height", window.innerHeight).css("width", body_width - c_width);
	$("footer").css({
		"width" : body_width - c_width,
		"height" : "90px"
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

});

/*
 * $(function(){ var flip = 0; $("#joinbtn").click(function () {
 * $("#joinform").toggle( flip++ % 2 == 0 );
 * //$("#loginform").css('display','none'); });
 * 
 * });
 */