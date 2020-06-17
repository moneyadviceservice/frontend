define(['jquery', 'DoughBaseComponent', 'utilities'], function($, DoughBaseComponent, utilities) {
  'use strict';

  var MoneyNavigatorResults;
  
  MoneyNavigatorResults = function($el, config) {
    MoneyNavigatorResults.baseConstructor.call(this, $el, config);

    this.$headingContent = this.$el.find('[data-heading-content]'); 
    this.$sections = this.$el.find('[data-section]'); 
    this.$sectionTitles = this.$el.find('[data-section-title]'); 
    this.$headingTitles = this.$el.find('[data-heading-title]'); 
    this.$overlay = this.$el.find('[data-overlay]'); 
    this.hiddenSuffix = '--hidden'; 
    this.hiddenClass = 'is-hidden';
    this.collapsedClass = 'is-collapsed'; 
    this.doneSuffix = '--done'; 
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
    this.$headingContent.addClass('heading__content' + this.hiddenSuffix); 

    // Adds collapsed classes to sections
    this.$sections
      .addClass(this.collapsedClass)
      .find('.section__content').height(0); 

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
      _this._showHeading(e.target); 
    }); 

    this.$headingContent.find('[data-overlay-hide]').on('click', function(e) {
      _this._hideHeading(e.target); 
    }); 

    $(window).on(
      'resize',
      utilities.debounce(
        _this._sectionResize.bind(_this, this.$sections), 
        100
      ) 
    );
  };

  MoneyNavigatorResults.prototype._sectionResize = function(sections) {
    var _this = this; 

    $(sections).each(function() {
      var $content = $(this).find('.section__content'); 
      var height = 0; 

      if (!$(this).hasClass(_this.collapsedClass)) {
        $content.children().each(function() {
          height += $(this).outerHeight(true);
        }); 
      }

      $content.height(height);     
    }); 
  }

  MoneyNavigatorResults.prototype._toggleSection = function(btn) {
    var $section = $(btn).parents('[data-section]'); 

    if ($section.hasClass(this.collapsedClass)) {
      $section.removeClass(this.collapsedClass); 
    } else {
      $section.addClass(this.collapsedClass); 
    }

    this._sectionResize($section); 
  }; 

  MoneyNavigatorResults.prototype._showHeading = function(btn) {
    var $heading = $(btn).parents('[data-heading]'); 
    var $headingContent = $heading.find('[data-heading-content]'); 
    var hiddenClass = 'heading__content' + this.hiddenSuffix; 
    var doneClass = 'sections__heading' + this.doneSuffix; 

    if (!$heading.hasClass(doneClass)) {
      $heading.addClass(doneClass); 
    }

    if ($headingContent.hasClass(hiddenClass)) {
      $headingContent.removeClass(hiddenClass); 
    }

    if (this.$overlay.hasClass(this.hiddenClass)) {
      this.$overlay.removeClass(this.hiddenClass); 
    }
  }; 

  MoneyNavigatorResults.prototype._hideHeading = function(btn) {
    var $headingContent = $(btn).parents('[data-heading-content]'); 
    var hiddenClass = 'heading__content' + this.hiddenSuffix; 

    if (!$headingContent.hasClass(hiddenClass)) {
      $headingContent.addClass(hiddenClass); 
    }

    if (!this.$overlay.hasClass(this.hiddenClass)) {
      this.$overlay.addClass(this.hiddenClass); 
    }
  }

  return MoneyNavigatorResults; 
}); 
