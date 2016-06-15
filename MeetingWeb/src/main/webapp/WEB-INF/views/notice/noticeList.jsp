<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript"
	src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript"
	src='<c:url value="/resources/js/style_comm.js"/>'></script>
<script type="text/javascript"
	src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript"
	src='<c:url value="/resources/js/chat.js"/>'></script>
<script type="text/javascript"
	src='<c:url value="/resources/js/map.js"/>'></script>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALsCWQfq_e5wj4Dcna1ZR99Ik1fM0CXLo&callback=initMap"
	async defer></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	function writeForm(){		
		location.href="writeForm";
	}
	
	function search() {
		location.href = "searchList?key=" + $('input.key').val();
	}
	function allList() {
		location.href = "getList";
	}

	$(function() {
		window.name = "my";
		$("#pwc").keyup(function() {
			if ($('input#pw').val() == $('input#pwc').val()) {
				$('#pw_checktext').text("맞다.");
			} else if ($('input#pw').val() != $('input#pwc').val()) {
				$('#pw_checktext').text("아니야.");
			}
		});

	});

	function email_check() {
		var email = $('#email').val();
		$.ajax({
			type : 'get',
			dataType : 'json',
			url : 'eamil_check',
			data : {
				email : email
			},
			success : function(evt) {
				if (evt.ok == true) {
					alert("확인되었ㅅ브니다.")
				}
			},
			complete : function(data) {

			},
			error : function(xhr, status, error) {
				alert(error);
			}
		});

	}

	function id_check() {
		var id = $('input#id').val();
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'id_check',
			data : {
				id : id
			},
			success : function(evt) {
				if (evt.ok == true) {
					$('#id_checktext').text("사용 가능한 아이디 입니다.");
					//alert("사용 가능한 아이디 입니다.");
				} else if (evt.ok == false) {
					$('#id_checktext').text("사용 중인 아이디 입니다.");
					//alert("사용 중인 아이디 입니다.");
				}
			},
			complete : function(data) {

			},
			error : function(xhr, status, error) {
				alert(error);
			}
		});

	}

	function joinsave() {
		var data = $('#joinform').serialize();
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'join',
			data : data,
			success : function(evt) {
				if (evt.ok == true) {
					alert("성공");
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
<div id="notice">
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<div id="noticetable">
		<table class="table">
			<caption><h2 class="title">Notice</h2></caption>
			<thead style="text-align:center">
			<tr>
				<th style="width:8%">번호</th>
				<th>제목</th>
				<th style="width:10%" >작성자</th>
				<th style="width:12%">작성일</th>
				<th style="width:8%">조회수</th>
			</tr>
			</thead>
			<c:forEach var="list" items="${ map.list }">
				<tr>
					<td>${ list.num }</td>
					<td style="text-align:left;"><a href="read?num=${ list.num }">${ list.title }</a></td>
					<td>${ list.id }</td>
					<td>${ list.cre_date }</td>
					<td>${ list.hit }</td>
				</tr>
			</c:forEach>
			
			
			<tfoot style="vertical-align:inherit;">
			<tr  style="border-bottom:none" class="buttontr"><td colspan="5">
			<p class="buttons">
			
		
			<button type="button" onclick="allList()">전체보기</button>		
			<button type="button" onclick="writeForm()">글쓰기</button>
			</p>
			
			</td></tr>	
			<tr style="border-top:none"class="pagetr">
			<td colspan="5">
			
			
				<c:choose>
			<c:when test="${map.condition eq 'normal'}">
				<c:if test="${ map.page.currPage > 3 }">
					<a href="getPage?page=${ map.page.startPage-1 }">PREV</a>
				</c:if>
			</c:when>
			<c:when test="${map.condition eq 'search'}">
				<c:if test="${ map.page.currPage > 3 }">
					<a
						href="searchPage?key=${ map.key }&page=${ map.page.startPage-1 }">PREV</a>
				</c:if>
			</c:when>
		</c:choose>


		<c:choose>
			<c:when test="${map.condition eq 'normal'}">
				<c:forEach var="no" begin="${ map.page.startPage }"
					end="${ map.page.endPage }">
					<c:if test="${ no <= map.page.totalPage }">
						<a href="getPage?page=${ no }">${ no }</a>
					</c:if>
				</c:forEach>
			</c:when>
			<c:when test="${map.condition eq 'search'}">
				<c:forEach var="no" begin="${ map.page.startPage }"
					end="${ map.page.endPage }">
					<c:if test="${ no <= map.page.totalPage }">
						<a href="searchPage?key=${ map.key }&page=${ no }">${ no }</a>
					</c:if>
				</c:forEach>
			</c:when>
		</c:choose>


		<c:choose>
			<c:when test="${map.condition eq 'normal'}">
				<c:if test="${ map.page.endPage < map.page.totalPage }">
					<a href="getPage?page=${ map.page.endPage+1 }">NEXT</a>
				</c:if>
			</c:when>
			<c:when test="${map.condition eq 'search'}">
				<c:if test="${ map.page.endPage < map.page.totalPage }">
					<a href="searchPage?key=${ map.key }&page=${ map.page.endPage+1 }">NEXT</a>
				</c:if>
			</c:when>
		</c:choose>
			
			
			
			
			</td>
			</tr>	
			<tr class="searchtr">
			<td colspan="5">
				<input type="text" class="key">
			<button type="button" onclick="search()">검색</button>
			
			</td>
			</tr>
		
	


		
		</tfoot>
		
		</table>
		</div>
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />

	</section>
	

	<jsp:include page="../include/footer.jsp" />
	</div>
</body>