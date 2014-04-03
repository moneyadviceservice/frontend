

// MAS.bootstrap.I18n_locale == en || cy == file path in require config

define(
  ['jquery', 'pubsub', 'log', 'analytics', window.MAS.bootstrap.I18n_locale],
  function ($, log, analytics, text) {

    'use strict';

    var common = {};

    common.log = log;
    common.analytics = analytics;
    common.text = text;

    return common;

  }
);