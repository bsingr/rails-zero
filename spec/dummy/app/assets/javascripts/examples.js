// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function(){
  var xhr = new XMLHttpRequest();
  xhr.open("GET", "/examples/cached.json", true);
  xhr.send();
};
window.onload = ready;
