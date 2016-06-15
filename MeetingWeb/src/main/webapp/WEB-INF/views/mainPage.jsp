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
	
	$(function() {

		window.name = "my";
		$("#pwc").keyup(function() {
			if ($('input#pw').val() == $('input#pwc').val()) {
				$('#pw_checktext').text("맞다.");
			} else if ($('input#pw').val() != $('input#pwc').val()) {
				$('#pw_checktext').text("아니야.");
			}
		});
		$("#show_Infomation").css("height", $(window).height() - 64);

		if ("${sessionScope.id}" != "") {		
			drawMeetings(map);
			showMyLocation();			
			if("${requestScope.search}"=='ok')
			{
				$("#search-menu").css('display', 'block');	
			}
		}

		<c:if test="${ok == true}">
		var email = '<c:out value="${requestScope.email}"/>';
		$("input[name='id']").prop('disabled', false);
		$("input[name='pw']").prop('disabled', false);
		$("input[name='pwc']").prop('disabled', false);
		$("input[name='name']").prop('disabled', false);
		$("input[name='interests']").prop('disabled', false);
		$("input[name='email']").val(email);
		$('form#joinform').css("display", "block")
		</c:if>

		$('#id').keyup(function() {
			var id = $('#id').val();
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'check',
				data : {
					id : id
				},
				success : function(evt) {
					if (evt.idErr) {
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

		$('input#pw').keyup(function() {
			var pw = $('input#pw').val();
			var pwc = $('#pwc').val();
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'check',
				data : {
					pw : pw,
					pwc : pwc
				},
				success : function(evt) {
					if (evt.pwdErr) {
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

		$('#pwc').keyup(function() {
			var pw = $('input#pw').val();
			var pwc = $('#pwc').val();
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'check',
				data : {
					pw : pw,
					pwc : pwc
				},
				success : function(evt) {
					if (evt.pwdErr2) {
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

	var id_checks = null;
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
					$('#id_checktext').text("중복확인 되었습니다..");
					id_checks = evt.msg;
				} else if (evt.ok == false) {
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

		if (id_checks != $('#id').val()) {
			alert("중복검사하세요.");
		}
		if (id_checks == $('#id').val()) {

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
	
	function goSearch(){
		var searchArr=[];
		var searchList=$('input[name=search]')
		
		for(var i=0; i<searchList.length; i++){
			if(searchList[i].checked==true){
				searchArr.push(searchList[i].value);
			}		
		}	
		var data={
			"data":	searchArr
		}	

		jQuery.ajaxSettings.traditional = true;		
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'search',
			data : data,
			success : function(data) {				
				setMapOnAll(null);
				markers=[];
			 	 for(var i=0; i<data.length; i++)
				{
					var loc=data[i].loc;
					var arr=loc.split(',');				
					var lat=Number(arr[0]);
					var lng=Number(arr[1]);				 
					var latlng = new google.maps.LatLng(lat,lng);
					makeMarker(latlng,data[i]);
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
	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	<section id="contents">


		<!-- Button trigger modal -->
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">

			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

						<h4 class="modal-title" id="myModalLabel">This Modal title</h4>
					</div>

					<div class="modal-body" id="myModalBody">Press ESC button to exit.</div>

					<div class="modal-footer">
						<input type="hidden" name="master">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

						<button type="button" class="btn btn-success" onclick="direction()">Directions</button>

						<button type="button" class="btn btn-success chat-btn">Participation in chat rooms</button>

						<button type="button" class="btn btn-success">Rough map</button>
					</div>

				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->

		</div>
		<!-- /.modal -->

		
		
		
		
		
		
		
<div id="search-menu">
<ul class = "list-group">
   <li class = "list-group-item"><input type="checkbox" name="search" value="롱보드"><span class="searchtext">롱보드</span></li>
   <li class = "list-group-item"><input type="checkbox" name="search" value="농구"><span class="searchtext">농구</span></li>
   <li class = "list-group-item"><input type="checkbox" name="search" value=""><span class="searchtext">선택1</span></li>
   <li class = "list-group-item"><input type="checkbox" name="search" value=""><span class="searchtext">선택1</span></li>
   <li class = "list-group-item"><input type="checkbox" name="search" value=""><span class="searchtext">선택1</span></li>
 <button type = "button" class = "btn btn-success btn-lg" onclick="goSearch()" style="width:100%">
     검색
   </button>  
</ul>

  <!--  <div class = "panel-heading">
      <h3 class = "panel-title" style="margin-left:17%;">
      </h3>
   </div>
   
   <div class = "panel-body">
      			<table class = "table table-striped">			
  
  
     
   
   
   <tbody>
      <tr>
         <td></td>
         <td>롱보드</td>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
      </tr>
      
      <tr>
         <td></td>
         <td>농구</td>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
      </tr>
      
      <tr>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
      </tr>
      <tr>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택2</td>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
      </tr>
      <tr>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택3</td>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
      </tr>
      <tr>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택4</td>
         <td><input type="checkbox" name="search" value=""></td>
         <td>선택1</td>
      </tr>
   </tbody>
   
</table> -->
					
			</div> 
   </div>
</div>	
			
		

		
		
		<div id="map" style="width: 100%; height: 100%;"></div>
		<jsp:include page="include/loginForm.jsp" />
		<jsp:include page="include/joinForm.jsp" />
	</section>
	<jsp:include page="include/footer.jsp" />
</body>
<c:if test="${param.error==true }">
	<script type="text/javascript">
		alert("로그인 실패");
	</script>
</c:if>
</html>
