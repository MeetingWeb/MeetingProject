<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<li>
					<div class="glyphicon glyphicon-plus menu-btn-icon"></div>
					<div class="menu-btn-name">
						<a href="/NowMeetingWeb/web/addForm">MEETING</a>
					</div>
				</li>
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
					<div class="menu-btn-name"><a href="/NowMeetingWeb/Inquiry/list">INQUIRY</a></div>
					<div class="menu-btn-name"><a href="#">USE</a></div>
				</li>
			</ul>
		</nav>
	</div>
</section>
<div id="m-menu">
	<nav style="width: 100%; height: 100%;">
		<ul>
			<li>HOME</li>
			<li>MEETING ADD</li>
			<li>NOTICE</li>
			<li>REVIEWS</li>
			<li>INQUIRY</li>
		</ul>
	</nav>
</div>