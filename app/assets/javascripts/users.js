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
      } else {
        this.display(response.user);    
      }
    }.bind(this));
    request.fail(function(response) {
      this.display(response);
    }.bind(this));
    return request;
  },
  display: function(info) {
    renderUserPage(info);
    $("#profile-page").modal('show');
  }
}

var InfoCheck = {
  getButton: function(element) {
    if($.inArray(element, this.providerList())) {
      return 'remove'
    } else {
      return 'add'
    }
  },
  deleteExtra: function(title) {
    return title !== "hulu_free"
  },
  providerList: function() {
    return ['hulu_free', 'hbo', 'netflix']
  }
}
