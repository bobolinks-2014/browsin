var queryLookup = function(query) {
  var request = $.ajax({
    url: "/search?query="+query,
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
