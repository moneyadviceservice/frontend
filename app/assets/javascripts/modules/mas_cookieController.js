define(['common'], function (MAS) {
  'use strict';

  var defaults = {
    optionalCookies: []
  };

  var CookieController = function (opts) {
    this.config = $.extend({}, defaults, opts);
    this.addOptionalCookies();
  };

  CookieController.prototype.addOptionalCookies = function() {
    console.log('MAS: ', MAS); 

    var analytics = {
      name : 'analytics',
      recommendedState: true,
      lawfulBasis: 'legitimate interest',
      cookies: ['_ga', '_gid', '_gat', '__utma', '__utmt', '__utmb', '__utmc', '__utmz', '__utmv'],
      label: MAS.text.cookieController.optionalCookies.analytics.label,
      description: MAS.text.cookieController.optionalCookies.analytics.description,

      onAccept : function(){
        // Add Google Analytics
        (function (i,s,o,g,r,a,m) {
          i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-XXXXX-Y', 'auto');

        ga('send', 'pageview');
        // End Google Analytics
      },
      onRevoke: function(){
      // Disable Google Analytics
      window['ga-disable-UA-XXXXX-Y'] = true;
      // End Google Analytics
      }
    }; 

    this.config.optionalCookies.push(analytics);
  }

  CookieController.prototype.loadModule = function() {
    console.log('loadModule!');

    CookieControl.load(this.config);
  }

  return CookieController;
});
