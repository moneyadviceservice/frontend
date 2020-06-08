define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorResults;
  
  MoneyNavigatorResults = function($el, config) {
    MoneyNavigatorResults.baseConstructor.call(this, $el, config);

    this.$headingContent = this.$el.find('[data-heading-content]'); 
    this.hiddenClass = 'is-hidden'; 
  };

  DoughBaseComponent.extend(MoneyNavigatorResults);

  MoneyNavigatorResults.componentName = 'MoneyNavigatorResults';

  MoneyNavigatorResults.prototype.init = function(initialised) {
    this._updateDOM(); 
    this._initialisedSuccess(initialised);
  };

  MoneyNavigatorResults.prototype._updateDOM = function() {
    console.log('_updateDOM!'); 

    // Adds hidden classes to section content
    this.$headingContent.addClass(this.hiddenClass); 

    // Adds collapsed classes to sections
    // Adds arrow icon to section headings
    // Adds checkbox element to headings
  }; 

  return MoneyNavigatorResults; 
}); 
