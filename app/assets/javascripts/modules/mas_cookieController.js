define(['common'], function (MAS) {
  'use strict';

  var defaults = {
    optionalCookies: [],
    text: {}
  };

  var CookieController = function (opts) {
    this.config = $.extend({}, defaults, opts);
    this.addOptionalCookies();
    this.addText();
  };

  CookieController.prototype.addText = function() {
    var textObj = this.config.text;
    var textContent = MAS.text.cookieController.text;

    for (var content in textContent) {
      textObj[content] = textContent[content];
    }
  }

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
