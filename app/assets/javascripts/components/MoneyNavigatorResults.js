define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorResults;
  
  MoneyNavigatorResults = function($el, config) {
    MoneyNavigatorResults.baseConstructor.call(this, $el, config);

    this.$headingContent = this.$el.find('[data-heading-content]'); 
    this.$sections = this.$el.find('[data-section]'); 
    this.$headingTitles = this.$el.find('[data-heading-title]'); 
    this.hiddenClass = 'is-hidden'; 
    this.collapsedClass = 'is-collapsed'; 
  };

  DoughBaseComponent.extend(MoneyNavigatorResults);

  MoneyNavigatorResults.componentName = 'MoneyNavigatorResults';

  MoneyNavigatorResults.prototype.init = function(initialised) {
    this._updateDOM(); 
    this._initialisedSuccess(initialised);
  };

  MoneyNavigatorResults.prototype._updateDOM = function() {
    var sectionIcon = document.createElement('span'); 
    var headingTitleIcon = document.createElement('span'); 

    $(sectionIcon).addClass('section__title__icon'); 
    $(headingTitleIcon).addClass('heading__title__icon'); 

    // Adds hidden classes to section content
    this.$headingContent.addClass(this.hiddenClass); 

    // Adds collapsed classes to sections
    this.$sections.addClass(this.collapsedClass); 

    // Adds arrow icon to section headings
    this.$sections.find('.section__title').append(sectionIcon); 

    // Adds checkbox element to headings
    this.$headingTitles.append(headingTitleIcon); 
  }; 

  return MoneyNavigatorResults; 
}); 
