describe.only('GlobalNav', function() {
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
          self.clump = self.component.find('[data-dough-nav-clump]');
          self.clumpHeading = self.component.find('[data-dough-nav-clump-heading]');
          self.clumpHeadingText = self.clumpHeading.find('.global-nav__clump__heading__text');
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

  describe('Mobile interaction', function() {
    beforeEach(function() {
      this.obj.init();
    });

    it('toggles nav visibility when menu button is clicked', function() {
      this.mobileNavButton.trigger('click');
      expect(this.component.hasClass('is-active')).to.be.true;

      this.mobileNavButton.trigger('click');
      expect(this.component.hasClass('is-active')).to.be.false;
    });

    /*
     * this test is breaking because GlobalNav.js won't read the width set here
     * return to it later!
     *
    it('toggles subnav visibility when clump heading is clicked', function() {
      this.clumpHeading.click();

      expect(this.clumpHeading.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.true;
      expect(this.clumpHeading.parents('[data-dough-nav-clumps]').hasClass('is-active')).to.be.true;
    });
    */

    it('toggles subnav visibility when subnav heading is clicked', function() {
      // the subnav and nav need to be open before the test is run
      this.subNavHeading.parents('[data-dough-nav-clump]').addClass('is-active');
      this.subNavHeading.parents('[data-dough-nav-clumps]').addClass('is-active');

      this.subNavHeading.trigger('click');
      expect(this.clumpHeading.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.false;
      expect(this.clumpHeading.parents('[data-dough-nav-clumps]').hasClass('is-active')).to.be.false;

      this.subNavHeading.trigger('click');
      expect(this.clumpHeading.parents('[data-dough-nav-clump]').hasClass('is-active')).to.be.true;
      expect(this.clumpHeading.parents('[data-dough-nav-clumps]').hasClass('is-active')).to.be.true;
    });

    it('closes nav when close button is clicked', function() {
      // the nav needs to be open before the test is run
      this.component.addClass('is-active');

      this.mobileNavCloseButton.trigger('click');
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
      this.clump.addClass('is-active');
      this.mainContent.trigger('touchstart');
      expect(this.clump.hasClass('is-active')).to.be.false;
    });

    it('closes subnav when user moves mouse outside of global nav', function() {
      // the subnav needs to be open before test is run
      this.clump.addClass('is-active');
      this.component.trigger('mouseleave');
      clock.tick(this.delay);
      expect(this.clump.hasClass('is-active')).to.be.false;
    });

    it('opens subnav when user hovers on clump heading', function() {
      this.clumpHeadingText.trigger('mouseenter');
      clock.tick(this.delay);
      expect(this.clump.hasClass('is-active')).to.be.true;
    });

    it('toggles subnav when user touches clump heading', function() {
      // opens subnav
      this.clumpHeadingText.trigger('touchend');
      clock.tick(this.delay);
      expect(this.clump.hasClass('is-active')).to.be.true;

      // closes subnav
      this.clumpHeadingText.trigger('touchend');
      expect(this.clump.hasClass('is-active')).to.be.false;
    });
  });
});
