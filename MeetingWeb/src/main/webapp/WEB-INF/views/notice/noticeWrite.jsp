<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
input.title{width:720px;}

</style>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript">
function insert(){
	$.ajax({
		type:"get",
		url:"write",
		data:$('form').serialize(),	
		dataType:"json",
		success:function(data)
		{
			if(data.ok){
				alert("글이 성공적으로 등록되었습니다.");
				location.href="latelyRead";
			}else alert("글쓰기에 실패하였습니다.");				
		},
		complete:function(data)
		{			
		},
		error:function(xhr,status,error)
		{
			alert("글쓰기에 실패하였습니다.");
		}

		
	});
}

</script>

</head>
<body>
<form>
<table>
<caption>글 쓰기</caption>
<tr><th>제목</th><td><input type="text" name="title" class="title"></td></tr>
<tr><th>내용</th><td><textarea rows="40" cols="100" name="contents"></textarea></td></tr>
</table>
<button type="button" onclick="insert()">글쓰기</button> 
</form>
</body>
</html>