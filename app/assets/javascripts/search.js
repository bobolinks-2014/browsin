var queryLookUp = function(query) {
  var request = $.ajax({
    url: "/search?"+query,
    type: "GET",
    dataType: "JSON"   
  });
  request.fail(function(status) {
    renderFail(status, query); 
  });
  request.done(function(itemList) {
    renderList(itemList);
  });
  return request;
}

function renderFail(status, query) { 
  $('#search-area').append("<br><div class='col-md-4 col-md-offset-4 alert' role='alert'><strong>Couldn't find any results for: "+query+"</strong></div>")
    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
      });
    }, 3000);
}
