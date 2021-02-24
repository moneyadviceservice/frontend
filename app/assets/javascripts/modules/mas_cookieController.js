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
    var analytics = {
      name : 'analytics',
      recommendedState: true,
      lawfulBasis: 'legitimate interest',
      cookies: ['_ga', '_gid', '_gat', '__utma', '__utmt', '__utmb', '__utmc', '__utmz', '__utmv'],
      label: MAS.text.cookieController.optionalCookies.analytics.label,
      description: MAS.text.cookieController.optionalCookies.analytics.description,

      onAccept: function() {
        window.dataLayer = window.dataLayer || [];

        window.dataLayer.push({
          'event': 'civicConsentResponse'
        });
      },

      onRevoke: function() {
        window.dataLayer = window.dataLayer || [];

        window.dataLayer.push({
          'event': 'civicConsentResponse'
        });
      }
    };

    this.config.optionalCookies.push(analytics);
  }

  CookieController.prototype.loadModule = function() {
    CookieControl.load(this.config);
  }

  return CookieController;
});
