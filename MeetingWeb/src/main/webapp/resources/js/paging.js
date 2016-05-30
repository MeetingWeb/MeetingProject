/*$(function() {
	$("#page-num").append("<span id=left><a href=#><</a></span>");
	if (endPage > maxPage) {
		endPage = maxPage;
	}
	for (var i = startPage; i <= endPage; i++) {
		if (i <= maxPage) {
			var span = null;
			if (from == "search") {
				span = "<span><a href=# onclick='navi(" + i + ")'>" + i + "</span>";
			} else if(from == "list") {
				span = "<span><a href=" + from + "?page_no=" + i + ">" + i + "</span>";
			}
		}
		$("#page-num").append(span);
	}
	$("#page-num").append("<span id=right><a href=#>></a></span>");
	console.log(currPage);

	if (currPage <= 5) {
		$("#left").css("display", "none");
	} else {
		var no = parseInt(startPage) - 1;
		if (from == "search") {
			$("#left a").attr("onclick", "navi(" + no + ")").attr("href", "#");
		} else
			$("#left a").attr("href", from + "?page_no=" + no);
	}

	if (endPage >= maxPage) {
		$("#right").css("display", "none");
	} else {
		var no = parseInt(endPage) + 1;
		if (from == "search") {
			$("#right a").attr("onclick", "navi(" + no + ")").attr("href", "#");
		} else {
			$("#right a").attr("href", from + "?page_no=" + no);
		}
	}

	$("#page-num span").each(function() {
		if ($(this).find("a").text() == currPage)
			$(this).find("a").addClass("curr-page");
	});

	$("#max-page").text(maxPage);
	$("#current-page").text(currPage);

	if (from == "search") {
		$("#search form select").val(category);
		$("#search input[type=text]").val(val);
	}
});

function navi(num) {
	$("#search form input[type=hidden]").val(num);
	$("#search form").submit();
}*/
$(function() {
	if (category == "")
		category = "title";
	$("#search form select").val(category);
	$("#search input[type=text]").val(val);

	$("#page-num span").each(function() {
		if ($(this).find("a").text() == currPage)
			$(this).find("a").addClass("curr-page");
	});
});

function navi(num, status) {
	$("#search form input[type=hidden]").val(num);
	/*
	 * if(status == "list") { location.href="list?page_no=" + num; } else {
	 * $("#search form").submit(); }
	 */
	$.ajax({
		type : "POST",
		url : "ajax" + status,
		data : $("#search form").serialize(),
		dataType : "json",
		success : function(json) {
			console.log(json);
			$(".navi_no a").empty();
			$(".list").each(function(idx){
				$(".list").eq(idx).find("td:nth-child(1) span").empty();
				$(".list").eq(idx).find("td:nth-child(2) a").empty();
				$(".list").eq(idx).find("td:nth-child(3)").empty();
				$(".list").eq(idx).find("td:nth-child(4) span").empty();
			})
			
			for (var i = 0; i < json.length; i++) {
				var obj = json[i];
				if (i != json.length - 1) {
					$(".list").eq(i).find("td:nth-child(1) span").text(obj.no);
					$(".list").eq(i).find("td:nth-child(2) a").html(obj.title).attr("href", "selectOne?num=" + obj.num);
					$(".list").eq(i).find("td:nth-child(3)").text(obj.author);
					$(".list").eq(i).find("td:nth-child(4) span").text(obj.wdate);
				} else {
					var s_no = parseInt(obj.start_no) - 1;
					var e_no = parseInt(obj.end_no) + 1;
					$("#page-num #left a").attr("onclick", "navi(" + s_no + ",'" + obj.status + "')");
					$("#page-num #right a").attr("onclick", "navi(" + e_no + ",'" + obj.status + "')");
					for (var j = obj.start_no, k = 0; j <= obj.end_no; j++, k++) {
						$(".navi_no").eq(k).find("a").attr("onclick", "navi(" + j + ",'" + obj.status + "')").text(j);
					}
					$("#page-num span").each(function() {
						console.log(obj.curr_no);
						if ($(this).find("a").text() == obj.curr_no) {
							$(this).find("a").addClass("curr-page");
						} else {
							$(this).find("a").removeClass("curr-page");
						}
					});
					$("#page-num").appned();
					if(obj.curr_no > 5) {
						$("#page-num #left").css("display","block");
					}
				}
				
				
			}
		},
		error : function(status, err, xrl) {
			console.log(status.responseText);
		}
	});
}