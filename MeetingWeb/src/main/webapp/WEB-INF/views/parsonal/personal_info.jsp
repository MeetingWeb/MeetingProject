<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<style type="text/css">

</style>

<script type="text/javascript" src='<c:url value="/resources/js/personal_info.js"/>'></script>

<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/map.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/join.js"/>'></script>
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
	
	 $("#show_Infomation").css("height",$(window).height()-64);
	
	 if("${sessionScope.id}"!="")
	{		
		 	console.log(user_id);
			drawMeetings(map);				
			showMyLocation();
			var id = user_id;
			$.ajax({
				type : 'post',
				dataType : 'json',
				data : {id:id},
				url : 'personal_info',			
				success : function(data) {
					$('div#pemail').text(data.email);
					$('div#pid').text(data.id);
					$('div#pname').text(data.name);
					
					for(var i=0; i<data.interests.length;i++)
					{
						//alert(data.interests[i]);
						$("#"+data.interests[i]+"").prop('checked', true) ;
					}
					
					//$("#축구").prop('checked', true) ;
				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});
			
	}	
	
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

	
	 
});

function getRecommend(){
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'getRecommend',			
		success : function(data) {
			$('div.recommend-list').children().remove();
			var html="";
			for(var i=0; i<data.length; i++)
			{					
				var loc=data[i].loc;					
				var arr=loc.split(',');				
				var meetinglat=Number(arr[0]);				
				var meetinglng=Number(arr[1]);					
				var distance=calcDistance(mylat,mylng,meetinglat,meetinglng);
			
				if(distance<40){							
					if(((i!=0)&&(data[i-1].field!=data[i].field))||(i==0)){
						html+="<table><caption>"+data[i].field+"</caption>";							
					}
					html+="<tr><td> "+data[i].title+"</td><td> "+data[i].master+"</td><td> 거리"+distance+"km</td><td> <button type = 'button' class = 'btn btn-default btn-sm' onclick='showHere("+meetinglat+","+meetinglng+")'>모임 보기</button></td></tr>";
					if((i==(data.length-1))||(data[i].field!=data[i+1].field)){
						html+="</table>";				
						$('div.recommend-list').append(html);
						html="";
					}						
				}					
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
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">

<form id="personal_info">
	<div id="personal_group">
				
				<div id="personal_title">Personal Information</div>
				
				<label>E-mail</label><div id="pemail" ></div>
				 
				<label>ID</label><div id="pid"></div>
				
				<label>Name</label><div id="pname"></div>
				
				
				<div id="pass_changeform" style="display: none;">
				<label>PassWord</label><input type="password" name="pw" id="pw">
				
				<div id="pwc_checktext" ></div>
				
				<label>PassWordCheck</label><input type="password" name="pwc" id="pwc">
				
				<div id="pw_checktext" ></div>

				 </div>
				
				
				<label id="in">관심분야</label>
				<table id="checkBox"  style="margin: 26px 0 0 150px; border:solid 1px; width: 300px;">
				<tr>
				<td>
				<input type="checkbox" id="축구" name="interests" value="축구" disabled>
				축구  
				</td>
				<td>
				<input type="checkbox" id="농구" name="interests" value="농구" disabled>
				농구  
				</td>
				<td>
				<input type="checkbox" id="야구" name="interests" value="야구" disabled>
				야구
				</td>

				</tr>
				
				<tr>
				<td>
				<input type="checkbox" id="배구" name="interests" value="배구" disabled>
				배구
				</td>
				<td>
				<input type="checkbox" id="수영" name="interests" value="수영" disabled>
				수영
				</td>
				<td>
				<input type="checkbox" id="여행" name="interests" value="여행" disabled>
				여행
				</td>
				
				</tr>
				<tr>
				<td>
				<input type="checkbox" id="영화보기" name="interests" value="영화보기" disabled>
				영화보기
				</td>
				<td>
				<input type="checkbox" id="밥 먹기" name="interests" value="밥 먹기" disabled>
				밥 먹기
				</td>
				<td>
				<input type="checkbox" id="자전거" name="interests" value="자전거" disabled>
				자전거
				</td>
				
				</tr>
				   
				</table>
				<div id="pass_changebtn">비밀번호 변경</div>
				<div id="interests_changebtn">관심분야 변경</div>
				</div>

</form>	

<!-- Button trigger modal -->
<!-- Modal -->
<div class = "modal fade" id = "myModal" tabindex = "-1" role = "dialog" 
   aria-labelledby = "myModalLabel" aria-hidden = "false">
   
   <div class = "modal-dialog">
      <div class = "modal-content">
         
         <div class = "modal-header">
            <button type = "button" class = "close" data-dismiss = "modal" aria-hidden = "true">

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

	</section>
	<jsp:include page="../include/footer.jsp" />
</body>

</html>