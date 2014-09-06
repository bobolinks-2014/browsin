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

  $("#sign-up-button").on("submit", function(event) {
    $('#sign-up-form').modal('show');
  });

  $("#sign-up-submit").on("click", function(event) {
    event.preventDefault();
    submitSignUp($("#sign-up-data"));
  });

  $(".search-area").on("click", "#sign-in-button", function(event) {
    event.preventDefault();
    var email = $("#login-form #email").val()
    var pass = $("#login-form #password").val()
    submitSignIn(email, pass);
  });

  $(".login-area").on("click", ".logout", function(event) {
    event.preventDefault();
    logOutUser();
  });
});
