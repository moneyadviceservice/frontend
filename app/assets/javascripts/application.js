//= require require_config

if(MAS.fonts.loadWithJS && MAS.fonts.url && !MAS.fonts.localstorage) {
  require(['common'], function (MAS) {
    'use strict';

    MAS.log('FONTS: load via ajax');
    $.ajax({
      url: MAS.fonts.url,
      success: function(res){
        MAS.log('FONTS: ajax load success > stylesheet appended to page > load class added');
        $('html').addClass(MAS.fonts.loadClass);
        $('head').append('<style>' + res + '</style>');
        if(MAS.supports.localstorage){
          MAS.log('FONTS: localstorage supported, fonts saved');
          localStorage.setItem(MAS.fonts.cacheName, res);
        }
      },
      dataType: 'text'
    });
  });
}

require(
  ['jquery', 'scrollTracking', 'collapsable', 'ujs'], function ($, scrollTracking, Collapsable) {
  'use strict';

  $(document).ready(function(){
    // Analytics scroll tracking on editorial pages
    scrollTracking({
      el: '.editorial',
      triggerPoints: [0.25, 0.5, 0.75, 1]
    });

    // Primary Nav
    new Collapsable({
      name: 'primaryNav',
      closeOffFocus:true,
      accordion:true,
      triggerEl: '#primary-nav > li > a',
      targetEl: '.primary-nav__dropdown',
      parentWrapper: '#primary-nav'
    });

    // Mobile Nav
    new Collapsable({
      name: 'mobileNav',
      closeOffFocus:false,
      accordion:true,
      triggerEl: '.mobile-nav a',
      targetType: 'href',
      parentWrapper: '#primary-nav'
    });

    // Article Collapsables
    new Collapsable({
      name: 'articleCollapsables',
      showOnlyFirst:true,
      showIcon: true,
      useButton: true
    });

    // DEMO >> Subscribe to collapsable event
    // MAS.subscribe('collapsable', function(event,o){
    //   console.info(o);
    // });

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
