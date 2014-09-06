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
      animatePage();
      renderList(response);
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
  }, 3000);
}

function animatePage() {
  $( ".content" )
  .animate({
    height: "20%"
  }, {
    queue: false,
    duration: 2000
  })
  .animate({ fontSize: "24px" }, 1500 )
  .animate({ borderRightWidth: "15px" }, 1500 );
}
