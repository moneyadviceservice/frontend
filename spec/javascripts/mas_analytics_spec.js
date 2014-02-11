//= require spec_helper

describe("mas_analytics#scrollTracking", function(){
  var mas_analytics;

  beforeEach(function(done){
    $('body').html(JST['templates/scrollTracking']());
    require(['analytics'], function(ma) {
      mas_analytics = ma;
      done()
    }, done);
  })

  it("should return false when there is no options object", function(){
    expect(mas_analytics.scrollTracking()).to.equal(false)
  })

  it("should return false when there are no trigger points defined", function(){
    expect(mas_analytics.scrollTracking({el:'body', triggerPoints:false})).to.be.false
  })

  it("should return false when the trigger points are not an array", function(){
    expect(mas_analytics.scrollTracking({el:'body', triggerPoints:{'test':'object'}})).to.be.false
  })

  it("should return false when the element is not in the DOM", function(){
    expect(mas_analytics.scrollTracking({el:'.notInDom', triggerPoints:[0.25]})).to.be.false
  })


  // AT - This test works in :serve but not using :run. Leaving commented out so we can try and resolve at a later stage
  // it("should ONLY push object to GTM datalayer the first time it scrolls past a triggerPoint, not on UP, or second down", function(done){
  //   var object = {el:'.wp-container2', triggerPoints:[0.5]},
  //     delay = 250;

  //   // Bind events
  //   mas_analytics.scrollTracking(object);

  //   // cache dataLayer length - must be after event binding, as some events fire in creation
  //   var l = dataLayer.length;

  //   // Beautiful code for forcing it to scroll down>up>down !
  //   $(window).scrollTop(3000);
  //   setTimeout(function(){
  //     expect(dataLayer).to.have.length(l+1);

  //     $(window).scrollTop(0);
  //     setTimeout(function(){
  //       expect(dataLayer).to.have.length(l+1);

  //       $(window).scrollTop(3000);
  //       setTimeout(function(){
  //         expect(dataLayer).to.have.length(l+1);
  //         done();

  //       },delay)
  //     },delay);
  //   },delay);
  // })

})


describe("mas_analytics#triggerAnalytics", function(){
  var mas_analytics, spy;

  beforeEach(function(done){
    spy = sinon.spy(MAS, 'log');
    require(['analytics'], function(ma) {
      mas_analytics = ma;
      done()
    }, done);
  })

  it("should log event when triggerAnalytics() is called", function(){
    var object = {'title':'test'};
    mas_analytics.triggerAnalytics(object);
    assert(spy.calledWith('mas_analytics.triggerAnalytics',object))
  })

  it("should push object to the GTM datalayer when triggerAnalytics() is called", function(){
    var object = {'title':'test'};
    var initialLength = dataLayer.length;
    mas_analytics.triggerAnalytics(object);
    expect(initialLength + 1).to.equal( dataLayer.length );
  })

  afterEach(function(){
    MAS.log.restore();
  })

})


