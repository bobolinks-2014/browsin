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
    var signUpData = $("#sign-up-data").serialize();
    submitSignUp(signUpData);
  });

  $("#sign-in-button").on("click", function(event) {
    var email = $("#login-form #email").val()
    var pass = $("#login-form #password").val()
    submitSignIn(email, pass);
  });

});
