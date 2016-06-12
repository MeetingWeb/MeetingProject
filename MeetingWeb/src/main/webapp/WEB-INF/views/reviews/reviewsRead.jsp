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
<title>여기여기 붙어라</title>
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';
function del(num) {
	if(confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			url:"delete",
			data:{num : num},
			dataType: "json",
			type:"post",
			success : function(obj){
				if(obj.ok) {
					alert("삭제 성공");
					location.href="list";
				} else {
					alert("삭제 실패");
				}
					
			}
		});
	}
}
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<table>
			<caption>글 읽기</caption>
			<tr>
				<th>번호</th>
				<td>${ data.num }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${ data.title }</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>${ data.id }</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${ data.cre_date }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${ data.contents }</td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><img src="../resources/images/${data.mod_file_name }"></td>
			</tr>
		</table>
		<button type="button" onclick="javascript:location.href='list'">목록</button>
		<button type="button" onclick="modify()">수정</button>
		<button type="button" onclick="del(${data.num})">삭제</button>
		<br>
		<br>
		<br>

		<div class="replyForm">
			<textarea class="reply" rows="10" cols="40"></textarea>
			<br>
			<button type="button" onclick="replyWrite()">글쓰기</button>
			<br>
			<br>
		</div>

		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
		<jsp:include page="../include/chat_view.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>