<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<style type="text/css">
</style>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/map.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALsCWQfq_e5wj4Dcna1ZR99Ik1fM0CXLo&callback=initMap" async defer></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	$(function() {
		$('#myModal').modal({
			keyboard : true,
			backdrop : false
		});
		/* if ("${sessionScope.id}" != "") {		
			drawMeetings(map);
			showMyLocation();
		} */
	})

	function myLocation() {
		location.href = "myLocation";
	}
	function main() {
		location.href = "main";
	}
</script>
</head>
<body>
	<sec:authorize access="isAuthenticated()">


		<jsp:include page="include/navi.jsp" />
		<jsp:include page="include/header.jsp" />
		<section id="contents">
			<div id="map" style="width: 100%; height: 100%;"></div>
			<jsp:include page="include/loginForm.jsp" />
			<jsp:include page="include/joinForm.jsp" />
			<jsp:include page="include/chat_view.jsp" />
		</section>
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display: block; background: rgba(0, 0, 0, 0.6);">

			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 50%">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						<h4 class="modal-title" id="myModalLabel">Welcome to COME TOGETHER</h4>
					</div>
					<div class="modal-body" id="myModalBody">
						내 위치를 다시 지정하시겠습니까?
						</br>
						정확한 위치가 지정되어있지 않으면 정확한 서비스를 제공받으실 수 없습니다.
						<br>
						다시 지정하지 않으실꺼면 [ 예전 위치에서 시작하기 ] 버튼을 눌러주세요.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-success chat-btn" style="width: 100%; height: 50px;" onclick="myLocation()">내 위치 다시 지정하기</button>
						<button type="button" class="btn btn-success chat-btn" style="width: 100%; height: 50px; margin: 10px 0px 0px 0px" onclick="main()">예전 위치에서 시작하기</button>
					</div>

				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->

		</div>
		<!-- /.modal -->
		<jsp:include page="include/footer.jsp" />
	</sec:authorize>
</body>

</html>
