<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Bootstrap -->
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>

<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/report.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" 
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	 integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<!-- Bootstrap -->

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
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
	
		<h1>사건사고 게시판</h1>
		
		<table class="table table-hover">
			<tr>
				<th id="thCenter">글 번호</th><th id="thCenter">제목</th>
				<th id="thCenter">아이디</th><th id="thCenter">작성일</th>
			</tr>
			
			<c:forEach var="list" items="${listReport}">
			<tr align="center">
				<td>${list.num}</td>
				<td align="left"><a href="reportInfo?num=${list.num}">${list.title}</a></td>
				<td>${list.id}</td>
				<td>${list.cre_date}</td>
			</tr>
			</c:forEach>
		</table>
		
			<ul id="ulPaging" class="pagination" >
				<!-- 페이징 -->
				<li><a href = "reportList?pageNum=${startPageNum}">&laquo;</a></li>
				<c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
					<c:if test="${pageNum == i}">
					<li><a href="reportList?pageNum=${i}${pms}">${i}</a></li>
					</c:if>
					<c:if test="${pageNum != i}">
						<li><a href="reportList?pageNum=${i}${pms}">${i}</a></li>
					</c:if>
				</c:forEach>
				<li><a href = "reportList?pageNum=${endPageNum}">&raquo;</a></li>
			</ul>
		
		<button type="button" id="writeBtn" class="btn btn-default" onclick="writeForm()">사건사고 등록</button><p>
	
		<!-- 검색 -->
		<form name="search" method="post">
			<div id="divSearch" class="col-xs-4">
				<div class = "input-group">
					<div class = "input-group-btn">
						<select name="keyField" class="btn btn-default dropdown-toggle">
							<option value="title">제목</option>
							<option value="id">작성자</option>
						</select>
					</div>
					<input type="text" name="keyword" class="form-control" />
				</div>
			</div>
			<button type="button" name="searchBtn" class="btn btn-default" onclick="searchCheck()">검색</button>
		</form>
	
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>