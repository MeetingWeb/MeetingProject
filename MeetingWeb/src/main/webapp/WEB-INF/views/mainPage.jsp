<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/style_comm.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	function joinsave() {
		var data = $('#joinform').serialize();
		alert(data);
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'join',
			data : data,
			success : function(evt) {
				if (evt.ok == true) {
					alert("성공");
				}
			},
			complete : function(data) {

			},
			error : function(xhr, status, error) {
				alert(error);
			}
		});

	}
</script>
</head>
<body>
	<jsp:include page="navi.jsp" />
	<jsp:include page="header.jsp" />
	<section id="contents">
		<div class="chat-btn">채팅방참여</div>
		<input type="hidden" name="_csrf" value="${_csrf.token }">
		<div id="login-form">
			<form name="loginForm">
				<div id="login-title">
					Enter <b>여기여기 붙어라</b>
				</div>
				<div id="info-group">
					<label>id</label>
					<input type="text" name="id">
					<label>password</label>
					<input type="password" name="pw">
					<div class="clear_f"></div>
				</div>

				<div id="login-btn-group">
					<div id="facebookLogin">FACEBOOK LOGIN</div>
					<div id="login-btn">LOGIN</div>
				</div>
			</form>
		</div>
		<form id="joinform">
			<table>
				<caption>join</caption>
				<tr>
					<td>ID</td>
					<td>
						<input type="text" name="id">
					</td>
				</tr>
				<tr>
					<td>PassWord</td>
					<td>
						<input type="password" name="pw">
					</td>
				</tr>
				<tr>
					<td>PassWordCheck</td>
					<td>
						<input type="password" name="pwc">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="name">
					</td>
				</tr>
				<tr>
					<td>E-mail</td>
					<td>
						<input type="text" name="email">
					</td>
				</tr>
				<tr>
					<td>관심분야</td>
					<td>
						<input type="checkbox" name="interests" value="exercise">
						운동
						<input type="checkbox" name="interests" value="travle">
						여행
						<input type="checkbox" name="interests" value="fishing">
						낚시
					</td>
				</tr>
			</table>
			<input type="hidden" name="power" value="user">
			<div onclick="javacript:joinsave()" style="cursor: pointer;">저 장</div>

		</form>
		<jsp:include page="chat_view.jsp" />
	</section>
	<div class="clear_f"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>