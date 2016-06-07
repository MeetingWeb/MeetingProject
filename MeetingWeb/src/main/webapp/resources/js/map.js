var map;
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


}

function goChat(){
	alert("채팅방 입장");
}

function simpleMap(){
	alert("약도 보기");
}

function searchRoad(){
	alert("길찾기");
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
	 });
}

function drawMeetings(){		
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : 'getAllMeeting',		
		success : function(data) {			
			for(var i=0; i<data.length; i++)
			{
				var loc=data[i].loc;
				var arr=loc.split(',');				
				var lat=Number(arr[0]);
				var lng=Number(arr[1]);				 
				var latlng = new google.maps.LatLng(lat,lng);
				makeMarker(latlng,data[i]);
			}
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
			var latlng = new google.maps.LatLng(lat,lng);
			map.panTo(latlng);
						
			
		},
		complete : function(data) {

		},
		error : function(xhr, status, error) {
			alert(error);
		}	
		
	});
	
}

function makeMarker(latlng,meeting){
	var num=String(meeting.num);
	var marker=new google.maps.Marker({
		position: latlng,
		map:map,
		title:num
	});
	
	attachMeetingInfo(marker,meeting);	
	condition=0;	
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
			: 'Error: Your browser doesn\'t support geolocation.');
}
