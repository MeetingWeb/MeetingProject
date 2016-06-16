<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/chat_style.css"/>'>
<script type="text/javascript">
	var user_id = "${sessionScope.id}";
</script>
<title>여기여기 붙어라</title>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<div id="chat-list-lid" class="pull-left">
			<div id="chat-list-lid-in">
				<span>CHAT LIST</span>
				<c:forEach var="info" items="${map }">
					<div class="chat-group">
						<span class="master">주최자 : ${info.master }</span>
						<div class="title">모임이름 : ${info.title}</div>
						<input type="hidden" class="master" value="${info.master }">
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="chat-lid pull-left">
			<div class="chat-lid-in">
				<div class="chat-lid-in-title"></div>
				<div class="chat-lid-in-console"></div>
				<div class="msg">
					<input type="text" name="msg">
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
<c:if test="${param.error==true }">
	<script type="text/javascript">
		alert("로그인 실패");
	</script>
</c:if>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
</html>
