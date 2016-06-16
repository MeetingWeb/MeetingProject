<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="login-form">
	<c:if test="${param.error==true }">
		<span>로그인 실패</span>
	</c:if>
	
	<script type="text/javascript">
		function login() {
			$.ajax({
				url : '<c:url value="/user/login" />', 
				data : $('#loginForm').serialize(), 
				type : 'POST', 
				success : function(res) {
					alert("로그인 성공");
				}, 
				error : function(error) { 
					alert("시스템 에러!"); 
				}
				
			});
		}
	</script>
	
	<form id="loginForm" name="loginForm" action="<c:url value='/user/login' />" method="post">
		<input type="hidden" name="_csrf" value="${_csrf.token }">
		<div id="login-title">
			Enter <b>여기여기 붙어라</b>
		</div>
		<div id="info-group">
			<label>id</label>
			<input type="text" name="id">
			<label>password</label>
			<input type="password" name="pw">
			<div class="clear_f"></div>
		</div>

		<div id="login-btn-group">
			<div id="facebookLogin">FACEBOOK LOGIN</div>
			<div id="login-btn">LOGIN</div>
		</div><p>
		<div id="searchID">아이디 / 패스워드 찾기</div>
	</form>
</div>