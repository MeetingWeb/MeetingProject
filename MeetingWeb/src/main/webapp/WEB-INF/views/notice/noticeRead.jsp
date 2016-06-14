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
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';
var replyPage=1;

function list(){	
	location.href="getList";
}

function modify(){	
	location.href="modifyForm?num="+${data.num};	
}

function replyModifyGo(num){	
	$.ajax({
		type:"get",
		url:"replyModify",
 		data:
		{	
 			ref:${ data.num },
			num:num,
			contents:$('input.'+num).val(),
			page:replyPage
		},	 
		dataType:"json",
		success:function(data)
		{	
			$('table.reply').children().remove();
			$('div.replyMenu').children().remove();
			$('textarea.reply').val("");			
			for(var i=0; i<data.list.length; i++)
			{
				var html="<tr><th>"+data.list[i].id+"</th><td class='"+data.list[i].num+"'>"+data.list[i].contents+"</td>";
				//조건문 if()
				html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>수정</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>삭제</button></td>";				
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";			
			if(data.page.totalPage>data.page.currPage)
			{				
				menu+="<a href='#none' onClick='nextReply(); return false;'>다음댓글보기</a><br>";
			}
			if(data.page.currPage>1)
			{
				menu+="<a href='#none' onClick='prevReply(); return false;'>이전댓글보기</a><br>";	
			}
			
			menu+="<a href='#none' onClick='allReply(); return false;'>전체댓글보기</a><br>";
			$('div.replyMenu').append(menu);
		
		},
		complete:function(data)
		{
			
		},
		error:function(xhr,status,error)
		{
			alert(error);
		}			
	});	
	
}
function replyModify(num){	
	var text=$('td.'+num).text();
	$('td.'+num).text("");
	var html="<input type='text' class='"+num+"'value='"+text+"'>"
	$('td.'+num).append(html);
	$('button.'+num).text('완료');
	$('button.'+num).removeAttr('onclick');
	$('button.'+num).attr('onclick','replyModifyGo('+num+')');	

		
}

function replyDel(num){
	
	if(confirm('정말 삭제 하시겠습니까?'))
	{
		$.ajax({
			type:"get",
			url:"replyDel",
			data:
			{	
				ref:${data.num},
				num:num,
				page:replyPage
			},	
			dataType:"json",
			success:function(data)
			{
				$('table.reply').children().remove();
				$('div.replyMenu').children().remove();
				$('textarea.reply').val("");				
				for(var i=0; i<data.list.length; i++)
				{
					var html="<tr><th>"+data.list[i].id+"</th><td class='"+data.list[i].num+"'>"+data.list[i].contents+"</td>";
					//조건문 if()
					html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>수정</button>"+ 
					"<button type='button' onclick='replyDel("+data.list[i].num+")'>삭제</button></td>";				
					html+="</tr>";
					$('table.reply').append(html);
				}
				var menu="";			
				
				if(data.page.totalPage>data.page.currPage)
				{				
					menu+="<a href='#none' onClick='nextReply(); return false;'>다음댓글보기</a><br>";
				}
				if(data.page.currPage>1)
				{
					menu+="<a href='#none' onClick='prevReply(); return false;'>이전댓글보기</a><br>";	
				}
				
				menu+="<a href='#none' onClick='allReply(); return false;'>전체댓글보기</a><br>";
				$('div.replyMenu').append(menu);
				
			},
			complete:function(data)
			{
				
			},
			error:function(xhr,status,error)
			{
				alert("글삭제에 실패하였습니다.");
			}			
		});		
	}
}

function allReply(){
	$.ajax({
		type:"get",
		url:"allReply",
		data:
		{
			num:${data.num}
		},	
		dataType:"json",
		success:function(data)
		{
			$('table.reply').children().remove();
			$('div.replyMenu').children().remove();
			for(var i=0; i<data.length; i++)
			{
				var html="<tr><th>"+data[i].id+"</th><td class='"+data[i].num+"'>"+data[i].contents+"</td>";
				//조건문 if()
				html+="<td><button type='button' class='"+data[i].num+"' onclick='replyModify("+data[i].num+")'>수정</button>"+ 
				"<button type='button' onclick='replyDel("+data[i].num+")'>삭제</button></td>";			
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="<a href='#none' onClick='firstReply(); return false;'>처음댓글보기</a>";
			$('div.replyMenu').append(menu);
		},
		complete:function(data)
		{
			
		},
		error:function(xhr,status,error)
		{
			alert(error);
		}
	});	
}

function firstReply(){
	$.ajax({
		type:"get",
		url:"firstReply",
		data:
		{
			num:${data.num}
		},	
		dataType:"json",
		success:function(data)
		{
			$('table.reply').children().remove();
			$('div.replyMenu').children().remove();
			for(var i=0; i<data.list.length; i++)
			{
				var html="<tr><th>"+data.list[i].id+"</th><td class='"+data.list[i].num+"'>"+data.list[i].contents+"</td>";
				//조건문 if()
				html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>수정</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>삭제</button></td>";					
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";
			
			if(data.page.totalPage>5)
			{
				menu+="<a href='#none' onclick='nextReply(); return false;'>다음댓글보기</a><br>";
			}
			menu+="<a href='#none' onclick='allReply(); return false;'>전체댓글보기</a><br>";
			$('div.replyMenu').append(menu);
			
		},
		complete:function(data)
		{
			
		},
		error:function(xhr,status,error)
		{
			alert(error);
		}
	});		
}

function nextReply(){	
	
	$.ajax({
		type:"get",
		url:"nextReply",
		data:
		{
			num:${data.num},
			page:replyPage
		},	
		dataType:"json",
		success:function(data)
		{
			replyPage++;
			$('table.reply').children().remove();
			$('div.replyMenu').children().remove();
			for(var i=0; i<data.list.length; i++)
			{
				var html="<tr><th>"+data.list[i].id+"</th><td class='"+data.list[i].num+"'>"+data.list[i].contents+"</td>";
				//조건문 if()
				html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>수정</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>삭제</button></td>";					
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";			
			if(data.page.currPage<data.page.totalPage)
			{
				menu+="<a href='#none' onClick='nextReply(); return false;'>다음댓글보기</a><br>";
			}
			menu+="<a href='#none' onClick='prevReply(); return false;'>이전댓글보기</a><br>";
			menu+="<a href='#none' onClick='allReply(); return false;'>전체댓글보기</a>";
			$('div.replyMenu').append(menu);
		},
		complete:function(data)
		{
			
		},
		error:function(xhr,status,error)
		{
			alert(error);
		}
	});
}

function prevReply(){
	$.ajax({
		type:"get",
		url:"prevReply",
		data:
		{
			num:${data.num},
			page:replyPage
		},	
		dataType:"json",
		success:function(data)
		{
			replyPage--;
			$('table.reply').children().remove();
			$('div.replyMenu').children().remove();
			for(var i=0; i<data.list.length; i++)
			{
				var html="<tr><th>"+data.list[i].id+"</th><td class='"+data.list[i].num+"'>"+data.list[i].contents+"</td>";
				//조건문 if()
				html+="<td><button type='button' class='"+data.list[i].num+"'  onclick='replyModify("+data.list[i].num+")'>수정</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>삭제</button></td>";		;			
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";			
			
			menu+="<a href='#none' onClick='nextReply(); return false;'>다음댓글보기</a><br>";
			if(data.page.currPage!=1)
			{
				menu+="<a href='#none' onClick='prevReply(); return false;'>이전댓글보기</a><br>";					
			}			
			menu+="<a href='#none' onClick='allReply(); return false;'>전체댓글보기</a>";
			$('div.replyMenu').append(menu);
		},
		complete:function(data)
		{
			
		},
		error:function(xhr,status,error)
		{
			alert(error);
		}
	});
	
}


function del(){
	if(confirm('정말 삭제하시겠습니까?'))
	{
		$.ajax({
			type:"get",
			url:"delete",
			data:
			{
				num:${data.num}
			},	
			dataType:"json",
			success:function(data)
			{
				if(data.ok){
					alert("글이 성공적으로 삭제되었습니다.");
					location.href="getList";
				}else alert("글삭제에 실패하였습니다.");				
			},
			complete:function(data)
			{
				
			},
			error:function(xhr,status,error)
			{
				alert("글삭제에 실패하였습니다.");
			}			
		});		
	}	
}

function replyWrite(){
	if(confirm('정말 등록 하시겠습니까?'))
	{
		$.ajax({
			type:"get",
			url:"replyWrite",
			data:
			{
				contents:$('textarea.reply').val(),
				id:'scott',	
				ref:${data.num}
			},	
			dataType:"json",
			success:function(data)
			{
				$('table.reply').children().remove();
				$('div.replyMenu').children().remove();
				$('textarea.reply').val("");
				replyPage=1;
				for(var i=0; i<data.list.length; i++)
				{
					var html="<tr><th>"+data.list[i].id+"</th><td class='"+data.list[i].num+"'>"+data.list[i].contents+"</td>";
					//조건문 if()
					html+="<td><button type='button' class='"+data.list[i].num+"'  onclick='replyModify("+data.list[i].num+")'>수정</button>"+ 
					"<button type='button' onclick='replyDel("+data.list[i].num+")'>삭제</button></td>";		;			
					html+="</tr>";
					$('table.reply').append(html);
				}
				var menu="";				
				if(data.page.totalPage>5)
				{
					menu+="<a href='#none' onClick='nextReply(); return false;'>다음댓글보기</a><br>";
				}
				menu+="<a href='#none' onClick='allReply(); return false;'>전체댓글보기</a><br>";
				$('div.replyMenu').append(menu);
				
			},
			complete:function(data)
			{
				
			},
			error:function(xhr,status,error)
			{
				alert("글 등록에 실패하였습니다.");
			}			
		});		
	}	
	
}
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
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<table>
			<caption>글 읽기</caption>
			<tr>
				<th>번호</th>
				<td>${ data.num }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${ data.title }</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>${ data.id }</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${ data.cre_date }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${ data.contents }</td>
			</tr>
		</table>
		<button type="button" onclick="list()">목록</button>
		<button type="button" onclick="modify()">수정</button>
		<button type="button" onclick="del()">삭제</button>
		<br>
		<br>
		<br>

		<div class="replyForm">
			<textarea class="reply" rows="10" cols="40"></textarea>
			<br>
			<button type="button" onclick="replyWrite()">글쓰기</button>
			<br>
			<br>
		</div>


		<table class="reply">
			<c:forEach var="list" items="${ map.list }">
				<tr>
					<th>${ list.id }</th>
					<td class="${ list.num }">${ list.contents }</td>

					<c:choose>
						<%-- <c:when test="${sessionScope.id eq 'scott'}"> --%>
						<c:when test="${ 'scott' eq 'scott' }">
							<td>
								<button type="button" class="${ list.num }" onclick="replyModify(${ list.num })">수정</button>
								<button type="button" onclick="replyDel(${ list.num })">삭제</button>
							</td>
						</c:when>
					</c:choose>
				</tr>
			</c:forEach>
		</table>

		<div class="replyMenu">
			<c:if test="${ map.page.listTotal > 5 }">
				<a href="#none" onClick="nextReply(); return false;">다음댓글보기</a>
				<br>
			</c:if>
			<a href="#none" onClick="allReply(); return false;">전체댓글보기</a>
			<br>
		</div>
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>