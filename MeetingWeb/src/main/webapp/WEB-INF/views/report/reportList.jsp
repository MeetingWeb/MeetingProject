<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ǻ�� �Խ���</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>

<script type="text/javascript">
	function writeForm() {
		location.href = "./writeForm";
	}
</script>

</head>
<body>
	
	<h1 align="center">��ǻ�� �Խ���</h1>
	
	<table border="5" width="1125" align= "center">
		<tr>
			<th>�� ��ȣ</th><th>����</th><th>���̵�</th><th>�ۼ���</th>
		</tr>
		
		<c:forEach var="list" items="${listReport}">
		<tr>
			<td>${list.num}</td>
			<td>${list.title}</td>
			<td>${list.id}</td>
			<td>${list.cre_date}</td>
		</tr>
		</c:forEach>
	</table>
	
	<table align="center">
		<tr>
			<td>
				<button type="button" onclick="writeForm()">��ǻ�� ���</button>
			</td>
		</tr>
	</table>
	
</body>
</html>