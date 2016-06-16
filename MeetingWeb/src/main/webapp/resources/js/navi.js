var body_height = $(window).height();
var mobileArr = new Array("iPhone", "iPod", "BlackBerry", "Android", "Windows CE", "LG", "MOT", "SAMSUNG", "SonyEricsson");

$(function() {
   // ///////메뉴 네비////////////////////////////
   $("#menu ul li:not(#menu-btn, #logo)").on("click", function() {
      var path = $(this).find("a").attr("href");
      location.href = path;
   });

   var link = document.location.href;
   var body_width = $(window).width();

   $("#map").css("height", body_height - 64);
   $("#login-form, #joinform").css("height", body_height - 64);
   $("#mobile-login-form").css("height", body_height);
   // ///////////로그인 회원가입////////////////////////////////////////////////
   var flip = 0;
   var flip2 = 0;
   $("#loginbtn").click(function() {
      $("#login-form").toggle(flip++ % 2 == 0);
      $("#joinform").css('display', 'none');
      flip2 = 0;

   });

   $("#joinbtn").click(function() {
      $("#joinform").toggle(flip2++ % 2 == 0);
      $("#login-form").css('display', 'none');
      flip = 0;
   });

   $("#login-btn").on("click", function() {
      // location.href="/user/login";
      $("form[name=loginForm]").submit();
   });

   $("#logoutbtn").on("click", function() {
      location.href = "/NowMeetingWeb/logout";
   });
   // ////////추천/////////////////////
   $("#recommendbtn").on("click", function() {

      if ($("div.recommend").css('display') == 'none') {
         getRecommend();
         $("div.recommend").css('display', 'block');
      } else if ($("div.recommend").css('display') == 'block') {
         $("div.recommend").css('display', 'none');
      }
      ;

   });
   
   ///////////날 보여줘//////////////
   
      $('#logo').on('click',function(){      
         var latlng = new google.maps.LatLng(mylat,mylng);         
         map.panTo(latlng);   
      });
   //////////검색///////////////////////
   $("#search-btn").on("click", function() {
      var url=$(location).attr('pathname');
         //user_id를 못찾음
         if(user_id!="")
         {
            if(url=='/NowMeetingWeb/web/main')
            {
               if ($("#search-menu").css('display') == 'none') {                  
                  $("#search-menu").css('display', 'block');
               } else if ($("#search-menu").css('display') == 'block') {                  
                  $("#search-menu").css('display', 'none');
               }
            }else{         
               location.href="/NowMeetingWeb/web/main?search=ok";         
            }
         }
         
      
   });
   $("#search-btn-name").on("click", function() {
      var url=$(location).attr('pathname');
      if(user_id!="")
      {
         if(url=='/NowMeetingWeb/web/main')
         {
            if ($("div.search-menu").css('display') == 'none') {         
               $("div.search-menu").css('display', 'block');
            } else if ($("div.search-menu").css('display') == 'block') {
               $("div.search-menu").css('display', 'none');
            }
         }else{         
            location.href="main?search=ok";         
         }
      }
      

   });

   
   //////////내위치 정하기////////////////
   $('#mylocation-btn').on('click',function(){
      location.href="myLocation";
   });
   $('#myLocation-btn-name').on('click',function(){
      location.href="myLocation";
      
   });
	// ///////메뉴///////////////////////
	var bool = false;
	$("#menu #menu-btn").on("click", function() {
		if (bool == false) {
			$("#menu #menu-in").animate({
				width : "208px"
			}, 500);
			$("#menu .menu-btn-name").addClass("menu-btn-name-active");
			bool = true;
		} else {
			$("#menu #menu-in").animate({
				width : "64px"
			}, 250);
			$("#menu .menu-btn-name").removeClass("menu-btn-name-active");

         bool = false;
      }
   });
   // ////////////모임만들기///////////////////////////////////////
   // $("#meeting-form-background").css("width", $("#contents").width());
   var add_form_left = $("#contents").width() - $("#meeting-form-lid").width() + 140;
   var add_form_top = $("#contents").height() - $("#meeting-form-lid").height() + 100;
   // $("#meeting-form-lid").css("top", "120px");
   $// ("#meeting-form-lid").css("margin-left",
      // -$("#meeting-form-lid").width() / 2 + 32);
   $("#meeting-form-background, #meeting-form-map").css("height", $(window).height() - 64);

   var visibility = false;
   

   $("#view-map #close").on("click", function() {
      $("#view-map").css("visibility", "hidden");
   });

   // ////////////review js////////////////////////
   $(".img-box").on("click", function() {
      console.log($(this).attr("data-num"));
      location.href = "selectOne?num=" + $(this).attr("data-num");
   });
   
   //////////////MeetingList js/////////////////////////////////////
   $(".not-now-list-btn").on("click",function(){
      var num = $(this).find("input[name=num]").val();
      location.href = "/NowMeetingWeb/meeting/meetingView?num=" + num;
   });
   // 모바일 자바스크립트///////////////////////////////////
   
   for ( var txt in mobileArr) {
      if (navigator.userAgent.match(mobileArr[txt]) != null) {
         $("#m-menu-btn").on("click", function() {
            $("#m-menu").css("display", "block");
         });
         
         $("#headernavi").css("width", document.body.clientWidth);
         
         $("#view-map").css({
            "width" : document.body.clientWidth,
            "height" : document.documentElement.clientHeight - 139
         });
         
         console.log(document.documentElement.clientHeight);
         
         $("#set-location").on("click", function() {
            $("#view-map").css("visibility", "visible");
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
         });
         
         $(".chat-lid").css("height",document.body.clientHeight).css("width", document.body.clientWidth);
         $("#chat-list-lid").css({/*"width":$(window).width(), */"height": document.body.clientHeight - 64})
         
         break;
      } else {
         $("#view-map").css({
            "width" : $(window).width() - 64,
            "height" : $(window).height() - 64
         });
         
         $("#set-location").on("click", function() {
            $("#view-map").css("visibility", "visible");
         });
         
         $(".chat-lid").css("height",$(window).height() - 164).css("width", $(window).width() - ($("#chat-list-lid").width() + 65));
         $("#chat-list-lid").css({/*"width":$(window).width(), */"height": $(window).height() - 64})
         
         $("#message-btn").on("click", function(){
            $(this).find(".badge").css("display","none").empty();
         });
         break;
      }
   }
   
   
   
/////게인정보///////
   
   var flips = 0;
   $('div#member-info-btn').on("click",function(){

      location.href='/NowMeetingWeb/web/personal_form';
   });
   

   

   $('div#pass_changebtn').on("click",function(){

      $('div#pass_changeform').css("display","block");
      $('#pass_changebtn').text("저 장").attr('onclick','javascript:pwchangesave();').attr('id','ii');
   });
   
   
   $('div#interests_changebtn').on("click",function(){

      $('input[name=interest]').prop('disabled', false);
      $('#interests_changebtn').text("저 장").attr('onclick','interestssave()').attr('id','i');
      
   });
   
   
});


