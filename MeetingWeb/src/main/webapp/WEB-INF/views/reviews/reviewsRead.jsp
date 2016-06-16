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
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/reviews_style.css"/>'>
<title>여기여기 붙어라</title>
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';
var replyPage=1;
function del(num) {
	if(confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			url:"delete",
			data:{num : num},
			dataType: "json",
			type:"post",
			success : function(obj){
				if(obj.ok) {
					alert("삭제 성공");
					location.href="list";
				} else {
					alert("삭제 실패");
				}
					
			}
		});
	}
}

function modify(){
	location.href="modify?num=${ data.num }";
}

function replyWrite(){
	if(confirm("댓글을 등록하시겠습니까?")){
		$.ajax({
			type:"get",
			url:"replyWrite",
			data:
			{
				contents:$('textarea.reply').val(),
				id:'${sessionScope.id}',	
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
function replyModify(num){	
	var text=$('td.'+num).text();
	$('td.'+num).text("");
	var html="<input type='text' class='"+num+"'value='"+text+"'>"
	$('td.'+num).append(html);
	$('button.'+num).text('완료');
	$('button.'+num).removeAttr('onclick');
	$('button.'+num).attr('onclick','replyModifyGo('+num+')');	

		
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
</script>
</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">
		<div id="contents-in">
			<h2>REVIEWS READ</h2>
			<div id="contents-in-board">
				<table class="table">
					<tr>
						<td style="width: 15%;">제목</td>
						<td>${ data.title }<input type="hidden" name="num" value="${data.num }">
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${data.id }</td>
					</tr>
					<tr>
						<td>작성일</td>
						<td>${data.cre_date}</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: left;">${data.contents}<br>
							<br>
							<br>
							<br>
							<br>
							<c:if test="${data.mod_file_name != 'none' }">
								<img src="../resources/images/${data.mod_file_name }">
							</c:if>
						</td>
					</tr>
				</table>
			</div>
			<div class="pull-left" id="reply-btn" onclick="javascript:location.href='/NowMeetingWeb/reviews/list'">LIST</div>
			<c:if test="${data.id == sessionScope.id }">
				<div class="pull-left" id="reply-btn" onclick="modify()">MODIFY</div>
				<div class="pull-left" id="reply-btn" onclick="del(${data.num})">DELETE</div>
			</c:if>
			<br>
			<br>
			<br>

			<div class="replyForm contents-in-reply">
				<textarea class="reply form-control" rows="3"></textarea>
				<div class="pull-right" id="reply-btn" onclick="replyWrite()">REPLY</div>
			</div>


			<table class="reply table">
				<c:forEach var="list" items="${ map.list }">
					<tr>
						<th>${ list.id }</th>
						<td class="${ list.num }">${ list.contents }</td>

						<c:choose>
							<%-- <c:when test="${sessionScope.id eq 'scott'}"> --%>
							<c:when test="${ sessionScopte.id == list.id }">
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
		</div>
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>