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
						<td colspan="3">${map.data.title}</td>
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
							<img src="../resources/images/${map.data.map_name }">
						</td>
					</tr>
				</table>
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
						<tr class="list">
							<td class="text-center">${reply.id }<input type="hidden" name="num" value="${reply.id }">
							</td>
							<td>${reply.contents }</td>
							<td class="list-btn">
								<button type="button" class="btn btn-success btn-sm">수정</button>
								<button type="button" class="btn btn-warning btn-sm">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
		function addReply(num) {
			$.ajax({
				url : "/NowMeetingWeb/meeting/reply",
				type : "post",
				data : {ref : num, contents : $("textarea[name=reply-contents]").val(), id : user_id},
				dataType : "json",
				success : function(obj){
					$(".list").empty();
					var tr = "<tr class='list'></tr>";
					for(var i = 0; i < obj.length; i++) {
						var data = obj[i];
						$(tr).appendTo("#contents-in-reply-list table").append("<td class='text-center'>"+data.id+"</td>").append("<td>"+data.contents+"</td>");
					}
				},
				error : function(error, xhr, status) {
					alert("ERROR");
				}
			});
		}
</script>
</html>