describe("Application File", function() {
  it("runs Search.query on navbar-form submit", function () {
    var searchArea = "<div class='search-area'><form class='navbar-form'><button type='submit'></button></form></div>";
    spyOn(Search, 'query');
    
    $(searchArea).trigger('submit');
    
    expect(Search.query).toHaveBeenCalled(); 
  });
});
