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
    this.mobileAnimationDuration = this.$globalNav.css('transition-duration');
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

    $(window).on('resize', utilities.debounce($.proxy(this._resize, this), 100));

    return this;
  };

  // Ensure mobile nav not activated on resize
  GlobalNav.prototype._resize = function() {
    this._setUpMobileAnimation();
  }

  GlobalNav.prototype._setUpMobileAnimation = function() {
    if (mediaQueries.atSmallViewport()) {
      this.$globalNav.css('transition-duration', this.mobileAnimationDuration);
    } else {
      this.$globalNav.css('transition-duration', '0s');
    }
  }

  /**
  * Set up events for mobile nav
  */
  GlobalNav.prototype._setUpMobileInteraction = function() {
    var self = this;

    this.$mobileNavButton.click(function() {
      if (self.$globalNav.hasClass('is-active')) {
        self._closeMobileNav();
      } else {
        self._openMobileNav();
      }
    });

    this.$globalNavClumpHeading.click(function() {
      self._openMobileSubNav(this);
    });

    this.$globalSubNavHeading.click(function() {
      self._closeMobileSubNav(this);
    })
  }

  /**
  * Set up events for desktop nav
  */
  GlobalNav.prototype._setUpDesktopInteraction = function() {
    var self = this;

    // heading behaviour
    this.$globalNavClumpHeading.not('.global-nav__clump__blog-link')
      .mouseenter(function() {
        self._openDesktopSubNav(this);
      })
      .mouseleave(function() {
        self._closeDesktopSubNav(this);
      });

    // subnav behaviour
    $('.global-subnav')
      .mouseenter(function() {
        self._openDesktopSubNav(this);
      })
      .mouseleave(function() {
        self._closeDesktopSubNav(this);
      });
  }

  GlobalNav.prototype._openMobileNav = function() {
    this.$globalNav.addClass('is-active');
  }

  GlobalNav.prototype._closeMobileNav = function() {
    this.$globalNav.removeClass('is-active');

    if (this.$globalNavClumps.hasClass('is-active')) {
      this.$globalNavClumps.removeClass('is-active');
    }
  }

  GlobalNav.prototype._openMobileSubNav = function(index) {
    // clear active clumps
    this.$globalNavClump.removeClass('is-active');
    this.$globalNavClumps.removeClass('is-active');

    $(index)
      .parents('[data-dough-nav-clump]').addClass('is-active')
      .parents('[data-dough-nav-clumps]').addClass('is-active');
  }

  GlobalNav.prototype._closeMobileSubNav = function(index) {
    $(index)
      .parents('[data-dough-nav-clump]').removeClass('is-active')
      .parents('[data-dough-nav-clumps]').removeClass('is-active');
  }

  GlobalNav.prototype._openDesktopSubNav = function(index) {
    var self = this;

    window.clearTimeout(this.timeout);

    this.timeout = window.setTimeout(function() {
      // clear active clumps
      self.$globalSubNav.removeClass('is-active');
      self.$globalNavClump.removeClass('is-active');

      $(index)
        // show current heading
        .parent('[data-dough-nav-clump]').addClass('is-active')
        // show current subnav
        .siblings('[data-dough-subnav]').addClass('is-active');
    }, this.delay);
  }

  GlobalNav.prototype._closeDesktopSubNav = function(index) {
    window.clearTimeout(this.timeout);

    this.timeout = window.setTimeout(function() {
      $(index)
        // hide current subnav
        .removeClass('is-active')
        // hide current heading
        .siblings('[data-dough-nav-clump-heading]').parent('[data-dough-nav-clump]').removeClass('is-active');
    }, this.delay);
  }

  return GlobalNav;
});
