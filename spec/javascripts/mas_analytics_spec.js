

describe("templating", function() {
  it("is built in to Sprockets", function() {
    $('body').html(JST['templates/hello']());
    $('body h1').text().should.equal('Hello Konacha!');
  });
});

describe("mas_analytics#scrollTracking", function(){
  describe("when options are invalid",function(){
    it("when there is no option", function(){
      mas_analytics.scrollTracking()
    })
    it("when the element is not in the DOM", function(){
      mas_analytics.scrollTracking({el:false, triggerPoints:[0.25]})
    })
    it("when there are no trigger points defined", function(){
      mas_analytics.scrollTracking({el:, triggerPoints:[0.25]})
    })
  })
})