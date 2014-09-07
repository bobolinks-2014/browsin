var queryLookUp = function(query) {
  var request = $.ajax({
    url: "/search?query="+query,
    type: "GET",
    dataType: "JSON"   
  });
  request.done(function(response) {
    $('.loader').remove();
    if(response.success == false) {
      renderFail(response.error); 
    } else {
      animatePage();
      renderList(response);
    }
  });
  return request;
}

var removeMediaItem = function(id) {
  var request = $.ajax({
    url: "/media?id="+id,
    type: "PATCH"
  });
  request.done(function(response) {
    if(response.success == true) {
      removeMediaItem(response);
    }
  });
}

function removeMediaItem(id) {
  debugger;
}

function renderFail(query) { 
  $('#search-area').append("<br><div class='col-md-4 col-md-offset-4 alert alert-white' role='alert'><strong>Couldn't find any results for: "+query+"</strong></div>")
    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
    });
  }, 4000);
}

function animatePage() {
  $('body').css("background-color", "white");
  $('.title').animate({'margin-top': "5px"}, 800);
  $(".runtime").tooltip('hide');
}
