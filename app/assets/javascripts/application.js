//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require react
//= require_tree .

$( document ).ready(function() {
  $("#search").on("submit", function(event) {
    event.preventDefault();
    var query = $("#search").serialize();
    queryLookUp(query);
    //clear search bar
    //push page up
  });
  $("#sign-in-button").on("click", function(event) {
    event.preventDefault();

  });

});
