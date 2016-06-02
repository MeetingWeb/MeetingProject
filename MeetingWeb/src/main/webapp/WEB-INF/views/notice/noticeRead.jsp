<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript">
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
				//���ǹ� if()
				html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>����</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>����</button></td>";				
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";			
			if(data.page.totalPage>data.page.currPage)
			{				
				menu+="<a href='#none' onClick='nextReply(); return false;'>������ۺ���</a><br>";
			}
			if(data.page.currPage>1)
			{
				menu+="<a href='#none' onClick='prevReply(); return false;'>������ۺ���</a><br>";	
			}
			
			menu+="<a href='#none' onClick='allReply(); return false;'>��ü��ۺ���</a><br>";
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
	$('button.'+num).text('�Ϸ�');
	$('button.'+num).removeAttr('onclick');
	$('button.'+num).attr('onclick','replyModifyGo('+num+')');	

		
}

function replyDel(num){
	
	if(confirm('���� ���� �Ͻðڽ��ϱ�?'))
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
					//���ǹ� if()
					html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>����</button>"+ 
					"<button type='button' onclick='replyDel("+data.list[i].num+")'>����</button></td>";				
					html+="</tr>";
					$('table.reply').append(html);
				}
				var menu="";			
				
				if(data.page.totalPage>data.page.currPage)
				{				
					menu+="<a href='#none' onClick='nextReply(); return false;'>������ۺ���</a><br>";
				}
				if(data.page.currPage>1)
				{
					menu+="<a href='#none' onClick='prevReply(); return false;'>������ۺ���</a><br>";	
				}
				
				menu+="<a href='#none' onClick='allReply(); return false;'>��ü��ۺ���</a><br>";
				$('div.replyMenu').append(menu);
				
			},
			complete:function(data)
			{
				
			},
			error:function(xhr,status,error)
			{
				alert("�ۻ����� �����Ͽ����ϴ�.");
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
				//���ǹ� if()
				html+="<td><button type='button' class='"+data[i].num+"' onclick='replyModify("+data[i].num+")'>����</button>"+ 
				"<button type='button' onclick='replyDel("+data[i].num+")'>����</button></td>";			
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="<a href='#none' onClick='firstReply(); return false;'>ó����ۺ���</a>";
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
				//���ǹ� if()
				html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>����</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>����</button></td>";					
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";
			
			if(data.page.totalPage>5)
			{
				menu+="<a href='#none' onclick='nextReply(); return false;'>������ۺ���</a><br>";
			}
			menu+="<a href='#none' onclick='allReply(); return false;'>��ü��ۺ���</a><br>";
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
				//���ǹ� if()
				html+="<td><button type='button' class='"+data.list[i].num+"' onclick='replyModify("+data.list[i].num+")'>����</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>����</button></td>";					
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";			
			if(data.page.currPage<data.page.totalPage)
			{
				menu+="<a href='#none' onClick='nextReply(); return false;'>������ۺ���</a><br>";
			}
			menu+="<a href='#none' onClick='prevReply(); return false;'>������ۺ���</a><br>";
			menu+="<a href='#none' onClick='allReply(); return false;'>��ü��ۺ���</a>";
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
				//���ǹ� if()
				html+="<td><button type='button' class='"+data.list[i].num+"'  onclick='replyModify("+data.list[i].num+")'>����</button>"+ 
				"<button type='button' onclick='replyDel("+data.list[i].num+")'>����</button></td>";		;			
				html+="</tr>";
				$('table.reply').append(html);
			}
			var menu="";			
			
			menu+="<a href='#none' onClick='nextReply(); return false;'>������ۺ���</a><br>";
			if(data.page.currPage!=1)
			{
				menu+="<a href='#none' onClick='prevReply(); return false;'>������ۺ���</a><br>";					
			}			
			menu+="<a href='#none' onClick='allReply(); return false;'>��ü��ۺ���</a>";
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
	if(confirm('���� �����Ͻðڽ��ϱ�?'))
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
					alert("���� ���������� �����Ǿ����ϴ�.");
					location.href="getList";
				}else alert("�ۻ����� �����Ͽ����ϴ�.");				
			},
			complete:function(data)
			{
				
			},
			error:function(xhr,status,error)
			{
				alert("�ۻ����� �����Ͽ����ϴ�.");
			}			
		});		
	}	
}

function replyWrite(){
	if(confirm('���� ��� �Ͻðڽ��ϱ�?'))
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
					//���ǹ� if()
					html+="<td><button type='button' class='"+data.list[i].num+"'  onclick='replyModify("+data.list[i].num+")'>����</button>"+ 
					"<button type='button' onclick='replyDel("+data.list[i].num+")'>����</button></td>";		;			
					html+="</tr>";
					$('table.reply').append(html);
				}
				var menu="";				
				if(data.page.totalPage>5)
				{
					menu+="<a href='#none' onClick='nextReply(); return false;'>������ۺ���</a><br>";
				}
				menu+="<a href='#none' onClick='allReply(); return false;'>��ü��ۺ���</a><br>";
				$('div.replyMenu').append(menu);
				
			},
			complete:function(data)
			{
				
			},
			error:function(xhr,status,error)
			{
				alert("�� ��Ͽ� �����Ͽ����ϴ�.");
			}			
		});		
	}	
	
}
</script>
</head>
<body>
<table>
<caption>�� �б�</caption>
<tr><th>��ȣ</th><td>${ data.num }</td></tr>
<tr><th>����</th><td>${ data.title }</td></tr>
<tr><th>�۾���</th><td>${ data.id }</td></tr>
<tr><th>��¥</th><td>${ data.cre_date }</td></tr>
<tr><th>����</th><td>${ data.contents }</td></tr>
</table>
<button type="button" onclick="list()">���</button>
<button type="button" onclick="modify()">����</button>
<button type="button" onclick="del()">����</button>
<br><br><br>

<div class="replyForm">
<textarea class="reply"rows="10" cols="40"></textarea><br>
<button type="button" onclick="replyWrite()">�۾���</button>
<br><br>
</div>


<table class="reply">
<c:forEach var="list" items="${ map.list }">
<tr><th>${ list.id }</th><td class="${ list.num }">${ list.contents }</td>

<c:choose>
<%-- <c:when test="${sessionScope.id eq 'scott'}"> --%>
<c:when test= "${ 'scott' eq 'scott' }">
<td>
<button type="button" class="${ list.num }" onclick="replyModify(${ list.num })">����</button> 
<button type="button" onclick="replyDel(${ list.num })">����</button></td>
</c:when>
</c:choose>
</tr>
</c:forEach>
</table>

<div class="replyMenu">
<c:if test="${ map.page.listTotal > 5 }">
<a href="#none" onClick="nextReply(); return false;">������ۺ���</a><br> 
</c:if>
<a href="#none" onClick="allReply(); return false;">��ü��ۺ���</a><br> 
</div>

</body>
</html>