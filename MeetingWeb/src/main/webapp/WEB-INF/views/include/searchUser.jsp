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


<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/searchUser.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" 
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	 integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<!-- Bootstrap -->

<title>아이디 / 패스워드 찾기</title>

<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript">
	
	function idSearch() {
		var name = $('input[name=name]').val();
		var email = $('input[name=email]').val();
		
		if(name == "") {
			confirm('이름을 입력해 주세요.');
			return;
			
		} else if(email == "") {
			confirm('이메일을 입력해 주세요.');
			return;
			
		} else if (!emailCheck(email) ) {
			confirm("올바른 email주소가 아닙니다.");
			return;
		}
			
		$.ajax({
			url : "searchID", 
			type : "post", 
			data : $("#s-id").serialize(), 
			success : function(search) {
				if (search.code == 200) {
// 					alert(search.msg);
					
					 $("#myAlert").bind('closed.bs.alert', function () {
				         alert(search.msg);
				      });
					
				}
				else if (search.code == 201) alert(search.msg);
			},
			error : function(error) {
					alert("이름과 이메일을 정확하게 입력해 주세요.");
			}
		});
	}
	
	function pwSearch() {
		var id = $('input[name=id]').val();
		var email = $('input[name=email]').val();
		
		if(id == "") {
			confirm('아이디를 입력해 주세요.');
			return;
			
		} else if(email == "") {
			confirm('이메일을 입력해 주세요.');
			return;
			
		} else if (!emailCheck(email) ) {
			confirm("올바른 email주소가 아닙니다.");
			return;
		}
		
		$.ajax({
			url : "searchPW", 
			type : "post", 
			data : $("#searchPW").serialize(), 
			success : function(search) {
				if (search.code == 200) alert(search.msg); 
				
				else if (search.code == 201) alert(search.msg);
			},
			error : function(error) {
					alert("아이디와 이메일을 정확하게 입력해 주세요.");
			}
		});
	}
	
	function emailCheck(email){
		var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		return emailPattern.test(email);
	}
</script>

</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		
		<div id="myAlert" class="alert alert-success" hidden="hidden"></div>
		
	
		<div>
			<form id="s-id">
				<div id="header">
					<h1>ID 찾기</h1>
				</div>
				<table id="tbl" class="table table-bordered">
					<tr>
						<td align="center" width="150">이름</td>
						<td><input type="text" name="name" /></td>
					</tr>
					<tr>
						<td align="center" width="150">이메일</td>
						<td><input type="text" name="email" /></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div align="left" style="margin-left: 10%;">
		<button type="button" id="idSearchBtn" 
			class="btn btn-default xs-4" onclick="idSearch()">ID 찾기</button>
		</div>
		
		<br><br>
		<div>
			<form id="searchPW">
				<div id="header">
					<h1>PW 찾기</h1>
				</div>
				<table id="tbl" class="table table-bordered col-xs-4">
					<tr>
						<td align="center" width="150">아이디</td>
						<td><input type="text" name="id" /></td>
					</tr>
					<tr>
						<td align="center" width="150">이메일</td>
						<td><input type="text" name="email" /></td>
					</tr>
				</table><br>
			</form>
		</div>
	
		<div align="left" style="margin-left: 10%;">
			<button type="button" id="pwSearchBtn" 
				class="btn btn-default xs-4" onclick="pwSearch()">PW 찾기</button>
		</div>
		
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>