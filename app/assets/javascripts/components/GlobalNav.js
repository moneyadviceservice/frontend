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
    this.$mobileNavClose = this.$el.find('[data-dough-mobile-nav-close]');
    this.$mobileNavOverlay = $(document).find('[data-dough-mobile-nav-overlay]');
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
    this._setUpKeyboardEvents();

    $(window).on('resize', utilities.debounce($.proxy(this._setUpMobileAnimation, this), 100));

    return this;
  };

  /**
   * Set up keyboard events
   * Adds enhanced keyboard interation to nav
   */
  GlobalNav.prototype._setUpKeyboardEvents = function() {
    var self = this;

    this.$globalNav.keydown(function(e) {
      if (e.which === 32 || e.which === 40) {
        e.preventDefault();
      }
    });

    this.$globalNav.keyup(function(e) {
      var level;

      if ($(e.target).parents('[data-dough-subnav]').length > 0) {
        level = 'subnav';
      } else {
        level = 'top';
      }

      switch (e.which) {
        // tab
        case 9:
          if (level === 'top') {
            self._closeBlurredClumps(e.target);
          }
          break;
        // enter
        case 13:
          if (level === 'top') {
            e.preventDefault();
            self._openDesktopSubNav(e.target, false);
            self._moveFocusToSubNav(e.target);
          }
          break;
        // escape
        case 27:
          if (level === 'subnav') {
            self._closeDesktopSubNav($(e.target).parents('[data-dough-subnav]'), false);
            self._moveTopLevelFocus(e.target);
          }
          break;
        // spacebar
        case 32:
          e.preventDefault();

          if (level === 'top') {
            self._openDesktopSubNav(e.target, false);
          }
          break;
        // left arrow
        case 37:
          self._moveTopLevelFocus(e.target, 'left');

          if (level === 'subnav') {
            self._closeDesktopSubNav($(e.target).parents('[data-dough-subnav]'), false);
          }
          break;
        // up arrow
        case 38:
          if (level === 'subnav') {
            self._moveSubNavFocus(e.target, 'up');
          }
          break;
        // right arrow
        case 39:
          self._moveTopLevelFocus(e.target, 'right');

          if (level === 'subnav') {
            self._closeDesktopSubNav($(e.target).parents('[data-dough-subnav]'), false);
          }
          break;
        // down arrow
        case 40:
          if (level === 'top') {
            if ($(e.target).parents('[data-dough-nav-clump]').hasClass('is-active')) {
              self._moveFocusToSubNav(e.target);
            } else {
              self._openDesktopSubNav(e.target, false);
            }
          } else {
            self._moveSubNavFocus(e.target, 'down');
          }
          break;
      }
    });
  };

  /**
  * Moves focus to first link of subnav
  */
  GlobalNav.prototype._moveFocusToSubNav = function(el) {
    var firstLink = $(el).siblings('[data-dough-subnav]').find('[data-dough-subcategories]').find('a')[0];

    $(firstLink).focus();
  };

  /**
  * Moves focus of subnav up or down
  */
  GlobalNav.prototype._moveSubNavFocus = function(el, dir) {
    var subCatArray = $(el).parents('[data-dough-subcategories]').find('a');
    var index = $(subCatArray).index(el);

    if (dir === 'up') {
      if (index > 0) {
        subCatArray[index - 1].focus();
      } else {
        subCatArray[subCatArray.length - 1].focus();
      }
    } else {
      if (index < subCatArray.length - 1) {
        subCatArray[index + 1].focus();
      } else {
        subCatArray[0].focus();
      }
    }
  };

  /**
  * Moves focus of top level nav to left or right
  */
  GlobalNav.prototype._moveTopLevelFocus = function(el, dir) {
    var thisClump = $(el).parents('[data-dough-nav-clump]');
    var clumps = $(thisClump).siblings('[data-dough-nav-clump]');
    var firstClump = $(clumps).first();
    var lastClump = $(clumps).last();

    if (dir === 'left') {
      if ($(thisClump).prev('[data-dough-nav-clump]').length > 0) {
        $(thisClump).blur()
          .prev().children('[data-dough-nav-clump-heading]').focus();
      } else {
        $(lastClump).children('[data-dough-nav-clump-heading]').focus();
      }
    } else if (dir === 'right') {
      if ($(thisClump).next('[data-dough-nav-clump]').length > 0) {
        $(thisClump).blur()
          .next().children('[data-dough-nav-clump-heading]').focus();
      } else {
        $(firstClump).children('[data-dough-nav-clump-heading]').focus();
      }
    } else {
      $(thisClump).children('[data-dough-nav-clump-heading]').focus();
    }
  };

  /**
  * Closes all subnavs when top level focus shifts
  */
  GlobalNav.prototype._closeBlurredClumps = function(el) {
    this.$globalNavClump.not($(el).parents('[data-dough-nav-clump]')).removeClass('is-active');
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

    this.$mobileNavClose.click(function(){
      self._closeMobileNav();
    });

    this.$mobileNavOverlay.click(function(){
      self._closeMobileNav();
    });
  };

  /**
  * Set up events for desktop nav
  */
  GlobalNav.prototype._setUpDesktopInteraction = function() {
    var self = this;

    this.$globalNavClumpHeading
      .mouseenter(function() {
        self._openDesktopSubNav(this, true);
      })
      .mouseleave(function() {
        self._closeDesktopSubNav(this, true);
      });

    $('.global-subnav')
      .mouseenter(function() {
        self._openDesktopSubNav(this, true);
      })
      .mouseleave(function() {
        self._closeDesktopSubNav(this, true);
      });
  };

  GlobalNav.prototype._toggleMobileNav = function() {
    this.$globalNav.toggleClass('is-active');
    this.$mobileNavOverlay.toggleClass('is-active');

    if (this.$globalNavClumps.hasClass('is-active')) {
      this.$globalNavClumps.removeClass('is-active');
    }
  };

  GlobalNav.prototype._closeMobileNav = function() {
    this.$globalNav.removeClass('is-active');
    this.$mobileNavOverlay.removeClass('is-active');
    this.$globalNavClumps.removeClass('is-active');
    this.$globalNavClump.removeClass('is-active');
  };

  GlobalNav.prototype._toggleMobileSubNav = function(index) {
    $(index)
      .parents('[data-dough-nav-clump]').toggleClass('is-active')
      .parents('[data-dough-nav-clumps]').toggleClass('is-active');
  };

  GlobalNav.prototype._openDesktopSubNav = function(index, delay) {
    var timeoutDelay;

    if (delay) {
      timeoutDelay = this.delay;
    } else {
      timeoutDelay = 0;
    }


    if (!this.$globalNav.hasClass('is-active')) {
      var self = this;

      window.clearTimeout(this.timeout);

      this.timeout = window.setTimeout(function() {
        self.$globalSubNav.removeClass('is-active');
        self.$globalNavClump.removeClass('is-active');

        $(index)
          .attr('aria-expanded', 'true')
          .parent('[data-dough-nav-clump]').addClass('is-active')
          .siblings('[data-dough-subnav]').addClass('is-active');
      }, timeoutDelay);
    }
  };

  GlobalNav.prototype._closeDesktopSubNav = function(index, delay) {
    var timeoutDelay;

    if (delay) {
      timeoutDelay = this.delay;
    } else {
      timeoutDelay = 0;
    }


    if (!this.$globalNav.hasClass('is-active')) {
      window.clearTimeout(this.timeout);

      this.timeout = window.setTimeout(function() {
        $(index)
          .removeClass('is-active')
          .siblings('[data-dough-nav-clump-heading]').attr('aria-expanded', 'false')
            .parent('[data-dough-nav-clump]').removeClass('is-active');
      }, timeoutDelay);
    }
  };

  return GlobalNav;
});
