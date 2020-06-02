define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorQuestions;
  
  MoneyNavigatorQuestions = function($el, config) {
    MoneyNavigatorQuestions.baseConstructor.call(this, $el, config);

    this.$submitBtn = this.$el.find('[data-submit]'); 
    this.$questions = this.$el.find('[data-question]'); 
    this.activeClass = 'question--active'; 
  };

  DoughBaseComponent.extend(MoneyNavigatorQuestions);

  MoneyNavigatorQuestions.componentName = 'MoneyNavigatorQuestions';

  MoneyNavigatorQuestions.prototype.init = function(initialised) {
    this._updateDOM(); 
    this._initialisedSuccess(initialised);
  };

  MoneyNavigatorQuestions.prototype._updateDOM = function() {
    var _this = this; 

    // Removes submit button
    this.$submitBtn.remove(); 

    for (var i = 0; i < this.$questions.length; i++) {
      var question = this.$questions[i]; 

      if (i === 0) {
        // Adds get-started button to first question
        $(question).find('.question__content').append('<button class="button button--start" data-get-started="true">Get started</button>'); 
         // Adds active class to first question
        $(question).addClass(_this.activeClass); 
     } else {
        // Adds continue and back buttons to all other questions
        $(question).find('.question__content')
          .append('<button data-continue="true" class="button button--continue">Continue</button>')
          .append('<button data-back="true" class="button button--back">Back</button>');
      }
    }; 

    this.$el.find('[data-get-started]').on('click', function(e) {
      e.preventDefault(); 

      _this._updateDisplay('next'); 
    }); 

    this.$el.find('[data-continue]').on('click', function(e) {
      e.preventDefault(); 

      _this._updateDisplay('next'); 
    }); 

    this.$el.find('[data-back]').on('click', function(e) {
      e.preventDefault(); 

      _this._updateDisplay('prev'); 
    }); 
  }

  MoneyNavigatorQuestions.prototype._updateDisplay = function(dir) {
    var activeIndex, questionClasses = []; 

    this.$questions.each(function() {
      questionClasses.push(this.className); 
    }); 

    activeIndex = questionClasses.indexOf('l-c19_diagnostics__question ' + this.activeClass); 

    $(this.$questions[activeIndex]).removeClass(this.activeClass); 

    if (dir === 'next') {
      $(this.$questions[activeIndex + 1]).addClass(this.activeClass); 
    } else {
      $(this.$questions[activeIndex - 1]).addClass(this.activeClass); 
    }
  }

  return MoneyNavigatorQuestions; 
}); 
