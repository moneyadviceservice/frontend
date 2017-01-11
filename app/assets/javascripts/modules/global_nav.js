define(['jquery'], function($) {
  'use strict';

  var GlobalNav = function() {
    this._setUpMobileInteraction();
    this._setUpDesktopInteraction();
  }

  GlobalNav.prototype._setUpMobileInteraction = function() {
    $('.mobile-nav__link--menu').click(function() {
      if ($('.global-nav').hasClass('is-active')) {
        $('.global-nav').removeClass('is-active');
      } else {
        $('.global-nav').addClass('is-active');
      }
    });

    $('.global-nav__clump__heading').click(function() {
      // Fixes an issue with Keyboard navigation on Desktop,
      // if you open a Clump then other Clumps need to be closed
      if (window.innerWidth > 719) {
        $('.global-nav__clump').removeClass('is-active');
        $('.global-nav__clumps').removeClass('is-active');
      }
      // End Temporary fix

      $(this)
        .parents('.global-nav__clump').addClass('is-active')
        .parents('.global-nav__clumps').addClass('is-active');
    });

    $('.global-subnav__heading').click(function() {
      $(this)
        .parents('.global-nav__clump').removeClass('is-active')
        .parents('.global-nav__clumps').removeClass('is-active');
    })
  }

  GlobalNav.prototype._setUpDesktopInteraction = function() {
    var delay = 250; // ms
    var timeout;

    // heading behaviour
    $('.global-nav__clump__heading').not('.global-nav__clump__blog-link')
      .mouseenter(function() {
        var self = this;

        window.clearTimeout(timeout);

        timeout = window.setTimeout(function() {
          // clear active clumps
          $('.global-subnav').removeClass('is-active');
          $('.global-nav__clump').removeClass('is-active');

          $(self)
            // show current heading
            .parent('.global-nav__clump').addClass('is-active')
            // show current subnav
            .siblings('.global-subnav').addClass('is-active');
        }, delay);
      })
      .mouseleave(function() {
        var self = this;

        window.clearTimeout(timeout);

        timeout = window.setTimeout(function() {
          // clear current subnav
          $(self).siblings('.global-subnav').removeClass('is-active');
        }, delay);
      });

    // subnav behaviour
    $('.global-subnav')
      .mouseenter(function() {
        var self = this;

        window.clearTimeout(timeout);

        // clear active clumps
        $('.global-nav__clump').removeClass('is-active');

        // show current heading
        $(self).siblings('.global-nav__clump__heading').parent('.global-nav__clump').addClass('is-active');

        timeout = window.setTimeout(function() {
          // show current clump
          $(self).addClass('is-active')
        }, delay);
      })
      .mouseleave(function() {
        var self = this;

        window.clearTimeout(timeout);

        timeout = window.setTimeout(function() {
          $(self)
            // hide current subnav
            .removeClass('is-active')
            // hide current heading
            .siblings('.global-nav__clump__heading').parent('.global-nav__clump').removeClass('is-active');
        }, delay);
      });
  }

  return GlobalNav;
});
