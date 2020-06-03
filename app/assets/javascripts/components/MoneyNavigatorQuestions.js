define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorQuestions;
  
  MoneyNavigatorQuestions = function($el, config) {
    MoneyNavigatorQuestions.baseConstructor.call(this, $el, config);

    this.$submitBtn = this.$el.find('[data-submit]'); 
    this.$questions = this.$el.find('[data-question]'); 
    this.$multipleQuestions = this.$el.find('[data-question-multiple]'); 
    this.activeClass = 'question--active'; 
  };

  DoughBaseComponent.extend(MoneyNavigatorQuestions);

  MoneyNavigatorQuestions.componentName = 'MoneyNavigatorQuestions';

  MoneyNavigatorQuestions.prototype.init = function(initialised) {
    this._updateDOM(); 
    this._setUpMultipleQuestions(); 
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
        $(question).find('.question__content').append('<div class="question__actions"><button class="button button--start" data-get-started="true">Get started</button></div>'); 
         // Adds active class to first question
        $(question).addClass(_this.activeClass); 
     } else {
        // Adds continue and back buttons to all other questions
        $(question).find('.question__content')
          .append('<div class="question__actions"><button data-continue="true" class="button button--continue">Continue</button><button data-back="true" class="button button--back">Back</button></div>')
      }
    }; 

    var buttons = this.$el.find('button'); 

    buttons.on('click', function(e, options) {
      if ($(this).data('get-started')) {
        e.preventDefault(); 
        _this._updateDisplay('next'); 
      } else if ($(this).data('continue')) {
        if (_this.$questions.last()[0] == $(this).parents('[data-question]')[0]) {
          if (options == 'preventDefault') {
            e.preventDefault(); 
          }
        } else {
          e.preventDefault(); 
          _this._updateDisplay('next'); 
        }
      } else if ($(this).data('back')) {
        e.preventDefault(); 
        _this._updateDisplay('prev'); 
      }
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

  MoneyNavigatorQuestions.prototype._setUpMultipleQuestions = function() {
    var _this = this; 

    this.$multipleQuestions.each(function() {
      var inputs = $(this).find('input[type="checkbox"]'); 

      $(inputs[0]).on('change', function(e) {
        _this._updateMultipleQuestions(e.target); 
      }); 

      for (var i = 0, length = inputs.length; i < length; i++) {
        if (i == 0) {
          inputs[i].checked = true; 
        } else {
          inputs[i].disabled = true; 
        }
      }
    }); 
  }

  MoneyNavigatorQuestions.prototype._updateMultipleQuestions = function(input) {
    var responses = $(input).parents('[data-response]').siblings('[data-response]'); 

    responses.each(function() {
      $(this).find('input[type="checkbox"]').each(function() {
        if (input.checked) {
          this.disabled = true; 
        } else {
          this.disabled = false; 
        }
      })
    })
  }

  return MoneyNavigatorQuestions; 
}); 
