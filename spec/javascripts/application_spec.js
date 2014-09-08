describe("Application File", function() {
  it("should be able to mock DOM call", function () {
    spyOn($.fn, "val").andReturn("bar");
    var result = $("#Something").val();
    expect(result).toEqual("bar");
  });
});
