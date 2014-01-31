//= require spec_helper
// require views

// appendTo = function(applicationRoot) {
//   return $(applicationRoot).append('<div class="hello-world">Hello, world!</div>');
// };


describe("mas_analytics#scrollTracking", function(){
  var mas_analytics, spy;

  beforeEach(function(done){
    spy = sinon.spy(MAS, 'log');
    require(['mas_analytics'], function(ma) {
      mas_analytics = ma;
      done()
    }, done);
  })

  it("when there is no options object", function(){
    // var spy = sinon.spy();
    expect(mas_analytics.scrollTracking()).to.equal(false)
  })

  it("when there are no trigger points defined", function(){
    expect(mas_analytics.scrollTracking({el:'body', triggerPoints:false})).to.equal(false)
  })

  it("when the element is not in the DOM", function(){
    expect(mas_analytics.scrollTracking({el:false, triggerPoints:[0.25]})).to.equal(false)
  })

  it("should log each triggerPoint when it binds the event", function(){
    var $body = $('body').html(JST['templates/scrollTracking']());
    var object = {el:'body', triggerPoints:[0.5]};

    var testspy = sinon.spy(_privateDullShit);

    mas_analytics.triggerAnalytics(object);
    // assert(spy.calledWith('mas_analytics.scrollTracking (bind each) - '))
    assert(testspy.called)

  })

  // it("should set ", function(){
  //   var $body = $('body').html(JST['templates/scrollTracking']());
  //   var spy = sinon.spy($body, 'waypoint');


  //   mas_analytics.scrollTracking({el:'body', triggerPoints:[0.5]});

  //   assert(spy.called);
  //   // assert(spy.calledWith(mas_analytics._handleScroll));
  // })

  afterEach(function(){
    MAS.log.restore();
  })

})

describe("mas_analytics#_handleScroll", function(){
  var mas_analytics;

  beforeEach(function(done){
    require(['mas_analytics'], function(ma) {
      mas_analytics = ma;
      done()
    }, done);
  })

  it("should return false when user scrolls up", function(){
    var dir = 'up';
    var val = 0.25;
    expect( mas_analytics._handleScroll(dir,val) ).to.equal(false)
  })

})

// describe('application view', function() {
//   it('should render', function() {
//     // Call the production code
//     appendTo('#konacha');
//     // Test that "Hello World" was rendered (by testing that the
//     // number of .hello-world divs is truthy)
//     assert.ok($('#konacha').find('div.hello-world').length);
//   });
// });


describe("mas_analytics#triggerAnalytics", function(){
  var mas_analytics, spy;

  beforeEach(function(done){
    spy = sinon.spy(MAS, 'log');
    require(['mas_analytics'], function(ma) {
      mas_analytics = ma;
      done()
    }, done);
  })

  it("when triggerAnalytics is called it is logged", function(){
    var object = {'title':'test'};

    mas_analytics.triggerAnalytics(object);
    assert(spy.calledWith('mas_analytics.triggerAnalytics',object))
  })

  it("when triggerAnalytics is called object is pushed to the datalayer", function(){
    var object = {'title':'test'};
    var initialLength = dataLayer.length;

    mas_analytics.triggerAnalytics(object);
    assert.equal(dataLayer.length, (initialLength + 1));
  })

  afterEach(function(){
    MAS.log.restore();
  })

})



