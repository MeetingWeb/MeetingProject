<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="joinform">
	<table>
		<caption>join</caption>
		<tr>
			<td>E-mail</td>
			<td>
				<input type="text" name="email" id="email">
				<div onclick="javascript:email_check()" style="cursor: pointer; float: right;" >이메일 체크</div>
			</td>
		</tr>
		<tr>
			<td>ID</td>
			<td>
				<input type="text" name="id" id="id" disabled>
				<div id="id_checktext" style="float: right;" ></div>
				<div id="ids_check" onclick="javascript:id_check()" style="cursor: pointer; float: right;" >중복체크</div>
			</td>
		</tr>
		<tr>
			<td>PassWord</td>
			<td>
				<input type="password" name="pw" id="pw" disabled><div id="pwc_checktext" style="float: right;"></div>
			</td>
		</tr>
		<tr>
			<td>PassWordCheck</td>
			<td>
				<input type="password" name="pwc" id="pwc" disabled>
				<div id="pw_checktext" style="float: right;"></div>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" disabled>
			</td>
		</tr>
		
		<tr>
			<td>관심분야</td>
			<td>
				<input type="checkbox" name="interests" value="exercise" disabled>
				운동
				<input type="checkbox" name="interests" value="travle" disabled>
				여행
				<input type="checkbox" name="interests" value="fishing" disabled>
				낚시
			</td>
		</tr>
	</table>
	<input type="hidden" name="power" value="MEMBER">
	<div onclick="javacript:joinsave()" style="cursor: pointer;">저 장</div>
</form>