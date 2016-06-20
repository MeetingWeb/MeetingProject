<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="login-form">
	<c:if test="${param.error==true }">
		<span>로그인 실패</span>
	</c:if>
	<form name="loginForm" action="<c:url value='/user/login' />" method="post">
		<input type="hidden" name="_csrf" value="${_csrf.token }">
		<div id="login-title">
			Enter <b>여기여기 붙어라</b>
		</div>
		<div id="info-group">
			<label>id</label>
			<input type="text" name="id" required>
			<label>password</label>
			<input type="password" name="pw" required>
			<div class="clear_f"></div>
		</div>

		<div id="login-btn-group">
			<div id="searchID" class="pull-left">SEARCH ID & PW</div>
			<div id="login-btn">LOGIN</div>
		</div>
	</form>
</div>