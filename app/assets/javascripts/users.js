$( document ).ready(function(){
  $('.login-area').on("click", '.profile', function(event) {
    Login.fetch();
  });
  $('.profile-page').on('click', '.add', function(event) {
    var service = $(this).parent().attr('id')
    var service_list = $(this).parents().eq(1).attr('id').split(",");
    UpdateProfile.addService(service, service_list);  
  });
  $('.profile-page').on('click', '.remove', function(event) {
    var service = $(this).parent().attr('id')
    var service_list = $(this).parents().eq(1).attr('id').split(",");
    UpdateProfile.removeService(service, service_list);  
  });
  $('.profile-page').on('click', '.show', function(event) {
    var item = $(this).attr('id')
    var area = $(this); 
    UpdateProfile.reShowItem(item, area);  
  });
});

var Login = {
  fetch: function() {
    var request = $.ajax({
      url: "/users/show",
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
  getButton: function(element, list) {
    if($.inArray(element, list) >= 0) {
      return 'remove'
    } else {
      return 'add'
    }
  },
  providerList: function() {
    return ['hulu_plus', 'hbo', 'netflix']
  }
}
var UpdateProfile = {
  ajaxCall: function(list) {
    var request = $.ajax({
      url: "/users",
      type: "PATCH",
      dataType: "JSON",
      data: {service_list: list}
    });
    request.done(function(response) {
      if(response.success == true) {
        Login.fetch();
      }
    });
    return request;
  },
  addService: function(service, list) {
    list.push(service);
    this.ajaxCall(list);
  },
  removeService: function(service, list) {
    a = list.indexOf(service); 
    list.splice(a, 1);
    this.ajaxCall(list);
  },
  reShowItem: function(item, area) {
    var request = $.ajax({
      url: "/media/add",
      type: "PATCH",
      dataType: "JSON",
      data: {item_id: item}
    });
    request.done(function(response) {
      if(response.success == true) {
        $(area.parents().eq(1)).fadeTo(500, 0).slideUp(500, function() {
        });
      }
    });
    return request;
  }
}
