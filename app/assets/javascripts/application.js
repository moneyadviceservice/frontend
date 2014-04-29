//= require require_config

if (MAS.fonts.loadWithJS && MAS.fonts.url && !MAS.fonts.localstorage) {
  require(['jquery', 'common'], function ($, MAS) {
    'use strict';

    MAS.log('FONTS: load via ajax');
    $.ajax({
      url: MAS.fonts.url,
      success: function (res) {
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

require(['jquery', 'collapsable'], function ($, Collapsable) {
  'use strict';

  // Primary Nav
  new Collapsable({
    name: 'primaryNav',
    closeOffFocus: true,
    accordion: true,
    triggerEl: '#primary-nav > li > a',
    targetEl: '.primary-nav__dropdown',
    parentWrapper: '#primary-nav'
  });

  // Mobile Nav
  new Collapsable({
    name: 'mobileNav',
    closeOffFocus: false,
    accordion: true,
    triggerEl: '.mobile-nav a',
    targetType: 'href',
    parentWrapper: '#primary-nav'
  });

  // Article Collapsables
  new Collapsable({
    name: 'articleCollapsables',
    showOnlyFirst: true,
    showIcon: true,
    useButton: true
  });
});

require(['jquery', 'ujs'], function ($) {
  'use strict';

  $(document).ready(function(){
    // Cookie message
    $('.js-cookie-message').bind('ajax:success', function () {
      $('.cookie-message').hide();
      $('.footer-site-links__cookie-link').removeClass('is-on');
    });

    // Responsive Opt Out
    $('.js-close-opt-out').bind('ajax:success', function () {
      $('.opt-out').addClass('is-hidden');
    });
  });
});

if(window.enableScrollTracking){
  require(['jquery', 'scrollTracking'], function ($, scrollTracking) {
    'use strict';
    
    // Analytics scroll tracking on editorial pages
    scrollTracking({
      el: '.editorial',
      triggerPoints: [0.25, 0.5, 0.75, 1]
    });
  });
}
