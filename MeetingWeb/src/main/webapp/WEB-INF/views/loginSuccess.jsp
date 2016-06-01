<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<script>
		location.href="../meeting/meetingList?id=<sec:authentication property="name"/>";
	</script>
</sec:authorize>