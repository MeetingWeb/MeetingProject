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
function modify(){	
	
	$.ajax({		
		type:"get",
		url:"modify",
		data:
		{
			num:${data.num},
			title:$('input.title').val(),
			contents:$('textarea.contents').val()
		},
		dataType:"json",
		success:function(data)
		{
			if(data.ok){
				alert("글이 성공적으로 수정되었습니다.");
				location.href="latelyRead";
			} else alert("글 수정에 실패하였습니다.");			
		},
		complete:function(data)
		{			
		},
		error:function(xhr,status,error)
		{
			alert("글 수정에 실패하였습니다.");
		}
		
	}); 	
}

</script>
</head>
<body>
<form>
<table>
<caption>글 수정</caption>
<tr><th>번호</th><td>${ data.num }</td></tr>
<tr><th>제목</th><td><input type="text" class="title" value=${ data.title }></td></tr>
<tr><th>글쓴이</th><td>${ data.id }</td></tr>
<tr><th>날짜</th><td>${ data.cre_date }</td></tr>
<tr><th>내용</th><td><textarea rows="40" cols="100" class="contents">${ data.contents }</textarea></td></tr>
</table>
<button type="button" onclick="modify()">수정</button>
<button type="button" type="reset">취소</button>
</table>
</form>
</body>
</html>