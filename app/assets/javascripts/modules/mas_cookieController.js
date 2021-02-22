define(function () {
  "use strict";

  var defaults = {
  };

  var CookieController = function (opts) {
    this.o = $.extend({}, defaults, opts);

    console.log(this); 
  };

  return CookieController;
});
