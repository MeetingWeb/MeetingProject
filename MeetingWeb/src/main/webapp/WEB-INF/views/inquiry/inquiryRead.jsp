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
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/inquiry_style.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
	var user_id = '<c:out value="${sessionScope.id}"/>';
	
	$(function() {
		
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
							$('#btn').html("<button class='glyphicon glyphicon-ok' type='button' id='repleybtn' name='repleybtn' value="+evt.num+"></button>");
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


		$("#show_Infomation").css("height", $(window).height() - 64);

		if ("${sessionScope.id}" != "") {		
			drawMeetings(map);
			showMyLocation();			
			if("${requestScope.search}"=='ok')
			{
				$("#search-menu").css('display', 'block');	
			}
		}


	
	});
	
	function deletes() {
		if (confirm("삭제 하시겠습니까?") == true)
			{
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
						location.href='list?page=1&start=1&check=1';
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
		
	}



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
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents" style="background-color: #fff;">

<form id="readform">
<table id="read_table">
<caption>Inquiry</caption>
<tr style="border-top: 2px solid #333333;"><td id="wtitle">제목</td><td><input style="background-color:transparent;border:0 solid black;" type="text" name="title" value="${ivo.title} " readonly="readonly"></td></tr>
<tr>
<td id="wcontents">내용
</td>
<td>
<div style="width: 80%;">${ivo.contents}
</div>

<c:if test="${ivo.img_name != 'null' }">
<img src="../resources/images/${ivo.img_name }">
</c:if>
</td>
</tr>
</table>

<input type="hidden" name="id" value="${ivo.id} ">
<input type="hidden" name="num" value="${ivo.num} ">
<input type="hidden" name="img_name" value="null">
<div id="btns">
<a id="listbtn" href='list?page=1&start=1&check=1' style="cursor: pointer;"><img src="/NowMeetingWeb/resources/images/list.png"></a>
<a id="editbtn" onclick="location.href='update?num=${ivo.num}'" style="cursor: pointer;"><img src="/NowMeetingWeb/resources/images/edit.png"></a>
<a id="deletebtn" onclick="javascript:deletes()" style="cursor: pointer;"><img src="/NowMeetingWeb/resources/images/delete.png"></a>
<a id="writebtn2" href="writeForm" style="cursor: pointer;"><img src="/NowMeetingWeb/resources/images/write2.png"></a>

</div>
</form>



<form name="replyForm" id="reply" enctype="multipart/form-data">
<input type="hidden" name="ref" value="${ivo.num }">
<input type="hidden" name="title" value="${ivo.title}">
<input type="hidden" name="id" value="${ sessionScope.id}">
<input type="file" name="file" style="display: none;">
<textarea rows="3" cols="208" name="contents" id="con" placeholder="내용을 입력해 주세요."></textarea><br>
<div id="reple_btns">
<a style="cursor: pointer;" onclick="javascript:replysave()"><img src="/NowMeetingWeb/resources/images/replewrite.png"></a><br>
</div>
</form>








<table>
<caption >Reply</caption>
<tr><th id="replenum">번호</th><th id="repletitle">내용</th><th id="repleid">작성자</th><th id="repleday">작성일</th><th></th></tr>
<c:forEach var="replylist" items="${replylist}" >
<tr><td id="replenum" style="border-bottom: 0px solid #333333;">${replylist.num}</td><td id="cont" style="border-bottom: 0px solid #333333;">${replylist.contents}</td><td id="repleid" style="border-bottom: 0px solid #333333;">${replylist.id}</td><td id="repleday" style="border-bottom: 0px solid #333333;">${replylist.cre_date}</td><td id="btn" style="border-bottom: 0px solid #333333;">
<c:if test="${replylist.id == sessionScope.id || sessionScope.id=='admin'}">
<button type="button" class="glyphicon glyphicon-erase" name="repleubtn" value="${replylist.num}"></button><button class="glyphicon glyphicon-trash" name="replebtn" value="${replylist.num}" type="button"></button></td></tr>
</c:if>
</c:forEach>
</table>









<c:set var="en" value="${start+4}"></c:set>
<c:if test="${ start+4 > repleptotal}">
<c:set var="en" value="${repleptotal}"></c:set>
</c:if>

<div id="pageNavi">
<button type="button" name="left" onclick="location.href='readForm?page=${start-5}&start=${start-5}&num=${ivo.num}'"><<</button>
<c:forEach var="i" begin="${start}" end="${en}">
<a href="readForm?page=${i}&start=${start}&num=${ivo.num}">${i}</a>
</c:forEach>
<button type="button" name="right" onclick="location.href='readForm?page=${start+5}&start=${start+5}&num=${ivo.num }'">>></button>
</div>




		<div class="recommend">		
			<br>	
				<span id="recommend-more">
				<div class="glyphicon glyphicon-retweet menu-btn-icon"></div>				
				<a href='#none' onClick='getRecommend(); return false;'> 새로고침</a>
			</span>
			<div class="recommend-list"></div>
			<br>
			
		</div>
		
		
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
</body>
<c:if test="${param.error==true }">
	<script type="text/javascript">
		alert("로그인 실패");
	</script>
</c:if>
</html>
