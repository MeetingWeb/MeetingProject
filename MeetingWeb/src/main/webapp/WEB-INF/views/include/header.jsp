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
	<div id="meeting-btn" class="hidden-sm hidden-xs">
		<div id="now-meeting" class="pull-right" onclick="javascript:location.href='/NowMeetingWeb/web/main'">실시간 모임</div>
		<div id="not-now-meeting" class="pull-right" onclick="javascript:location.href='/NowMeetingWeb/meeting/notNowList'">예정된 모임</div>
	</div>

	<div id="mobile-title-name" class="hidden-md hidden-lg">come together</div>
	<div class="glyphicon glyphicon-menu-hamburger hidden-md hidden-lg pull-right" id="m-menu-btn"></div>
</div>

<!-- Button trigger modal -->
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">

			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

						<h4 class="modal-title" id="myModalLabel">This Modal title</h4>
					</div>

					<div class="modal-body" id="myModalBody">Press ESC button to exit.</div>

					<div class="modal-footer">
						<input type="hidden" name="master">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

						<button type="button" class="btn btn-success" onclick="direction()">Directions</button>

						<button type="button" class="btn btn-success chat-btn">Participation in chat rooms</button>

						<button type="button" class="btn btn-success">Rough map</button>
					</div>

				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->

		</div>
		<!-- /.modal -->

		<div class="recommend">		
			<br>	
				<span id="recommend-more">
				<div class="glyphicon glyphicon-retweet menu-btn-icon"></div>				
				<a href='#none' onClick='getRecommend(); return false;'> 새로고침</a>
			</span>
			<div class="recommend-list"></div>
			<br>
			
		</div>



