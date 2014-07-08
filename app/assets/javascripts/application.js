//= require require_config

require(['common'], function(MAS) {
  'use strict';

  if (MAS.fonts.loadWithJS && MAS.fonts.url && !MAS.fonts.localstorage) {
    require(['jquery', 'common'], function($, MAS) {

      MAS.log('FONTS: load via ajax');
      $.ajax({
        url: MAS.fonts.url,
        success: function(res) {
          MAS.log('FONTS: ajax load success > stylesheet appended to page > load class added');
          $('html').addClass(MAS.fonts.loadClass);
          $('head').append('<style>' + res + '</style>');
          if (MAS.supports.localstorage) {
            MAS.log('FONTS: localstorage supported, fonts saved');
            localStorage.setItem(MAS.fonts.cacheName, res);
          }
        },
        dataType: 'text'
      });
    });
  }

  if (window.enableScrollTracking) {
    require(['jquery', 'scrollTracking'], function($, scrollTracking) {
      // Analytics scroll tracking on editorial pages
      scrollTracking({
        el: '.editorial',
        triggerPoints: [0.25, 0.5, 0.75, 1]
      });
    });
  }

  require(['jquery', 'collapsable'], function($, Collapsable) {
    $(document).ready(function() {

      $('#primary-nav')
        .clone()
        .attr('id', 'js-primary-nav')
        .insertAfter('.mobile-nav')
        .wrap('<div class="l-menu-nav"></div>');

      $('.mobile-nav__link--menu').attr('href', '#js-primary-nav');

      // Mobile Nav
      new Collapsable({
        name: 'mobileNav',
        closeOffFocus: false,
        accordion: true,
        triggerEl: '.mobile-nav a',
        targetType: 'href',
        parentWrapper: '#js-primary-nav'
      });

      // Article Collapsables
      new Collapsable({
        name: 'articleCollapsables',
        showOnlyFirst: true,
        showIcon: true,
        useButton: true
      });

      // Category Collapsables
      new Collapsable({
        name: 'categoryCollapsables',
        showIcon: true,
        useButton: true,
        triggerEl: '.category-detail__heading',
        targetEl: '.category-detail__list-container'
      });
    });
  });

  require(['jquery', 'ujs'], function($) {

    $(document).ready(function() {
      // Cookie message
      $('.js-cookie-message').bind('ajax:success', function() {
        $('.cookie-message').hide();
        $('.footer-site-links__cookie-link').removeClass('is-on');
      });

      // Responsive Opt Out
      $('.js-close-opt-out').bind('ajax:success', function() {
        $('.opt-out').addClass('is-hidden');
      });
    });
  });

});
