<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
<%-- <script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script> --%>

<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDq3jxShghVhbdVBUvU1WoyLbJnNYxoCKA"></script> -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC9kEdjl_v9QToMmfVpM0U_I0BkBoNu7Hs&libraries=places"></script>

<title>여기여기 붙어라</title>
</head>
<body>
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents" class="contents">	
		<!-- <h1 class="center-block meeting-title"> MyLocation</h1>	 -->			
		<div id="view-map">
			
			<form action="#" onsubmit="searchMap(document.getElementById('address').value); return(false);">
				주소/건물：
				<input id="address" style="width: 400px;" type="text" value="">
				<!-- <input type="submit" value="검색"> -->
				<button type = "submit" class = "btn btn-success btn-xs" >
    			  검색
 				</button>
				<button type = "button" class = "btn btn-success btn-xs" onclick="setMyLocation()">
    			  해당위치로 변경
 				</button>
			</form>
			<div id="location-map" style="height: 100%; width: 100%;"></div>
		</div>
		<jsp:include page="include/loginForm.jsp" />
		<jsp:include page="include/joinForm.jsp" />
		<jsp:include page="include/chat_view.jsp" />
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<script type="text/javascript">
var myLoc = JSON.parse('${data}');
var lat = myLoc.latlng.split(",")[0];
var lng = myLoc.latlng.split(",")[1];
console.log(myLoc);
</script>
<script type="text/javascript" src="../resources/js/set_location.js"></script>
</html>