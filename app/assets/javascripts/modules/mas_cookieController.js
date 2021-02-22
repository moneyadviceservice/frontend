define(function () {
  "use strict";

  var defaults = {};

  var CookieController = function (opts) {
    this.config = $.extend({}, defaults, opts);

    console.log('this: ', this);
  };

  return CookieController;
});
