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
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/inquiry_style.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	
	$(function() {
		
		
		
		
		$('.list_huvor').hover(
				  function () {
				    $(this).css("background-color","#BDBDBD");
				  },
				  function () {
				    $(this).css("background-color","#fff");
				  }
				);
		
		
		var start = ${start};
		var end = ${start+4};
		var pages = ${ptotal};
		
		
		if(start==1)
		{
			$('a#left').css("opacity","0").prop("disabled", true);
		}
		if(end>pages)
		{
			$('a#right').css("opacity","0").prop("disabled", true);
		}


		$("#show_Infomation").css("height", $(window).height() - 64);

		if ("${sessionScope.id}" != "") {		
			drawMeetings(map);
			showMyLocation();			
			if("${requestScope.search}"=='ok')
			{
				$("#search-menu").css('display', 'block');	
			}
		}

	
	});
	
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents" style="background-color: #fff">


<table>
<caption>Inquiry</caption>
<tr><th id="snum">번호</th><th id="stitle">제목</th><th id="sid">작성자</th><th id="sday">작성일</th></tr>
<c:forEach var="list" items="${list}" >
<c:if test="${list.id == sessionScope.id || sessionScope.id == 'admin'}">
<tr class="list_huvor"><td id="tdnum">${list.num}</td><td id="tdtitle"><a href="readForm?num=${list.num}&page=1&start=1">${list.title}</a></td><td id="tdid">${list.id} </td><td id="tdday">${list.cre_date} </td></tr>
</c:if>
</c:forEach>

</table>

<c:set var="en" value="${start+4}"></c:set>
<c:if test="${ start+4 > ptotal}">
<c:set var="en" value="${ptotal}"></c:set>
</c:if>


<div id="btns">
<a id="writebtn" style="cursor: pointer;" href="writeForm"><img src="/NowMeetingWeb/resources/images/write.png"></a>
<a id="listbtn" href='list?page=1&start=1&check=1' style="cursor: pointer; "><img src="/NowMeetingWeb/resources/images/list.png"></a>
</div>


<div id="pageNavi">
<a id="left" onclick="location.href='list?page=${start-5}&start=${start-5}&check=${check}&serch=${serch}&select=${select}'" style="margin: auto 20px; cursor: pointer; text-decoration: none;"><<</a>
<c:forEach var="i" begin="${start}" end="${en}">
<a style="margin: auto 10px auto 10px; cursor: pointer; text-decoration: none;" href="list?page=${i}&start=${start}&check=${check}&serch=${serch}&select=${select}">${i}</a>
</c:forEach>
<a id="right" onclick="location.href='list?page=${start+5}&start=${start+5}&check=${check}&serch=${serch}&select=${select}'" style="margin: auto 20px; cursor: pointer; text-decoration: none;">>></a>
</div>






<div id="search_btn">
<form id="myForm" method="get">
<input type="hidden" name="page" value="1">
<input type="hidden" name="start" value="1">
<input type="hidden" name="check" value="2">
<input type="radio" name="select" value="제 목" checked="checked">제 목
<input type="radio" name="select" value="내 용">내 용
<input type="radio" name="select" value="작성자">작성자
<input type="text" name="serch">
<a onclick="document.getElementById('myForm').submit();" style="cursor: pointer; position: relative; left: -25px; top:-2px;"><img src="/NowMeetingWeb/resources/images/search_icon.png"></a>
</form>
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
		
		
		
		
		
		


					
</div> 
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
<c:if test="${param.error==true }">
	<script type="text/javascript">
		alert("로그인 실패");
	</script>
</c:if>
</html>
