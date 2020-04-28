//= require require_config

require(['common', 'jquery'], function(MAS, $) {
  'use strict';

  require(['componentLoader'], function(componentLoader) {
    componentLoader.init($('body'));
  });
});
