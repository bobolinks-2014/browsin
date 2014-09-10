//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-confirmation
//= require react
//= require_tree .

$( document ).ready(function() {
  $(".search-area").on("submit", ".navbar-form", function(event) {
    event.preventDefault();
    var query = $('#search-bar-value').val();
    $(this).append("<div class='loader'>Loading...</div>");
    Search.query(query);
  });

  $("#search-results-area").on("click", ".search-item", function(event) {
    event.preventDefault();
    var asset = $(this).attr("id");
    $('.search-area').append("<div class='loader'>Loading...</div>");
    Search.lookUp(asset);
  });

  $("#search-results-area").on("click", ".load-item", function(event) {
    event.preventDefault();
    var asset = $(this).attr("id");
    $('.search-area').append("<div class='loader'>Loading...</div>");
    Search.lookUp(asset);
  });

  $(".triangle").on("click", function(event) {
    event.preventDefault();
    $('.search-area').append("<div class='loader'>Loading...</div>");
    Search.top25();
  });

  $("#sign-up-button").on("submit", function(event) {
    $('#sign-up-form').modal('show');
  });

  $("#sign-up-submit").on("click", function(event) {
    event.preventDefault();
    $('.modal-dialog').prepend("<div class='loader'>Loading...</div>");
    Signup.submit($("#sign-up-data"));
    $('#sign-up-button').remove();
  });

  $(".search-area").on("click", "#sign-in-button", function(event) {
    event.preventDefault();
    var email = $("#login-form #email").val()
    var pass = $("#login-form #password").val()
    $('.search-area').append("<div class='loader'>Loading...</div>");
    Session.signIn(email, pass);
  });

  $(".login-area").on("click", ".logout", function(event) {
    logOutUser();
  });

  $("#search-results-area").on("click", ".delete-media-item", function(event) {
     var itemId = $(this).parents().eq(2).find('.panel-collapse').attr('id');
    removeMediaItem(itemId, $(this));
  });
});
