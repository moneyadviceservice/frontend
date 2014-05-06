define(['jquery'], function ($) {
  'use strict';

  var pubsub = {},
      o = $({});

  pubsub.subscribe = function() {
    o.on.apply(o, arguments);
  };

  pubsub.unsubscribe = function() {
    o.off.apply(o, arguments);
  };

  pubsub.publish = function() {
    o.trigger.apply(o, arguments);
  };

  return pubsub;
});