function pwchangesave() {
   var id = $('div#pid').text();
   var pw = $('input#pw').val();

   $.ajax({
      type : 'post',
      dataType : 'json',
      data : {id:id,pw:pw},
      url : 'pwchange',         
      success : function(data) {
         if(data.ok==true)
         {
            alert("변경 되었습니다.");
            $('#ii').text("비밀번호 변경").attr('onclick','#').attr('id','pass_changebtn');
            $('div#pass_changeform').css("display","none");
         }
         
         
      },
      complete : function(data) {

      },
      error : function(xhr, status, error) {
         alert(error);
      }
   });
   
}

function interestssave() {
   var id = $('div#pid').text();
   var interests = "";
      $("input[name=interest]:checked").each(function(i) {
         interests += $(this).val();
         if(i+1!=$('input[name=interest]:checked').length)
         {
            interests +=",";
         }
         
      });

   $.ajax({
      type : 'post',
      dataType : 'json',
      data : {interests:interests,id:id},
      url : 'interests',         
      success : function(data) {
         if(data.ok==true)
         {
            alert("변경 되었습니다.");
            $('input[name=interest]').prop('disabled', true);
            $('#i').text("관심분야 변경").attr('onclick','#').attr('id','interests_changebtn');
         }
         
         
         
      },
      complete : function(data) {

      },
      error : function(xhr, status, error) {
         alert(error);
      }
   });
   
}