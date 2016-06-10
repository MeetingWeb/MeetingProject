var body_height = $(window).height();
$(function() {
	/////////메뉴 네비////////////////////////////
	$("#menu ul li:not(#menu-btn, #logo)").on("click", function(){
		var path = $(this).find("a").attr("href");
		location.href= path;
	});
	
	
	var link = document.location.href;
	var body_width = $(window).width();

	$("#map").css("height", body_height - 64);
	$("#login-form, #joinform").css("height", body_height - 64);

	// ///////////로그인 회원가입////////////////////////////////////////////////
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
		// location.href="/user/login";
		$("form[name=loginForm]").submit();
	});

	$("#logoutbtn").on("click", function() {
		location.href = "../logout";
	});
	//////////추천/////////////////////
	$("#recommendbtn").on("click",function(){
		
		if($("div.recommend").css('display')=='none'){	
			getRecommend();
			$("div.recommend").css('display','block');
		}else if($("div.recommend").css('display')=='block'){
			$("div.recommend").css('display','none');
		};
				
	
	});
	// ///////메뉴///////////////////////
	var bool = false;
	$("#menu #menu-btn").on("click", function() {
		if (bool == false) {
			$("#menu #menu-in").animate({
				width : "208px"
			}, 500);
			$("#menu .menu-btn-name").addClass("menu-btn-name-active");
			bool = true;
		} else {
			$("#menu #menu-in").animate({
				width : "64px"
			}, 250);
			$("#menu .menu-btn-name").removeClass("menu-btn-name-active");

			bool = false;
		}
	});
	// ////////////모임만들기///////////////////////////////////////
	// $("#meeting-form-background").css("width", $("#contents").width());
	var add_form_left = $("#contents").width() - $("#meeting-form-lid").width() + 140;
	var add_form_top = $("#contents").height() - $("#meeting-form-lid").height() + 100;
	//$("#meeting-form-lid").css("top", "120px");
	$//("#meeting-form-lid").css("margin-left", -$("#meeting-form-lid").width() / 2 + 32);
	$("#meeting-form-background, #meeting-form-map").css("height", $(window).height() - 64);

	var visibility = false;
	$("#set-location").on("click", function() {
		$("#view-map").css("visibility", "visible");
	});

	$("#view-map #close").on("click", function() {
		$("#view-map").css("visibility", "hidden");
	});
	
	$("#view-map").css({"width":$(window).width() - 64, "height":$(window).height() -64});
	
	//////////////review js////////////////////////
	$(".img-box").on("click",function(){
		console.log($(this).attr("data-num"));
		location.href="selectOne?num=" + $(this).attr("data-num");
	});
	
	$("#m-menu-btn").on("click",function() {
		
	});
	
});