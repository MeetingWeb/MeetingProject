<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ǻ�� �� ����</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>

<!-- ckEdit.js ��� -->
<script type="text/javascript" src='<c:url value="/resources/ckeditor/ckeditor.js"/>' ></script>

<script>
	//ckeditor setting
	var ckeditor_config = {
			resize_enabled : false, // ������ ũ�⸦ �������� ����
			enterMode : CKEDITOR.ENTER_BR , // ����Ű�� <br> �� ������.
	     	shiftEnterMode : CKEDITOR.ENTER_P ,  // ����Ʈ +  ���͸� <p> �� ������.
	     	toolbarCanCollapse : true , 
	     	removePlugins : "elementspath", // DOM ������� ����
	     	filebrowserUploadUrl: '/file_upload', // ���� ���ε带 ó�� �� ��� ����.
	
	     	// �����Ϳ� ����� ��ɵ� ����
	     	toolbar : [
	       		[ 'Source', '-' , 'NewPage', 'Preview' ],
	       		[ 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo' ],
	       		[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],
	       		[ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ],
	       		'/',
	       		[ 'Styles', 'Format', 'Font', 'FontSize' ],
	       		[ 'TextColor', 'BGColor' ],
	       		[ 'Image', 'Flash', 'Table' , 'SpecialChar' , 'Link', 'Unlink']
	
	     	]
	};
	
	var editor = null;
	
	$(function() {
		// ckeditor ����
	    editor = CKEDITOR.replace("ckEditor" , ckeditor_config, {
	    	width:'100%',
	        height:'400px',
	        filebrowserImageUploadUrl: '/imgUpload' //���� ��η� ������ �����Ͽ� ���ε� ��Ų��.
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
			url : "./reportEdit",
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
				alert("�ý��� ����!");
			}
		}); // end of ajax({})
	} // end of saved()
</script>

</head>
<body>
	
	<div align="center">
		<h1>��ǻ�� ���</h1>
		
		<form>
			<table>
				<tr>
					<th>�� ��ȣ</th>
					<td><input type="text" name="num" value="${info.num}" 
							readonly="readonly" size="5" /></td>
				</tr>
				<tr>
					<th>����</th>
					<td><input type="text" name="title" value="${info.title}" size="80" /></td>
				</tr>
				
				<tr>
					<th>�󼼳���</th>
					<td height="50">
						<textarea id="ckEditor" name="contents" cols="100" rows="30">${info.contents}</textarea>
					</td>
				</tr>

			</table>
			
			<button type="button" onclick="saved()">���</button>
			<input type="reset"	value="�ٽ��ۼ�"> <input type="button" 
				value="���" onclick="location='./reportList'">
		</form>
		
	</div>
	
</body>
</html>