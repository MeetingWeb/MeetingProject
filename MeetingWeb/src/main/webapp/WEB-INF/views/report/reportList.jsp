<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사건사고 게시판</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>

<script type="text/javascript">
	function writeForm() {
		location.href = "./reportForm";
	}
	
	function searchCheck() {
		if(search.keyword.value == "") {
			alert("검색할 단어를 입력하세요.");
			search.keyword.focus();
			return;
		}
		search.submit();
	}
</script>

</head>
<body>
	
	<h1 align="center">사건사고 게시판</h1>
	
	<table border="5" width="1125" align= "center">
		<tr>
			<th>글 번호</th><th>제목</th><th>아이디</th><th>작성일</th>
		</tr>
		
		<c:forEach var="list" items="${listReport}">
		<tr>
			<td>${list.num}</td>
			<td><a href="reportInfo?num=${list.num}">${list.title}</a></td>
			<td>${list.id}</td>
			<td>${list.cre_date}</td>
		</tr>
		</c:forEach>
	</table>
	
	<table align="center">
		<tr>
			<td>
				<button type="button" onclick="writeForm()">사건사고 등록</button>
			</td>
		</tr>
		<tr>
			<!-- 페이징 -->
			<c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
				<c:if test="${pageNum == i}">
					<span style="color:red">
						<a href="reportList?pageNum=${i}${pms}">[${i}]</a>
					</span>
				</c:if>
				<c:if test="${pageNum != i}">
					<span>
						<a href="reportList?pageNum=${i}${pms}">[${i}]</a>
					</span>
				</c:if>
			</c:forEach>
		</tr>
		<tr>
			<!-- 검색 -->
			<td>
				<form name="search" method="post">
					<p align=right>
						<select name="keyField">
							<option value="title">제목</option>
							<option value="id">작성자</option>
						</select>
						<input type="text" name="keyword" size=20 maxlength=20 />
						<button type="button" onclick="searchCheck()">검색</button>
				</form>
			</td>
		</tr>
	</table>
	
</body>
</html>