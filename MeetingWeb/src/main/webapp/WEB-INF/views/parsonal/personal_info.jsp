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
<script type="text/javascript" src='<c:url value="/resources/js/map.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/join.js"/>'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/basic_style.css"/>'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
   crossorigin="anonymous">
   
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
   crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyALsCWQfq_e5wj4Dcna1ZR99Ik1fM0CXLo&callback=initMap" async defer></script>
<title>여기여기 붙어라</title>
<script type="text/javascript">
var user_id = '<c:out value="${sessionScope.id}"/>';
$(function(){
   
    $("#show_Infomation").css("height",$(window).height()-64);
   
    if("${sessionScope.id}"!="")
   {      
          console.log(user_id);
         drawMeetings(map);            
         showMyLocation();
         var id = user_id;
         $.ajax({
            type : 'post',
            dataType : 'json',
            data : {id:id},
            url : 'personal_info',         
            success : function(data) {
               $('div#pemail').text(data.email);
               $('div#pid').text(data.id);
               $('div#pname').text(data.name);
               
               for(var i=0; i<data.interests.length;i++)
               {
                  $("#"+data.interests[i]+"").prop('checked', true) ;
               }
               
            },
            complete : function(data) {

            },
            error : function(xhr, status, error) {
               alert(error);
            }
         });
         
      
         
   }   
   

   
    
});




</script>
</head>
<body>
   <jsp:include page="../include/navi.jsp" />
   <jsp:include page="../include/header.jsp" />
   <section id="contents" style="background-image: url('/NowMeetingWeb/resources/images/map.jpg'); height: 1011px;">

<form id="personal_info">
   <div id="personal_group">
            
            <div id="personal_title">Personal Information</div>
            
            <label>ID</label><div id="pid"></div><br>
            
            <label>Name</label><div id="pname"></div><br>
            
            <label>E-mail</label><div id="pemail" ></div><br>
            
            <div id="pass_changeform" style="display: none;">
            <label>PassWord</label><input type="password" name="pw" id="pw" class="pws">
            
            <div id="pwc_checktext" class="pwc_checktext2"></div>
            
            <label>PassWordCheck</label><input type="password" name="pwc" id="pwc" class="pwcs">
            
            <div id="pw_checktext" class="pw_checktext22"></div>

             </div>
            
            <label id="in">관심분야</label>
            <table id="checkBox"  style="margin: 0 0 0 150px; border:solid 1px; width: 300px;">
            <tr>
            <td>
            <input type="checkbox" id="축구" name="interest" value="축구" disabled>
            축구  
            </td>
            <td>
            <input type="checkbox" id="농구" name="interest" value="농구" disabled>
            농구  
            </td>
            <td>
            <input type="checkbox" id="야구" name="interest" value="야구" disabled>
            야구
            </td>

            </tr>
            
            <tr>
            <td>
            <input type="checkbox" id="배구" name="interest" value="배구" disabled>
            배구
            </td>
            <td>
            <input type="checkbox" id="수영" name="interest" value="수영" disabled>
            수영
            </td>
            <td>
            <input type="checkbox" id="롱보드" name="interest" value="롱보드" disabled>
            롱보드
            </td>
            
            </tr>
            <tr>
            <td>
            <input type="checkbox" id="영화보기" name="interest" value="영화보기" disabled>
            영화보기
            </td>
            <td>
            <input type="checkbox" id="밥먹기" name="interest" value="밥먹기" disabled>
            밥 먹기
            </td>
            <td>
            <input type="checkbox" id="자전거" name="interest" value="자전거" disabled>
            자전거
            </td>
            
            </tr>
               
            </table>
            <div id="person_btn">
            <div id="pass_changebtn">비밀번호 변경</div>
            <div id="interests_changebtn">관심분야 변경</div>
            </div>
            </div>
            
            
            <table id="create_join">
            <caption id="cre_join_title">개설 모임</caption>
            <tr id="ctr"><td id="cnum">글 번호</td><td id="cinterest">분야</td><td id="ctitle">제목</td><td id="cday">모임 날짜</td><td id="cplace">모임 장소</td><td id="cbtn"></td></tr>
            <c:forEach var="mlist" items="${mlist}">
            <tr id="ctr"><td id="cnum">${mlist.num }</td><td id="cinterest">${mlist.field }</td><td id="ctitle">${mlist.title }</td><td id="cday">${mlist.start_time }</td><td id="cplace">${mlist.area }</td><td id="cbtn"><div class="personal_yes"  id="${mlist.num }" onclick="#" style="cursor: pointer;">완료</div></td></tr>
            </c:forEach>
            
            </table>

</form>   

      
  
<div class="recommend">   
   <span id="recommend-title">추천목록</span><br>
   <div class="recommend-list">      
   </div>
   <span id="recommend-more"><a href='#none' onClick='getRecommend(); return false;' >새로고침</a></span>
</div>  
  

   </section>
   <jsp:include page="../include/footer.jsp" />
</body>

</html>