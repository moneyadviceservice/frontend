define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorResults;
  
  MoneyNavigatorResults = function($el, config) {
    MoneyNavigatorResults.baseConstructor.call(this, $el, config);

    this.$headingContent = this.$el.find('[data-heading-content]'); 
    this.$sections = this.$el.find('[data-section]'); 
    this.$sectionTitles = this.$el.find('[data-section-title]'); 
    this.$headingTitles = this.$el.find('[data-heading-title]'); 
    this.hiddenClass = 'is-hidden'; 
    this.collapsedClass = 'is-collapsed'; 
    this.doneClass = 'is-done'; 
  };

  DoughBaseComponent.extend(MoneyNavigatorResults);

  MoneyNavigatorResults.componentName = 'MoneyNavigatorResults';

  MoneyNavigatorResults.prototype.init = function(initialised) {
    this._updateDOM(); 
    this._setUpEvents(); 
    this._initialisedSuccess(initialised);
  };

  MoneyNavigatorResults.prototype._updateDOM = function() {
    var _this = this; 
    var sectionIcon = document.createElement('span'); 
    var headingTitleIcon = document.createElement('span'); 

    $(sectionIcon).addClass('section__title__icon'); 
    $(headingTitleIcon).addClass('heading__title__icon'); 

    // Adds hidden classes to headings content
    this.$headingContent.addClass(this.hiddenClass); 

    // Adds collapsed classes to sections
    this.$sections.addClass(this.collapsedClass); 

    // Adds arrow icon to section headings
    this.$sections.find('.section__title button').append(sectionIcon); 

    // Adds checkbox element to headings
    this.$headingTitles.append(headingTitleIcon); 
  }; 

  MoneyNavigatorResults.prototype._setUpEvents = function() {
    var _this = this; 

    this.$sectionTitles.find('button').on('click', function(e) {
      _this._toggleSection(e.target); 
    }); 

    this.$headingTitles.find('button').on('click', function(e) {
      _this._toggleHeading(e.target); 
    }); 
  };

  MoneyNavigatorResults.prototype._toggleSection = function(btn) {
    var $section = $(btn).parents('[data-section]'); 

    if ($section.hasClass(this.collapsedClass)) {
      $section.removeClass(this.collapsedClass); 
    } else {
      $section.addClass(this.collapsedClass); 
    }
  }; 

  MoneyNavigatorResults.prototype._toggleHeading = function(btn) {
    var $heading = $(btn).parents('[data-heading]'); 
    var $headingContent = $heading.find('[data-heading-content]'); 

    if (!$heading.hasClass(this.doneClass)) {
      $heading.addClass(this.doneClass); 
    }

    if ($headingContent.hasClass(this.hiddenClass)) {
      $headingContent.removeClass(this.hiddenClass); 
    } else {
      $headingContent.addClass(this.hiddenClass); 
    }
  }; 

  return MoneyNavigatorResults; 
}); 
