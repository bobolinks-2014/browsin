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
    } 
    else {
      animatePage();
      renderList(response);
      $('[data-toggle="tooltip"]').tooltip();
    }
  });
  return request;
}

var assetLookUp = function(query) {
  var request = $.ajax({
    url: "/find?lookup="+query,
    type: "GET",
    dataType: "JSON"   
  });
  request.done(function(response) {
    $('.loader').remove();
    if(response.success == false) {
      renderFail(response.error); 
    } 
    else {
      animatePage();
      renderList(response);
      $('[data-toggle="tooltip"]').tooltip();
    }
  });
  return request;
}
var topTwentyFive = function() {
  var request = $.ajax({
    url: "/top25",
    type: "GET",
    datatType: "JSON"
  });
  request.done(function(response) {
    $('.loader').remove();
    if (response.success == false) {
      renderFail(response.error); 
    } 
    else {
      animatePage();
      renderList(response);
      $('[data-toggle="tooltip"]').tooltip();
    }
  });
  return request;
}

var removeMediaItem = function(dataId, locationArea) {
  var request = $.ajax({
    url: "/media/"+dataId,
    type: "PATCH",
    dataType: "JSON"
  });
  request.done(function(response) {
    removeItem(locationArea);
  });
}

function removeItem(area) {
  $(area.parents().eq(2)).fadeTo(500, 0).slideUp(500, function() {
  });
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
