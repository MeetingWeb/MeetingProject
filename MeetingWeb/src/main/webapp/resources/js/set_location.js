var markersArray = [];
var pre_marker;
var places, iw;
var pre_marker;
var ADR, LOC;
var map;
var markers = [];

function init() {
   map = new google.maps.Map(document.getElementById("location-map"), {
      zoom : 15,
      center : new google.maps.LatLng(Number(lat), Number(lng)),
      mapTypeId : google.maps.MapTypeId.ROADMAP
   });
   places = new google.maps.places.PlacesService(map);
   google.maps.event.addListener(map, 'tilesloaded', tilesLoaded);
   autocomplete = new google.maps.places.Autocomplete(document.getElementById('address'));
   google.maps.event.addListener(autocomplete, 'place_changed', function() {
      showSelectedPlace();
   });

   google.maps.event.addListener(map, 'click', function(mouseEvent) {
      getAddress(mouseEvent.latLng);
      if (pre_marker != null)
         pre_marker.setMap(null);
   });

   function tilesLoaded() {
      google.maps.event.clearListeners(map, 'tilesloaded');
   }

   function showSelectedPlace() {
      var place = autocomplete.getPlace();
      map.panTo(place.geometry.location);
      markers[0] = new google.maps.Marker({
         position : place.geometry.location,
         map : map
      });
      /*
       * iw = new google.maps.InfoWindow({ content : getIWContent(place) });
       */
      iw.open(map, markers[0]);
   }

   function changemap() {
      var sm = $("#markerList option:selected").val().toString().replace(/[\(\) ]/gi, '').split(",");
      console.log(sm);
      map.setCenter(new google.maps.LatLng(sm[0].trim(), sm[1].trim()));
      map.setZoom(15);
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
                  var address = results[r].formatted_address;

                  new google.maps.InfoWindow({
                     content : address
                  }).open(map, new google.maps.Marker({
                     position : latlng,
                     map : map
                  }));
               }
            }
            map.fitBounds(bounds);
            map.setZoom(15);
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
}

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
               content : address
            // content: address
            }).open(map, marker);
            ADR = address;
            LOC = latlng;
            console.log(LOC);
            console.log(ADR);
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
window.addEventListener('load', function() {
   window.addEventListener('keydown', function(evt) {
      // evt.returnValue = false;
      if (evt.keyCode == 13) {
         searchMap(document.getElementById('address').value);
         console.log(document.getElementById('address').value);
      }
   });
});

function myLocation() {
   for ( var txt in mobileArr) {
      if (navigator.userAgent.match(mobileArr[txt]) != null) {
         division = $("input[name=division]").val("now");
         if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
               var pos = {
                  lat : position.coords.latitude,
                  lng : position.coords.longitude
               };
               getAddress(pos);
               map.setCenter(pos);
               if (pre_marker != null)
                  pre_marker.setMap(null);
            });
         }
         break;
      } else {
         alert("내 위치는 모바일에서만 가능합니다.");
         break;
      }
   }
}

function searchMap(place) {
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
               var address = results[r].formatted_address;
            }
         }

         /*
          * iw = new google.maps.InfoWindow({ content : getIWContent(place) })
          */
         // iw.open(map, markers[0]);
         map.fitBounds(bounds);
         map.setZoom(15);
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

function adrSave() {
   if (confirm("모임장소로 설정하기겠습니까?")) {
      $("#meeting-location").val(ADR);
      if(LOC.lat == null){
         $("input[name=area]").val(LOC.toString().replace(/[()]/gi, ''));
      }
      else {
         $("input[name=area]").val(LOC.lat() +"," + LOC.lng());
      }
      $("#view-map").css("visibility", "hidden");
   }
}

function setMyLocation() {
   if (confirm("내 위치로 지정 하시겠습니까?")) {
      var lat = LOC.lat();
      var lng = LOC.lng();
      var latlng = "("+lat + ',' + lng+")";
      location.href = "changeMyLOC?latlng=" + latlng;

   }
}
var lan = "37.49736948554443,127.02452659606933";
var width = $("#rough-map").width();
var height = $("#rough-map").height();
var path = null;

