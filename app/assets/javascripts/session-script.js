function submitSignUp(data) {
  debugger;
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
    } else {
      errorLoggingIn();
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
    userLoggedOut();
    $("#login-area").empty();
  });
  
  return request;
}
