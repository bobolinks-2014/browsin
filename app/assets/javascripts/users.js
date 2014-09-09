$( document ).ready(function(){
  $('.login-area').on("click", function(event) {
    Login.fetch();
  });
});

var Login = {
  fetch: function() {
    var request = $.ajax({
      url: "/users",
      type: "GET",
      dataType: "JSON"
    });
    request.done(function(response){
      if(response.success == false) {
        debugger;
      } else {
        this.display('hi');    
      }
    }.bind(this));
    request.fail(function(response) {
      this.display(response);
    }.bind(this));
    return request;
  },
  display: function(info) {
    //renderUserPage(info); 
    renderUserPage({user: "bob@bob.com", service_list: ["one","two"]}); 
    $("#profile-page").modal('show');
  }
}
