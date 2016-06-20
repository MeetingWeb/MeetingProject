<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- Bootstrap -->
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/navi.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/chat.js"/>'></script>


<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/report.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" 
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" 
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	 integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<!-- Bootstrap -->

<title>사건사고 등록</title>

<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>

<!-- ckEdit.js 경로 -->
<script type="text/javascript" src='<c:url value="/resources/ckeditor/ckeditor.js"/>' ></script>

<script>
	//ckeditor setting
	var ckeditor_config = {
			resize_enabled : false, // 에디터 크기를 조절하지 않음
			enterMode : CKEDITOR.ENTER_BR , // 엔터키를 <br> 로 적용함.
	     	shiftEnterMode : CKEDITOR.ENTER_P ,  // 쉬프트 +  엔터를 <p> 로 적용함.
	     	toolbarCanCollapse : true , 
	     	removePlugins : "elementspath", // DOM 출력하지 않음
	     	filebrowserUploadUrl: './imgUpload' // 파일 업로드를 처리 할 경로 설정.
	};
	
	var editor = null;
	
	$(function() {
		// ckeditor 적용
        editor = CKEDITOR.replace("ckEditor" , ckeditor_config, {
        	width:'100%',
            height:'400px',
        });
		
        CKEDITOR.on('dialogDefinition', function(ev){
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
          
            switch (dialogName) {
                case 'image': //Image Properties dialog
                    //dialogDefinition.removeContents('info');
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
		
	});
	
	function saved() {
		editor.updateElement();
		
		var title = $('input[name=title]').val();
		var contents = $('textarea[name=contents]').val();
		
		if(title == "") {
			confirm('제목을 입력해 주세요.');
			return;
			
		} else if(contents == "") {
			confirm('내용을 입력해 주세요.');
			return;
			
		} else {			
			$.ajax({
				url : "./reportWrite",
				type : "post",
				data :  $('#f-wirte').serialize(),
				success : function(save) {
					if(save.code = 200) {
						alert(save.msg);
						location.href = "./reportInfo?num=" + save.maxNum;
					} else if(save.code == 201) {
						alert(save.msg);
						location.href = save.url;
					}
				},
				error : function(error) {
					alert("시스템 에러!");
				}
			}); // end of ajax({})
		} // end of else
		
	} // end of saved()
</script>

</head>
<body>
	<jsp:include page="../include/navi.jsp" />
	<jsp:include page="../include/header.jsp" />
	<section id="contents">

		<div id="header">
			<h3>사건사고 등록</h3>
		</div>
		<form id="f-wirte">
			<table id="tbl" class="table col-xs-4">
				<tr>
					<th id="thCenter">작성자</th>
					<td>
						<input type="text" name="id" value="<sec:authentication property='name'/>" 
							readonly="readonly" size="10" />
					</td>
				</tr>
				
				<tr>
					<th id="thCenter">제목</th>
					<td><input type="text" name="title" size="80" /></td>
				</tr>
					
				<tr>
					<th id="thCenter">상세내용</th>
					<td height="50">
						<textarea id="ckEditor" name="contents" cols="30" rows="50"></textarea>
					</td>
				</tr>
	
			</table>
		</form>
				
		<div align="right">
			<button type="button" class="btn btn-default xs-4" onclick="location='./reportList'">목 록</button>
			<button type="button" class="btn btn-default xs-4" onclick="saved()">등 록</button>
			<input type="reset" class="btn btn-default xs-4"	value="다시작성"> 
		</div>
	
		<jsp:include page="../include/loginForm.jsp" />
		<jsp:include page="../include/joinForm.jsp" />
	</section>
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>