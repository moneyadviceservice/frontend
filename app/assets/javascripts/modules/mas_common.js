

// MAS.bootstrap.I18n_locale == en || cy == file path in require config

define(
  ['jquery', 'pubsub', 'log', 'analytics', window.MAS.bootstrap.I18n_locale],
  function ($, pubsub, log, analytics, text) {

    'use strict';

    var common = window.MAS || {};
    common.text = text;
    common.analytics = analytics;
    $.extend(common, pubsub);
    $.extend(common, log);
    return common;
  }
);