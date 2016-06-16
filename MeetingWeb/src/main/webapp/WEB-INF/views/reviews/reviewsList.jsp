<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/reviews_style.css"/>'>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	var page = 2;
	function moreList() {
		$.ajax({
			url : "/NowMeetingWeb/reviews/moreList",
			data : {
				page : page
			},
			dataType : "json",
			type : "post",
			success : function(obj) {
				creList(obj);
				var maxPage = obj[obj.length-1];
				if(page > maxPage) {
					$("#more-btn-in").attr("class","glyphicon glyphicon-chevron-up");
					$("#more-btn").attr("onclick","resetList()")
				}
			},
			error : function(error, xhr, status) {
				alert("ERROR");
			}
		});
		page++;
	}

	function creList(obj) {
		for (var i = 0; i < obj.length - 1; i++) {
			var data = obj[i];
			var colDiv = "<div class='col-sm-4 col-md-3'></div>";
			var tumbDiv = "<div class='thumbnail img-box' data-num="+data.num+"></div>";
			var imgDiv = "<div class='reviews-img' style='background:url(../resources/images/" + data.fileName
					+ "); background-size: cover; background-position: center;'></div>";
			var capDiv = "<div class=caption><h3>" + data.title
					+ "</h3><p><a href='#' class='btn btn-primary' role='button'>VIEW DETAIL</a></p></div>";
			var preDiv = $(tumbDiv).append(imgDiv).append(capDiv);
			$(colDiv).appendTo("#list-box-in").append(preDiv);
		}
	}
	
	function resetList() {
		$.ajax({
			url : "/NowMeetingWeb/reviews/moreList",
			data : {
				page : 1
			},
			dataType : "json",
			type : "post",
			success : function(obj) {
				$("#list-box-in").empty();
				creList(obj);
				$("#more-btn-in").attr("class","glyphicon glyphicon-chevron-down");
				$("#more-btn").attr("onclick","moreList()");
				page = 2;
				
			},
			error : function(error, xhr, status) {
				alert("ERROR");
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents" style="overflow: visible">
		<div class="container-fluid">
			<h2 style="margin-left: 18px; margin-right: 18px; margin-top: 82px; border-bottom: 2px solid #ccc;">REVIEWS</h2>
			<div id="reviews-write">
				<a href="#" onclick="javascript:location.href='writeForm'" class="">WRITE</a>
			</div>
			<div id="list-box" class="row">
				<div id="list-box-in">
					<c:forEach var="list" items="${list }">

						<div class="col-sm-4 col-md-3">
							<div class="thumbnail img-box" data-num="${list.num }">
								<%-- <img src="../resources/images/${list.mod_file_name }" alt="..." class="img-responsive reviews-img"> --%>
								<div class="reviews-img" style="background:url(../resources/images/${list.mod_file_name }); background-size: cover; background-position: center;"></div>
								<div class="caption">
									<h3>${list.title }</h3>
									<p>
										<a href="#" class="btn btn-primary" role="button">VIEW DETAIL</a>
									</p>
								</div>
							</div>
						</div>

					</c:forEach>
				</div>
				<div class="clear_f"></div>
				<div id="more-btn-box">
					<div id="more-btn" onclick="moreList()">
						<div id="more-btn-in" class="glyphicon glyphicon-chevron-down"></div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>