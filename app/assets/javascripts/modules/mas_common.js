
// MAS.bootstrap.I18n_locale == en || cy == file path in require config
define(
  ['jquery', 'pubsub', 'log', window.MAS.bootstrap.I18nLocale],
  function ($, pubsub, log, text) {

    'use strict';

    var MAS = window.MAS || {},
        dataLayer = window.dataLayer || [];

    // Extend common object with globally required scripts
    MAS.text = text;
    $.extend(MAS, pubsub);
    $.extend(MAS, log);

    // Fire analytics events
    // TO USE: MAS.publish('analytics:trigger', {object with props})
    MAS.subscribe('analytics:trigger', function(e, data){
      MAS.log('mas_analytics.triggerAnalytics', data);
      dataLayer.push(data);
    });

    return MAS;
  }
);