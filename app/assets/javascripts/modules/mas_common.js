
// MAS.bootstrap.I18n_locale == en || cy == file path in require config
define(
  ['jquery', 'pubsub', 'log', window.MAS.bootstrap.I18nLocale],
  function ($, pubsub, log, text) {

    'use strict';

    var common = window.MAS || {},
        dataLayer = window.dataLayer || [];

    // Extend common object with globally required scripts
    common.text = text;
    $.extend(common, pubsub);
    $.extend(common, log);

    // Fire analytics events
    // TO USE: MAS.publish('analytics:trigger', {object with props})
    common.subscribe('analytics:trigger', function(e, data){
      common.log('mas_analytics.triggerAnalytics', data);
      dataLayer.push(data);
    });

    return common;
  }
);