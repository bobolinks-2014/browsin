describe("Application File", function() {
  it("signs in a user", function () {
    spyOn($.fn, "click");
    $("#email").val("joey@joey.com");
    $("#password").val("password");
    $("#sign-in-button").click();
    //expect($.fn.append).toEqual();
  });
});
