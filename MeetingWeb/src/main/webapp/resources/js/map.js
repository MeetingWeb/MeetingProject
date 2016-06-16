var map;
var mylat;
var mylng;
var deslat;
var deslng;
var directionsService;
var directionsDisplay;
var markers=[];
function initMap() {

   // Specify features and elements to define styles.
   var styleArray = [ {
      featureType : "all",
      stylers : [ {
         saturation : -80
      } ]
   }, {
      featureType : "road.arterial",
      elementType : "geometry",
      stylers : [ {
         hue : "#00ffee"
      }, {
         saturation : 50
      } ]
   }, {
      featureType : "poi.business",
      elementType : "labels",
      stylers : [ {
         visibility : "off"
      } ]
   } ];

   // Create a map object and specify the DOM element for display.
   map = new google.maps.Map(document.getElementById('map'), {
      center : {
         lat : 37.57,
         lng : 126.98
      },
      // Apply the map style array to the map.
      styles : styleArray,
      zoom : 15
   });
   
    directionsService = new google.maps.DirectionsService;
    directionsDisplay = new google.maps.DirectionsRenderer;
    directionsDisplay.setMap(map);


}
function calcDistance(lat1, lon1, lat2, lon2){
    var EARTH_R, Rad, radLat1, radLat2, radDist; 
    var distance, ret;


    EARTH_R = 6371000.0;
    Rad       = Math.PI/180;
    radLat1 = Rad * lat1;
    radLat2 = Rad * lat2;
    radDist = Rad * (lon1 - lon2);
    
    distance = Math.sin(radLat1) * Math.sin(radLat2);
    distance = distance + Math.cos(radLat1) * Math.cos(radLat2) * Math.cos(radDist);
    ret        = EARTH_R * Math.acos(distance);
            
    var rtn = Math.round(Math.round(ret) / 1000);        
//      rtn = rtn + " km";    
    return  rtn;
}

function goChat(){
   alert("채팅방 입장");
}

function direction(){   
   calculateAndDisplayRoute(directionsService, directionsDisplay);
}



function showHere(lat,lng){   
   var latlng = new google.maps.LatLng(lat,lng);
   drawMeetings();
   map.panTo(latlng);
   
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
     directionsService.route({
       origin: new google.maps.LatLng(mylat,mylng),
       destination: new google.maps.LatLng(deslat,deslng),
       travelMode: google.maps.TravelMode.DRIVING
     }, function(response, status) {
       if (status === google.maps.DirectionsStatus.OK) {
         directionsDisplay.setDirections(response);
       } else {
         window.alert('Directions request failed due to ' + status);
       }
     });
   }

function showDetail(num){
   $.ajax({
      type:"get",
      url:"getMeeting",
      data:
      {
         num:num
      },   
      dataType:"json",
      success:function(meeting)
      {
      
         var num=meeting.num;
         var contents=meeting.contents;
         var end_time=meeting.endTime;
         var start_time=meeting.startTime;
         var master=meeting.master;
         var type=meeting.type;
         var title=meeting.title;
         $('#myModalLabel').text(title);
         $('#myModalBody').text(num+" "+ contents+" "+end_time+" "+start_time+" "+master+" "+type+" "+title);
         $('#myModal').modal({keyboard: true});
         $(".modal-footer input[name=master]").val(master);
         var loc=meeting.loc;
         var arr=loc.split(',');            
         var lat=Number(arr[0]);
         var lng=Number(arr[1]);   
         deslat=lat;
         deslng=lng;
         
      },
      complete:function(data)
      {
         
      },
      error:function(xhr,status,error)
      {
         alert(error);
      }      
   });
   
   
   
}

function attachMeetingInfo(marker,meeting){   
   
   var simpleInfo=""+
   "<span class = 'label label-success'>Longboard</span> <b>  Host: </b>"+meeting.master+"<br><br>"+      
      meeting.title+
   " <br><br><button type = 'button' class = 'btn btn-default btn-xs' onclick='showDetail("+meeting.num+")'>"+
      "show detail"+
   "</button>";

   var simpleInfoWindow=new google.maps.InfoWindow({
      content : simpleInfo
   });
   //simpleInfoWindow.open(marker.get('map'), marker);      
   
   marker.addListener('click', function() {
      simpleInfoWindow.open(marker.get('map'), marker);
      console.log(marker.position.lat());
    });
}

function drawMeetings(){      
   $.ajax({
      type : 'post',
      dataType : 'json',
      url : 'getAllMeeting',      
      success : function(data) {
         setMapOnAll(null);
         markers=[];
         for(var i=0; i<data.length; i++)
         {
            var loc=data[i].loc;
            var arr=loc.split(',');            
            var lat=Number(arr[0]);
            var lng=Number(arr[1]);             
            var latlng = new google.maps.LatLng(lat,lng);
            makeMarker(latlng,data[i]);
         }
         //markers.click();
         setMapOnAll(map); 
      },
      complete : function(data) {

      },
      error : function(xhr, status, error) {
         alert(error);
      }      
   });      
}

function showMyLocation(){
   $.ajax({
      type: 'post',
      dataType : 'json',   
      url : 'getMyLocation',      
      success : function(data) {
         
         var loc=data.latlng;         
         loc=loc.replace('(','');
         loc=loc.replace(')','');         
         var arr=loc.split(',');            
         var lat=Number(arr[0]);
         var lng=Number(arr[1]);   
         mylat=lat;
         mylng=lng;
         var latlng = new google.maps.LatLng(lat,lng);
      
         myMarker(latlng);//내위치마커
         map.panTo(latlng);
                  
         
      },
      complete : function(data) {

      },
      error : function(xhr, status, error) {
         alert(error);
      }   
      
   });
   
}
function myMarker(latlng){
   var marker=new google.maps.Marker({
      position: latlng,
      map:map,
      color:'blue'
      
   });   
   var info="내위치";
   var simpleInfoWindow=new google.maps.InfoWindow({
      content : info
   }).open(marker.get('map'), marker);
   //simpleInfoWindow.open(marker.get('map'), marker);      
   /*marker.addListener('click', function() {
      simpleInfoWindow.open(marker.get('map'), marker);      
    });   */ 
   
}

function makeMarker(latlng,meeting){
   var num=String(meeting.num);
   var marker=new google.maps.Marker({
      position: latlng,
      map:map,
      title:num
   });
   markers.push(marker);
   attachMeetingInfo(marker,meeting);   
   condition=0;   
}

function setMapOnAll(map) {
     for (var i = 0; i < markers.length; i++) {
       markers[i].setMap(map);
     }
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
   infoWindow.setPosition(pos);
   infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
         : 'Error: Your browser doesn\'t support geolocation.');
}