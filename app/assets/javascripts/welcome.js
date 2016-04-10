$(document).on("page:change", function () {
  'use strict';
  var button = document.getElementById("get-location");
  var currentLocation = document.getElementById("current-location");
  var lat;
  var lng;
  var map;

  var getLocation = function () {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else {
      currentLocation.innerHTML = "Geolocation is not supported by this browser.";
    }
  }

  var initMap = function () {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: lat, lng: lng},
      scrollwheel: false,
      zoom: 15
    });

    var marker = new google.maps.Marker({
      position: {lat: lat, lng: lng},
      map: map,
      title: 'Current Position'
    });
  }

  var addPopoMarkersToMap = function () {
    var req = $.ajax({
      url: "/markers",
      dataType: "json"
    });

    req.done(function (data) {
      var popos = data;
      var infoWindow = new google.maps.InfoWindow();

      for (var i = 0; i < popos.length; i++) {
        var data = popos[i];

        var myLatlng = new google.maps.LatLng(data.lat, data.long);

        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: data.name
        });

        (function (marker, data) {
            var source   = $("#info-window").html();
            var template = Handlebars.compile(source);
            var context = data;
            var html = template(context);

            Handlebars.registerHelper('imageReformat', function(options) {
               var re = /\s/g;
               return new Handlebars.SafeString(options.fn(this).replace(re, '%20'));
            });

            google.maps.event.addListener(marker, "click", function (e) {
                infoWindow.setContent(html);
                infoWindow.open(map, marker);
            });
        })(marker, data);
      };
    })

    req.fail(function () {
      console.log("fail")
    })
  }

  var showPosition = function (position) {
    lat = position.coords.latitude;
    lng = position.coords.longitude;
    currentLocation.innerHTML = "Latitude: " + lat +
    "<br>Longitude: " + lng;
    initMap();
    addPopoMarkersToMap();
  }

  button.addEventListener("click", getLocation);
})