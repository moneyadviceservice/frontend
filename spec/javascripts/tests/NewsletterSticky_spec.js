describe('NewsletterSticky', function() {

  'use strict';

  beforeEach(function(done) {
    var self = this;
    requirejs(
        ['jquery', 'NewsletterSticky', 'eventsWithPromises', 'utilities'],
        function($, NewsletterSticky, eventsWithPromises, utilities) {
          self.$html = $(window.__html__['spec/javascripts/fixtures/NewsletterSticky.html']).appendTo('body');
          self.component = self.$html.find('[data-dough-component="NewsletterSticky"]');
          self.NewsletterSticky = NewsletterSticky;
          self.eventsWithPromises = eventsWithPromises;
          self.eventsWithPromises.unsubscribeAll();

          self.obj = new self.NewsletterSticky(self.component);
          self.utilities = utilities;

          self.clock = sinon.useFakeTimers();

          done();

        }, done);
  });

  afterEach(function() {
    this.clock.restore();
    this.$html.remove();
    $(window).off('scroll');
  });

  describe('init', function() {
    it('calls the right methods when initializing', function() {
      var setListenersStub = sinon.stub(this.obj, "_setListeners"),
          handleScrollStub = sinon.stub(this.obj, "_handleScroll"),
          initialisedSuccessStub = sinon.stub(this.obj, "_initialisedSuccess");

      this.obj.init();

      expect(setListenersStub.callCount).to.be.equal(1);
      expect(handleScrollStub.callCount).to.be.equal(1);
      expect(initialisedSuccessStub.callCount).to.be.equal(1);
    });
  });

  describe('_setListeners', function() {
    beforeEach(function() {
      this.obj._setVars();
    });

    it('calls _setScrollListener', function() {
      var setScrollListenerStub = sinon.stub(this.obj, "_setScrollListener");

      this.obj._setListeners(true);

      expect(setScrollListenerStub.callCount).to.be.equal(1);
    });

    it('sets an event handle on the close button when true is passed in', function() {
      var handleCloseClickStub = sinon.stub(this.obj, "_handleCloseClick");

      this.obj._setListeners(true);

      $('.news-signup-sticky__close').trigger('click');

      expect(handleCloseClickStub.callCount).to.be.equal(1);
    });

    it('unsets an event handle on the close button when false is passed in', function() {
      var handleCloseClickStub = sinon.stub(this.obj, "_handleCloseClick");

      this.obj._setListeners(true); // on
      this.obj._setListeners(false); // and then off

      $('.news-signup-sticky__close').trigger('click');

      expect(handleCloseClickStub.callCount).to.be.equal(0);
    });
  });

  describe('_setScrollListener', function() {
    it('sets an event handle on the scroll of the window when true is passed in', function() {
      var handleScrollStub = sinon.stub(this.obj, "_handleScroll");

      this.obj._setScrollListener(true);

      $(window).trigger('scroll');

      this.clock.tick(100);

      expect(handleScrollStub.callCount).to.be.equal(1);
    });

    it('unsets an event handle on the scroll of the window when false is passed in', function() {
      var handleScrollStub = sinon.stub(this.obj, "_handleScroll");

      this.obj._setScrollListener(true);
      this.obj._setScrollListener(false);

      $(window).trigger('scroll');

      this.clock.tick(100);

      expect(handleScrollStub.callCount).to.be.equal(0);
    });
  });

  describe('_scrollDebounceMethod', function() {
    it('calls debounce when isActive is true', function() {
      var utilStub = sinon.stub(this.utilities, 'debounce');

      this.obj._scrollDebounceMethod(true);

      expect(utilStub.callCount).to.be.equal(1);
    });

    it('returns null when isActive is false', function() {
      expect(this.obj._scrollDebounceMethod(false)).to.be.falsy;
    });
  });

  describe('_handleScroll', function() {
    var hasScrolledOverPercentageStub;

    beforeEach(function() {
      hasScrolledOverPercentageStub = sinon.stub(this.obj, '_hasScrolledOverPercentage', function() {
        return true;
      });
    });

    it('calls _hasScrolledOverPercentage', function() {
      this.obj._handleScroll();

      expect(hasScrolledOverPercentageStub.callCount).to.be.equal(1);
    });

    it('adds the visible class to the module', function() {
      this.obj._handleScroll();

      expect(this.obj.$el.hasClass('news-signup-sticky--visible')).to.be.equal(true);
    });

    it('calls _setScrollListener, passing it false', function() {
      var setScrollListenerStub = sinon.stub(this.obj, '_setScrollListener');

      this.obj._handleScroll();

      expect(setScrollListenerStub.calledWith(false)).to.be.equal(true);
    });
  });

  describe('_hasScrolledOverPercentage', function() {
    it('returns true if the window has scrolled beyond the threshold', function() {
      var windowScrollTopStub = sinon.stub(this.obj, '_windowScrollTop', function() {
        return 300;
      }),
      scrollThresholdStub = sinon.stub(this.obj, '_scrollThreshold', function() {
        return 100;
      });

      expect(this.obj._hasScrolledOverPercentage()).to.be.equal(true);
    });

    it('returns false if the window has not scrolled beyond the threshold', function() {
      var windowScrollTopStub = sinon.stub(this.obj, '_windowScrollTop', function() {
        return 100;
      }),
      scrollThresholdStub = sinon.stub(this.obj, '_scrollThreshold', function() {
        return 300;
      });

      expect(this.obj._hasScrolledOverPercentage()).to.be.equal(false);
    });
  });

  describe('_windowScrollTop', function() {
    it('returns the window scrollTop', function() {
      expect(this.obj._windowScrollTop()).to.be.equal($(window).scrollTop());
    });
  });

  describe('_scrollThreshold', function() {
    it('returns the correct value', function() {
      expect(this.obj._scrollThreshold()).to.be.equal($(document).height() * 0.4);
    });
  });

  describe('_handleCloseClick', function() {
    beforeEach(function() {
      this.obj._setVars();
    });

    it('removes the visible class from the module', function() {
      this.obj._handleCloseClick($.Event("click"));
      expect(this.obj.$el.hasClass('news-signup-sticky--visible')).to.be.equal(false);
    });

    it('adds the closed class to the module', function() {
      this.obj._handleCloseClick($.Event("click"));
      expect(this.obj.closeButton.hasClass('news-signup-sticky__close--closed')).to.be.equal(true);
    });

    it('calls setListeners with false', function() {
      var setListenersStub = sinon.stub(this.obj, "_setListeners");
      this.obj._handleCloseClick($.Event("click"));
      expect(setListenersStub.calledWith(false)).to.be.equal(true);
    });
  });
});
