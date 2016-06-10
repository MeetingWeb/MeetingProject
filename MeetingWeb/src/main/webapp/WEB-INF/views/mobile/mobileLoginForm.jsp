<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
<title>COME TOGETHER</title>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<div id="mobile-login-form">
		<form name="loginForm" action="<c:url value='/user/login' />" method="post" class="form-horizontal">
			<input type="hidden" name="_csrf" value="${_csrf.token }">
			<div id="login-title">
				Enter <b>COME TOGETHER</b>
			</div>
			<div class="form-group" id="info-group">
				<label class="col-sm-2 control-label">id</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="meeting-title" placeholder="아이디" name="id">
				</div>
				<label class="col-sm-2 control-label">password</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="meeting-title" placeholder="비밀번호" name="pw">
				</div>
			</div>
			<!-- <div id="info-group">
				<label class="col-sm-2 control-label">id</label>
				<input type="text" name="id" class="col-sm-10">
				<label class="col-sm-2 control-label">password</label>
				<input type="password" name="pw" class="col-sm-10">
				<div class="clear_f"></div>
			</div> -->

			<div id="login-btn-group">
				<div id="facebookLogin" class="col-sm-6">FACEBOOK LOGIN</div>
				<div id="login-btn" class="col-sm-6">LOGIN</div>
			</div>
		</form>
	</div>
</body>
</html>