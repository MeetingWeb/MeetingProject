<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div id="headernavi" class="container-fulid">
	<div id="title_name">come together</div>
	<div id="buttonclass" class="hidden-sm hidden-xs">
		
		<sec:authorize access="! isAuthenticated()">
			<div id="loginbtn"><span>Login</span></div>
			<div id="joinbtn"><span>join</span></div>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<div id="logoutbtn"><span>Logout</span></div>
			<div id="member-info-btn"><span id="member-id"><sec:authentication property="name"/></span><span class="glyphicon glyphicon-user"></span></div>
		</sec:authorize>
		<div id="client-req-btn">CENTER</div>
	</div>
	<div class="glyphicon glyphicon-align-justify hidden-md hidden-lg pull-right" id="m-menu-btn"></div>
</div>


