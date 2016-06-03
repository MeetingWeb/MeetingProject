<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="joinform">
	<table>
		<caption>join</caption>
		<tr>
			<td>ID</td>
			<td>
				<input type="text" name="id" id="id">
				<div id="id_checktext" style="float: right;"></div>
				<div onclick="javascript:id_check()" style="cursor: pointer; float: right;">중복체크</div>
			</td>
		</tr>
		<tr>
			<td>PassWord</td>
			<td>
				<input type="password" name="pw" id="pw">
			</td>
		</tr>
		<tr>
			<td>PassWordCheck</td>
			<td>
				<input type="password" name="pwc" id="pwc">
				<div id="pw_checktext" style="float: right;"></div>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name">
			</td>
		</tr>
		<tr>
			<td>E-mail</td>
			<td>
				<input type="text" name="email" id="email">
				<div onclick="javascript:email_check()" style="cursor: pointer; float: right;">이메일 체크</div>
			</td>
		</tr>
		<tr>
			<td>관심분야</td>
			<td>
				<input type="checkbox" name="interests" value="exercise">
				운동
				<input type="checkbox" name="interests" value="travle">
				여행
				<input type="checkbox" name="interests" value="fishing">
				낚시
			</td>
		</tr>
	</table>
	<input type="hidden" name="power" value="MEMBER">
	<div onclick="javacript:joinsave()" style="cursor: pointer;">저 장</div>
</form>