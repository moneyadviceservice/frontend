//= require spec_helper



describe("mas_collapsable", function () {

  var ValidCollapsable, 
      EmptyCollapsable,
      $body;

  before(function (done) {
    $('body').html(JST['templates/collapsable']());
    $body = $('body');

    require(['collapsable'], function (mod) {
      ValidCollapsable = new mod();
      EmptyCollapsable = new mod({triggerEl:'.doesntExist'});
      done();
    }, done);
  })


  // NEW TOP NAV TESTS
  describe("when initiated", function(){
    it("return false if no trigger elements in DOM", function () {
      expect(EmptyCollapsable.sections.length).to.be.equal(0);
    })

    it("contains a valid set of options", function () {
      expect(ValidCollapsable.o).to.have.property('triggerEl');
      expect(ValidCollapsable.o).to.have.property('targetEl');
      expect(ValidCollapsable.o).to.have.property('activeClass');
      expect(ValidCollapsable.o).to.have.property('closeOffFocus');
      expect(ValidCollapsable.o).to.have.property('accordion');
    })
  })

  describe("onload", function () {

    it("adds aria-role=button to all toggle trigger elements", function(){
      var button = $body.find('#toggleButton1');
      expect(button.attr('aria-role')).to.equal('button');
    })
    
    describe("target element is hidden", function () {
      it("adds aria-hidden=true to target element", function(){
        var hiddenTarget = $body.find('#toggleTarget2');
        expect(hiddenTarget.attr('aria-hidden')).to.equal('true')
      })
      it("adds (active class) on both target and trigger elements", function(){
        var hiddenTrigger = $body.find('#toggleButton2');
        var hiddenTarget = $body.find('#toggleTarget2');
        expect(hiddenTrigger.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
        expect(hiddenTarget.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
      })
    })

    describe("target element is visible", function () {
      it("adds aria-hidden=false to target element", function(){
        var visibleTarget = $body.find('#toggleTarget1');
        expect(visibleTarget.attr('aria-hidden')).to.equal('false')        
      })
    })
  })


  describe("when trigger is activated on closed element", function(){
    xit("sets aria-hidden=false on target element", function(){})
    xit("adds (active class) on both target and trigger elements", function(){})

    describe("when the accordion options is enabled", function(){
      xit("closes any open target elements in the collection", function(){})
    })

    it("adds keyboard(space) support to trigger elements", function(done){
      var button = $body.find('#toggleButton1');
      var target = $body.find('#toggleTarget1');
      console.log(target.hasClass(ValidCollapsable.o.activeClass))
      // Trigger keypress on spacebar
      var e = jQuery.Event( 'keydown', { which: 32, keyCode: 32 } );
      button.trigger(e);
      setTimeout(function(){
      console.log(target.hasClass(ValidCollapsable.o.activeClass))
        expect(target.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
        done()
      },200)
    })

  })

  // describe("when trigger is activated on open element", function(){
  //   it("toggles aria-hidden=true on target element", function(){})
  //   it("removes (active class) on both target and trigger elements", function(){})
  // })

  // describe("when the closeOffFocus option is enabled", function(){
  //   it("closes the open element when focus leaves it", function(){})
  // })








  // it("should add activeClass to all sections except first if o.showOnlyFirst is true", function(){
  //   var S = $body.find(ValidCollapsable.o.triggerEl);
  //   S.each(function(i,el){
  //     if(i === 0){
  //       expect($(el).hasClass(ValidCollapsable.o.activeClass)).to.be.true;
  //     }else{
  //       expect($(el).hasClass(ValidCollapsable.o.activeClass)).to.be.false;
  //     }
  //   })
  // })

  // it("should toggle the active class on both trigger and target element when the toggle element is clicked", function (done) {
  //   var button = $body.find('#toggleButton1');
  //   var target = $body.find('#toggleTarget1');

  //   // Confirm initial state
  //   expect(button.hasClass(ValidCollapsable.o.activeClass)).to.be.false;
  //   expect(target.hasClass(ValidCollapsable.o.activeClass)).to.be.false;

  //   // Force interaction
  //   button.trigger('click');

  //   // Test expected state
  //   expect(button.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
  //   expect(target.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
  //   done();      

  // })

})