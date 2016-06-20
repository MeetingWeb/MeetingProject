<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					location.href = save.url + ${info.num};
				} else if(save.code == 201) {
					alert(save.msg);
					location.href = save.url + ${info.num};
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		}); // end of ajax({})
	} // end of saved()
	
	// 댓글 수정 전 사용할 함수
	function editReplyPre(index) {
		
		$("#replyContents"+index).css("display", "none");
		$("#divEdit"+index).css("display", "none");
		
		var text = document.getElementById("contents"+index);
		text.type= "text";
		
		var btn = document.getElementById("replyEditSaveBtn"+index);
		btn.type = "button";
	}
	
	// 댓글 수정 등록
	function replySaved(index, num, contents) {
		$.ajax({
			url : "./replyEdit",
			type : "post",
			data : {
				num : num,
				contents : $('#contents'+index).val()
			},
			success : function(saved) {
				if(saved.code = 200) {
					alert(saved.msg);
					$("#replyContents"+index).text($('#contents'+index).val() );
					editReplyNext(index);
					
				} else if(saved.code == 201) {
					alert(saved.msg);
					location.href = save.url + ${info.num};
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		}); // end of ajax({})
	}
	
	// 댓글 수정 후 사용할 함수
	function editReplyNext(index) {
		
		$("#replyContents"+index).css("display", "");
		$("#divEdit"+index).css("display", "");
		
		var text = document.getElementById("contents"+index);
		text.type= "hidden";
		
		var btn = document.getElementById("replyEditSaveBtn"+index);
		btn.type = "hidden";
	}
	
	// 댓글 삭제
	function replyRemoved(index, num) {
		if (!confirm('댓글를 정말로 삭제하시겠어요?'))
			return;
			
		$.ajax({
			url : "./replyRemove",
			type : "post",
			data : {num : num},
			success : function(del) {
				if(del.code = 200) {
					alert(del.msg);
					$("#tdReplyContents"+index).parent().remove();
					
				} else if (del.code == 201) {
					alert(del.msg);
					location.href = save.url + ${info.num};
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
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
	
	<div id="header">
		<h1>상세보기 페이지</h1>
	</div>

		<form id="viewForm">
			<table id="tbl" class="table col-xs-4">
				<tr>
					<th id="thLeft">글 번호</th>
					<td align="left"><input type="hidden" name="num" value="${info.num}">${info.num}</td>
				</tr>
			
				<tr>
					<th id="thLeft">제목</th>
					<td align="left">${info.title}</td>
				</tr>
				
				<tr>
					<th id="thLeft">작성자</th>
					<td align="left">${info.id}</td>
				</tr>
				<tr>
					<th id="thLeft">작성일</th>
					<td align="left"><fmt:formatDate value="${info.cre_date}" pattern="yyyy-MM-dd"/></td>
				</tr>
				
				<tr>
					<th></th>
					<td align="left">${info.contents}</td>
				</tr>
				
				<tr>
					<th id="thLeft">이전글</th>
					<td align="left"><a href="reportInfo?num=${prev.num}">${prev.title}</a></td>
				</tr>
					
				<tr>
					<th id="thLeft">다음글</th>
					<td align="left"><a href="reportInfo?num=${next.num}">${next.title}</a></td>
				</tr>
			</table>
		</form>
	
		<div align="left" style="margin-left: 10%;">
			<sec:authentication property='name' var="currentUserName"/>
			<c:if test="${currentUserName == info.id}">
				<button type="button" class="btn btn-default xs-4" onclick="editForm()">수 정</button>&nbsp;
				<button type="button" class="btn btn-default xs-4" onclick="removed()">삭 제</button>&nbsp;
			</c:if>
				<button type="button" class="btn btn-default xs-4" onclick="location='./reportList'">목 록</button>&nbsp;
		</div><br><br>
	
	<!-- 댓글 등록 -->
	<div id="header">
		<h3>댓글</h3>
	</div><br>
	
	<form id="replyForm">
		<input type="hidden" name="id" value="<sec:authentication property='name'/>" />
		<input type="hidden" name="ref" value="${info.num}">
		
		<table id="tbl" class="col-xs-4">
			<tr>
				<th id="thLeft">내용</th>
			</tr>
			
			<tr>
				<td>
					<sec:authorize access="! isAuthenticated()">
						<textarea name="contents" rows="5" cols="100"> 댓글을 등록하시려면 로그인 후 사용하세요~</textarea>
					</sec:authorize>
						
					<sec:authorize access="isAuthenticated()">
						<textarea name="contents" rows="5" cols="100"></textarea>
					</sec:authorize>
				</td>
			</tr>
			
			<tr>
			</tr>
		</table>
	</form>
	
	<br><br><br><br><br><br><br>
	<div style="margin-left: 10%;">
		<sec:authorize access="isAuthenticated()">
			<button type="button" class="btn btn-default xs-4" onclick="saved()">등 록</button>
		</sec:authorize>
	</div>
	<br><br>
		
	<!-- 댓글 조회(리스트) -->
	<table id="tbl" class="table col-xs-4">
		<c:forEach var="list" items="${replyList}" varStatus="status">
			<tr>
				<td id="tdReplyContents${status.index}" width="350">
					<input type="hidden" id="num" name="num" value="${list.num}">
					
					<div id="replyContents${status.index}">
						${list.contents}
					</div>
					
					<!-- 수정할 댓글 내용 입력 -->
					<input type="hidden" id="contents${status.index}" value="${list.contents}">
				</td>
				<td width="150" align="center">${list.id}</td>
				<td width="150" align="center">${list.cre_date}</td>
					
				<sec:authentication property='name' var="currentUserName"/>
				<c:if test="${currentUserName == list.id}">
				
				<td id="tdEdit${status.index}" width="150">
					<div id="divEdit${status.index}">
						<button type="button" id="replyEditBtn${status.index}" 
							onclick="editReplyPre(${status.index})">수정</button>
					</div>
							
					<!-- 댓글 수정 후 등록 -->
					<input type="hidden" id="replyEditSaveBtn${status.index}" 
						onclick="replySaved(${status.index}, ${list.num}, '${list.contents}' )" value="등 록" >
				</td>
				<td>
					<button type="button" onclick="replyRemoved(${status.index}, ${list.num})">삭제</button>
				</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>