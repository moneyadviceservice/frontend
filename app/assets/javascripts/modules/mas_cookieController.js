define(['common'], function (MAS) {
  'use strict';

  var defaults = {
    theme: 'light', 
    optionalCookies: [],
    text: {}, 
    branding: {}
  };

  var CookieController = function (opts) {
    this.config = $.extend({}, defaults, opts);
    this.textStrings = MAS.text.cookieController; 
    this.addOptionalCookies();
    this.addText();
    this.addBranding(); 
  };

  CookieController.prototype.addBranding = function() {
    var brandingObj = this.config.branding;
    var brandingContent = this.textStrings.branding;

    for (var content in brandingContent) {
      brandingObj[content] = brandingContent[content];
    }
  }

  CookieController.prototype.addText = function() {
    var textObj = this.config.text;
    var textContent = this.textStrings.text;

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
      label: this.textStrings.optionalCookies.analytics.label,
      description: this.textStrings.optionalCookies.analytics.description,

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
