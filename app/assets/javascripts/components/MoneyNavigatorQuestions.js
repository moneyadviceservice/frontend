define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorQuestions;
  
  MoneyNavigatorQuestions = function($el, config) {
    MoneyNavigatorQuestions.baseConstructor.call(this, $el, config);
  };

  DoughBaseComponent.extend(MoneyNavigatorQuestions);

  MoneyNavigatorQuestions.componentName = 'MoneyNavigatorQuestions';

  MoneyNavigatorQuestions.prototype.init = function(initialised) {
    this._updateDOM(); 
    this._initialisedSuccess(initialised);
  };

  MoneyNavigatorQuestions.prototype._updateDOM = function() {
    console.log('_updateDOM!'); 
  }

  return MoneyNavigatorQuestions; 
}); 
