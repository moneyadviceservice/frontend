//= require require_config

require(['common', 'jquery'], function(MAS, $) {
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
        targetEl: '.category-detail__list-container',
        targetItems: '.category-detail__list-item',
        viewAllButton: '.js-category-detail__view-all',
        numberItemsToDisplay: 6
      });


      if($(this).width() <= 720){
        new Collapsable({
          name: 'contactCollapsables',
          showIcon: true,
          useButton: true,
          triggerEl: '.contact-detail__heading',
          targetEl: '.contact-detail__content'
        });
      }

    });
  });

  require(['jquery', 'ujs'], function($) {

    $(document).ready(function() {
      // Cookie message
      $('.js-cookie-message').bind('ajax:success', function() {
        $('.cookie-message').hide();
        $('.footer-site-links__cookie-link').removeClass('is-on');
      });
    });
  });

  require(['googleComplete'], function(googleComplete) {
    $(document).ready(function() {
      new googleComplete({input: $('#search'), form: $('form.search')});
      $('[data-dough-component="ClearInput"]').find('.tt-hint').removeAttr('data-dough-clear-input');
    });
  });

  // Kick off component loader
  var engines = [];
  $('[data-engine]').each(function() {
    engines.push($(this).attr('data-engine') + 'Config');
  });

  require(engines, function() {
    require(['componentLoader', 'eventsWithPromises'], function(componentLoader, eventsWithPromises) {
      componentLoader.init($('body'));
      eventsWithPromises.subscribe('component:contentChange', function(data) {
        componentLoader.init(data.$container);
      });
    });
  });
});
