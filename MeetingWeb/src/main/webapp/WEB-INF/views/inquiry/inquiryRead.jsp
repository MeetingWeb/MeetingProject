<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='http://code.jquery.com/jquery-2.2.2.min.js'></script>
<%-- <script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
 --%>
<script type="text/javascript">

$(function(){
	/* 
	var img_name = ${ivo.img_name};
	
	if(img_name==null)
	{
		$('img').css("opacity","0").prop("disabled", true);
	} */
	
	
	var start = ${start};
	var end = ${start+4};
	var pages = ${repleptotal};
	
	if(start==1)
	{
		$('button[name=left]').css("opacity","0").prop("disabled", true);
	}
	if(end>pages)
	{
		$('button[name=right]').css("opacity","0").prop("disabled", true);
	}
	
	$('button[name=replebtn]').each(function(){
		$(this).click(function(index){
			//$(this).css("border","1px solid red").css("width","30px");;
			var num = $(this).val()
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'deletes',
				data : {num:num},
				success : function(evt) {
					if(evt.ok==true)
					{
						alert("삭제되었습니다.");
					}
					else if(evt.ok==false)
					{
						alert("삭제가 안됨");
					}
				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});
		})
	})
	
	$('button[name=repleubtn]').each(function(){
		$(this).click(function(index){
			//$(this).css("border","1px solid red").css("width","30px");;
			var num = $(this).val()
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'repleupdateform',
				data : {num:num},
				success : function(evt) {
					if(evt.ok==true)
					{
						$('#cont').html("<input type='text' id='ucontents' name=contents value="+evt.contents+">");
						$('#btn').html("<button type='button' id='repleybtn' name='repleybtn' value="+evt.num+">저장</button>");
					}
				},
				complete : function(data) {

				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});
		})
	});

	
	$(document).on("click", "#repleybtn",function() {
			var num = $(this).val()
			var contents = $('#ucontents').val();
			alert(contents)
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'repleupdate',
				data : {num:num,contents:contents},
				success : function(evt) {
					if(evt.ok==true)
					{
						alert("저장되었습니다.");
						location.href='readForm?num='+${ivo.num}+'&page=1&start=1';
					}
					else if(evt.ok==false)
					{
						alert("저장되지 않았습니다.");
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

function deletes() {
	var num = $('input[name=num]').val();
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'deletes',
		data : {num:num},
		success : function(evt) {
			if(evt.ok==true)
			{
				alert("삭제되었습니다.");
			}
			else if(evt.ok==false)
			{
				alert("삭제가 안됨");
			}
		},
		complete : function(data) {

		},
		error : function(xhr, status, error) {
			alert(error);
		}
	});
}

$(function(){
	var flip = 0;
	$("#replyformbtn").click(function () {
	$("#reply").toggle( flip++ % 2 == 0 );
	});  

});

function replysave() 
{

	var contents = $('#con').val();

	if(contents=="" || contents==null)
	{
		alert("내용을 입력해 주세요.")	
	}
	else if(contents!="" && contents!=null)
	{
		if (confirm("정말 저장하시겠습니까??") == true)
		{
			var form = new FormData(document.getElementById('reply')); 
			alert(form);
			$.ajax
			({
				dataType:'json',
				type:'post',
				url:'writesave',
				data:form,
				contentType: false,
				processData: false,
				success:function(evt)
				{
					if(evt.ok==true)
					{
						alert("저장되었습니다.");	
						location.href='readForm?num='+${ivo.num}+'&page=1&start=1';
					}
					else
					{
						alert("저장에 실패했습니다.");	
					}
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
	}
};




</script>
</head>
<body>
<form id="readform">
<table>
<caption>문의하기 읽기</caption>
<tr><td>제목</td><td><input type="text" name="title" value="${ivo.title} " readonly="readonly"></td></tr>
<tr><td>내용</td><td><textarea cols="50" rows="20" name="contents"  readonly="readonly">${ivo.contents}</textarea></td></tr>
</table>

<img src="../resources/images/${ivo.img_name }">
<input type="hidden" name="id" value="${ivo.id} ">
<input type="hidden" name="num" value="${ivo.num} ">
<input type="hidden" name="img_name" value="null">
<button type="button" onclick="location.href='update?num=${ivo.num}'">수정</button>
<button type="button" onclick="javascript:deletes()">삭제</button>
<button type="button" id="replyformbtn">댓글쓰기</button>
</form>


<table>
<caption>댓글리스트</caption>
<tr><th>번호</th><th>내용</th><th>글쓴이</th></tr>
<c:forEach var="replylist" items="${replylist}" >
<tr><td>${replylist.num}</td><td id="cont">${replylist.contents}</td><td>${replylist.id}</td><td id="btn"><button type="button" name="repleubtn" value="${replylist.num}">수정</button><button name="replebtn" value="${replylist.num}" type="button">삭제</button></td></tr>
</c:forEach>
</table>

<c:set var="en" value="${start+4}"></c:set>
<c:if test="${ start+4 > repleptotal}">
<c:set var="en" value="${repleptotal}"></c:set>
</c:if>

<button type="button" name="left" onclick="location.href='readForm?page=${start-5}&start=${start-5}&num=${ivo.num}'"><<</button>
<c:forEach var="i" begin="${start}" end="${en}">
<a href="readForm?page=${i}&start=${start}&num=${ivo.num}">${i}</a>
</c:forEach>
<button type="button" name="right" onclick="location.href='readForm?page=${start+5}&start=${start+5}&num=${ivo.num }'">>></button>


<form name="replyForm" id="reply" style="display: none;" enctype="multipart/form-data">
<input type="hidden" name="ref" value="${ivo.num }">
<input type="hidden" name="title" value="${ivo.title}">
<input type="hidden" name="id" value="${ivo.id }">
<input type="file" name="file" style=""display: none;"">
<input type="text" size="100" name="contents" id="con" placeholder="내용을 입력해 주세요."><br>
<button type="button" onclick="javascript:replysave()">저 장</button>
</form>
</body>
</html>
