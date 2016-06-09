<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='http://code.jquery.com/jquery-2.2.2.min.js'></script>
<%-- <script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
 --%>
<script type="text/javascript">

function writesave() {
	var data = $('#updateform').serialize();
	alert(data);
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'updates',
		data : data,
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
<form id="updateform">
<table>
<caption>문의하기 수정</caption>
<tr><td>제목</td><td><input type="text" name="title" value="${ivo.title}"></td></tr>
<tr><td>내용</td><td><textarea cols="50" rows="20" name="contents">${ivo.contents }</textarea></td></tr>
</table>
<input type="hidden" name="id" value="${ivo.id }">
<input type="hidden" name="num" value="${ivo.num}">
<input type="hidden" name="img_name" value="null">
<button type="button" onclick="javascript:writesave()">저장</button>
</form>
</body>
</html>
