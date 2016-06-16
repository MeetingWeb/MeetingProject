<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/style_comm.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/map.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">
 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALsCWQfq_e5wj4Dcna1ZR99Ik1fM0CXLo&callback=initMap" async defer></script>
<title>여기여기 붙어라</title>
<style type="text/css">
input.title{width:720px;}
 
</style>
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';
 
 
 
$(function(){
	window.name="my";
	 $("#pwc").keyup (function() {
		    if($('input#pw').val()==$('input#pwc').val())
		    {
		    	$('#pw_checktext').text("맞다.");	
		    }
		    else if($('input#pw').val()!=$('input#pwc').val())
		    {
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
			data : {email:email},
			success : function(evt) {
				if(evt.ok==true)
				{
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
			data : {id:id},
			success : function(evt) {
				if(evt.ok==true)
				{
					$('#id_checktext').text("사용 가능한 아이디 입니다.");
					//alert("사용 가능한 아이디 입니다.");
				}
				else if(evt.ok==false)
				{
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
	
	function insert(){
		$.ajax({
			type:"get",
			url:"write",
			data:$('form').serialize(),	
			dataType:"json",
			success:function(data)
			{
				if(data.ok){
					alert("글이 성공적으로 등록되었습니다.");
					location.href="latelyRead";
				}else alert("글쓰기에 실패하였습니다.");				
			},
			complete:function(data)
			{			
			},
			error:function(xhr,status,error)
			{
				alert("글쓰기에 실패하였습니다.");
			}
 
			
		});
	}
	
	function cancel(){
		if(confirm('리스트로 돌아가시겠습니까?'))
		{
			location.href="getList";			
		}		
	}
	
	
	
	
	
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<form>
<table id="noticewrite" class="table">
<caption><h2 class="title" style="color:#464646;position: relative;    font-weight: normal;margin-bottom: 5px; font-size: 40px;">Notice</h2></caption>
<tr style="border-top:2px solid black"><th>제목</th><td><input type="text" name="title" class="title"></td></tr>
<tr><th>내용</th><td><textarea rows="30" cols="100" name="contents"></textarea></td></tr>
		
			
<tr><td colspan="2" style="text-align:right;"><a style="cursor: pointer;" onclick="insert()" ><img src="/NowMeetingWeb/resources/images/write.png"></a> 
<a style="cursor: pointer;" onclick="cancel()"><img src="/NowMeetingWeb/resources/images/list.png"></a></td></tr>
</table>
<input type="hidden" name="id" 	value="${sessionScope.id }">
 
</form>
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
 
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>
