function submitSignUp(location) {
  var request = $.ajax({
    url: "/users",
    type: "POST",
    dataType: "JSON",
    data: {user: submitDataParse(location), services: getServices(location) }
  });
  request.done(function(response) {
    if(response.success == true) {
      $('#sign-up-form').modal('hide');
      renderSearchBar();
      userLoggedIn(response.user);
      $('').remove('#sign-up-button');
    } else {
      renderLoginFail(response);
    }
  });
  return request;
}

function getServices(data) {
  var netflix = $(data).find("#netflixBox").is(':checked');
  var hbo = $(data).find("#hboBox").is(':checked');
  var hulu = $(data).find("#huluBox").is(':checked');
  var hulu_free = false;

  if(netflix == true) {
    netflix = "netflix";
  }
  if(hbo == true) {
    hbo = "HBO";
  } 
  if(hulu == true) {
    hulu = "hulu_plus";
    hulu_free = "hulu_free";
  } 
  return {services: [netflix, hbo, hulu, hulu_free]}
}

function submitDataParse(data) {
  var email = $(data).find("#email").val();
  var pass = $(data).find("#pass").val();
  var passconf = $(data).find("#pass_conf").val();
  return {email: email, password: pass, password_confirmation: passconf}
} 

function submitSignIn(email, pass) {
  var request = $.ajax({
    url: "/users/sign_in",
    type: "POST",
    dataType: "JSON",
    data: {user: {email: email, password: pass} }
  });
  request.done(function(response) {
    if(response.success == true) {
      renderSearchBar();
      userLoggedIn(response.user);
      $('#sign-up-button').remove();
    } else {
      errorLoggingIn(response.error);
    }
  });
  return request;
}

function logOutUser() {
  var request = $.ajax({
    url: "/users/sign_out",
    type: "DELETE"
  });

  request.done(function(status) {
    window.location = '/';
    $( docuemnt ).ready(function() {
      flashAlert();
    });
  });
  
  return request;
}

function errorLoggingIn(message) {
  $('#search-area').append("<br><div class='col-md-6 col-md-offset-3 alert alert-white' role='alert'><strong>"+message+", please try again.</strong></div>")
    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
      });
    }, 5000);
}
function flashAlert() {
  $('#search-area').append("<br><div class='col-md-6 col-md-offset-3 alert alert-white' role='alert'><strong>Successfully logged out. Come back soon!</strong></div>")
    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
      });
    }, 5000);
}
function renderLoginFail(response) {
  $('.modal-header').append("<div class='alert alert-login' role='alert'><strong>"+response.error+"</strong></div>")
  window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
    });
  }, 3000);
}
