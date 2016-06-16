<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/addMeeting_style.css"/>'>
<title>여기여기 붙어라</title>
</head>
<body>
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents" class="contents">
		<div id="contents-in">
			<h2>예정된 모임 상세보기</h2>
			<div id="contents-in-board">
				<table class="table">
					<tr>
						<td>제목</td>
						<td colspan="3">${map.data.title}<input type="hidden" name="num" value="${map.data.num }">
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="3">${map.data.master }</td>
					</tr>
					<tr>
						<td>시작시간</td>
						<td>${map.data.start_time}</td>
						<td>종료시간</td>
						<td>${map.data.end_time}</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: left;">${map.data.contents}<br>
							<br>
							<br>
							<br>
							<br>
							<c:if test="${map.data.map_name != 'none' }">
								<img src="../resources/images/${map.data.map_name }">
							</c:if>
						</td>
					</tr>
				</table>
				<div class="pull-left" id="reply-btn" onclick="javascript:location.href='/NowMeetingWeb/meeting/notNowList'">LIST</div>
				<c:if test="${map.data.master == sessionScope.id }">
					<div class="pull-left" id="reply-btn" onclick="javascript:location.href='modifyForm?num=${map.data.num}'">MODIFY</div>
					<div class="pull-left" id="reply-btn">DELETE</div>
				</c:if>
			</div>
			<div id="contents-in-reply">
				<textarea class="form-control" rows="3" name="reply-contents"></textarea>
				<!-- <button class="btn btn-success pull-right" id="reply-btn" type="button">댓글달기</button> -->
				<div class="pull-right" id="reply-btn" onclick="addReply(${map.data.num})">REPLY</div>
			</div>
			<div id="contents-in-reply-list">
				<table class="table">
					<tr>
						<th style="width: 20%;">아이디</th>
						<th colspan="2">내용</th>
					</tr>
					<c:forEach var="reply" items="${map.reply }">
						<c:set var="replyid" value="${reply.id }" />
						<tr class="list">
							<td class="text-center" data-num="${reply.num}">${reply.id }
							</td>
							<td>${reply.contents }</td>
							<td class="list-btn">
								<c:if test="${reply.id == sessionScope.id }">
									<button type="button" class="btn btn-success btn-xs" name="modify" onclick="replyUpdate(${reply.num},${reply.ref })">수정</button>
									<button type="button" class="btn btn-warning btn-xs" onclick="replyDelete(${reply.num},${reply.ref })">삭제</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
				<nav>
					<ul class="pagination">
						<c:choose>
							<c:when test="${map.startPage > 5 }">
								<li class="pre">
									<span aria-hidden="true" onclick="replyNavi(${map.startPage-1})">&laquo;</span>
								</li>
							</c:when>
							<c:otherwise>
								<li class="pre" style="display: none;">
									<span aria-hidden="true">&laquo;</span>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="page" begin="${map.startPage }" end="${map.endPage }">
							<c:if test="${page <= map.maxPage }">
								<li class="navi-num">
									<span onclick="replyNavi(${page})">${page }</span>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${map.endPage <= map.maxPage }">
							<li class="next">
								<span>
									<span aria-hidden="true" onclick="replyNavi(${map.endPage+1})">&raquo;</span>
								</span>
							</li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	var totalPage = 1;
		function addReply(num) {
			$.ajax({
				url : "/NowMeetingWeb/meeting/reply",
				type : "post",
				data : {ref : num, contents : $("textarea[name=reply-contents]").val(), id : user_id},
				dataType : "json",
				success : function(obj){
					if(obj != null) {
						alert("댓글 작성 성공");
						creReplyList(obj);	
					}
				},
				error : function(error, xhr, status) {
					alert("ERROR");
				}
			});
		}
		
	function replyNavi(page) {
		console.log(page);
		$.ajax({
			url : "/NowMeetingWeb/meeting/replyNavi",
			type : "post",
			data : {page:page, ref : $("input[name=num]").val()},
			dataType : "json",
			success : function(obj){
				creReplyList(obj);
				totalPage = Number(page);
			},
			error : function(error, xhr, status) {
				alert("ERROR");
			}
		});
	}
	
	function replyDelete(num, ref) {
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				url : "/NowMeetingWeb/meeting/replyDelete",
				type : "post",
				data : {num : Number(num), ref : Number(ref), page : totalPage},
				dataType : "json",
				success : function(obj){
					creReplyList(obj);
				},
				error : function(error, xhr, status) {
					alert("ERROR");
				}
			});
		}
	}
	
	function replyUpdate(num, ref) {
		$(".list").each(function(idx) {
			if($(this).find("td:first-child").attr("data-num") == num) {
				var contents = $(this).find("td:nth-child(2)").text();
				$(this).find("td:nth-child(2)").html("<input class=form-control type=text name=contents value="+contents+">");
				$(this).find("td:nth-child(3)").find("button[name=modify]").text("완료").attr("name","save").attr("onclick","modify("+totalPage+","+num+","+ref+")");
			}
		});
	}
	
	function modify(page, num, ref) {
		var contents = null;
		$(".list").each(function(idx) {
			if($(this).find("td:first-child").attr("data-num") == num) {
				contents = $(this).find("td:nth-child(2) input").val();
			}
		});
		
		if(confirm("수정하시겠습니까?")) {
			$.ajax({
				url : "/NowMeetingWeb/meeting/replyUpdate",
				type : "post",
				data : {num : Number(num), ref : Number(ref), page : totalPage, contents : contents},
				dataType : "json",
				success : function(obj){
					creReplyList(obj);
				},
				error : function(error, xhr, status) {
					alert("ERROR");
				}
			});
		}
	}
	
	function creReplyList(obj) {
		$(".list").empty();
		var tr = "<tr class='list'></tr>";
		var endPage = obj[obj.length - 3];
		var startPage = obj[obj.length - 2];
		var maxPage = obj[obj.length - 1];
		for(var i = 0; i < obj.length; i++) {
			if(obj.length - 3 > i) {
				var data = obj[i];
				var id_td = "<td class='text-center' data-num="+data.num+">"+data.id+"</td>";
				var contents_td = "<td>"+data.contents+"</td>";
				var btn = "<button type=button class='btn btn-success btn-xs' name=modify onclick=replyUpdate("+data.num+","+data.ref+")>수정</button> <button type=button class='btn btn-warning btn-xs' onclick=replyDelete("+data.num+","+data.ref+")>삭제</button>";
				var btn_td = "<td class=list-btn></td>";
				if(user_id == data.id) {
					var td = $(btn_td).append(btn);
					$(tr).appendTo("#contents-in-reply-list table").append(id_td).append(contents_td).append(td);
				} else {
					$(tr).appendTo("#contents-in-reply-list table").append(id_td).append(contents_td).append(btn_td);
				}
			}
		}

		for(var j = startPage, i = 0; j <= maxPage; j++, i++) {
			$(".navi-num").eq(i).find("span").text(j).attr("onclick","replyNavi("+j+")");
		}
		
		if(endPage > maxPage) {
			$(".navi-num").eq(maxPage - 6).nextAll().css("display","none");
		} else {
			$(".navi-num").eq(maxPage - 6).nextAll().css("display","inline");
		}
		
		if(startPage > 1) {
			var page = startPage - 1;
			$(".pre").css("display","inline");
			$(".pre span").attr("onclick", "replyNavi("+page+")");
		} else {
			$(".pre").css("display","none");
		}
		
		
		/* 
			for(var i = 0; i < obj.length - 3; i++) {
			var data = obj[i];
			var btn = "<button type=button class='btn btn-success btn-xs'>수정</button><button type=button class='btn btn-warning btn-xs'>삭제</button>";
			$(".list").eq(i).find("td:nth-child(1)").html(data.id+"<input type=hidden name=num value="+data.num+">");
			$(".list").eq(i).find("td:nth-child(2)").html(data.contents);
			if(user_id == data.id) {
				$(".list").eq(i).find("td:nth-child(3)").html(btn);	
			} else {
				$(".list").eq(i).find("td:nth-child(3)").html();
			}
		} */
	}
</script>
</html>