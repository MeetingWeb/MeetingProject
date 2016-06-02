$(function() {
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

	$("#meeting-form-background").css("width", $("#contents").width());
	var add_form_left = $("#contents").width() - $("#meeting-form-lid").width() + 150;
	var add_form_top = $("#contents").height() - $("#meeting-form-lid").height();
	$("#meeting-form-lid").css("left", add_form_left / 2).css("top", add_form_top / 2);
});