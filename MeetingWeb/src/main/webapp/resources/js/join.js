$(function(){
   $('#email').keyup(function(){
       var email = $('#email').val();
       $.ajax({
            type : 'post',
            dataType : 'json',
            url : 'check',
            data : {email:email},
            success : function(evt) {
               if(evt.emailErr) {
                  $('#email_text').text(evt.emailErr).css("display","block");
                  $('#emailcheck').css("display","none");
                  if(evt.emailErr=="나")
                     {
                        $('#email_text').text(evt.emailErr).css("display","none");
                        $('#emailcheck').css("display","block");
                     }
               }
            },
            complete : function(data) {

            },
            error : function(xhr, status, error) {
               alert(error);
            }
         });    
    
   });
   
   
   $('#id').keyup(function(){
       var id = $('#id').val();
       $.ajax({
            type : 'post',
            dataType : 'json',
            url : 'check',
            data : {id:id},
            success : function(evt) {
               if(evt.idErr) {
                  $('#id_checktext').text(evt.idErr).css("display","block");
                  $('#ids_check').css("display","none");
                  if(evt.idErr=="사용 가능한 아이디 입니다.")
                     {
                        $('#id_checktext').text(evt.idErr).css("display","none");
                        $('#ids_check').css("display","block");
                        
                     }
               }
            },
            complete : function(data) {

            },
            error : function(xhr, status, error) {
               alert(error);
            }
         });    
    
   });
   
   
   $('input#pw').keyup(function(){
       var pw = $('input#pw').val();
       //var pwc = $('#pwc').val();
       $.ajax({
            type : 'post',
            dataType : 'json',
            url : 'check',
            data : {pw:pw},
            success : function(evt) {
                  if(evt.pwdErr)
                  {
                     $('#pwc_checktext').text(evt.pwdErr).css("display","block");
                     
                  
                  if(evt.pwdErr=="가")
                  {
                     $('#pwc_checktext').text(evt.pwdErr).css("display","none");
                  }
                  }
                  //$('#pw_checktext').text(evt.pwdErr2).css("display","block");;
            
            },
            complete : function(data) {

            },
            error : function(xhr, status, error) {
               alert(error);
            }
         });    
   });
   
   
   $('#pwc').keyup(function(){
       var pw = $('input#pw').val();
       var pwc = $('#pwc').val();
       $.ajax({
            type : 'post',
            dataType : 'json',
            url : 'check',
            data : {pw:pw,pwc:pwc},
            success : function(evt) {
               if(evt.pwdErr2) {
                  $('#pw_checktext').text(evt.pwdErr2).css("display","block");
                  if(evt.pwdErr2=="비밀번호가 맞았습니다.")
                     {
                     $('#pw_checktext').text(evt.pwdErr2).css("display","none");
                     }
               }
            },
            complete : function(data) {

            },
            error : function(xhr, status, error) {
               alert(error);
            }
         });    
    
   });
   
   $('#join_group > input').focus(function() {
      $(this).css("background-color","#fff");
   });
   
   $('#join_group > input').blur(function() {
      $(this).css("background-color","#b6c8cd");
   });
   
   
});



function email_check() {
    var email = $('#email').val();
    $.ajax({
         type : 'get',
         dataType : 'json',
         url : 'eamil_check',
         data : {email:email},
         success : function(evt) {
            if(evt.ok==true)
            {
               alert("확인 되었습니다.")
            }
         },
         complete : function(data) {

         },
         error : function(xhr, status, error) {
            alert(error);
         }
      });
      
   }

   var id_checks = null;
   function id_check() {
      var id = $('input#id').val();
      $.ajax({
         type : 'post',
         dataType : 'json',
         url : 'id_check',
         data : {id:id},
         success : function(evt) {
            if(evt.ok==true)
            {
               //$('#id_checktext').text("중복확인 되었습니다..").css("display","block");
               alert("사용 가능한 아이디 입니다.")
               $('#ids_check').css("display","none");
               id_checks=evt.msg;
            }
            else if(evt.ok==false)
            {
               alert("사용 중인 아이디 입니다.")
               $('#id_checktext').text("사용 중인 아이디 입니다.").css("display","block");
               $('#ids_check').css("display","none");
            }
         },
         complete : function(data) {

         },
         error : function(xhr, status, error) {
            alert(error);
         }
      });

   }

   function joinsave() {
      

      if(id_checks!=$('#id').val())
      {
      alert("중복검사하세요.");
      } 
      if(id_checks==$('#id').val())
      {
       
       
      var data = $('#joinform').serialize();
      $.ajax({
         type : 'post',
         dataType : 'json',
         url : 'join',
         data : data,
         success : function(evt) {
            if (evt.ok == true) {
               alert("회원가입에 성공 하였습니다.");
               $('#joinform').css('display', 'none');
               $('#login-form').css('display', 'block');
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