<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/addMeeting_style.css"/>'>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALsCWQfq_e5wj4Dcna1ZR99Ik1fM0CXLo" async defer></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
</script>
</head>
<body>
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents">
		<div class="table-responsive" id="not-now-list">
			<h2>예정된 모임 리스트</h2>
			<table class="table table-hover">
				<tr>
					<th>글 번호</th>
					<th>분야</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>모임날짜</th>
					<th>모임장소</th>
				</tr>
				<c:forEach var="list" items="${map.list }">
					<tr class="not-now-list-btn">
						<td>${list.num }<input type="hidden" name="num" value="${list.num }">
						</td>
						<td>${list.field }</td>
						<td class="title">${list.title }</td>
						<td>${list.master }</td>
						<td>${list.start_time }</td>
						<td>${list.area }</td>
					</tr>
				</c:forEach>
			</table>
			<div>
				<select>
					<option>분야</option>
				</select>
				<input type="text">
			</div>
			<nav id="meeting-navi">
				<ul class="pagination">
					<c:if test="${map.page.startPage > 5 }">
						<li>
							<a href="#" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>
					<c:forEach var="page" begin="${map.page.startPage }" end="${map.page.endPage }">
						<c:if test="${page <= map.page.maxPage }">
							<li>
								<a href="#" onclick="navi(${page})">${page }</a>
							</li>
						</c:if>
					</c:forEach>
					<c:if test="${map.page.endPage <= map.page.maxPage }">
					<li>
						<a href="#" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
					</c:if>
				</ul>
			</nav>
		</div>
		<jsp:include page="include/loginForm.jsp" />
		<jsp:include page="include/joinForm.jsp" />
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<c:if test="${param.error==true }">
	<script type="text/javascript">
		alert("로그인 실패");
	</script>
</c:if>
<script type="text/javascript">
	function navi(page, status) {
		location.href = "/NowMeetingWeb/meeting/notNowList?page=" + page + "&status=" + status;
	}
</script>
</html>
