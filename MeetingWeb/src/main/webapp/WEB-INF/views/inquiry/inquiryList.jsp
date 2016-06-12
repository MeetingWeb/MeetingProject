<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의하기 리스트</title>
<script type="text/javascript" src='http://code.jquery.com/jquery-2.2.2.min.js'></script>
<script type="text/javascript">

$(function(){
	var start = ${start};
	var end = ${start+4};
	var pages = ${ptotal};


	if(start==1)
	{
		$('button[name=left]').css("opacity","0").prop("disabled", true);
	}
	if(end>pages)
	{
		$('button[name=right]').css("opacity","0").prop("disabled", true);
	}
})

</script>
</head>
<body>

<table>
<caption>리스트</caption>
<tr><th>번호</th><th>제목</th><th>글쓴이</th><th>날짜</th></tr>
<c:forEach var="list" items="${list}" >
<tr><td>${list.num}</td><td><a href="readForm?num=${list.num}&page=1&start=1">${list.title}</a></td><td>${list.id} </td><td>${list.cre_date} </td></tr>
</c:forEach>

</table>

<c:set var="en" value="${start+4}"></c:set>
<c:if test="${ start+4 > ptotal}">
<c:set var="en" value="${ptotal}"></c:set>
</c:if>


<button type="button" name="left" onclick="location.href='list?page=${start-5}&start=${start-5}&check=${check}&serch=${serch}&select=${select}'"><<</button>
<c:forEach var="i" begin="${start}" end="${en}">
<a href="list?page=${i}&start=${start}&check=${check}&serch=${serch}&select=${select}">${i}</a>
</c:forEach>
<button type="button" name="right" onclick="location.href='list?page=${start+5}&start=${start+5}&check=${check}&serch=${serch}&select=${select}'">>></button>




<button type="button"  onclick="location.href='writeForm'">글 쓰 기</button>
<button type="button" onclick="location.href='list?page=1&start=1&check=1'">목 록</button>




<form method="get">
<input type="hidden" name="page" value="1">
<input type="hidden" name="start" value="1">
<input type="hidden" name="check" value="2">

<select name="select">
<option>제 목</option>
<option>내 용</option>
<option>작성자</option>

</select>
<input type="text" name="serch">
<button type="submit">확 인</button>
</form>


</body>
</html>