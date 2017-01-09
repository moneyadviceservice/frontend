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
    var delay = 1000; // 250; // ms
    var timeout_in, timeout_out;

    // heading behaviour
    $('.global-nav__clump__heading').not('.global-nav__clump__blog-link')
      .mouseenter(function() {
        var self = this;

        window.clearTimeout(timeout_out);

        timeout_in = window.setTimeout(function() {
          // clear active subnavs
          $('.global-subnav').removeClass('is-active');

          $(self)
            // .parent('.global-nav__clump').addClass('is-active')
            // show current subnav
            .siblings('.global-subnav').addClass('is-active');
        }, delay);
      })
      .mouseleave(function() {
        var self = this;

        window.clearTimeout(timeout_in);

        timeout_out = window.setTimeout(function() {
          $(self)
            .parent('.global-nav__clump').removeClass('is-active');
        }, delay);
      });

    /* subnav behaviour
    $('.global-subnav')
      .mouseenter(function() {
        $(this)
          .addClass('is-active')
          .siblings('.global-nav__clump__heading').parent('.global-nav__clump').addClass('is-active');
      })
      .mouseleave(function() {
        $(this)
          .removeClass('is-active')
          .siblings('.global-nav__clump__heading').parent('.global-nav__clump').removeClass('is-active');
      });
    */
  }

  return GlobalNav;
});
