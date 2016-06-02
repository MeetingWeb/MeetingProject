
var markersArray = [];
var pre_marker;

var map = new google.maps.Map(document.getElementById("map"), {
	zoom : 15,
	center : new google.maps.LatLng(37.49736948554443, 127.02452659606933),
	mapTypeId : google.maps.MapTypeId.ROADMAP
});
google.maps.event.addListener(map, 'click', function(mouseEvent) {
	getAddress(mouseEvent.latLng);
	if (pre_marker != null)
		pre_marker.setMap(null);
});

function getAddress(latlng) {

	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
		latLng : latlng
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			if (results[0].geometry) {

				var address = results[0].formatted_address;

				var marker = new google.maps.Marker({
					position : latlng,
					map : map
				});
				pre_marker = marker;
				new google.maps.InfoWindow({
					content : address + "<br>(Lat, Lng) = " + latlng
				// content: address
				}).open(map, marker);

				var opt = $("<option value='" + latlng.toString() + "'>" + address + "</option>");
				/*$("#markerList").append(opt);*/
				$("input[name=adrr]").val(latlng.toString().replace(/[()]/gi,''));
				// markersArray.push(marker);
			}
		} else if (status == google.maps.GeocoderStatus.ERROR) {
			alert("통신중 에러발생！");
		} else if (status == google.maps.GeocoderStatus.INVALID_REQUEST) {
			alert("요청에 문제발생！geocode()에 전달하는GeocoderRequest확인요！");
		} else if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
			alert("단시간에 쿼리 과다송신！");
		} else if (status == google.maps.GeocoderStatus.REQUEST_DENIED) {
			alert("이 페이지에는 지오코더 이용 불가! 왜??");
		} else if (status == google.maps.GeocoderStatus.UNKNOWN_ERROR) {
			alert("서버에 문제가 발생한거 같아요. 다시 한번 해보세요.");
		} else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
			alert("존재하지 않습니다.");
		} else {
			alert("??");
		}
	});
}

function changemap() {
	var sm = $("#markerList option:selected").val().toString().replace(/[\(\)]/gi, '').split(",");
	console.log(sm);
	map.setCenter(new google.maps.LatLng(sm[0].trim(), sm[1].trim()));
	map.setZoom(14);
}

function resetSearch() {
	location.reload();
}

function getLatLng(place) {

	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
		address : place,
		region : 'ko'
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			var bounds = new google.maps.LatLngBounds();

			for ( var r in results) {
				if (results[r].geometry) {
					var latlng = results[r].geometry.location;
					bounds.extend(latlng);
					// var address = results[0].formatted_address.replace(/^日本,
					// /, '');
					var address = results[r].formatted_address;

					new google.maps.InfoWindow({
						content : address + "<br>(Lat, Lng) = " + latlng.toString()
					}).open(map, new google.maps.Marker({
						position : latlng,
						map : map
					}));

					var opt = $("<option value='" + latlng.toString() + "'>" + address + "</option>");
					$("#markerList").append(opt);
					$("#addrList").append(slt);
				}
			}
			map.fitBounds(bounds);
		} else if (status == google.maps.GeocoderStatus.ERROR) {
			alert("서버 통신에러！");
		} else if (status == google.maps.GeocoderStatus.INVALID_REQUEST) {
			alert("리퀘스트에 문제발생！geocode()에 전달하는GeocoderRequest확인요！");
		} else if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
			alert("단시간에 쿼리 과다송신！");
		} else if (status == google.maps.GeocoderStatus.REQUEST_DENIED) {
			alert("이 페이지에서는 지오코더 이용불가! 왜?");
		} else if (status == google.maps.GeocoderStatus.UNKNOWN_ERROR) {
			alert("서버에 문제 발생한거 같아요.다시 한번 해보세요.");
		} else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
			alert("앙..못찾겠어요");
		} else {
			alert("??");
		}
	});
}