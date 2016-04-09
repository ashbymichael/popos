$(document).on("page:change", function () {
  'use strict';
  var button = document.getElementById("get-location");
  var currentLocation = document.getElementById("current-location");

  var getLocation = function () {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else {
      currentLocation.innerHTML = "Geolocation is not supported by this browser.";
    }
  }

  var showPosition = function (position) {
    currentLocation.innerHTML = "Latitude: " + position.coords.latitude +
    "<br>Longitude: " + position.coords.longitude;
  }

  button.addEventListener("click", getLocation);
})