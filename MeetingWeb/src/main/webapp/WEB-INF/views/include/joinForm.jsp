<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="joinform">
	
				<div id="join_group">
				
				<div id="join_title">Join COME TOGETHER</div>
				
				<label>E-mail</label><input type="text" name="email" id="email" >
				 
				 <div id="email_text" ></div>
				<div id="emailcheck" onclick="javascript:email_check()" style="cursor: pointer; " >이메일 체크</div>
				
				<label>ID</label><input type="text" name="id" id="id"disabled>

				<div id="id_checktext" ></div>

				<div id="ids_check" onclick="javascript:id_check()" style="cursor: pointer; position: relative; left:0px; top: 0px; display: none;" >중복체크</div>

				<label>PassWord</label><input type="password" name="pw" id="pw" disabled>
				
				<div id="pwc_checktext" ></div>
				
				<label>PassWordCheck</label><input type="password" name="pwc" id="pwc" disabled>
				
				<div id="pw_checktext" ></div>
				
				<label>Name</label><input type="text" name="name" disabled>
				
				
				<label id="in">관심분야</label>
				<table id="checkBox"  style="margin: 26px 0 0 150px; border:solid 1px; width: 300px;">
				<tr>
				<td>
				<input type="checkbox" name="interest" value="축구" disabled>
				축구  
				</td>
				<td>
				<input type="checkbox" name="interest" value="농구" disabled>
				농구  
				</td>
				<td>
				<input type="checkbox" name="interest" value="야구"disabled>
				야구
				</td>

				</tr>
				
				<tr>
				<td>
				<input type="checkbox" name="interest" value="배구"disabled>
				배구
				</td>
				<td>
				<input type="checkbox" name="interest" value="수영" disabled>
				수영
				</td>
				<td>
				<input type="checkbox" name="interest" value="여행" disabled>
				여행
				</td>
				
				</tr>
				<tr>
				<td>
				<input type="checkbox" name="interest" value="영화보기"disabled>
				영화보기
				</td>
				<td>
				<input type="checkbox" name="interest" value="밥 먹기"disabled>
				밥 먹기
				</td>
				<td>
				<input type="checkbox" name="interest" value="자전거" disabled>
				자전거
				</td>
				
				</tr>
				   
				</table>
	<input type="hidden" name="power" value="MEMBER">
	<input type="hidden" name="location" value="37.505027816784036,127.0152997970581">

	<div onclick="javacript:joinsave()" style="cursor: pointer;float: right;height: 48px;margin: 20px 30px;padding: 0 24px;background-color: #33B573;color: #fff;text-align: center;text-transform: uppercase;font-weight: 700;font-size: 15px;line-height: 48px;">저 장</div>
	
	</div>
</form>