define(['jquery', 'DoughBaseComponent', 'utilities'], function($, DoughBaseComponent, utilities) {
  'use strict';

  var MoneyNavigatorResults,
      i18nStrings = {
        printBtnText: 'Print this'
      };

  MoneyNavigatorResults = function($el, config) {
    MoneyNavigatorResults.baseConstructor.call(this, $el, config);

    this.i18nStrings = (config && config.i18nStrings) ? config.i18nStrings : i18nStrings;
    this.$headingContent = this.$el.find('[data-heading-content]'); 
    this.$sections = this.$el.find('[data-section]'); 
    this.$sectionTitles = this.$el.find('[data-section-title]'); 
    this.$headingTitles = this.$el.find('[data-heading-title]'); 
    this.$overlay = this.$el.find('[data-overlay]'); 
    this.$actions = this.$el.find('[data-actions]'); 
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
    this.bodyHeight = document.body.clientHeight; 
  };

  MoneyNavigatorResults.prototype._updateDOM = function() {
    var _this = this; 
    var sectionIcon = document.createElement('span'); 
    var headingTitleIcon = document.createElement('span'); 
    var printBtn = document.createElement('button'); 

    $(sectionIcon).addClass('section__title__icon'); 
    $(headingTitleIcon).addClass('heading__title__icon'); 
    $(printBtn)
      .addClass('button button--print')
      .text(this.i18nStrings.printBtnText); 
    printBtn.dataset.printBtn = true; 

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

    // Adds print button
    this.$actions.prepend(printBtn); 
  }; 

  MoneyNavigatorResults.prototype._setUpEvents = function() {
    var _this = this; 

    this.$sectionTitles.find('button').on('click', function(e) {
      _this._toggleSection(e.target); 
    }); 

    this.$headingTitles.parents('button').on('click', function(e) {
      _this._showHeading(e.target);
      _this._resizeContent(e.target);
    });

    this.$headingContent.find('[data-overlay-hide]').on('click', function(e) {
      e.preventDefault(); 
      _this._hideHeading(e.target); 
      _this._resizeContent();
    }); 

    this.$overlay.on('click', function() {
      _this._hideHeading(); 
    });

    this.$actions.find('[data-print-btn]').on('click', function() {
      window.print();
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
    var content; 
    var hiddenClass = 'heading__content' + this.hiddenSuffix; 

    if (btn) {
      content = $(btn).parents('[data-heading-content]'); 
    } else {
      this.$headingContent.each(function() {
        if (!$(this).hasClass(hiddenClass)) {
          content = this;
          return; 
        }
      }); 
    }

    if (!$(content).hasClass(hiddenClass)) {
      $(content).addClass(hiddenClass); 
    }

    if (!this.$overlay.hasClass(this.hiddenClass)) {
      this.$overlay.addClass(this.hiddenClass); 
    }
  }; 

  MoneyNavigatorResults.prototype._resizeContent = function(target) {
    if (target === undefined) {
      document.body.style.height = 'auto';
    } else {
      var article = $(target).parents('[data-heading]')[0].querySelector('[data-heading-content]'); 
      var size = this._getSize(article);

      if (this.bodyHeight < size.height) {
        document.body.style.height = size.height + 'px'; 
      } else {
        article.style.height = this.bodyHeight + 'px'; 
      }
    }
  };

  MoneyNavigatorResults.prototype._getSize = function(el) {
    return {
      height: el.getBoundingClientRect().height
    };
  }

  return MoneyNavigatorResults; 
}); 
