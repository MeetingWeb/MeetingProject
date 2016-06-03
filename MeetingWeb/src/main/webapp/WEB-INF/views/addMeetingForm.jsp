<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<%-- <script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script> --%>

<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/addMeeting_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDq3jxShghVhbdVBUvU1WoyLbJnNYxoCKA"></script> -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC9kEdjl_v9QToMmfVpM0U_I0BkBoNu7Hs&libraries=places"></script>

<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	//google.maps.event.addDomListener(window, "load", initialize);
</script>
</head>
<body>
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents" class="contents">
		<div id="meeting-form-background"></div>
		<div id="meeting-form-map"></div>
		<div id="meeting-form-lid">
			<h1 class="center-block meeting-title">CREATE MEETING</h1>
			<form class="form-horizontal" id="add-meeting-form">
				<div class="form-group">
					<label for="inputEmail3" class="col-sm-2 control-label" id="title">Title</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="meeting-title" placeholder="제목" name="title">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword3" class="col-sm-2 control-label">Contents</label>
					<div class="col-sm-10">
						<textarea class="form-control" id="meeting-contents" rows="10" placeholder="내용"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword3" class="col-sm-2 control-label">Location</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="meeting-location" placeholder="장소" name="location">
						<input type="hidden" name="address">
					</div>
					<div class="col-sm-offset-2 col-sm-10" style="width: 300px;">
						<button type="button" class="btn btn-default" id="set-location">Set Location</button>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">CREATE MEETING</button>
					</div>
				</div>
			</form>
		</div>
		<div id="view-map">
			<button type="button" class="close" aria-label="Close" id="close">
				<span aria-hidden="true">&times;</span>
			</button>
			<form action="#" onsubmit="searchMap(document.getElementById('address').value); return(false);">
				주소/건물：
				<input id="address" style="width: 400px;" type="text" value="">
				<input type="submit" value="검색">
				<button type="button" onclick="adrSave()">저장</button>
			</form>
			<div id="location-map" style="height: 100%; width: 100%;"></div>
		</div>
		<jsp:include page="include/loginForm.jsp" />
		<jsp:include page="include/joinForm.jsp" />
		<jsp:include page="include/chat_view.jsp" />
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<script type="text/javascript" src="../resources/js/set_location.js"></script>
</html>