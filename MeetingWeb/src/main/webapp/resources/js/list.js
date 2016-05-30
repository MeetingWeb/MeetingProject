var tr;
$(function() {
	$(document).on("click", ".ename", function() {
		$(".job").empty();
		$(".dName").empty();
		$(".sal").empty();
		$(".hiredate").empty();
		$(".btn button").css("display", "none");
		var info = $(this).parent();
		$.ajax({
			type : "POST",
			url : "search",
			data : {
				no : info.find(".empno").text()
			},
			dataType : "json",
			success : function(obj) {
				info.find("td.job").text(obj.job);
				info.find("td.sal").text(obj.sal);
				info.find("td.dName").text(obj.dName);
				info.find("td.hiredate").text(obj.hiredate);
				info.find("td.btn button").css("display", "block");
			},
			complete : function(data) {

			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		});
	});

	$(document).on("click", ".update", function() {
		var top = (window.innerWidth/2 - $("#update-form").width());
		var left = (window.innerHeight/2 - $("#update-form").height());
		tr = $(this).parents().eq(1);

		var ename = tr.find(".ename").text();
		var empno = tr.find(".empno").text();
		var job = tr.find(".job").text();
		var dname = tr.find(".dName").text();
		var sal = tr.find(".sal").text();
		var hiredate = tr.find(".hiredate").text();

		$("#update-form-in .u-empno").html(empno + "<input type=hidden name=empno value=" + empno + ">");
		$("#update-form-in .u-ename").text(ename);
		$("#update-form-in .u-job input").val(job);
		$("#update-form-in .u-hiredate").text(hiredate);
		$("#update-form-in .u-dName").text(dname);
		$("#update-form-in .u-sal input").val(sal);

		$("#update-form").css({
			"display" : "block"
		});
		
		$("#wrap").css("opacity","0.2");

	});

	$(document).on("click", ".delete", function() {
		var $tr = $(this).parent().parent();
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type : "POST",
				url : "delete",
				dataType : "json",
				data : {
					no : $tr.find(".empno").text()
				},
				success : function(obj) {
					console.log(obj);

					if (obj.ok) {
						$tr.remove();
						alert("삭제 성공");
					} else {
						alert("수정 실패");
					}

				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			});
		}
	});

	$(".insert").on("click", function() {
		var top = (window.innerWidth / 2 - $("#insert-form").width());
		var left = (window.innerHeight  /2 - $("#insert-form").height());

		console.log($("#insert-form").width());
		$("#insert-form").css({
			"display" : "block"
		});
		
		$("#wrap").css("opacity","0.2");
	});

	$("#insert-btn").on(
			"click",
			function() {
				var form_data = $("#insert-form-data").serialize();
				$.ajax({
					type : "POST",
					url : "insert",
					data : form_data,
					dataType : "json",
					success : function(obj) {
						console.log(obj);

						if (obj != null) {
							alert("입력 성공");
							$("#insert-form").css("display", "none");

							var ename = "<td class=ename>" + obj.name + "</td>";
							var empno = "<td class=empno>" + obj.no + "</td>";
							var sal = "<td class=sal>" + obj.sal + "</td>";
							var dName = "<td class=dName>" + obj.dName + "</td>";
							var job = "<td class=job>" + obj.job + "</td>";
							var hiredate = "<td class=hiredate>" + obj.hiredate + "</td>";
							var $tr = "<tr></tr>"

							$("#list").prepend($tr);
							$("#list tr:first-child").append(empno);
							$("#list tr:first-child").append(ename);
							$("#list tr:first-child").append(job);
							$("#list tr:first-child").append(dName);
							$("#list tr:first-child").append(sal);
							$("#list tr:first-child").append(hiredate);
							$("#list tr:first-child").append(
									"<td class=btn><button style='display:block' class=update type=button>수정</button></td>");
							$("#list tr:first-child").append(
									"<td class=btn><button style='display:block' class=delete type=button>삭제</button></td>");

							var first = $("#list tr:first-child").html();
							var second = $("#list tr:nth-child(2)").html();

							$("#list tr:first-child").html(second);
							$("#list tr:nth-child(2)").html(first);
							
							$("#wrap").css("opacity","1");
						} else {
							alert("입력 실패");
						}

					},
					complete : function(data) {

					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				});
			});

	$("#update-btn").on("click", function() {
		$("#update-form").css("display", "none");
		var form_data = $("#update-form-data").serialize();
		$.ajax({
			type : "GET",
			url : "update",
			data : form_data,
			dataType : "json",
			success : function(obj) {
				console.log(obj);

				if (obj != null) {
					alert("수정 성공");
					tr.find("td.job").text(obj.job);
					tr.find("td.dName").text(obj.dName);
					tr.find("td.hiredate").text(obj.hiredate);
					tr.find("td.sal").text(obj.sal);
					
					$("#wrap").css("opacity","1");
				} else {
					alert("수정 실패");
				}

			},
			complete : function(data) {

			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		});
	});

	$("#cancle-btn").on("click", function() {
		$("#update-form").css("display", "none");
		$("#wrap").css("opacity","1");
	});

	$("#cancle-insert").on("click", function() {
		$("#insert-form").css("display", "none");
		$("#wrap").css("opacity","1");
	});

	function searchEmp(empno) {
		location.href = "search?no=" + empno;
	}
	
	function logout() {
		jQuery.ajax({
			type : "POST",
			url : "../login/logout",
			dataType : "json",
			success : function(obj) {
				var msg = null;
				if (!obj.ok) {
					msg = "로그아웃 실패";
					alert(msg);
				} else {
					msg = "로그아웃 성공";
					alert(msg);
					location.href="../login/form"
				}
			},
			complete : function(data) {
			},
			error : function(xhr, status, error) {
				alert("ERROR!!!");
			}
		});
	}
});

