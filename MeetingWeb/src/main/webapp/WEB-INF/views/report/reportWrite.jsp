<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ǻ�� ���</title>
<script type="text/javascript" src='<c:url value="/resources/js/jquery-2.2.2.min.js"/>'></script>

<!-- nicEdit.js ��� -->
<script type="text/javascript" src="<c:url value='../nicEdit/nicEdit.js'/>"></script>

<script>
	//������ ȣ��
	bkLib.onDomLoaded(function() {
		nicEditors.editors.push(new nicEditor().panelInstance(document
				.getElementById('myNicEditor')));
	});
	
	function saved() {
		var contents = $(".nicEdit-main").html();
		$("textarea[name=contents]").val(contents);
		
		$.ajax({
			url : "./write",
			type : "post",
			data : $('form').serialize(),
			success : function(data) {
				if(data.code = 200) {
					alert(data.msg);
					location.href = data.url;
				} else if(data.code == 201) {
					alert(data.msg);
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
					<th>�ۼ���</th>
					<td>
						<input type="text" name="id" value="<sec:authentication property='name'/>" 
							readonly="readonly" size="10" />
					</td>
				</tr>

				<tr>
					<th>����</th>
					<td><input type="text" name="title" size="80" /></td>
				</tr>
				
				<tr>
					<th>�󼼳���</th>
					<td height="50">
						<textarea id="myNicEditor" name="contents" cols="100" rows="30"></textarea>
					</td>
				</tr>

			</table>
			
			<button type="button" onclick="saved()">���</button>
			<input type="reset"	value="�ٽ��ۼ�"> <input type="button" value="���" onclick="location='./list'">
		</form>
		
	</div>
	
</body>
</html>