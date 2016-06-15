<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
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
<style type="text/css">
input.title{width:720px;}
</style>
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';
var members=new Array();
var blacks=new Array();
var changeMembers=new Array();
var changeBlacks=new Array();
var resultMembers=new Array();
var resultBlacks=new Array();

function changePower(){

	$('#member>option').each(function(){
		var id=$(this).text();
		changeMembers.push(id);		
	});
	
	$('#black>option').each(function(){
		var id=$(this).text();
		changeBlacks.push(id);		
	});	
	
	
	for(var i=0; i<changeMembers.length; i++)
	{
		var ok=false;
		for(var j=0; j<members.length; j++)
		{				
			 	if(changeMembers[i]==members[j]){
				ok=true;
				break;				
				}			
		}		
		if(!ok){			
			resultMembers.push(changeMembers[i]);			
		}
	}
	
	for(var i=0; i<changeBlacks.length; i++)
	{
		var ok=false;
		for(var j=0; j<blacks.length; j++)
		{			
			 	if(changeBlacks[i]==blacks[j]){
				ok=true;
				break;				
				}			
		}		
		if(!ok){			
			resultBlacks.push(changeBlacks[i]);			
		}
	}
		

 	jQuery.ajaxSettings.traditional = true;
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'powerUpdate',
		data : {
			"resultmember":resultMembers,
			"resultblack":resultBlacks
			
		},
		success : function(data) {
			if(data.ok){
				alert('업데이트 성공');
				
			}else alert('업데이트 실패');
			
		},
		complete : function(data) {

		},
		error : function(xhr, status, error) {
			alert(error);
		}
	}); 
	
	
}

function goblack(){
	var id=$('#member option:selected').text();
	$('#member option:selected').remove();
	var html="<option>"+id+"</option>";
	$('#black').append(html);
}

function gomember(){
	var id=$('#black option:selected').text();
	$('#black option:selected').remove();
	var html="<option>"+id+"</option>";
	$('#member').append(html);
}
	
function gomain(){
	if(confirm('수정을 취소하시겠습니까?')){
		location.href='main';
		
	}
}
	
</script>
</head>
<body>

	<jsp:include page="include/navi.jsp" />
	<jsp:include page="include/header.jsp" />
	
	
	<table class="table" style="max-width:1100px; margin:50px auto;">
	<tr>	
	
	<td>
	<select id="member" size="20" style="width:300px">
	<c:forEach var="list" items="${ list }">
	<c:if test= "${ list.power eq 'MEMBER' }">
	<script>members.push("${list.id}");</script>
	<option>${ list.id }</option></c:if>
	</c:forEach>
	</select>
	</td>	
	
	<td>
	<button type="button" onclick="goblack()">>></button>
	<button type="button" onclick="gomember()"><<</button>
	</td>	
	
	<td>
	<select id="black" size="20" style="width:300px">
	<c:forEach var="list" items="${ list }">
	<c:if test= "${ list.power eq 'BLACK' }">
	<script>blacks.push("${list.id}")</script>
	<option>${ list.id }</option></c:if>
	</c:forEach>
	</select>		
	</td>
	
	</tr>
	<tr>
	<td>
	<button type="button" onclick="changePower()">수정</button>
	<button type="button" onclick="gomain()">취소</button>
	</td>
	</tr>
	</table>
	
	<jsp:include page="include/footer.jsp" />
</body>
</html>
