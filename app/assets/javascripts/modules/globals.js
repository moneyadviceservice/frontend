define(
  ['jquery', 'module'], function ($, module) {
    'use strict';

    var globals = $.extend({}, module.config());
    return globals;
  }
);