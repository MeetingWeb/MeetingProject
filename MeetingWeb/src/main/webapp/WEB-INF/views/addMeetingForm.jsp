<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/style_comm.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<%-- <script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script> --%>
<script type="text/javascript" src='<c:url value="/resources/js/map.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/addMeeting_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
</script>
</head>
<body>
	<jsp:include page="navi.jsp" />
	<jsp:include page="header.jsp" />
	<section id="contents">
		<div id="meeting-form-background"></div>
		<div id="meeting-form-map"></div>
		<div id="meeting-form-lid">
			<form name="addMeetingForm">
				<div id="meeting-form-lid-in">
					<div id="meeting-form-lid-in-top">
						<span>COME TOGETHER</span>
					</div>
					<h1>CREATE MEETING</h1>
				</div>
			</form>
		</div>
		<jsp:include page="loginForm.jsp" />
		<jsp:include page="joinForm.jsp" />
		<jsp:include page="chat_view.jsp" />
	</section>
	<jsp:include page="footer.jsp" />
</body>
</html>