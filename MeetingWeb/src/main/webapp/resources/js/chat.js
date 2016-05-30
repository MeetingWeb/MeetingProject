var check;
$(function() {
	$("#all").on("change", function() {
		if (check) {
			$("p input[type=checkbox]").attr("checked", false);
			check = false;
		} else {
			$("p input[type=checkbox]").attr("checked", true);
			check = true;
		}
		console.log(check);
	});
	// var ws = new WebSocket("ws://localhost:8888/MavenWeb/wsinit");
	var ws = new WebSocket("ws://192.168.8.19:7777/SpringWeb/simpleChat");

	ws.onopen = function() {
		var list_ok = connect_cre_list();
		if (!list_ok) {
			send_message("list");
		}
		$('#chatStatus').text('Info: connection opened.');
		$('input[name=chatInput]').on('keydown', function(evt) {
			if (evt.keyCode == 13) {
				var msg = $('input[name=chatInput]').val();
				send_message(msg);
				$('input[name=chatInput]').val('');
			}
		});
	};

	ws.onmessage = function(event) {
		var $console = $("#console");
		var json = JSON.parse(event.data);
		if (json.cmd == "list") {
			connect_cre_list();
		} else if (json.cmd == "msg") {
			$('#console').append("<span>" + json.msg + '</span><br>');
		}
		$console.scrollTop($console.prop("scrollHeight"));
	};

	ws.onclose = function(event) {
		$('#chatStatus').text('Info: connection closed.');
	};

	function send_message(msg) {
		var jsonStr;
		var obj = {};
		if (msg != '') {
			if (msg == "list") {
				obj.cmd = "list";
				// obj.nickArr = arr;
				jsonStr = JSON.stringify(obj);
			} else {
				var arr = [];
				$("#guestList p").find("input[type=checkbox]").each(function(idx) {
					if ($(this).is(":checked")) {
						arr.push($(this).parent().text());
						obj.cmd = "msg";
						obj.msg = user_id + " -> " + msg;
						obj.nickArr = arr;
						jsonStr = JSON.stringify(obj);
					}
				});
				$("#chat").val("");
			}
		}
		ws.send(jsonStr);
	}
});

function connect_cre_list() {
	$.ajax({
		type : "POST",
		url : "list",
		dataType : "json",
		success : function(obj) {
			view_write_list(obj);
		},
		complete : function(data) {// 응답이 종료되면 실행, 잘 사용하지않는다
		},
		error : function(xhr, status, error) {
			alert("ERROR!!!");
		}
	});
}

function view_write_list(obj) {
	for (var i = 0; i < obj.length; i++) {
		ok = false;

		$("#guestList").find("p").each(function(idx) {
			if ($(this).text() == obj[i]) {
				ok = true;
			}
		});
		if (!ok) {
			guestList.log("<input type=checkbox>" + obj[i]);
		}
	}

	return ok;
}

var guestList = {};

guestList.log = (function(id) {
	var $listBox = $("#guestList");
	$listBox.append("<p></p>");
	$listBox.find("p:last").html(id);
	$listBox.scrollTop($listBox.prop("scrollHeight"));
});