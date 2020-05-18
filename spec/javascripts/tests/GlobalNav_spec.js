describe('GlobalNav', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    requirejs(
        ['jquery', 'GlobalNav', 'mediaQueries', 'utilities', 'common'],
        function($, GlobalNav, mediaQueries, utilities, common) {
          self.$html = $(window.__html__['spec/javascripts/fixtures/GlobalNav.html']).appendTo('body');
          self.component = self.$html.find('[data-dough-component="GlobalNav"]');
          self.globalNav = GlobalNav;
          self.mainContent = self.$html.find('#main');
          self.mobileNavButton = (self.$html).find('[data-dough-mobile-nav-button]');
          self.clumps = self.component.find('[data-dough-nav-clumps]');
          self.clumpHeading = self.component.find('[data-dough-nav-clump-heading]');
          self.mobileSubNav = self.component.find('[data-dough-subnav]');
          self.subNavHeading = self.component.find('[data-dough-subnav-heading]');
          self.mobileNavCloseButton = self.component.find('[data-dough-mobile-nav-close]');
          self.mobileNavOverlay = self.component.find('[data-dough-mobile-nav-overlay]');
          self.obj = new self.globalNav(self.component, self.component.data('dough-global-nav-config'));
          self.delay = 250;

          done();
        }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  describe('Initialise component', function() {
    it('calls the right methods when initialising', function() {
      var setUpMobileInteractionStub = sinon.stub(this.obj, "_setUpMobileInteraction"),
          setUpDesktopInteractionStub = sinon.stub(this.obj, "_setUpDesktopInteraction"),
          setUpMobileAnimationStub = sinon.stub(this.obj, "_setUpMobileAnimation"),
          setUpKeyboardEventsStub = sinon.stub(this.obj, "_setUpKeyboardEvents"),
          bindEventsStub = sinon.stub(this.obj, "_bindEvents");

      this.obj.init();

      expect(setUpMobileInteractionStub.callCount).to.be.equal(1);
      expect(setUpDesktopInteractionStub.callCount).to.be.equal(1);
      expect(setUpMobileAnimationStub.callCount).to.be.equal(1);
      expect(setUpKeyboardEventsStub.callCount).to.be.equal(1);
      expect(bindEventsStub.callCount).to.be.equal(1);
    });
  });

  describe('Bind Events', function() {
    beforeEach(function() {
      this.obj.init();
    });
  });

  describe('Mobile animation', function() {
    beforeEach(function() {
      this.obj.init();
    });

    it('toggles the no-transition class when viewport size changes', function() {
      // This is not functional because I have been unable to simulate the resize event - DT
    });
  });

  describe('Mobile interaction', function() {
    beforeEach(function() {
      this.obj.init();
    }); 

    it('toggles nav visibility when menu button is clicked', function() {
      this.mobileNavButton.trigger('click');
      expect(this.component.hasClass('is-active')).to.be.true;

      this.mobileNavButton.trigger('click');
      expect(this.component.hasClass('is-active')).to.be.false;

      this.mobileNavButton.trigger('click');
      expect(this.mobileSubNav.hasClass('is-hidden')).to.be.true;
      expect($('body').hasClass('no-scroll')).to.be.true;
    });

    it('When clump heading is clicked remove is-hidden class from subnav', function() {
      // This test is prevented from being initiated by mediaQueries.atSmallViewport() helper.
    }); 

    it('Applys is-hidden class to sub nav and returns to main mobile nav', function() {
      $('#clump-1').find('[data-dough-subnav-heading]').trigger('click');
      var siblingsNav = $('#clump-1').find('[data-dough-subnav]').get(0);

      expect($(siblingsNav).hasClass('is-hidden')).to.be.true;
    }); 

    it('toggles subnav visibility when clump heading is clicked', function() {
      $('#clump-1').find('[data-dough-subnav-heading]').trigger('click');

      expect($('#clump-1').hasClass('is-active')).to.be.true;
      expect(this.clumps.hasClass('is-active')).to.be.true;

      $('#clump-1').find('[data-dough-subnav-heading]').trigger('click');

      expect($('#clump-1').hasClass('is-active')).to.be.false;
      expect(this.clumps.hasClass('is-active')).to.be.false;
    });

    it('toggles subnav visibility when subnav heading is clicked', function() {
      // open the subnav and nav before the test is run
      $('#clump-1').addClass('is-active');
      this.clumps.addClass('is-active');

      $('#clump-1').find('[data-dough-subnav-heading]').trigger('click');
      expect($('#clump-1').hasClass('is-active')).to.be.false;
      expect(this.clumps.hasClass('is-active')).to.be.false;

      $('#clump-1').find('[data-dough-subnav-heading]').trigger('click');
      expect($('#clump-1').hasClass('is-active')).to.be.true;
      expect(this.clumps.hasClass('is-active')).to.be.true;
    });

    it('closes nav when close button is clicked', function() {
      // open the nav before the test is run
      this.component.addClass('is-active');

      $('#clump-1').find('[data-dough-mobile-nav-close]').trigger('click');
      expect(this.component.hasClass('is-active')).to.be.false;
    });

    it('closes nav when overlay is clicked', function() {
      // the nav needs to be open before the test is run
      this.component.addClass('is-active');

      this.mobileNavOverlay.trigger('click');
      expect(this.component.hasClass('is-active')).to.be.false;
    });
  });

  describe('Desktop interaction', function() {
    var clock;

    beforeEach(function() {
      clock = sinon.useFakeTimers();
      this.obj.init();
    });

    afterEach(function() {
      clock.restore();
    });

    it('closes subnav on a touch event outside of global nav', function() {
      // the subnav needs to be open before test is run
      $('#clump-1').addClass('is-active');
      this.mainContent.trigger('touchstart');
      expect($('#clump-1').hasClass('is-active')).to.be.false;
    });

    it('closes subnav when user moves mouse outside of global nav', function() {
      // the subnav needs to be open before test is run
      $('#clump-1').addClass('is-active');
      this.component.trigger('mouseleave');
      clock.tick(this.delay);
      expect($('#clump-1').hasClass('is-active')).to.be.false;
    });

    it('opens subnav when user hovers on clump heading', function() {
      $('#clump-1').find('.global-nav__clump__heading__text').trigger('mouseenter');
      clock.tick(this.delay);
      expect($('#clump-1').hasClass('is-active')).to.be.true;
    });

    it('toggles subnav when user touches clump heading', function() {
      // opens subnav
      $('#clump-1').find('.global-nav__clump__heading__text').trigger('touchend');
      clock.tick(this.delay);
      expect($('#clump-1').hasClass('is-active')).to.be.true;

      // closes subnav
      $('#clump-1').find('.global-nav__clump__heading__text').trigger('touchend');
      expect($('#clump-1').hasClass('is-active')).to.be.false;
    });
  });

  describe('Keyboard Events', function() {
    var triggerKeyUp = function(element, keyCode) {
      var e = $.Event('keyup');
      e.which = keyCode;
      element.trigger(e);
    };

    beforeEach(function() {
      this.obj.init();
    });

    it('when at top level the enter key opens dropdown and moves focus into this', function() {
      var index = $('#clump-1').find('[data-dough-nav-clump-heading]');

      triggerKeyUp(index, 13);

      expect(index.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.true;
      expect(index.attr('aria-expanded')).to.eq('true');
      expect($(index).siblings('[data-dough-subnav]').find('[data-dough-subcategories]').find('a').get(0) === document.activeElement).to.be.true;
    });

    it('when at top level the spacebar key opens dropdown', function() {
      var index = $('#clump-1').find('[data-dough-nav-clump-heading]');

      triggerKeyUp(index, 32);

      expect(index.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.true;
      expect(index.attr('aria-expanded')).to.eq('true');
    });

    it('when at top level the left arrow key moves focus to the previous element or wraps if on the first element', function() {
      var index = $('#clump-2').find('[data-dough-nav-clump-heading]');

      triggerKeyUp(index, 37);

      expect($('#clump-1').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;
    });

    it('when at top level the right arrow key moves focus to the next element or wraps if on the last element', function() {
      var index = $('#clump-1').find('[data-dough-nav-clump-heading]');

      triggerKeyUp(index, 39);

      expect($('#clump-2').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;
    });

    it('when at top level the down arrow key opens the dropdown', function() {
      var index = $('#clump-1').find('[data-dough-nav-clump-heading]');

      triggerKeyUp(index, 40);

      expect(index.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.true;
    });

    it('when at secondary level the escape key closes dropdown and moves focus back to top level', function() {
      var index = $('#clump-1').find('[data-dough-subcategories]');

      triggerKeyUp(index, 27);

      expect(index.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.false;
      expect($('#clump-1').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;
    });

    it('when at secondary level the up arrow key moves focus to previous element or wraps to the last element if on the first', function() {
      var links = $('#clump-1').find('[data-dough-subcategories]').find('a');

      triggerKeyUp(links.last(), 38);

      expect(links.get(0) === document.activeElement).to.be.true;

      triggerKeyUp(links.first(), 38);

      expect(links.get(1) === document.activeElement).to.be.true;
    });

    it('when at secondary level the down arrow key moves focus to the next element or wraps to the first element if on the last', function() {
      var links = $('#clump-1').find('[data-dough-subcategories]').find('a');

      triggerKeyUp(links.first(), 40);

      expect(links.get(1) === document.activeElement).to.be.true;

      triggerKeyUp(links.last(), 40);

      expect(links.get(0) === document.activeElement).to.be.true;
    });

    it('when at secondary level the left arrow key closes the dropdown and moves focus to the previous top level element or the last element if already on the first', function() {
      var links;

      // open dropdown before running test
      $('#clump-2').addClass('is-active');

      links = $('#clump-2').find('[data-dough-subcategories]').find('a');

      triggerKeyUp(links.last(), 37);

      expect($('#clump-2').hasClass('is-active')).to.be.false;
      expect($('#clump-1').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;

      // open dropdown before running test
      $('#clump-1').addClass('is-active');

      links = $('#clump-1').find('[data-dough-subcategories]').find('a');

      triggerKeyUp(links.last(), 37);

      expect($('#clump-1').hasClass('is-active')).to.be.false;
      expect($('#clump-2').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;
    });

    it('when at secondary level the right arrow key closes the dropdown and moves focus to the next top level element or the first element if already on the last', function() {
      var links;

      // open dropdown before running test
      $('#clump-1').addClass('is-active');

      links = $('#clump-1').find('[data-dough-subcategories]').find('a');

      triggerKeyUp(links.last(), 39);

      expect($('#clump-1').hasClass('is-active')).to.be.false;
      expect($('#clump-2').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;

      // open dropdown before running test
      $('#clump-2').addClass('is-active');

      links = $('#clump-2').find('[data-dough-subcategories]').find('a');

      triggerKeyUp(links.last(), 39);

      expect($('#clump-2').hasClass('is-active')).to.be.false;
      expect($('#clump-1').find('[data-dough-nav-clump-heading]').get(0) === document.activeElement).to.be.true;
    });
  });
});
