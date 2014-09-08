describe("queryLookUp", function() {

  it("Sends parameters to rails server as variable in url", function () {
    var query = "comedy";
    var call = spyOn($, 'ajax').and.callFake(function (req) {
      var d = $.Deferred();
      d.done(query);
      return d.promise();
    }); 
    queryLookUp(query);
    expect(call.calls.allArgs()[0][0].url).toEqual("/search?query="+query);
  });

  it("Should run renderFail on error",function() {
    var query = "drama";
    var callOut = spyOn($, 'ajax').and.callFake(function (req) {
      var d = $.Deferred();
      d.fail(query);
      return d.promise(); 
    });
    queryLookUp(query);
    expect(renderFail).toHaveBeenCalled();
  });
});
