describe("Search", function() {
  
  describe("Search.query", function() {
  
    it("Sends parameters to rails server as variable in url", function () {
      var query = "comedy";
      var d = $.Deferred();
      spyOn($, 'ajax').and.returnValue(d);
  
      Search.query(query);
      expect($.ajax).toHaveBeenCalledWith({url: "/search?query="+query,
                                           type: "GET",
                                           dataType: "JSON"});
    });
  
    it("Should run Render.fail on error", function() {
      var query = "fake-a-gory";
      var d = $.Deferred();
      d.resolve({success: false});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'fail')
  
      Search.query(query);
  
      expect(Render.fail).toHaveBeenCalled();
    });
  
    it("Should run Render.done on success true", function() {
      var query = "drama";
      var d = $.Deferred();
      d.resolve({success: true});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'done')
  
      Search.query(query);
  
      expect(Render.done).toHaveBeenCalled();
    });
  });

  describe("Search.lookUp", function() {
  
    it("Should send a request to proper url", function () {
      var query = "comedy";
      var d = $.Deferred();
      var call = spyOn($, 'ajax').and.returnValue(d);
  
      Search.lookUp(query);
      expect($.ajax).toHaveBeenCalledWith({url: "/find?lookup="+query,
                                           type: "GET",
                                           dataType: "JSON"})
    });
  
    it("Should remove loading sprite on resolve", function() {
      var query = "drama";
      var d = $.Deferred();
      d.resolve({success: false});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'removeLoader')
  
      Search.lookUp(query);
  
      expect(Render.removeLoader).toHaveBeenCalled();
    });
  
    it("Should run Render.fail on success false", function() {
      var query = "non category";
      var d = $.Deferred();
      d.resolve({success: false});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'fail')
  
      Search.lookUp(query);
  
      expect(Render.fail).toHaveBeenCalled();
    });

    it("Should run Render.done on success true", function() {
      var query = "drama";
      var d = $.Deferred();
      d.resolve({success: true});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'done')
  
      Search.lookUp(query);
  
      expect(Render.done).toHaveBeenCalled();
    });
  });

  describe("Search.top25", function() {
    it("Should resolve the correct url on button click", function() {
      var d = $.Deferred();
      var call = spyOn($, 'ajax').and.returnValue(d);

      Search.top25();
      expect($.ajax).toHaveBeenCalledWith({url: "/top25",
                                           type: "GET",
                                           dataType: "JSON"});
    });

    it("should render fail if success is false", function() {
      var d = $.Deferred();
      d.resolve({success: false});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'pleaseLogin')
  
      Search.top25();
  
      expect(Render.pleaseLogin).toHaveBeenCalled();
    });

    it("should render done if success is false", function() {
      var d = $.Deferred();
      d.resolve({success: true});
  
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'done');
  
      Search.top25();
  
      expect(Render.done).toHaveBeenCalled();
    });

  });

  describe("removeMediaItem", function() {
    it('should resolve the proper address', function() {
      var d = $.Deferred();
      var id = '12'
      var call = spyOn($, 'ajax').and.returnValue(d);

      removeMediaItem(id, '13');
      expect($.ajax).toHaveBeenCalledWith({url: "/media/"+id,
                                           type: "PATCH",
                                           dataType: "JSON"});
    });

    it("should run Render.remove on success", function() {
      var d = $.Deferred();
      var location = {area: 123};
      d.resolve();
      
      spyOn($, 'ajax').and.returnValue(d);
      spyOn(Render, 'remove');

      removeMediaItem("12", location);
      expect(Render.remove).toHaveBeenCalledWith(location);
    });
  });
});

describe("Vendor", function() {
  it("should call with a vendor name", function() {
    var vendor = "hulu"
    spyOn(Vendor, 'find');    
    Vendor.find(vendor);
    expect(Vendor.find).toHaveBeenCalledWith(vendor);
  });

  it("return a url", function() {
    var vendor = "hulu_plus"
    expect(Vendor.find(vendor)).toEqual("www.hulu.com/search?q=");
  });
});
