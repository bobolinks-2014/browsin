$( document ).ready(function(){
  $('.login-area').on("click", function(event) {
    Login.fetch();
  });
  $('.profile-page').on('click', '.add', function(event) {
    var service = $(this).parent().attr('id')
    UpdateProfile.addService(service);  
  });
  $('.profile-page').on('click', '.remove', function(event) {
    var service = $(this).parent().attr('id')
    UpdateProfile.removeService(service);  
  });
  $('.profile-page').on('click', '.show', function(event) {
    UpdateProfile.reShowItem(item);  
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
    if($.inArray(element, ['hulu_plus', 'hbo', 'netflix'])) {
      return 'remove'
    } else {
      return 'add'
    }
  },
  deleteExtra: function(title) {
    return title !== "hulu_free"
  },
  providerList: function() {
    return ['hulu_plus', 'hbo', 'netflix']
  },
  wholeList: function() {
    return ['hulu_plus', 'hbo', 'netflix', 'hulu_free']
  }
}

var UpdateProfile = {
  addService: function(service) {
    debugger;
  },
  removeService: function(service) {

  },
  reShowItem: function(item) {
  
  }
}
