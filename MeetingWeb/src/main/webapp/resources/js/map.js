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
    Rad 		= Math.PI/180;
    radLat1 = Rad * lat1;
    radLat2 = Rad * lat2;
    radDist = Rad * (lon1 - lon2);
    
    distance = Math.sin(radLat1) * Math.sin(radLat2);
    distance = distance + Math.cos(radLat1) * Math.cos(radLat2) * Math.cos(radDist);
    ret 		 = EARTH_R * Math.acos(distance);
				
    var rtn = Math.round(Math.round(ret) / 1000);     	
//   	rtn = rtn + " km";    
    return  rtn;
}

function goChat(){
	alert("채팅방 입장");
}

function direction(){	
	calculateAndDisplayRoute(directionsService, directionsDisplay);
}



function showHere(meeting){	
	
	var loc = meeting.loc;
	var arr = loc.split(',');
	var meetinglat = Number(arr[0]);
	var meetinglng = Number(arr[1]);	
	var latlng = new google.maps.LatLng(meetinglat,meetinglng);
	
	var master=meeting.master;
	var title=meeting.title;
	var num=meeting.num;
	
	//drawMeetings();
	map.panTo(latlng);
	for(var i=0; i<markers.length; i++)
	{
		if(markers[i].position.lat()==meetinglat && markers[i].position.lng()==meetinglng)
		{
 
			console.log(markers[i].getLabel());
		/*	markers[i].setMap(null);
			var marker=new google.maps.Marker({
				position: latlng,
				map:map,
				title:num
			});
			markers.push(marker);*/
			var simpleInfo=""+
			"<span class = 'label label-success'>Longboard</span> <b>  Host: </b>"+master+"<br><br>"+		
				title+
			" <br><br><button type = 'button' class = 'btn btn-default btn-xs' onclick='showDetail("+num+")'>"+
		      "show detail"+
		   "</button>";
 
			var simpleInfoWindow=new google.maps.InfoWindow({
				content : simpleInfo
			});
			simpleInfoWindow.open(markers[i].get('map'), markers[i]);			
		}
	}
	
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
			var mapname=meeting.mapname;
			
			if(mapname == 'none')
				mapname = "none.jpg";
			
			var startTimeArr=start_time.split(" ");
			var s=startTimeArr[1].split(":");
			var start=s[0]+"시 "+s[1]+"분";
			
			var endTimeArr=end_time.split(" ");
			var e=endTimeArr[1].split(":");
			var end=e[0]+"시 "+e[1]+"분";
			
			if(master!=user_id){
				$('#complete-btn').remove();
				$('#modify-btn').remove();
				
			}else{
				$('#complete-btn').on('click',function(){
					complete(num,master);
				});
				$("#modify-btn").attr("onclick","javascript:location.href='/NowMeetingWeb/meeting/modifyForm?num=83'");
			}
			var html="<table class='table'><tr><td colspan='2'>"+contents+"</td></tr>" +
					"<tr><td>주최자</td><td class='master'>"+master+"</td></tr>"+
					"<tr><td>종목</td><td>"+type+"</td></tr>"+
					"<tr><td>시작시간</td><td>"+start+"</td></tr>"+
					"<tr><td>끝나는시간</td><td>"+end+"</td></tr>"+					
					"<tr><td colspan='2'><img style='width:100%;'src='../resources/images/"+mapname+"'></td></tr><table>";
			$('#myModalLabel').text(title);
			$('#myModalBody').html(html);		
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
	 });	*/ 
	
}

function complete(mettingnum,meetingmaster){
    if(confirm('모임을 끝내시겠습니까??'))
    {
       
        $.ajax({
          type : 'post',
          dataType : 'json',
          url : 'complete',
          data : {
             num:mettingnum,
             master:meetingmaster
             
          },
          success : function(evt) {
             if(evt.ok){
                alert('완료처리 되었습니다.');
                location.href="main";
             }else alert('완료처리가 되지 않았습니다.')
             
          },
          complete : function(data) {

          },
          error : function(xhr, status, error) {
             alert(error);
          }
       });          
    }      
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
