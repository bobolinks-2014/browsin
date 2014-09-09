describe("queryLookUp", function() {

  it("Sends parameters to rails server as variable in url", function () {
    var query = "comedy";

    var d = $.Deferred();
    var call = spyOn($, 'ajax').and.returnValue(d);

    Search.query(query);
    expect($.ajax).toHaveBeenCalledWith({url: "/search?query="+query,
                                         type: "GET",
                                         dataType: "JSON"})
  });

  it("Should run Render.fail on error", function() {
    var query = "drama";

    var d = $.Deferred();
    d.resolve({success: false});
    Search.query(query);

    spyOn($, 'ajax').and.returnValue(d);
    spyOn(Render, 'fail')

    expect(Render.fail).toHaveBeenCalled();
  });
});
