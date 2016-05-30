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
<title>여기여기 붙어라</title>
</head>
<body>
	<jsp:include page="navi.jsp" />
	<jsp:include page="header.jsp" />
	<section id="contents">
		<div class="chat-btn">채팅방참여</div>
		<form id="loginform">
			<table id="logintable">
				<caption>Enter 여기여기 붙어라</caption>
				<tr>
					<td>ID</td>
					<td>
						<input type="text" size="30px" style="height: 30px;">
					</td>
					<td>
						<a href="#">
							FORGOT
							<br>
							ID?
						</a>
					</td>
				</tr>
				<tr>
					<td>PASSWORD</td>
					<td>
						<input type="password" size="30px" style="height: 30px;">
					</td>
					<td>
						<a href="#">
							FORGOT
							<br>
							PASSWORD?
						</a>
					</td>
				</tr>
			</table>

			<div id="logingroup">
				<div id="facebookLogin">FACEBOOK LOGIN</div>
				<div id="sign_In">SIGN IN</div>
			</div>

		</form>
		<form id="joinform"></form>
		<jsp:include page="chat_view.jsp" />
	</section>
	<div class="clear_f"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>