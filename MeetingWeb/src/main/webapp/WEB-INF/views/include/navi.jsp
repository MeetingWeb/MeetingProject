<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<section id="menu" class="hidden-sm hidden-xs">
	<div id="menu-in">
		<nav style="position: relative; z-index: 50; left: 0px; width: 64px;">
			<ul>
				<li id="logo">
					<div class="glyphicon glyphicon-record menu-btn-icon"></div>
				</li>
				<li id="menu-btn">
					<div class="glyphicon glyphicon-align-justify menu-btn-icon"></div>
				</li>
				<li id="home-btn">
					<div class="glyphicon glyphicon-th menu-btn-icon"></div>
					<div class="menu-btn-name" style="background: #33B573">
						<a href="/NowMeetingWeb/web/main">HOME</a>
					</div>
				</li>
				<sec:authorize access="hasAuthority('MEMBER') || hasAuthority('ADMIN')">
					<li>
						<div class="glyphicon glyphicon-plus menu-btn-icon"></div>
						<div class="menu-btn-name">
							<a href="/NowMeetingWeb/web/addForm">MEETING</a>
						</div>
					</li>
				</sec:authorize>
				<sec:authorize access="hasAuthority('MASTER')">
					<li onclick="javascript:alert('개설할 수 있는 모임은 한정 되어있습니다.')">
						<div class="glyphicon glyphicon-plus menu-btn-icon"></div>
						<div class="menu-btn-name">
							<a href="#">MEETING</a>
						</div>
					</li>
				</sec:authorize>
				<li>
					<div class="glyphicon glyphicon-list-alt menu-btn-icon"></div>
					<div class="menu-btn-name">
						<a href="/NowMeetingWeb/notice/getList">NOTICE</a>
					</div>
					<div class="menu-btn-name">
						<a href="/NowMeetingWeb/reviews/list">REVIEWS</a>
					</div>
				</li>
				<li>
					<div class="glyphicon glyphicon-phone-alt menu-btn-icon"></div>
					<div class="menu-btn-name">
						<a href="/NowMeetingWeb/Inquiry/list">INQUIRY</a>
					</div>
				</li>
				<li id="message-btn">
					<div class="glyphicon glyphicon-envelope menu-btn-icon" style="width: 100%;">
						<span class="badge" style="position: absolute; top: -10px; left: 35px; display: none;">0</span>
					</div>
					<div class="menu-btn-name">
						<a href="/NowMeetingWeb/web/chatForm">MESSAGE</a>
					</div>
				</li>
				<li>
			<div id="search-btn" class="glyphicon glyphicon-search menu-btn-icon"></div>
					<div class="menu-btn-name" id="search-btn-name">
						<a href="#">SEARCH</a>
					</div>
				</li>
				<li>
					<div id="mylocation-btn" class="glyphicon glyphicon-flag menu-btn-icon"></div>
					<div class="menu-btn-name" id="myLocation-btn-name">
						<a href="#">내위치</a>
					</div>
				</li>
				<sec:authorize access="hasAuthority('ADMIN')">
				<li>
					<div id="mylocation-btn" class="glyphicon glyphicon-cog menu-btn-icon"></div>
					<div class="menu-btn-name" id="myLocation-btn-name">
						<a href="/NowMeetingWeb/web/blackList">블랙리스트</a>
					</div>
				</li>
				</sec:authorize>
			</ul>
		</nav>
	</div>
</section>
<div id="m-menu">
	<nav>
		<ul>
			<li>
				<a href="/NowMeetingWeb/web/main">HOME</a>
			</li>
			<li>
				<a href="/NowMeetingWeb/web/mobileLogin">LOGIN</a>
			</li>
			<li>
				<a href="/NowMeetingWeb/web/addForm">MEETING</a>
			</li>
			<li>
				<a href="/NowMeetingWeb/web/chatForm">CHAT</a>
			</li>
			<li>
				<a href="/NowMeetingWeb/reviews/list">REVIWS</a>
			</li>
		</ul>
	</nav>
</div>