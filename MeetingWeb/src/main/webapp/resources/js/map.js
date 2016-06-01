
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
	var map = new google.maps.Map(document.getElementById('map'), {
		center : {
			lat : 37,
			lng : 126
		},
		// Apply the map style array to the map.
		styles : styleArray,
		zoom : 15
	});

	var infoWindow = new google.maps.InfoWindow({
		map : map
	});

	// Try HTML5 geolocation.
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			var pos = {
				lat : position.coords.latitude,
				lng : position.coords.longitude
			};

			infoWindow.setPosition(pos);
			infoWindow.setContent('Location found.');
			map.setCenter(pos);
		}, function() {
			handleLocationError(true, infoWindow, map.getCenter());
		});
	} else {
		// Browser doesn't support Geolocation
		handleLocationError(false, infoWindow, map.getCenter());
	}

}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
	infoWindow.setPosition(pos);
	infoWindow.setContent(browserHasGeolocation ? 'Error: The Geolocation service failed.'
			: 'Error: Your browser doesn\'t support geolocation.');
}
