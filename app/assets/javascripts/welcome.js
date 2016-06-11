$(document).on("page:change", function () {
    'use strict';

    var userLat,
        userLng,
        map,
        infoWindow;

    // DOM Getters
    var button = document.getElementById("get-location");
    var mapDiv = document.getElementById("map");
    var loading = $("#loading");



    // Display loading while page loads
    loading.hide();
    $(document).ajaxStart(function () {
        loading.show();
    }).ajaxStop(function () {
        loading.hide();
    });

    var getUserLocation = function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(setUserLocation, getUserLocationError);
        } else {
          currentLocation.innerHTML = "Geolocation is not supported by this browser.";
        }
    }

    var setUserLocation = function (pos) {
        var crd = pos.coords;
        userLat = crd.latitude;
        userLng = crd.longitude;
    }

    var getUserLocationError = function (err) {
      console.warn('ERROR(' + err.code + '): ' + err.message);
    }

    var initMap = function () {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 37.7880, lng: -122.405},
          scrollwheel: false,
          zoom: 15
      });
    }

    var addCurrentLocationMarkerToMap = function () {
        var marker = new google.maps.Marker({
            position: {lat: userLat, lng: userLng},
            map: map,
            title: 'Current Position'
        });
    }

    var switchViews = function() {
      console.log('switchViews inited');
      var current = $('#view-switcher-button').text();
      console.log('current: ' + current);
      if (current === 'view as list') {
        $('#view-switcher-button').text('view as map');
      } else {
        $('#view-switcher-button').text('view as list');
      }
      $('#map').toggle();
      $('#list-view').toggle();
    }

    var viewPage = function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('href')
      }).done(function(res){
        $('#list-view').html($($.parseHTML(res)).filter('#list-view').html());
      });
    }

    var styleInfoWindow = function() {
          // Reference to the DIV which receives the contents of the infowindow using jQuery
          var iwOuter = $('.gm-style-iw');

          /* The DIV we want to change is above the .gm-style-iw DIV.
           * So, we use jQuery and create a iwBackground variable,
           * and took advantage of the existing reference to .gm-style-iw for the previous DIV with .prev().
           */
           var iwBackground = iwOuter.prev();

          // Remove the background shadow DIV
          iwBackground.children(':nth-child(2)').css({'display' : 'none'});

          // Remove the white background DIV
          iwBackground.children(':nth-child(4)').css({'display' : 'none'});

          // Moves the infowindow 115px to the right.
          iwOuter.parent().parent().css({left: '115px'});

          // Moves the shadow of the arrow 76px to the left margin
          iwBackground.children(':nth-child(1)').attr('style', function(i,s){ return s + 'left: 76px !important;'});

          // Moves the arrow 76px to the left margin
          iwBackground.children(':nth-child(3)').attr('style', function(i,s){ return s + 'left: 76px !important;'});

          // Changes the desired tail shadow color.
          iwBackground.children(':nth-child(3)').find('div').children().css({'box-shadow': 'rgba(72, 181, 233, 0.6) 0px 1px 6px', 'z-index' : '1'});

          var iwCloseBtn = iwOuter.next();

          // Apply the desired effect to the close button
          iwCloseBtn.css({
            opacity: '1', // by default the close button has an opacity of 0.7
            right: '48px', top: '10px', // button repositioning
            // border: '7px solid black', // increasing button border and new color
            'border-radius': '13px', // circular effect
            'box-shadow': '0 0 5px black' // 3D effect to highlight the button
        });

          // The API automatically applies 0.7 opacity to the button after the mouseout event.
          // This function reverses this event to the desired value.
          iwCloseBtn.mouseout(function(){
            $(this).css({opacity: '1'});
        });
    }

    var addPopoMarkersToMap = function () {
        var req = $.ajax({
            url: "/markers",
            dataType: "json"
        });

        req.done(function (popos) {
            infoWindow = new google.maps.InfoWindow();

            google.maps.event.addListener(infoWindow, 'domready', function() {
                styleInfoWindow();
            });

            for (var i = 0; i < popos.length; i++) {
                var popo = popos[i];
                var userLatLng = new google.maps.LatLng(userLat, userLng);
                var popoLatLng = new google.maps.LatLng(popo.lat, popo.lng);

                var marker = new google.maps.Marker({
                    position: popoLatLng,
                    map: map,
                    title: popo.name
                });

                var distance = google.maps.geometry.spherical.computeDistanceBetween (userLatLng, popoLatLng);

                (function (marker, popo) {
                  var source   = $("#info-window-template").html();
                  var template = Handlebars.compile(source);
                  var context = popo;
                  var html = template(context);
                  google.maps.event.addListener(marker, "click", function (e) {
                    infoWindow.setContent(html);
                    infoWindow.open(map, marker);
                });
              })(marker, popo);
          };
      })

        req.fail(function () {
          console.log("fail")
      })
    }


    GoogleMapsLoader.KEY = 'AIzaSyAHhvFsZXG-xvmzC9vELiTt8FiCf31dHP8';
    GoogleMapsLoader.LIBRARIES = ['geometry', 'places'];
    GoogleMapsLoader.load(function(google) {
        initMap();
        getUserLocation();
        addPopoMarkersToMap();
        google.maps.event.addListener(map, "click", function(event) {
            infoWindow.close();
        });
    });

    //Listeners
    $('#view-switcher-button').click(switchViews);
    $(document.body).on('click', '.pagination a', viewPage);

    // button.addEventListener("click", getUserLocation);
})
