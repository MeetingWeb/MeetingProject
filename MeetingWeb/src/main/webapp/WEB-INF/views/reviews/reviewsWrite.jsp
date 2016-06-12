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
<script type="text/javascript" src='<c:url value="/resources/js/map.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<title>여기여기 붙어라</title>
<style type="text/css">
input.title {
	width: 720px;
}
</style>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';

	function insert() {
		var form = new FormData(document.getElementById('insertForm'));
		$.ajax({
			url : "insert",
			type : "post",
			data : form,
			processData: false,
            contentType: false,
			dataType : "text",
			success : function(obj) {
				var json = JSON.parse(obj);
				if(json.ok) {
					alert("글쓰기 성공");
					location.href="selectOne?num=0";
				} else {
					alert("글쓰기 실패");
				}
			},
			complete : function(data) {
			},
			error : function(xhr, status, error) {
				alert("글쓰기에 실패하였습니다.");
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<form enctype="multipart/form-data" name="insert-form" id="insertForm">
			<table>
				<caption>글 쓰기</caption>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" class="title">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="40" cols="100" name="contents"></textarea>
					</td>
				</tr>
			</table>
			<div class="form-group">
				<label for="inputfile">File input</label>
				<input type="file" id="inputfile" name="file">
			</div>
			<button type="button" onclick="insert()">글쓰기</button>
			<button type="button" onclick="javascript:location.href='list'">취소</button>
		</form>
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
		<jsp:include page="../include/chat_view.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>
