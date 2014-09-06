var queryLookUp = function(query) {
  var request = $.ajax({
    url: "/search?"+query,
    type: "GET",
    dataType: "JSON"   
  });
  request.done(function(response) {
    if(response.success == false) {
      renderFail(response.error); 
    } else {
      renderList(response);
      animatePage();
      $("#media-items").accordion({ collapsible: true, active: false });
    }
  });
  return request;
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
  $('.title').animate({
    'margin-top': "5px"
  }, 800);
}
