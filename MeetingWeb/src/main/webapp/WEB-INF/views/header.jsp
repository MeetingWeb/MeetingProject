<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div id="headernavi">
	<div id="title_name">here here stick</div>
	<div id="buttonclass">
		<sec:authorize access="! isAuthenticated()">
			<div id="loginbtn"><span>Login</span></div>
			<div id="joinbtn"><span>join</span></div>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<div id="logoutbtn"><span>Logout</span></div>
			<div id="member-info-btn"><span id="member-id"><sec:authentication property="name"/></span><span class="glyphicon glyphicon-user"></span></div>
		</sec:authorize>
	</div>
</div>


