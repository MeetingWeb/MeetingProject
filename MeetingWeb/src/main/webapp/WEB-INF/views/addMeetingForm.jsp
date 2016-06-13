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
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/addMeeting_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDq3jxShghVhbdVBUvU1WoyLbJnNYxoCKA"></script> -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC9kEdjl_v9QToMmfVpM0U_I0BkBoNu7Hs&libraries=places"></script>
<script>
	$(function() {
		$("#datepicker1, #datepicker2").datepicker({
			dateFormat : 'yy-mm-dd',
			prevText : '이전 달',
			nextText : '다음 달',
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			yearSuffix : '년'
		});
	});
	function insert() {
		/* var division = null;
		for ( var txt in mobileArr) {
			if (navigator.userAgent.match(mobileArr[txt]) != null) {
				division = $("input[name=division]").val("now");
				$.ajax({
					url : "/NowMeetingWeb/meeting/insert",
					type : "post",
					data : $("#add-meeting-form").serialize(),
					dataType : "json",
					success : function(obj) {
						if (obj.ok) {
							alert("모임 만들기 성공");
						} else {
							alert("모임 만들기 실패");
						}
					},
					error : function(xhr, error, status) {

					}
				});
				break;
			} else {
				division = $("input[name=division]").val("notnow");
				$.ajax({
					url : "/NowMeetingWeb/meeting/insert",
					type : "post",
					data : $("#add-meeting-form").serialize(),
					dataType : "json",
					success : function(obj) {
						if (obj.ok) {
							alert("모임 만들기 성공");
							location.href="/NowMeetingWeb/meeting/meetingView?num=0";
						} else {
							alert("모임 만들기 실패");
						}
					},
					error : function(xhr, error, status) {

					}
				});
				break;
			}
		} */
		
		$.ajax({
			url : "/NowMeetingWeb/meeting/insert",
			type : "post",
			data : $("#add-meeting-form").serialize(),
			dataType : "json",
			success : function(obj) {
				if (obj.ok) {
					alert("모임 만들기 성공");
					location.href="/NowMeetingWeb/web/chatForm";
				} else {
					alert("모임 만들기 실패");
				}
			},
			error : function(xhr, error, status) {

			}
		});
	}
</script>
<title>여기여기 붙어라</title>
</head>
<body>
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents" class="contents">
		<div id="meeting-form-background"></div>
		<div id="meeting-form-map"></div>
		<div id="meeting-form-lid" class="custom-model">
			<div class="custom-modal-dialog">
				<div class="custom-modal-content">
					<h1 class="center-block" id="meeting-form-title">CREATE MEETING</h1>
					<form class="form-horizontal" id="add-meeting-form">
						<div class="form-group">
							<label class="col-sm-2 control-label" id="title">Title</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="meeting-title" placeholder="제목" name="title">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Contents</label>
							<div class="col-sm-10">
								<textarea class="form-control" id="meeting-contents" rows="10" placeholder="내용" name="contents"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Division</label>
							<div class="col-sm-3">
								<select class="form-control" name="field">
									<option>농구</option>
									<option>야구</option>
									<option>축구</option>
									<option>족구</option>
									<option>배드민턴</option>
									<option>보드타기</option>
									<option>자전거타기</option>
									<option>술먹기</option>
									<option>동현이 죽빵 때리기</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Location</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id="meeting-location" placeholder="장소" name="locaion">
								<input type="hidden" name="area">
							</div>
							<div class="col-sm-2" style="width: 300px;">
								<button type="button" class="btn btn-default" id="set-location">Set Location</button>
								<button type="button" class="btn btn-default" id="set-location" onclick="roughMap(17)">Create Map</button>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Date</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="datepicker1" name='meetingDay' placeholder="모임 날짜 선택">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">StartTime</label>
							<div class="col-sm-2">
								<input type="time" class="form-control" name="s_time">
							</div>
							<label class="col-sm-2 control-label">EndTime</label>
							<div class="col-sm-2">
								<input type="time" class="form-control" name="e_time">
							</div>
						</div>
						<div class="fomr-group"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="button" class="btn btn-default" onclick="insert()">CREATE MEETING</button>
							</div>
						</div>
						<div id="rough-map-img">
							<img style="width: 100%; height: 100%;">
						</div>
						<input type="hidden" id="rough-map-data" name="imgData">
						<input type="hidden" id="division" name="division">
					</form>
				</div>
			</div>
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
		<div id="rough-map">
			<div id="rough-map-in">
				<input type="range" max="19" min="9" step="1" id="zoom-min" name="zoom-min" value="17" style="width: 200px;">
				<input type="number" value="17" id="zoom-num" max="19" min="9">
				<button id="rough-map-save-btn" type="button" onclick="roughMapSave()">Save</button>
				<img src="" id="rough-map-in-img">
				<canvas id="map-canvas" width="640" height="640"></canvas>
				<label for="zoom-min" style="color: #fff;">ZOOM:</label>
			</div>
		</div>
		<jsp:include page="include/loginForm.jsp" />
		<jsp:include page="include/joinForm.jsp" />
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	/* $(function() {
		$('#meeting-form-lid').modal({
			keyboard : true
		})
	}); */
</script>
<script type="text/javascript" src="../resources/js/set_location.js"></script>
</html>