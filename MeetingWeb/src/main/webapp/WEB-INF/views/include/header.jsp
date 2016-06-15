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

<div class="recommend">		
			<br>	
				<span id="recommend-more">
				<div class="glyphicon glyphicon-retweet menu-btn-icon"></div>				
				<a href='#none' onClick='getRecommend(); return false;'> 새로고침</a>
			</span>
			<div class="recommend-list"></div>
			<br>
			
		</div>

<<script type="text/javascript">
function getRecommend() {
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'getRecommend',
		success : function(data) {
			$('div.recommend-list').children().remove();
			var html = "";
			for (var i = 0; i < data.length; i++) {
				var loc = data[i].loc;
				var arr = loc.split(',');
				var meetinglat = Number(arr[0]);
				var meetinglng = Number(arr[1]);
				var distance = calcDistance(mylat, mylng, meetinglat, meetinglng);

				if (distance < 40) {
					if (((i != 0) && (data[i - 1].field != data[i].field)) || (i == 0)) {
						html += "<hr><table class='recommendTable'><caption><h4 class='recommendfield'>" + data[i].field + "<h4></caption>";
					}
					html += "<tr class='main'><td class='titletd'>" + data[i].title +
							 "</td><td class='buttontd'> <button type = 'button' class = 'btn btn-default btn-sm' onclick='showHere(" + meetinglat
							+ "," + meetinglng + ")'>모임 보기</button></td></tr><tr class='sub'><td class='titletd'>주최자:"+data[i].master+",  거리:"+distance+"km</td></tr>";
					if ((i == (data.length - 1)) || (data[i].field != data[i + 1].field)) {
						html += "</table>";
						$('div.recommend-list').append(html);
						html = "";
					}
				}
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



