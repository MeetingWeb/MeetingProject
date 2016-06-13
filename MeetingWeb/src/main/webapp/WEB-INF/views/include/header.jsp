<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div id="headernavi">
	<div id="title_name" class="hidden-sm hidden-xs">come together</div>
	<div id="buttonclass" class="hidden-sm hidden-xs">

		<sec:authorize access="! isAuthenticated()">
			<div id="loginbtn">
				<span>Login</span>
			</div>
			<div id="joinbtn">
				<span>join</span>
			</div>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<div id="logoutbtn">
				<span>Logout</span>
			</div>
			<div id="recommendbtn">
				<span>Recommend</span>
			</div>
			<div id="member-info-btn">
				<span class="glyphicon glyphicon-user"></span>
				<span id="member-id">
					<sec:authentication property="name" />
				</span>
				
			</div>
			
		</sec:authorize>
	</div>

	<div id="mobile-title-name" class="hidden-md hidden-lg">come together</div>
	<div class="glyphicon glyphicon-menu-hamburger hidden-md hidden-lg pull-right" id="m-menu-btn"></div>
</div>



