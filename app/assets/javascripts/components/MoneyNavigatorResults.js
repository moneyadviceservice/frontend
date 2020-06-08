define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorResults;
  
  MoneyNavigatorResults = function($el, config) {
    MoneyNavigatorResults.baseConstructor.call(this, $el, config);
  };

  DoughBaseComponent.extend(MoneyNavigatorResults);

  MoneyNavigatorResults.componentName = 'MoneyNavigatorResults';

  MoneyNavigatorResults.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  return MoneyNavigatorResults; 
}); 
