<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<style type="text/css">

</style>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
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
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';

$(function(){
	
	<c:if test="${ok == true}">
		var email = '<c:out value="${requestScope.email}"/>';
		$("input[name='id']").prop('disabled', false);
		$("input[name='pw']").prop('disabled',false);
		$("input[name='pwc']").prop('disabled',false);
		$("input[name='name']").prop('disabled',false);
		$("input[name='interests']").prop('disabled',false);
		$("input[name='email']").val(email);
		$('form#joinform').css("display","block")
	</c:if>

	 $('#id').keyup(function(){
		 var id = $('#id').val();
		 $.ajax({
				type : 'post',
				dataType : 'json',
				url : 'check',
				data : {id:id},
				success : function(evt) {
					if(evt.idErr) {
						$('#id_checktext').text(evt.idErr);
					}
				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});	 
	 
	});
	
	 $('input#pw').keyup(function(){
		 var pw = $('input#pw').val();
		 var pwc = $('#pwc').val();
		 $.ajax({
				type : 'post',
				dataType : 'json',
				url : 'check',
				data : {pw:pw,pwc:pwc},
				success : function(evt) {
					if(evt.pwdErr) {
						$('#pwc_checktext').text(evt.pwdErr);
						$('#pw_checktext').text(evt.pwdErr2);
					}
				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});	 
	});
	 
	 $('#pwc').keyup(function(){
		 var pw = $('input#pw').val();
		 var pwc = $('#pwc').val();
		 $.ajax({
				type : 'post',
				dataType : 'json',
				url : 'check',
				data : {pw:pw,pwc:pwc},
				success : function(evt) {
					if(evt.pwdErr2) {
						$('#pw_checktext').text(evt.pwdErr2);
					}
				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});	 
	 
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

	var id_checks = null;
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
					$('#id_checktext').text("중복확인 되었습니다..");
					id_checks=evt.msg;
				}
				else if(evt.ok==false)
				{
					$('#id_checktext').text("사용 중인 아이디 입니다.");
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
		

		if(id_checks!=$('#id').val())
		{
		alert("중복검사하세요.");
		} 
		if(id_checks==$('#id').val())
		{
		 
		 
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
		
	}
</script>
</head>
<body>
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents">
	
	
<!-- Button trigger modal -->
<!-- Modal -->
<div class = "modal fade" id = "myModal" tabindex = "-1" role = "dialog" 
   aria-labelledby = "myModalLabel" aria-hidden = "false">
   
   <div class = "modal-dialog">
      <div class = "modal-content">
         
         <div class = "modal-header">
            <button type = "button" class = "close" data-dismiss = "modal" aria-hidden = "true">
               ×
            </button>
            
            <h4 class = "modal-title" id = "myModalLabel">
               This Modal title
            </h4>
         </div>
         
         <div class = "modal-body" id="myModalBody">
            Press ESC button to exit.
         </div>
         
         <div class = "modal-footer">
            <button type = "button" class = "btn btn-default" data-dismiss = "modal">
               Close
            </button>          
            
            <button type = "button" class = "btn btn-success" onclick="direction()")>
               	Directions
            </button>
            
             <button type = "button" class = "btn btn-success">
               Participation in chat rooms
            </button>
            
             <button type = "button" class = "btn btn-success">
               Rough map
            </button>
            
            
            
         </div>
         
      </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
   
</div><!-- /.modal -->	      
  
<div class="recommend">	
	<span id="recommend-title">추천목록</span><br>
	<div class="recommend-list">		
	</div>
	<span id="recommend-more"><a href='#none' onClick='getRecommend(); return false;' >새로고침</a></span>
</div>  
  
      	
		<div class="chat-btn">
			채팅방참여
			<input type="hidden" value="JUN">
		</div>
		<div id="map" style="width: 100%; height: 100%;"></div>
		<jsp:include page="include/loginForm.jsp" />
		<jsp:include page="include/joinForm.jsp" />
		<jsp:include page="include/chat_view.jsp" />
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<c:if test="${param.error==true }">
	<script type="text/javascript">
		alert("로그인 실패");
	</script>
</c:if>
</html>