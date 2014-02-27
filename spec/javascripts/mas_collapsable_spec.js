//= require spec_helper
//= require templates/collapsable



describe("mas_collapsable basics", function () {

  var ValidCollapsable, 
      EmptyCollapsable,
      $body;

  // beforeEach()
  // afterEach()

  before(function (done) {
    $('body').html(JST['templates/collapsable']());
    $body = $('body');

    require(['collapsable'], function (mod) {
      ValidCollapsable = new mod();
      EmptyCollapsable = new mod({triggerEl:'.doesntExist'});
      done();
    }, done);
  })

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
    var buttonVisible, targetVisible, buttonHidden, targetHidden;

    before(function(){
      buttonVisible = $body.find('#toggleButton1');
      targetVisible = $body.find('#toggleTarget1');
      buttonHidden = $body.find('#toggleButton2');
      targetHidden = $body.find('#toggleTarget2');
    })

    it("adds aria-role=button to all toggle trigger elements", function(){
      expect(buttonVisible.attr('aria-role')).to.equal('button');
    })
    
    describe("target element is hidden", function () {
      it("adds aria-hidden=true to target element", function(){
        expect(targetHidden.attr('aria-hidden')).to.equal('true')
      })
      it("adds (inactive class) on both target and trigger elements", function(){
        expect(buttonHidden.hasClass(ValidCollapsable.o.inactiveClass)).to.be.true;
        expect(targetHidden.hasClass(ValidCollapsable.o.inactiveClass)).to.be.true;
      })
    })

    describe("target element is visible", function () {
      it("adds aria-hidden=false to target element", function(){
        expect(targetVisible.attr('aria-hidden')).to.equal('false')        
      })
      it("adds (active class) on both target and trigger elements", function(){
        expect(buttonVisible.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
        expect(targetVisible.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
      })
    })
  })

  describe("when trigger is activated on closed element", function(){
    var button, target;

    function setTargetToHidden( hidden ){
      if( hidden && target.hasClass(ValidCollapsable.o.activeClass) ){ 
        button.trigger('click')
      }else if( !hidden && target.hasClass(ValidCollapsable.o.inactiveClass) ){
        button.trigger('click')
      }
    }

    before(function(){
      button = $body.find('#toggleButton1');
      target = $body.find('#toggleTarget1');
    })

    it("sets aria-hidden=false on target element", function(){
      // Set initial state to hidden then trigger toggle
      setTargetToHidden(true);
      button.trigger('click');
      expect(target.attr('aria-hidden')).to.equal('false');
    })
    
    it("adds (active class) on both target and trigger elements", function(){
      // Set initial state to hidden then trigger toggle
      setTargetToHidden(true);
      button.trigger('click');
      expect(button.hasClass(ValidCollapsable.o.activeClass)).to.be.true;
      expect(target.hasClass(ValidCollapsable.o.activeClass)).to.be.true;      
    })

    it("adds keyboard(space) support to trigger elements", function(done){
      setTargetToHidden(true);

      // Trigger keypress on spacebar
      var e = jQuery.Event("keypress");
      e.which = 32;
      e.charCode = 32;

      button.trigger(e);
      expect(target.hasClass(ValidCollapsable.o.inactiveClass)).to.be.false;
      expect(target.hasClass(ValidCollapsable.o.activeClass)).to.be.true;

      done();
    })

    describe("when the accordion options is enabled", function(){
      xit("closes any open target elements in the collection", function(){})
    })
  })

  describe("when trigger is activated on an open element", function(){
    var button, target;

    function setTargetToHidden( hidden ){
      if( hidden && target.hasClass(ValidCollapsable.o.activeClass) ){ 
        button.trigger('click')
      }else if( !hidden && target.hasClass(ValidCollapsable.o.inactiveClass) ){
        button.trigger('click')
      }
    }

    before(function(){
      button = $body.find('#toggleButton1');
      target = $body.find('#toggleTarget1');
    })

    it("sets aria-hidden=true on target element", function(){
      // Set initial state to hidden then trigger toggle
      setTargetToHidden(false);
      button.trigger('click');
      expect(target.attr('aria-hidden')).to.equal('true');
    })
    
    it("adds (inactive class) on both target and trigger elements", function(){
      // Set initial state to hidden then trigger toggle
      setTargetToHidden(false);
      button.trigger('click');
      expect(button.hasClass(ValidCollapsable.o.inactiveClass)).to.be.true;
      expect(target.hasClass(ValidCollapsable.o.inactiveClass)).to.be.true;      
    })

    it("adds keyboard(space) support to trigger elements", function(done){
      setTargetToHidden(false);

      // Trigger keypress on spacebar
      var e = jQuery.Event("keypress");
      e.which = 32;
      e.charCode = 32;

      button.trigger(e);
      expect(target.hasClass(ValidCollapsable.o.activeClass)).to.be.false;
      expect(target.hasClass(ValidCollapsable.o.inactiveClass)).to.be.true;

      done();
    })
  })

})

describe("mas_collapsable#options", function(){
  var Collapsable;
  var $body;

  before(function(done){
    $('body').html(JST['templates/collapsable']());
    $body = $('body');

    require(['collapsable'], function (mod) {
      Collapsable = new mod({
        triggerEl: $('#optionsTest > li > a'),
        targetEl: 'ul',
        showOnlyFirst: true,
        accordion: true,
        closeOffFocus: true
      });

      done();
    }, done);

  })

  // after(function(){
  //   Collapsable = false;
  // })

  describe("when the showOnlyFirst option is enabled", function(){
    it("accordion activeClass should = true", function(){
      expect(Collapsable.o.showOnlyFirst).to.be.true;
    })

    it("add activeClass to the first item and inactive class to all subsequent sections", function(){
      expect(Collapsable.o.showOnlyFirst).to.be.true;
      var S = Collapsable.sections;
      $.each(S, function(i,el){
        if(i === 0){
          expect( S[i].hidden ).to.be.false;
        }else{
          expect( S[i].hidden ).to.be.true;
        }
      })
    })
  })

  describe("when the accordion options is enabled", function(){
    it("accordion option should = true", function(){
      expect(Collapsable.o.accordion).to.be.true;
    })

    it("closes any open target elements in the collection", function(){
      var S = Collapsable.sections;
      S[2].trigger.click();

      $.each(S, function(i,el){
        if(i === 2){
          expect(S[i].hidden).to.be.false;
        }else{
          expect(S[i].hidden).to.be.true;
        }
      })
    })
  })

  // Have not found a way to successfully emulate user keyboard tabbing through content
  describe("when the closeOffFocus option is enabled", function(){
    xit("closes the open element when focus leaves it", function(){
      var S = Collapsable.sections;
      // Open list
      S[0].trigger.click();

      // Focus on last element in target one
      S[0].target.find('a:last').focus();

      // Focus on next element to trigger focusout
      S[1].trigger.focus();

      // check if previous element is shut
      expect(S[0].hidden).to.be.true;
    })
  })

})
