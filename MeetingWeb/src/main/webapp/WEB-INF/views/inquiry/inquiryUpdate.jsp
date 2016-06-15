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

	
	
	function writesave() {

		var form = new FormData(document.getElementById('writeform')); 
		

		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'writesave',
			data : form,
			contentType: false,
			processData: false,
			success : function(evt) {
				if(evt.ok==true)
				{
					alert("저장 성공");
					location.href='lateread';
				}
				else if(evt.ok==false)
				{
					alert("저장실패");
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
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents" style="background-color: #fff">


<form id="updateform" enctype="multipart/form-data">
<table>
<caption>Inquiry</caption>
<tr style="border-top: 2px solid #333333;"><td id="wtitle">제목</td><td><input type="text" name="title" value="${ivo.title}"></td></tr>
<tr><td id="wcontents">내용</td><td><textarea cols="180" rows="20" name="contents">${ivo.contents }</textarea></td></tr>
<tr><td id="wfile">첨 부</td><td><input type="file" name="file" value="../resources/images/${ivo.img_name }"></td></tr>
여기 ${ivo.img_name }
</table>
<input type="hidden" name="id" value="${ivo.id }">
<input type="hidden" name="num" value="${ivo.num}">
<input type="hidden" name="img_name" value="null">
<div id="btns">
<a id="writebtn" onclick="javascript:writesave()" style="cursor: pointer;"><img src="/NowMeetingWeb/resources/images/write.png"></a>
<a id="listbtn" href='list?page=1&start=1&check=1' style="cursor: pointer; "><img src="/NowMeetingWeb/resources/images/list.png"></a>
</div>
</form>	



		<div class="recommend">		
			<br>	
				<span id="recommend-more">
				<div class="glyphicon glyphicon-retweet menu-btn-icon"></div>				
				<a href='#none' onClick='getRecommend(); return false;'> 새로고침</a>
			</span>
			<div class="recommend-list"></div>
			<br>
			
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
