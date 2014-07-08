describe('scrollTracking', function () {
  'use strict';

  var scrollTracking,
      $body;

  before(function (done) {
    require(['scrollTracking'], function (ma) {
      $('body').html(window.__html__['spec/javascripts/templates/scrollTracking.html']);
      $body = $('body');

      scrollTracking = ma;
      done();
    }, done);
  });

  it('should return false when there is no options object', function () {
    expect(scrollTracking()).to.equal(false);
  });

  it('should return false when there are no trigger points defined', function () {
    expect(scrollTracking({el: 'body', triggerPoints: false})).to.be.false;
  });

  it('should return false when the trigger points are not an array', function () {
    expect(scrollTracking({el: 'body', triggerPoints: {'test': 'object'}})).to.be.false;
  });

  it('should return false when the element is not in the DOM', function () {
    expect(scrollTracking({el: '.notInDom', triggerPoints: [0.25]})).to.be.false;
  });


  // AT - This test works in :serve but not using :run. Leaving commented out so we can try and resolve at a later stage
  xit('should ONLY push object to GTM datalayer the first time it scrolls past a triggerPoint, not on UP, or second down', function(done){
    var object = {el:'.wp-container2', triggerPoints:[0.5]},
      delay = 250;

    // Bind events
    scrollTracking(object);

    // cache dataLayer length - must be after event binding, as some events fire in creation
    var l = dataLayer.length;

    // Beautiful code for forcing it to scroll down>up>down !
    $(window).scrollTop(3000);
    setTimeout(function(){
      expect(dataLayer).to.have.length(l+1);

      $(window).scrollTop(0);
      setTimeout(function(){
        expect(dataLayer).to.have.length(l+1);

        $(window).scrollTop(3000);
        setTimeout(function(){
          expect(dataLayer).to.have.length(l+1);
          done();

        },delay)
      },delay);
    },delay);
  })

});
