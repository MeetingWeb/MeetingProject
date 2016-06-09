<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사건사고 게시판</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>

<script type="text/javascript">
	function editForm() {
		location.href="./editForm?num=${info.num}";
	}
	
	function removed() {
		if (!confirm('현재 글을 정말로 삭제하시겠어요?'))
			return;

		$.ajax({
			url : "./reportRemove",
			type : "post",
			data : $('#viewForm').serialize(),
			success : function(del) {
				if(del.code = 200) {
					alert(del.msg);
					location.href = del.url;
				} else if (del.code == 201) {
					alert(del.msg);
					location.href = del.url;
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		});
	} // end of remove()
	
	// 댓글 등록
	function saved() {
		$.ajax({
			url : "./replyWrite",
			type : "post",
			data : $('#replyForm').serialize(),
			success : function(save) {
				if(save.code = 200) {
					alert(save.msg);
					location.href = save.url;
				} else if(save.code == 201) {
					alert(save.msg);
					location.href = save.url;
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		}); // end of ajax({})
	} // end of saved()
	
	// 댓글 수정 조회
	function editReply(num, index, contents) {
		
		var html = "<input type='text' id='contents' value='"+contents+"'>";
		$("#reBtn"+index).html(html);
		
		var html = "<button type='button' onclick='replySaved("+num+",\""+contents+"\" )'>등록</button>";
		$("#editBtn"+index).html(html);
	}
	
	// 댓글 수정 등록
	function replySaved(num, contents) {
		
		$.ajax({
			url : "./replyEdit",
			type : "post",
			data : {
				num : num,
				contents : $('#contents').val()
			},
			success : function(saved) {
				if(saved.code = 200) {
					alert(saved.msg);
					location.href = saved.url;
				} else if(saved.code == 201) {
					alert(saved.msg);
					location.href = saved.url;
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		}); // end of ajax({})
	}
	
	
	// 댓글 삭제
	function replyRemoved(num) {
		if (!confirm('댓글를 정말로 삭제하시겠어요?'))
			return;
			
		$.ajax({
			url : "./replyRemove",
			type : "post",
			data : {num : num},
			success : function(del) {
				if(del.code = 200) {
					alert(del.msg);
					location.href = del.url;
				} else if (del.code == 201) {
					alert(del.msg);
					location.href = del.url;
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		});
	} // end of remove()
	
</script>
		
</head>
<body>
	
	<div align="center">
	<h1>상세보기 페이지</h1>

	<form id="viewForm">
		<table>
			<tr>
				<th>글 번호</th>
				<td><input type="hidden" name="num" value="${info.num}">${info.num}</td>
			</tr>
		
			<tr>
				<th>작성자</th>
				<td>${info.id}</td>
			</tr>
			
			<tr>
				<th>작성일</th>
				<td><fmt:formatDate value="${info.cre_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			
			<tr>
				<th>제목</th>
				<td>${info.title}</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td>${info.contents}</td>
			</tr>
			<tr>
				<th>이전글</th>
				<td><a href="reportInfo?num=${prev.num}">${prev.title}</a></td>
			</tr>
			<tr>
				<th>다음글</th>
				<td><a href="reportInfo?num=${next.num}">${next.title}</a></td>
			</tr>
		</table>
		<sec:authentication property='name' var="currentUserName"/>
		<c:if test="${currentUserName == info.id}">
			<button type="button" onclick="editForm()">수정</button>
			<button type="button" onclick="removed()">삭제</button>
		</c:if>
	</form>
	
	</div>
	
	<!-- 댓글 등록 -->
	<div align="center">
		<h3>댓글</h3>
		<form id="replyForm">
				<input type="hidden" name="id" value="<sec:authentication property='name'/>" />
				<input type="hidden" name="ref" value="${info.num}">
			<table>
				<tr>
					<th>내용</th>
					<td><input type="text" name="contents"></td>
				</tr>
			</table>
			
			<sec:authorize access="isAuthenticated()">
				<button type="button" onclick="saved()">등록</button><p>
			</sec:authorize>
			
			<sec:authorize access="! isAuthenticated()">
				댓글을 등록하시려면 로그인 후 사용하세요~<p>
			</sec:authorize>
			
		</form>
	</div>
	
	<!-- 댓글 조회(리스트) -->
	<table border="1" align="center">
		<c:forEach var="list" items="${replyList}" varStatus="status">
			<form id="replyView${status.index}">
				<tr>
					<td id="reBtn${status.index}">
						<input type="hidden" id="num" name="num" value="${list.num}">
						${list.contents}
					</td>
					<td>${list.id}</td>
					<td>${list.cre_date}</td>
					
					<sec:authentication property='name' var="currentUserName"/>
					<c:if test="${currentUserName == list.id}">
						<td id="editBtn${status.index}"><button type="button" onclick="editReply(${list.num}, ${status.index}, '${list.contents}')">수정</button></td>
						<td><button type="button" onclick="replyRemoved(${list.num})">삭제</button></td>
					</c:if>
				</tr>
			</form>
		</c:forEach>
	</table>
	
</body>
</html>