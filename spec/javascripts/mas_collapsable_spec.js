describe('mas_collapsable basics', function () {
  'use strict';

  var validcollapsable,
      emptycollapsable,
      $body;

  before(function (done) {
    require(['collapsable'], function (Mod) {
      $('body').html(window.__html__['spec/javascripts/templates/collapsable.html']);
      $body = $('body');

      validcollapsable = new Mod({showOnlyFirst:true});
      emptycollapsable = new Mod({triggerEl:'.doesntExist'});
      done();
    }, done);
  });

  describe('when initiated', function() {
    it('return false if no trigger elements in DOM', function () {
      expect(emptycollapsable.sections.length).to.be.equal(0);
    });

    it('contains a valid set of options', function () {
      expect(validcollapsable.o).to.have.property('triggerEl');
      expect(validcollapsable.o).to.have.property('targetEl');
      expect(validcollapsable.o).to.have.property('activeClass');
      expect(validcollapsable.o).to.have.property('closeOffFocus');
      expect(validcollapsable.o).to.have.property('accordion');
      expect(validcollapsable.o).to.have.property('numberItemsToDisplay');
      expect(validcollapsable.o).to.have.property('viewAllButton');
    });
  });

  describe('onload', function () {
    var buttonVisible,
      targetVisible,
      buttonHidden,
      targetHidden,
      visibleItems,
      invisibleItems,
      buttonViewAllHidden,
      buttonViewAllVisible;

    before(function() {
      buttonVisible        = $body.find('#toggleButton1');
      targetVisible        = $body.find('#toggleTarget1');
      buttonViewAllVisible = $body.find('#viewAll1');
      buttonHidden         = $body.find('#toggleButton2');
      buttonViewAllHidden  = $body.find('#viewAll2');
      targetHidden         = $body.find('#toggleTarget2');
      visibleItems         = $body.find('li.is-on');
      invisibleItems       = $body.find('li.is-off');
    });

    it('adds aria-role=button to all toggle trigger elements', function() {
      expect(buttonVisible.attr('aria-role')).to.equal('button');
    });

    describe('target element is hidden', function () {

      it('adds aria-hidden=true to target element', function() {
        expect(targetHidden.attr('aria-hidden')).to.equal('true');
      });

      it('adds (inactive class) on both target and trigger elements', function() {
        expect(buttonHidden.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
        expect(targetHidden.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
      });

      it('adds (inactive class) on the target items', function() {
        expect(invisibleItems).to.have.length(8);
      });

      it('adds (inactive class) on the view all button', function() {
        expect(buttonViewAllHidden.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
      });

      it('adds aria-hidden=true on the view all button', function() {
        expect(buttonViewAllHidden.attr('aria-hidden')).to.equal('true');
      });
    });

    describe('target element is visible', function () {
      it('adds aria-hidden=false to target element', function() {
        expect(targetVisible.attr('aria-hidden')).to.equal('false');
      });

      it('adds (active class) on both target and trigger elements', function() {
        expect(buttonVisible.hasClass(validcollapsable.o.activeClass)).to.be.true;
        expect(targetVisible.hasClass(validcollapsable.o.activeClass)).to.be.true;
      });

      it('adds (active class) on the first six items', function() {
        expect(visibleItems).to.have.length(6);
      });

      it('adds (active class) on the view all button', function() {
        expect(buttonViewAllVisible.hasClass(validcollapsable.o.activeClass)).to.be.true;
      });

      it('adds aria-hidden=false on the view all button', function() {
        expect(buttonViewAllVisible.attr('aria-hidden')).to.equal('false');
      });
    });
  });

  describe('when trigger is activated on closed element', function() {
    var button, target, viewAll;

    function setTargetToHidden( hidden ) {
      if(hidden && target.hasClass(validcollapsable.o.activeClass)) {
        button.trigger('click');
      }else if( !hidden && target.hasClass(validcollapsable.o.inactiveClass) ) {
        button.trigger('click');
      }
    }

    before(function() {
      button  = $body.find('#toggleButton1');
      target  = $body.find('#toggleTarget1');
      viewAll = $body.find('#viewAll1');
    });

    it('sets aria-hidden=false on target and view all elements', function() {
      // Set initial state to hidden then trigger toggle
      setTargetToHidden(true);
      button.trigger('click');
      expect(target.attr('aria-hidden')).to.equal('false');
      expect(viewAll.attr('aria-hidden')).to.equal('false');
    });

    it('adds (active class) on target, view all and trigger elements', function() {
      setTargetToHidden(true);
      button.trigger('click');
      expect(button.hasClass(validcollapsable.o.activeClass)).to.be.true;
      expect(target.hasClass(validcollapsable.o.activeClass)).to.be.true;
      expect(viewAll.hasClass(validcollapsable.o.activeClass)).to.be.true;
    });

    it('adds keyboard(space) support to trigger elements', function(done) {
      setTargetToHidden(true);

      // Trigger keypress on spacebar
      var e = jQuery.Event('keypress');
      e.which = 32;
      e.charCode = 32;

      button.trigger(e);
      expect(target.hasClass(validcollapsable.o.inactiveClass)).to.be.false;
      expect(target.hasClass(validcollapsable.o.activeClass)).to.be.true;
      done();
    });
  });

  describe('when trigger is activated on an open element', function() {
    var button, target, visibleItems, viewAll;

    function setTargetToHidden( hidden ) {
      if( hidden && target.hasClass(validcollapsable.o.activeClass) ) {
        button.trigger('click');
      }else if( !hidden && target.hasClass(validcollapsable.o.inactiveClass) ) {
        button.trigger('click');
      }
    }

    before(function() {
      button = $body.find('#toggleButton1');
      target = $body.find('#toggleTarget1');
      viewAll = $body.find('#viewAll1');
      visibleItems = $body.find('li.is-on');
    });

    it('sets aria-hidden=true on target and view all elements', function() {
      setTargetToHidden(false);
      button.trigger('click');
      expect(target.attr('aria-hidden')).to.equal('true');
      expect(viewAll.attr('aria-hidden')).to.equal('true');
    });

    it('adds (inactive class) on target, view all and trigger elements', function() {
      setTargetToHidden(false);
      button.trigger('click');
      expect(button.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
      expect(target.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
      expect(viewAll.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
    });

    it('adds keyboard(space) support to trigger elements', function(done) {
      setTargetToHidden(false);

      // Trigger keypress on spacebar
      var e = jQuery.Event('keypress');
      e.which = 32;
      e.charCode = 32;

      button.trigger(e);
      expect(target.hasClass(validcollapsable.o.activeClass)).to.be.false;
      expect(target.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
      done();
    });

    it('adds (active class) on the first six items', function() {
        expect(visibleItems).to.have.length(6);
    });
  });

  describe('when view all is activated on an open element', function() {
    var button, target, visibleItems, viewAll;

    function setTargetToHidden( hidden ) {
      if( hidden && target.hasClass(validcollapsable.o.activeClass) ) {
        button.trigger('click');
      }else if( !hidden && target.hasClass(validcollapsable.o.inactiveClass) ) {
        button.trigger('click');
      }
    }

    before(function() {
      button = $body.find('#toggleButton1');
      target = $body.find('#toggleTarget1');
      viewAll = $body.find('#viewAll1');
    });

    it('add (active class) to all items', function() {
      setTargetToHidden(false);
      viewAll.trigger('click');
      visibleItems = $body.find('li.is-on');
      expect(visibleItems).to.have.length(8);
    });

    it('add (inactive class) to viewAll', function() {
      setTargetToHidden(false);
      viewAll.trigger('click');
      expect(viewAll.hasClass(validcollapsable.o.inactiveClass)).to.be.true;
    });
  });
});

describe('mas_collapsable#options', function() {
  'use strict';

  var collapsable,
      $body;

  before(function(done) {
    require(['collapsable'], function (Mod) {
      $('body').html(window.__html__['spec/javascripts/templates/collapsable.html']);
      $body = $('body');

      collapsable = new Mod({
        triggerEl: $('#optionsTest > li > a'),
        targetEl: 'ul',
        showOnlyFirst: true,
        accordion: true,
        closeOffFocus: true,
        parentWrapper: $body.find('#optionsTest')
      });

      done();
    }, done);

  });

  // after(function() {
  //   collapsable = false;
  // })

  describe('when the showOnlyFirst option is enabled', function() {
    it('accordion activeClass should = true', function() {
      expect(collapsable.o.showOnlyFirst).to.be.true;
    });

    it('add activeClass to the first item and inactive class to all subsequent sections', function() {
      expect(collapsable.o.showOnlyFirst).to.be.true;
      var S = collapsable.sections;
      $.each(S, function(i) {
        if(i === 0) {
          expect( S[i].hidden ).to.be.false;
        }else{
          expect( S[i].hidden ).to.be.true;
        }
      });
    });
  });

  describe('when the accordion options is enabled', function() {
    it('accordion option should = true', function() {
      expect(collapsable.o.accordion).to.be.true;
    });

    it('closes any open target elements in the collection', function() {
      var S = collapsable.sections;
      S[2].trigger.click();

      $.each(S, function(i) {
        if(i === 2) {
          expect(S[i].hidden).to.be.false;
        }else{
          expect(S[i].hidden).to.be.true;
        }
      });
    });
  });

  // Have not found a way to successfully emulate user keyboard tabbing through content
  describe('when the closeOffFocus option is enabled', function() {
    xit('closes the open element when focus leaves it', function(done) {
      var S = collapsable.sections;
      // Open list
      S[0].trigger.click();
      expect(S[0].hidden).to.be.false;

      // Focus on last element in target one
      // S[0].target.find('a:last').focus();

      // Focus on next element to trigger focusout
      // S[1].trigger.focus();
      $body.find('#forceFocus').click();

      setTimeout(function() {
        console.dir(S[0]);
        console.log(document.activeElement);
        done();
      },10);


      // check if previous element is shut
      // expect(S[0].hidden).to.be.true;
    });
  });

});
