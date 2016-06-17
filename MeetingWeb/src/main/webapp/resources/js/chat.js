var check;
var master;
var messageNum = 0;
$(function() {
	$(document).on("click touchstart",".chat-group", function(){
		$(".chat-group").css("background","#ddd");
		$(this).css("background","#fff");
		master = $(this).find("input[type=hidden]").val();
		$(".chat-lid-in-title").text($(this).find(".title").text().substring(6));
		$(".chat-lid-in-console").empty();
	});
	
	// var ws = new WebSocket("ws://localhost:8888/MavenWeb/wsinit");
	var ws = new WebSocket("ws://192.168.8.19:7777/NowMeetingWeb/chat");

	ws.onopen = function() {
		/*var list_ok = connect_cre_list();
		if (!list_ok) {
			send_message("list");
		}*/
		$(".chat-lid-in-console").append("<span>접속</span><br>");
		$('#chatStatus').text('Info: connection opened.');
		$(document).on('keydown',".msg input[name=msg]" ,function(evt) {
			if (evt.keyCode == 13) {
				var msg = $('input[name=msg]').val();
				send_message(msg);
				$('input[name=msg]').val('');
			}
		});
	};

	ws.onmessage = function(event) {
		var $console = $(".chat-lid-in-console");
		var json = JSON.parse(event.data);
		
		if(master == json.master) {
			if(json.sender == user_id) {
				$(".chat-lid-in-console").append('<span class="user-msg mine">'+ json.sender+" -> " + json.msg + '</span><br>');
				
			} else {
				$(".chat-lid-in-console").append('<span class=user-msg>'+ json.sender+" -> " + json.msg + '</span><br>');
			}
			console.log(json.userList);
		}
		
		if(location.pathname != "/NowMeetingWeb/web/chatForm") {
			$("#menu-in ul #message-btn .badge").css("display","block");
			$("#menu-in ul #message-btn .badge").text(++messageNum);
		}
		
		$console.scrollTop($console.prop("scrollHeight"));
	};

	ws.onclose = function(event) {
		$('.chat-lid-in-console').text('Info: connection closed.');
	};

	function send_message(msg) {
		var jsonStr;
		var obj = {};
		/*if (msg != '') {
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
		}*/
		obj.msg = msg;
		obj.sender = user_id;
		obj.master = master;
		jsonStr = JSON.stringify(obj);
		ws.send(jsonStr);
	}
	
	 
	$("#contents .chat-btn").on("click", function() {
		var master = $(".modal-footer input[name=master]").val();
		var title =$("#myModalLabel").text();
		console.log("방장 -> " + master);
		console.log("방장 -> " + user_id);
		console.log(title);
		$.ajax({
			url : "/NowMeetingWeb/meeting/chatInsert",
			type : "post",
			data :{member : user_id, master : master, title : title},
			dataType : "json",
			success : function(obj){
				location.href = "/NowMeetingWeb/web/chatForm";
			},
			error : function(error, xhr, status) {
				alert("권한이 없습니다.");
			}
		});
		
		/*$(".close").trigger("click");
		var name = $(".modal-footer").find("input[type=hidden]").val();
		var c_btn = "<div class=chat-view-btn></div>";
		var c_div = "<div class=chat-lid-in><div class=chat-lid-in-title>" + name + "</div></div>";
		var c_width = $(".chat-lid").height();
		var c_console = "<div class=chat-lid-in-console></div>";
		var c_input = "<div class=msg><input type=text name=msg></div>";
		
		 * $(c_div).append(c_title); $(".chat-lid").append(c_div);
		 
		$(c_div).appendTo(".chat-lid");
		$(c_btn).appendTo(".chat-lid");

		$(".chat-lid").css({
			"display" : "block",
			"top" : window.innerHeight - c_width
		});
		$(".chat-lid-in").append(c_console);
		$(".chat-lid-in").append(c_input);

		$(".chat-lid-in").each(function(idx) {
			if (name == $(this).find(".chat-lid-in-title").text()) {
				$(this).append(c_input);
			}
		});*/
	});

	/*$("#contents .chat-view-btn").on("click", function() {
		$(".chat-lid").css("overflow", "visible");
		$(".chat-lid-in").animate({
			top : -310
		});
	});
	var bool = false;
	$(document).on("click", ".chat-lid-in-title", function() {
		if (bool == false) {
			$(this).parent().animate({
				top : 0,
				width : 200
			});
			bool = true;
		} else {
			$(this).parent().animate({
				top : -310,
				width : 280
			});
			bool = false;
		}
	});*/
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