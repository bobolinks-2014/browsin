describe("User Sessions", function() {
  var email, pass, passconf, services 

  beforeEach(function(){
   var email = "bob@bob.com"
   var pass = "1234"
   var passconf = "1234"
   var services =  {services: ['netflix', 'hulu_plus']}
   var dataSet = {user: { email: email, password: pass, 
                          password_confirmation: passconf }, 
                  services: services }
  });

  describe("Signup", function() {
    it("should submit a request to the proper url", function() {
      var d = $.Deferred();
      spyOn($, 'ajax').and.returnValue(d);

      Signup.submit('location');
      expect($.ajax.calls.argsFor(0)[0]['url']).toEqual('/users');
    });
  });

  describe("getServices", function() {

    it('should return an array containing the value if true', function() {
      var data = "<div><input type='checkbox' name='provider[netflix]' id='netflixBox' value='netflix' checked></div>";
      var a = getServices(data);
      expect(a['services']).toContain('netflix');
    });

    it('should not return the object if it was not checked', function() {
      var data = "<div><input type='checkbox' name='provider[netflix]' id='netflixBox' value='netflix'></div>";
      var a = getServices(data);
      expect(a['services']).not.toContain('netflix');
    });
  });

  describe('submitDataParse', function() {
    it('should return the inputed email', function() {
      var email = "bob@bob.com"
      var data = "<div><input id='email' value='"+email+"'></div>";
      var a = submitDataParse(data);
      
      expect(a['email']).toEqual(email);
    });
  });

});
