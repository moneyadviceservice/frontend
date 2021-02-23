define(function () {
  "use strict";

  var defaults = {};

  var CookieController = function (opts) {
    this.config = $.extend({}, defaults, opts);
  };

  CookieController.prototype.loadModule = function() {
    console.log('loadModule!');

    CookieControl.load(this.config);
  }

  return CookieController;
});
