<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript">

function search(){
	location.href="searchList?key="+$('input.key').val();	
}
function allList(){
	location.href="getList";
}


</script>
</head>
<body>
<table>
<tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th></tr>
<c:forEach var="list" items="${ map.list }">
<tr><td>${ list.num }</td><td><a href="read?num=${ list.num }">${ list.title }</a></td><td>${ list.id }</td><td>${ list.cre_date }</td><td>${ list.hit }</td></tr>
</c:forEach>
</table>

<c:choose>
<c:when test="${map.condition eq 'normal'}">     
<c:if test= "${ map.page.currPage > 3 }">
<a href="getPage?page=${ map.page.startPage-1 }">PREV</a>
</c:if>
</c:when>
<c:when test="${map.condition eq 'search'}">     
<c:if test= "${ map.page.currPage > 3 }">
<a href="searchPage?key=${ map.key }&page=${ map.page.startPage-1 }">PREV</a>
</c:if>
</c:when>
</c:choose>


<c:choose>
<c:when test="${map.condition eq 'normal'}">       
<c:forEach var="no" begin="${ map.page.startPage }" end="${ map.page.endPage }" >
<c:if test= "${ no <= map.page.totalPage }">
<a href="getPage?page=${ no }">${ no }</a>
</c:if>
</c:forEach>
</c:when>
<c:when test="${map.condition eq 'search'}">       
<c:forEach var="no" begin="${ map.page.startPage }" end="${ map.page.endPage }" >
<c:if test= "${ no <= map.page.totalPage }">
<a href="searchPage?key=${ map.key }&page=${ no }">${ no }</a>
</c:if>
</c:forEach>
</c:when>
</c:choose>


<c:choose>
<c:when test="${map.condition eq 'normal'}">     
<c:if test= "${ map.page.endPage < map.page.totalPage }" >
<a href="getPage?page=${ map.page.endPage+1 }">NEXT</a>
</c:if>
</c:when>
<c:when test="${map.condition eq 'search'}">     
<c:if test= "${ map.page.endPage < map.page.totalPage }" >
<a href="searchPage?key=${ map.key }&page=${ map.page.endPage+1 }">NEXT</a>
</c:if>
</c:when>
</c:choose>


<input type="text" class="key"><button type="button" onclick="search()">검색</button>
<button type="button" onclick="allList()">전체보기</button>

</body>
</html>