function roughMap(zoom) {
   lan = $("input[name=area]").val();
   // $("#rough-map").css("visibility", "visible");
   $("#rough-map").css("display", "block");

   path = "https://maps.googleapis.com/maps/api/staticmap?markers=color:blue%7Clabel:S%7C37.49736948554443,127.02452659606933&zoom=" + zoom
         + "&size=" + width + "x" + height + "&scale=1&key=AIzaSyCsNuSNeaxGpvxJuRSgUuDkXD7RiMmhnzs";
   if (lan != "") {
      path = "https://maps.googleapis.com/maps/api/staticmap?markers=color:blue%7Clabel:S%7C" + lan + "&zoom=" + zoom + "&size=" + width + "x"
            + height + "&scale=1&key=AIzaSyCsNuSNeaxGpvxJuRSgUuDkXD7RiMmhnzs";
   }

   var img = document.getElementById("rough-map-in-img");
   $("#rough-map img").attr("src", path);
   var size = 0;
   if (width >= height) {
      size = height - 45;
   } else {
      size = width - 45;
   }
   $("#rough-map canvas").attr("width", size).attr("height", size);

   $("#rough-map-in").css({
      "width" : $("#rough-map canvas").attr("width"),
      "height" : $("#rough-map canvas").attr("width")
   });
   drawCanvas();
}

$("#zoom-num").on("change", function() {
   var zoom = $(this).val();
   $("#rough-map-in label").text(zoom);
   roughMap(zoom);
});

$("#zoom-min").on("change", function() {
   var zoom = $(this).val();
   $("#rough-map-in label").text("ZOOM : " + zoom);
   roughMap(zoom);

});

var canvas = null;
var context = null;
var imageObj = null;
var colorCode = "#375060";
var p1, p2, ep, sp;
var drawOk = false;

function drawCanvas() {
   canvas = document.getElementById('map-canvas');
   context = canvas.getContext('2d');

   imageObj = new Image();
   imageObj.setAttribute('crossOrigin', 'anonymous');
   var img = document.getElementById("rough-map-in-img");
   imageObj.onload = function() {
      context.fillStyle = '#fff';
      context.fillRect(0, 0, canvas.width, canvas.height);
      context.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
   };
   imageObj.src = path;

   canvas.addEventListener('mousedown', onMouseDown);
   canvas.addEventListener('mouseup', onMouseUp);
   canvas.addEventListener('mousemove', onMouseMove);
}

function roughMapSave() {
   $("#rough-map").css("display", "none");
   var img_data = canvas.toDataURL("image/png");
   $("#rough-map-img").css("visibility", "visible");
   $("#rough-map-img img").attr("src", img_data);
   $("#rough-map-data").val(img_data);
}

function Pointer(x, y) {
   this.x = x;
   this.y = y;
}

function onMouseDown(e) {
   p1 = new Pointer(e.clientX - canvas.offsetLeft, e.clientY - canvas.offsetTop);
   sp = p1;
   drawOk = true;
}

function onMouseUp(e) {
   /*
    * ep = new Pointer(e.clientX - canvas.offsetLeft, e.clientY -
    * canvas.offsetTop); context.beginPath(); context.moveTo(sp.x, sp.y);
    * context.lineTo(ep.x, ep.y); context.lineWidth = 5; context.strokeStyle =
    * colorCode; context.stroke();
    */
   drawOk = false;
}

function onMouseMove(e) {
   if (drawOk) {
      p2 = new Pointer(e.clientX - canvas.offsetLeft, e.clientY - canvas.offsetTop);
      context.beginPath();
      context.moveTo(p1.x, p1.y);
      context.lineTo(p2.x, p2.y);
      context.lineWidth = 5;
      context.strokeStyle = colorCode;
      context.stroke();
      p1 = p2;
   }
}

$("#rough-map-cancle-btn").on("click", function() {
   $("#rough-map").css("display", "none");
});

/*
 * $("#rough-map").on("click", function(){ $("#rough-map").css("visibility",
 * "hidden"); });
 */
google.maps.event.addDomListener(window, 'load', init);