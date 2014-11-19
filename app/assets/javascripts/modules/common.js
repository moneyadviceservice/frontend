// MAS.bootstrap.I18n_locale == en || cy == file path in require config
define(
  ['jquery', 'globals', 'pubsub', 'log', 'i18n'],
  function($, globals, pubsub, log, i18n) {
    'use strict';

    var MAS = $.extend({}, globals, pubsub, log);
    window.dataLayer = window.dataLayer || [];

    MAS.text = i18n;

    // Fire analytics events
    // TO USE: MAS.publish('analytics:trigger', {object with props})
    MAS.subscribe('analytics:trigger', function(e, data) {
      MAS.log('mas_analytics.triggerAnalytics', data);
      window.dataLayer.push(data);
    });

    return MAS;
  }
);
