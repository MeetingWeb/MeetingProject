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
				alert("���� ���������� ��ϵǾ����ϴ�.");
				location.href="latelyRead";
			}else alert("�۾��⿡ �����Ͽ����ϴ�.");				
		},
		complete:function(data)
		{			
		},
		error:function(xhr,status,error)
		{
			alert("�۾��⿡ �����Ͽ����ϴ�.");
		}

		
	});
}

</script>

</head>
<body>
<form>
<table>
<caption>�� ����</caption>
<tr><th>����</th><td><input type="text" name="title" class="title"></td></tr>
<tr><th>����</th><td><textarea rows="40" cols="100" name="contents"></textarea></td></tr>
</table>
<button type="button" onclick="insert()">�۾���</button> 
</form>
</body>
</html>