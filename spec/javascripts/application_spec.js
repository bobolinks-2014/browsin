describe("Application File", function() {
  it("", function () {
    spyOn($.fn, "val").andReturn("bar");
    var result = $("#Something").val();
    expect(result).toEqual("bar");
  });
});
