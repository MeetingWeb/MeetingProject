<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	     	filebrowserUploadUrl: './upload' // 파일 업로드를 처리 할 경로 설정.
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
		
		$.ajax({
			url : "./reportWrite",
			type : "post",
			data : $('form').serialize(),
			success : function(save) {
				if(save.code = 200) {
					alert(save.msg);
					location.href = save.url;
				} else if(save.code == 201) {
					alert(save.msg);
					location.href = save.url;
				}
			},
			error : function(error) {
				alert("시스템 에러!");
			}
		}); // end of ajax({})
	} // end of saved()
</script>

</head>
<body>
	
	<div align="center">
		<h1>사건사고 등록</h1>
		
		<form>
			<table>
				<tr>
					<th>작성자</th>
					<td>
						<input type="text" name="id" value="<sec:authentication property='name'/>" 
							readonly="readonly" size="10" />
					</td>
				</tr>

				<tr>
					<th>제목</th>
					<td><input type="text" name="title" size="80" /></td>
				</tr>
				
				<tr>
					<th>상세내용</th>
					<td height="50">
						<textarea id="ckEditor" name="contents" cols="100" rows="30"></textarea>
					</td>
				</tr>

			</table>
			
			<button type="button" onclick="saved()">등록</button>
			<input type="reset"	value="다시작성"> <input type="button" 
				value="목록" onclick="location='./reportList'">
		</form>
		
	</div>
	
</body>
</html>