<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='http://code.jquery.com/jquery-2.2.2.min.js'></script>
<%-- <script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
 --%>
<script type="text/javascript">






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
<form id="writeform" enctype="multipart/form-data">
<table>
<caption>문의하기 글쓰기</caption>
<tr><td>제목</td><td><input type="text" name="title"></td></tr>
<tr><td>내용</td><td><div><textarea cols="50" rows="20" name="contents"></textarea></div></td></tr>
</table>
<input type="file" name="file"><br>
<input type="hidden" name="id" value="asdasd">

<button type="button" onclick="javascript:writesave()">저장</button>
</form>
</body>
</html>
