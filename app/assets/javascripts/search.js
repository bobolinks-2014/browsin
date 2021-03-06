var Search = {
  query: function(query) {
    var request = $.ajax({
      url: "/search?query="+query,
      type: "GET",
      dataType: "JSON"   
    });
    request.done(function(response) {
      Render.removeLoader();
      if(response.success == false) {
        Render.fail(response.error);
      } 
      else {
        Render.done(response);
      }
    });
    return request;
  },
  lookUp: function(query) {
    var request = $.ajax({
      url: "/find?lookup="+query,
      type: "GET",
      dataType: "JSON"   
    });
    request.done(function(response) {
      Render.removeLoader();
      if(response.success == false) {
        Render.fail(response.error);
      } 
      else {
        $('#search-bar-value').val('');;
        Render.done(response);
        Render.scrollToTop();
        $('#search-bar-value').val(response.matches[0]);
      }
    });
    return request;
  },
  top25: function() {
    var request = $.ajax({
      url: "/top25",
      type: "GET",
      dataType: "JSON"
    });
    request.done(function(response) {
      Render.removeLoader();
      if (response.success == false) {
        Render.pleaseLogin();
      } 
      else {
        Render.done(response);
      }
    });
    return request;
  }
}
var removeMediaItem = function(dataId, locationArea) {
  var request = $.ajax({
    url: "/media/"+dataId,
    type: "PATCH",
    dataType: "JSON"
  });
  request.done(function(response) {
    Render.remove(locationArea);
  });
}

var Render = {
  fail: function(query) {
    $('#search-area').append("<br><div class='col-md-6 col-md-offset-3 alert alert-white' role='alert'><strong>Couldn't find any results for: "+query+"</strong></div>")
     window.setTimeout(function() {
       $(".alert").fadeTo(500, 0).slideUp(500, function(){
         $(this).remove();
     });
    }, 4000);
  },
  pleaseLogin: function() {
    $('#search-area').append("<br><div class='col-md-7 col-md-offset-3 alert alert-white col-sm-12 col-xs-12' role='alert'><strong>Please login to search.</strong></div>")
     window.setTimeout(function() {
       $(".alert").fadeTo(500, 0).slideUp(500, function(){
         $(this).remove();
     });
    }, 4000);
  },
  remove: function(area) {
    $(area.parents().eq(2)).fadeTo(500, 0).slideUp(500, function() {
    });
  },
  animate: function() {
    $('body').css("background-color", "white");
    $('.title').animate({'margin-top': "5px"}, 800);
    $(".runtime").tooltip('hide');
  },
  done: function(response) {
    this.animate();
    renderList(this.cleanData(response));
    $('[data-toggle="tooltip"]').tooltip();
  },
  removeLoader: function() {
    $('.loader').remove();
  },
  scrollToTop: function() {
    $('html, body').animate({ scrollTop: 0 }, 800);
  },
  searchResult: function(results) {
    $('.search-results-area-div').prepend(results);
  },
  cleanData: function(data) {
    return [JSON.parse(data['media']), data['matches']]
  },
  getTime: function() {
    var d = new Date();
    var n = d.getTime();
    return n; 
  }
}

var Vendor = {
  find: function(vendor) {
    if(vendor == "hulu_plus" || vendor == "hulu_free") {
      return "www.hulu.com/search?q="
    }
    else if(vendor == "netflix") {
      return "www.netflix.com/WiSearch?v1="
    }
    else if(vendor == "hbo") {
      return "www.hbogo.com/#search&browseMode=browseGrid?searchTerm="
    }
  }
}
