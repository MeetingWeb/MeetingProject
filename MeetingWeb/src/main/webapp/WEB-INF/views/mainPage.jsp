<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/style_comm.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALsCWQfq_e5wj4Dcna1ZR99Ik1fM0CXLo&callback=initMap" async defer></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">

$(function(){
	
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
	 
})

	function email_check() {
	 var email = $('#email').val();
	 $.ajax({
			type : 'post',
			dataType : 'json',
			url : 'email_check',
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
	function initMap() {

		// Specify features and elements to define styles.
		var styleArray = [ {
			featureType : "all",
			stylers : [ {
				saturation : -80
			} ]
		}, {
			featureType : "road.arterial",
			elementType : "geometry",
			stylers : [ {
				hue : "#00ffee"
			}, {
				saturation : 50
			} ]
		}, {
			featureType : "poi.business",
			elementType : "labels",
			stylers : [ {
				visibility : "off"
			} ]
		} ];

		// Create a map object and specify the DOM element for display.
		var map = new google.maps.Map(document.getElementById('map'), {
			center : {
				lat : -34.397,
				lng : 150.644
			},
			scrollwheel : false,
			// Apply the map style array to the map.
			styles : styleArray,
			zoom : 8
		});
	}
</script>
</head>
<body>
	<jsp:include page="navi.jsp" />
	<jsp:include page="header.jsp" />
	<section id="contents">

		<div class="chat-btn">
			채팅방참여
			<input type="hidden" value="JUN">
		</div>
		<div id="map" style="width: 100%; height: 100%;"></div>
		<jsp:include page="loginForm.jsp" />
		<jsp:include page="joinForm.jsp" />
		
		<jsp:include page="chat_view.jsp" />
	</section>

	<div class="clear_f"></div>
	<jsp:include page="footer.jsp" />
</body>
</html>