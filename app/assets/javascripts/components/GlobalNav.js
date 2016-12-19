define(['jquery', 'DoughBaseComponent', 'mediaQueries', 'utilities'], function($, DoughBaseComponent, mediaQueries, utilities) {
  'use strict';

  var GlobalNav;

  GlobalNav = function($el, config) {
    GlobalNav.baseConstructor.call(this, $el, config);

    this.$globalNav = this.$el;
    this.$mobileNavButton = $(document).find('[data-dough-mobile-nav-button]');
    this.$globalNavClumps = this.$el.find('[data-dough-nav-clumps]');
    this.$globalNavClump = this.$el.find('[data-dough-nav-clump]');
    this.$globalNavClumpHeading = this.$el.find('[data-dough-nav-clump-heading]');
    this.$globalSubNavHeading = this.$el.find('[data-dough-subnav-heading]');
    this.$globalSubNav = this.$el.find('[data-dough-subnav]');
    this.delay = 250; // ms
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(GlobalNav);
  GlobalNav.componentName = 'GlobalNav';

  /**
  * Initialize the component
  */
  GlobalNav.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setUpMobileInteraction();
    this._setUpDesktopInteraction();
    this._setUpMobileAnimation();

    $(window).on('resize', utilities.debounce($.proxy(this._setUpMobileAnimation, this), 100));

    return this;
  };

  /**
  * Ensure mobile nav not activated on resize or page load
  */
  GlobalNav.prototype._setUpMobileAnimation = function() {
    if (mediaQueries.atSmallViewport()) {
      this.$globalNav.removeClass('no-transition');
    } else {
      this.$globalNav.addClass('no-transition');
    }
  };

  /**
  * Set up events for mobile nav
  */
  GlobalNav.prototype._setUpMobileInteraction = function() {
    var self = this;

    this.$mobileNavButton.click(function() {
      self._toggleMobileNav();
    });

    this.$globalNavClumpHeading.click(function() {
      self._toggleMobileSubNav(this);
    });

    this.$globalSubNavHeading.click(function() {
      self._toggleMobileSubNav(this);
    });
  };

  /**
  * Set up events for desktop nav
  */
  GlobalNav.prototype._setUpDesktopInteraction = function() {
    var self = this;

    this.$globalNavClumpHeading
      .mouseenter(function() {
        self._openDesktopSubNav(this);
      })
      .mouseleave(function() {
        self._closeDesktopSubNav(this);
      });

    $('.global-subnav')
      .mouseenter(function() {
        self._openDesktopSubNav(this);
      })
      .mouseleave(function() {
        self._closeDesktopSubNav(this);
      });
  };

  GlobalNav.prototype._toggleMobileNav = function() {
    this.$globalNav.toggleClass('is-active');

    if (this.$globalNavClumps.hasClass('is-active')) {
      this.$globalNavClumps.removeClass('is-active');
    }
  };

  GlobalNav.prototype._toggleMobileSubNav = function(index) {
    $(index)
      .parents('[data-dough-nav-clump]').toggleClass('is-active')
      .parents('[data-dough-nav-clumps]').toggleClass('is-active');
  };

  GlobalNav.prototype._openDesktopSubNav = function(index) {
    if (!this.$globalNav.hasClass('is-active')) {
      var self = this;

      window.clearTimeout(this.timeout);

      this.timeout = window.setTimeout(function() {
        self.$globalSubNav.removeClass('is-active');
        self.$globalNavClump.removeClass('is-active');

        $(index)
          .parent('[data-dough-nav-clump]').addClass('is-active')
          .siblings('[data-dough-subnav]').addClass('is-active');
      }, this.delay);
    }
  }

  GlobalNav.prototype._closeDesktopSubNav = function(index) {
    if (!this.$globalNav.hasClass('is-active')) {
      window.clearTimeout(this.timeout);

      this.timeout = window.setTimeout(function() {
        $(index)
          .removeClass('is-active')
          .siblings('[data-dough-nav-clump-heading]').parent('[data-dough-nav-clump]').removeClass('is-active');
      }, this.delay);
    }
  }

  return GlobalNav;
});
